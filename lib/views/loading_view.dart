import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double sigma = 5.0;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigma,
        sigmaY: sigma,
      ),
      child: Center(
        child: Theme.of(context).platform == TargetPlatform.iOS
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator(),
      ),
    );
  }
}
