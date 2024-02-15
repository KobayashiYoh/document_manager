import 'package:document_manager/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.main,
        ),
        child: Image.asset('assets/images/app_logo.png'),
      ),
    );
  }
}
