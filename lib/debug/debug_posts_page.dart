import 'dart:async';

import 'package:document_manager/debug/debug_post_item.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:flutter/material.dart';

class DebugPostsPage extends StatefulWidget {
  const DebugPostsPage({Key? key}) : super(key: key);

  @override
  State<DebugPostsPage> createState() => _DebugPostsPageState();
}

class _DebugPostsPageState extends State<DebugPostsPage> {
  final TextEditingController _messageController = TextEditingController();

  Future<void> _setPost() async {
    try {
      await FirestoreRepository.setPost(_messageController.text);
    } catch (e) {
      rethrow;
    }
    _messageController.clear();
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
                stream: FirestoreRepository.postSnapshots(),
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
                    Expanded(
                      child: TextFormField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          label: Text('メッセージ'),
                        ),
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
        onPressed: () => _setPost(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
