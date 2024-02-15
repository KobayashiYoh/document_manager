import 'package:document_manager/constants/app_colors.dart';
import 'package:document_manager/pages/sign_in_page/sign_in_page.dart';
import 'package:document_manager/providers/launch_notifier.dart';
import 'package:document_manager/utils/navigator_util.dart';
import 'package:document_manager/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LaunchPage extends ConsumerStatefulWidget {
  const LaunchPage({super.key});

  @override
  LaunchPageState createState() => LaunchPageState();
}

class LaunchPageState extends ConsumerState<LaunchPage>
    with SingleTickerProviderStateMixin {
  final Duration _duration = const Duration(seconds: 1);
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: _duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    Future(() async {
      _controller.forward();
      final isSignedIn = await ref.read(launchProvider.notifier).isSignedIn();
      await Future.delayed(const Duration(seconds: 1));
      _controller.reverse();
      if (!mounted) return;
      NavigatorUtil.push(
        context,
        isSignedIn ? const BottomNavigation() : const SignInPage(),
      );
    });
  }

  @override
  void didUpdateWidget(LaunchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = _duration;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.main,
        ),
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset('assets/images/app_logo.png'),
        ),
      ),
    );
  }
}
