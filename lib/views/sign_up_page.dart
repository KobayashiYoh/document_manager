import 'package:document_manager/providers/sign_up_notifier.dart';
import 'package:document_manager/widgets/form_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends ConsumerState<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _onPressedSignUp() async {
    final notifier = ref.read(signUpProvider.notifier);
    await notifier.signUp(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('新規ユーザー登録'),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            FormItem(
              label: 'メールアドレス',
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'email@example.com',
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            FormItem(
              label: 'パスワード',
              child: TextFormField(
                controller: _passwordController,
              ),
            ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                Expanded(
                  child: FormItem(
                    label: '苗字',
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: '山田'),
                    ),
                  ),
                ),
                const SizedBox(width: 32.0),
                Expanded(
                  child: FormItem(
                    label: '名前',
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: '太郎'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            FormItem(
              label: '学校名',
              child: TextFormField(),
            ),
            const SizedBox(height: 32.0),
            FormItem(
              label: '区分',
              child: TextFormField(),
            ),
            const SizedBox(height: 64.0),
            ElevatedButton(
              onPressed: _onPressedSignUp,
              child: const Text('登録'),
            ),
            SizedBox(height: keyboardHeight),
          ],
        ),
      ),
    );
  }
}
