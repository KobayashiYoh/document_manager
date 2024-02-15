import 'package:document_manager/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LaunchPage extends ConsumerStatefulWidget {
  const LaunchPage({super.key});

  @override
  LaunchPageState createState() => LaunchPageState();
}

class LaunchPageState extends ConsumerState<LaunchPage> {
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
