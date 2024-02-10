import 'package:document_manager/models/user.dart';
import 'package:flutter/material.dart';

class UnapprovedPage extends StatelessWidget {
  const UnapprovedPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'ようこそ、${user.fullName}さん\n現在、教員による承認待ちです。\n承認が完了するとアプリが利用できるようになります。',
          ),
          TextButton(
            onPressed: () {},
            child: const Text('ログアウトする'),
          ),
        ],
      ),
    );
  }
}
