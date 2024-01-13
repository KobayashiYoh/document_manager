import 'dart:async';
import 'dart:io';

import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/repository/firebase_storage_repository.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/utils/image_util.dart';
import 'package:document_manager/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.channel});

  final Channel channel;

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  XFile? _image;
  final double _inputFieldHeight = 160.0;

  Future<void> _putImage(String postId) async {
    final String storagePath = 'posts/$postId.png';
    try {
      await FirebaseStorageRepository.put(File(_image!.path), storagePath);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _putPost(String id, String imageUrl) async {
    try {
      await FirestoreRepository.setPost(
        id,
        _messageController.text,
        imageUrl,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _onPressedSendButton() async {
    final String postId = const Uuid().v4();
    if (_image != null) {
      await _putImage(postId);
    }
    final String imageUrl = _image == null
        ? ''
        : 'https://firebasestorage.googleapis.com/v0/b/resukuru-mobile.appspot.com/o/posts%2F$postId.png?alt=media';
    await _putPost(postId, imageUrl);
    _messageController.clear();
    setState(() {
      _image = null;
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channel.name),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              StreamBuilder(
                stream: FirestoreRepository.postSnapshots(
                  channelId: kExampleChannel.id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(microseconds: 1),
                      curve: Curves.easeInOut,
                    );
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<Post> posts = snapshot.data!.docs
                          .map((doc) => Post.fromJson(doc.data()))
                          .toList();
                      return PostItem(
                        post: posts[index],
                        user: kExampleStudent,
                        isMyPost: true,
                        margin: index == posts.length - 1
                            ? EdgeInsets.only(bottom: _inputFieldHeight)
                            : EdgeInsets.zero,
                      );
                    },
                  );
                },
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                height: _inputFieldHeight,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        label: Text('メッセージ'),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final image = await ImageUtil.pickImageFromGallery();
                        setState(() {
                          _image = image;
                        });
                      },
                      icon: const Icon(Icons.photo_outlined),
                    ),
                    if (_image != null)
                      Expanded(
                        child: Image.file(
                          File(_image!.path),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressedSendButton(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
