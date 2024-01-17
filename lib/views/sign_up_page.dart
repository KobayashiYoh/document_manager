import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('新規ユーザー登録'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('メールアドレス'),
              ),
            ),
            const SizedBox(height: 32.0),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('パスワード'),
              ),
            ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('苗字'),
                    ),
                  ),
                ),
                const SizedBox(width: 32.0),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('名前'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('学校'),
              ),
            ),
            const SizedBox(height: 32.0),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('区分'),
              ),
            ),
            const SizedBox(height: 64.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('登録'),
            ),
            SizedBox(height: keyboardHeight),
          ],
        ),
      ),
    );
  }
}
