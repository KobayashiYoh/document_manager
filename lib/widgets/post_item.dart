import 'package:cached_network_image/cached_network_image.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:document_manager/widgets/circle_icon_image.dart';
import 'package:document_manager/widgets/image_preview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// FIXME: 既読機能にバグあり
class PostItem extends ConsumerStatefulWidget {
  const PostItem({
    Key? key,
    required this.post,
    required this.user,
    required this.isMyPost,
    this.margin = EdgeInsets.zero,
    required this.initialize,
  }) : super(key: key);

  final Post post;
  final User user;
  final bool isMyPost;
  final EdgeInsetsGeometry? margin;
  final void Function()? initialize;

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<PostItem> {
  Widget _circleIconImage() {
    return CircleIconImage(
      imageUrl: widget.post.userId,
      errorImagePath: 'assets/images/default_user.png',
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.initialize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      margin: widget.margin,
      child: Row(
        mainAxisAlignment:
            widget.isMyPost ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.isMyPost) _circleIconImage(),
          if (!widget.isMyPost) const SizedBox(width: 8.0),
          Flexible(
            child: Column(
              crossAxisAlignment: widget.isMyPost
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.user.lastName} ${widget.user.firstName}（${widget.user.userType.displayText}）',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.post.message.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: widget.isMyPost
                          ? Colors.green.shade200
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(widget.post.message),
                  ),
                if (widget.post.message.isEmpty &&
                    widget.post.imageUrl.isNotEmpty)
                  const SizedBox(height: 8.0),
                if (widget.post.imageUrl.isNotEmpty)
                  GestureDetector(
                    onTap: () =>
                        showImagePreview(context, widget.post.imageUrl),
                    child: Container(
                      color: Colors.black,
                      child: CachedNetworkImage(imageUrl: widget.post.imageUrl),
                    ),
                  ),
                Row(
                  mainAxisAlignment: widget.isMyPost
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '既読${widget.post.readCount}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12.0,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // タップ時
                          },
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.post.createdAtText,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.isMyPost) const SizedBox(width: 8.0),
          if (widget.isMyPost) _circleIconImage(),
        ],
      ),
    );
  }
}
