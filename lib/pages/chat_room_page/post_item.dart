import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/pages/user_page/user_page.dart';
import 'package:document_manager/widgets/circle_user_icon_image.dart';
import 'package:document_manager/widgets/image_preview.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.post,
    required this.user,
    required this.signedInUserId,
    this.margin = const EdgeInsets.only(bottom: 16.0),
    required this.onPressedCheck,
    required this.onLongPressCheck,
  }) : super(key: key);

  final Post post;
  final User user;
  final String signedInUserId;
  final EdgeInsetsGeometry? margin;
  final void Function()? onPressedCheck;
  final void Function()? onLongPressCheck;

  void _onTapUserIcon(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UserPage(user: user),
      ),
    );
  }

  Widget _circleUserIconImage(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapUserIcon(context),
      child: CircleUserIconImage(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMyPost = signedInUserId == post.userId;
    final bool hasRead = post.readUserIds.contains(signedInUserId);
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      margin: margin,
      child: Row(
        mainAxisAlignment:
            isMyPost ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMyPost) _circleUserIconImage(context),
          if (!isMyPost) const SizedBox(width: 8.0),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMyPost ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullNameWithUserType,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                if (post.message.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: isMyPost ? Colors.green.shade200 : Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(post.message),
                  ),
                if (post.message.isEmpty && post.imageUrl.isNotEmpty)
                  const SizedBox(height: 8.0),
                if (post.imageUrl.isNotEmpty)
                  GestureDetector(
                    onTap: () => showImagePreview(context, post.imageUrl),
                    child: Container(
                      color: Colors.black,
                      child: CachedNetworkImage(imageUrl: post.imageUrl),
                    ),
                  ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 24.0,
                  child: Row(
                    mainAxisAlignment: isMyPost
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40.0,
                        child: ElevatedButton(
                          onPressed: onPressedCheck,
                          onLongPress: onLongPressCheck,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: hasRead
                                ? Colors.blue.withOpacity(0.6)
                                : Colors.grey,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('✅'),
                              const SizedBox(width: 4.0),
                              Text(
                                '${post.readCount}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        post.createdAtText,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMyPost) const SizedBox(width: 8.0),
          if (isMyPost) _circleUserIconImage(context),
        ],
      ),
    );
  }
}
