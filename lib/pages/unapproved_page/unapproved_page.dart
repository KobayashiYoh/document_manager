import 'package:flutter/material.dart';

class UnapprovedPage extends StatelessWidget {
  const UnapprovedPage({
    Key? key,
    required this.userName,
    required this.schoolName,
  }) : super(key: key);

  final String userName;
  final String schoolName;

  @override
  Widget build(BuildContext context) {
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
                '$userName さん\n$schoolName へようこそ',
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
                onPressed: () {},
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
