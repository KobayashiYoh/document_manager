import 'dart:io';

import 'package:document_manager/models/chat_state.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/repository/firebase_storage_repository.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/utils/image_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

final chatProvider = StateNotifierProvider.autoDispose<ChatNotifier, ChatState>(
  (ref) => ChatNotifier(ref),
);

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier(this.ref) : super(kDefaultChatState);

  final Ref ref;

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  void setImage(XFile? image) {
    state = state.copyWith(image: image);
  }

  void setShowSearchBar(bool value) {
    state = state.copyWith(showSearchBar: value);
  }

  void setSearchWord(String value) {
    state = state.copyWith(searchWord: value);
  }

  Future<void> addPostReadId({
    required Post post,
    required String signedInUserId,
  }) async {
    if (post.readUserIds.contains(signedInUserId)) {
      return;
    }
    post.readUserIds.add(signedInUserId);
    await FirestoreRepository.updatePost(
      post: post.copyWith(
        readUserIds: post.readUserIds,
      ),
    );
  }

  Future<void> onPressedImageButton() async {
    final image = await ImageUtil.pickImageFromGallery();
    setImage(image);
  }

  Future<void> _putImage(String postId) async {
    final String storagePath = 'posts/$postId.png';
    try {
      await FirebaseStorageRepository.put(File(state.image!.path), storagePath);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _putPost({
    required String postId,
    required String channelId,
    required String message,
    required String imageUrl,
  }) async {
    try {
      await FirestoreRepository.setPost(
        postId: postId,
        channelId: channelId,
        message: message,
        imageUrl: imageUrl,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendPost({
    required String channelId,
    required String message,
  }) async {
    final String postId = const Uuid().v4();
    if (state.image != null) {
      await _putImage(postId);
    }
    final String imageUrl = state.image == null
        ? ''
        : 'https://firebasestorage.googleapis.com/v0/b/resukuru-mobile.appspot.com/o/posts%2F$postId.png?alt=media';
    await _putPost(
      postId: postId,
      channelId: channelId,
      message: message,
      imageUrl: imageUrl,
    );
    setImage(null);
  }
}
