import 'package:document_manager/models/post.dart';
import 'package:flutter/material.dart';

class DebugPostItem extends StatelessWidget {
  const DebugPostItem({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Text(
          'ID: ${post.id},\nMessage: ${post.message}\ncreated-at: ${post.createdAt}\nuser-id: ${post.userId}'),
    );
  }
}
