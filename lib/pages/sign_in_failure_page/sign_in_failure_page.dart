import 'package:document_manager/widgets/sign_out_button.dart';
import 'package:flutter/material.dart';

class SignInFailurePage extends StatelessWidget {
  const SignInFailurePage({
    Key? key,
    required this.onPressedSignOut,
  }) : super(key: key);

  final void Function()? onPressedSignOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 128.0),
              const Text('ユーザー情報を取得できませんでした。'),
              const Spacer(),
              SignOutButton(onPressed: onPressedSignOut),
              const SizedBox(height: 64.0),
            ],
          ),
        ),
      ),
    );
  }
}
