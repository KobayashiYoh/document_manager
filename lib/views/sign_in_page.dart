import 'package:document_manager/views/sign_up_page.dart';
import 'package:document_manager/widgets/form_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends ConsumerState<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onPressedSignUp() async {
    _emailController.clear();
    _passwordController.clear();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
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
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('ログイン'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            FormItem(
              label: 'メールアドレス',
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
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
                keyboardType: TextInputType.visiblePassword,
                // obscureText: state.obscureText,
                // decoration: InputDecoration(
                //   suffixIcon: PasswordSuffixIconButton(
                //     onPressed: notifier.switchObscureText,
                //     obscureText: state.obscureText,
                //   ),
                // ),
              ),
            ),
            const SizedBox(height: 64.0),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: _onPressedSignUp,
                  child: const Text('新規登録'),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _onPressedSignUp,
              child: const Text('ログインする'),
            ),
            SizedBox(height: keyboardHeight),
          ],
        ),
      ),
    );
  }
}
