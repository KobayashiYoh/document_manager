import 'dart:async';

import 'package:document_manager/models/user.dart';
import 'package:document_manager/pages/sign_in_page/sign_in_page.dart';
import 'package:document_manager/providers/sign_in_notifier.dart';
import 'package:document_manager/providers/unapproved_notifier.dart';
import 'package:document_manager/utils/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnapprovedPage extends ConsumerStatefulWidget {
  const UnapprovedPage({
    Key? key,
    required this.signedInUser,
    required this.schoolName,
  }) : super(key: key);

  final User signedInUser;
  final String schoolName;

  @override
  UnapprovedPageState createState() => UnapprovedPageState();
}

class UnapprovedPageState extends ConsumerState<UnapprovedPage> {
  Future<void> _onPressedSignOut() async {
    final notifier = ref.read(signInProvider.notifier);
    await notifier.signOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SignInPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(unapprovedProvider);
    if (state.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state.userIsDeleted) {
      NavigatorUtil.showCommonAlertDialog(
        context,
        titleText: 'ユーザーが削除されました',
        contentText: '教員からの承認を得ることができませんでした。',
        onPressedOK: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInPage()),
            (route) => false,
          );
        },
        hideCancel: true,
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 128.0),
              Text(
                '${widget.signedInUser.fullName} さん\n${widget.schoolName} へようこそ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '\n現在、教員による承認待ちです。\n承認完了までしばらくお待ちください。',
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _onPressedSignOut,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8.0),
                    Text('ログアウトする'),
                  ],
                ),
              ),
              const SizedBox(height: 64.0),
            ],
          ),
        ),
      ),
    );
  }
}
