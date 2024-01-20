import 'dart:io';

import 'package:document_manager/models/chat_state.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/repository/firebase_storage_repository.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/utils/image_util.dart';
import 'package:document_manager/utils/ocr_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
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

  Future<void> onPressedCheck({
    required Post post,
    required String signedInUserId,
  }) async {
    final bool hasRead = post.readUserIds.contains(signedInUserId);
    List<String> newReadUserIds = List.from(post.readUserIds);
    if (hasRead) {
      newReadUserIds.remove(signedInUserId);
    } else {
      newReadUserIds.add(signedInUserId);
    }
    await FirestoreRepository.updatePost(
      post: post.copyWith(
        readUserIds: newReadUserIds,
      ),
    );
  }

  Future<void> onPressedImageGallery() async {
    if (state.isLoading) {
      return;
    }
    final image = await ImageUtil.pickImageFromGallery();
    setImage(image);
  }

  Future<void> onPressedCamera() async {
    if (state.isLoading) {
      return;
    }
    final image = await ImageUtil.pickImageFromCamera();
    setImage(image);
  }

  Future<void> sendPost({
    required String channelId,
    required String message,
  }) async {
    final String postId = const Uuid().v4();
    List<String> imageTexts = [];
    setError(false);
    setLoading(true);
    try {
      if (state.image != null) {
        final image = File(state.image!.path);
        await FirebaseStorageRepository.put(image, 'posts/$postId.png');
        imageTexts = await OCRUtil.imageToTextList(InputImage.fromFile(image));
      }
      await FirestoreRepository.setPost(
        postId: postId,
        channelId: channelId,
        message: message,
        imageUrl: state.image == null
            ? ''
            : 'https://firebasestorage.googleapis.com/v0/b/resukuru-mobile.appspot.com/o/posts%2F$postId.png?alt=media',
        imageTexts: imageTexts,
      );
    } catch (e) {
      setError(true);
      throw Exception('Failed to send post: $e');
    } finally {
      setLoading(false);
    }
    setImage(null);
  }
}
