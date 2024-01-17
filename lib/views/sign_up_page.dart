import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('新規ユーザー登録'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('メールアドレス'),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('パスワード'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('苗字'),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('名前'),
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('学校'),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('区分'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
