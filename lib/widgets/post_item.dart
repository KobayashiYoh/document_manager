import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/widgets/circle_icon_image.dart';
import 'package:document_manager/widgets/image_preview.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.post,
    required this.user,
    required this.isMyPost,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final Post post;
  final User user;
  final bool isMyPost;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleIconImage(
            imageUrl: post.userId,
            errorImagePath: 'assets/images/default_user.png',
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${user.lastName} ${user.firstName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      post.createdAtText,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                if (post.message.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(post.message),
                  ),
                const SizedBox(height: 8.0),
                if (post.imageUrl.isNotEmpty)
                  GestureDetector(
                    onTap: () => showImagePreview(context, post.imageUrl),
                    child: Container(
                      color: Colors.black,
                      child: CachedNetworkImage(imageUrl: post.imageUrl),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
