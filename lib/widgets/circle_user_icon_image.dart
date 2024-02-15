import 'package:document_manager/models/user.dart';
import 'package:document_manager/widgets/circle_icon_image.dart';
import 'package:flutter/material.dart';

class CircleUserIconImage extends StatelessWidget {
  const CircleUserIconImage({
    Key? key,
    required this.user,
    this.diameter = 40.0,
  }) : super(key: key);

  final User user;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return CircleIconImage(
      diameter: diameter,
      imageUrl: user.iconImageUrl.isEmpty
          ? user.defaultIconImageUrl
          : user.iconImageUrl,
      errorImagePath: 'assets/images/default_user.png',
    );
  }
}
