import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/widgets/image_preview.dart';
import 'package:flutter/material.dart';

class DocumentItem extends StatelessWidget {
  const DocumentItem({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showImagePreview(context, post.imageUrl),
      child: Container(
        color: Colors.black,
        child: CachedNetworkImage(
          imageUrl: post.imageUrl,
        ),
      ),
    );
  }
}
