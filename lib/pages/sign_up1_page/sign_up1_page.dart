import 'package:document_manager/pages/sign_up2_page/sign_up2_page.dart';
import 'package:document_manager/providers/sign_up1_notifier.dart';
import 'package:document_manager/utils/navigator_util.dart';
import 'package:document_manager/widgets/form_item.dart';
import 'package:document_manager/widgets/loading_view.dart';
import 'package:document_manager/widgets/password_suffix_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp1Page extends ConsumerStatefulWidget {
  const SignUp1Page({super.key});

  @override
  SignUp1PageState createState() => SignUp1PageState();
}

class SignUp1PageState extends ConsumerState<SignUp1Page> {
  void _onPressedNext() {
    NavigatorUtil.push(context, const SignUp2Page());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUp1Provider);
    final notifier = ref.read(signUp1Provider.notifier);
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('新規ユーザー登録 1/2'),
            ),
            body: AutofillGroup(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FormItem(
                        label: 'メールアドレス',
                        child: TextFormField(
                          controller: notifier.emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const <String>[AutofillHints.email],
                          decoration: const InputDecoration(
                            hintText: 'email@example.com',
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      FormItem(
                        label: 'パスワード',
                        child: TextFormField(
                          controller: notifier.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const <String>[AutofillHints.password],
                          obscureText: state.obscureText,
                          decoration: InputDecoration(
                            suffixIcon: PasswordSuffixIconButton(
                              onPressed: notifier.switchObscureText,
                              obscureText: state.obscureText,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 320.h),
                      ElevatedButton(
                        onPressed: _onPressedNext,
                        child: const Text('次へ'),
                      ),
                      SizedBox(height: keyboardHeight),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (state.isLoading) const LoadingView(),
        ],
      ),
    );
  }
}
