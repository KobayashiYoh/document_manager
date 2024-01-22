import 'dart:async';
import 'dart:io';

import 'package:document_manager/debug/debug_post_item.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/repository/firebase_storage_repository.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class DebugPostsPage extends StatefulWidget {
  const DebugPostsPage({Key? key}) : super(key: key);

  @override
  State<DebugPostsPage> createState() => _DebugPostsPageState();
}

class _DebugPostsPageState extends State<DebugPostsPage> {
  final TextEditingController _messageController = TextEditingController();
  XFile? _image;

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
        postId: id,
        channelId: kExampleChannel.id,
        message: _messageController.text,
        imageUrl: imageUrl,
        imageTexts: [],
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DebugPostsPage'),
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
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<Post> posts = snapshot.data!.docs
                          .map((doc) => Post.fromJson(doc.data()))
                          .toList();
                      return DebugPostItem(post: posts[index]);
                    },
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 80.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                height: 160.0,
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
                        final image = await ImageUtil.pickCroppedImage(
                          source: ImageSource.gallery,
                        );
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
