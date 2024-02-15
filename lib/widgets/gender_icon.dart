import 'package:flutter/material.dart';

class GenderIcon extends StatelessWidget {
  const GenderIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: -4.0,
          right: -2.0,
          child: Icon(Icons.male),
        ),
        Positioned(
          child: Icon(Icons.female),
        ),
      ],
    );
  }
}
