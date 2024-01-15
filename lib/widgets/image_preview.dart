import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void showImagePreview(BuildContext context, String imageUrl) {
  showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return ImagePreview(imageUrl: imageUrl);
    },
  );
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xCC333333),
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.close),
            ),
            InteractiveViewer(
              minScale: 0.1,
              maxScale: 5,
              child: CachedNetworkImage(imageUrl: imageUrl),
            ),
          ],
        ),
      ),
    );
  }
}
