import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:document_manager/providers/sign_up_notifier.dart';
import 'package:document_manager/widgets/form_item.dart';
import 'package:document_manager/widgets/password_suffix_icon_button.dart';
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
  final _lastNameKey = GlobalKey();

  String get allUserTypeText {
    String text = '';
    for (UserType userType in UserType.values) {
      text = text.isEmpty
          ? userType.displayText
          : '$text / ${userType.displayText}';
    }
    return text;
  }

  Future<void> _onPressedSignUp() async {
    final notifier = ref.read(signUpProvider.notifier);
    await notifier.signUp(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(signUpProvider.notifier);
      notifier.setUserTypeFieldWidth(_lastNameKey);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpProvider);
    final notifier = ref.read(signUpProvider.notifier);
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
                obscureText: state.obscureText,
                decoration: InputDecoration(
                  suffixIcon: PasswordSuffixIconButton(
                    onPressed: notifier.switchObscureText,
                    obscureText: state.obscureText,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                Expanded(
                  key: _lastNameKey,
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  DropdownButton(
                    items: [
                      for (School school in state.schools)
                        DropdownMenuItem(
                          value: school,
                          child: Text(school.name),
                        ),
                    ],
                    value: state.selectedSchool,
                    isExpanded: true,
                    padding: const EdgeInsets.all(16.0),
                    onChanged: (value) => notifier.onChangedSchool(value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            FormItem(
              label: '区分（$allUserTypeText）',
              child: SizedBox(
                width: state.userTypeFieldWidth,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    TextFormField(
                      enabled: false,
                      decoration: const InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    DropdownButton(
                      items: [
                        for (UserType userType in UserType.values)
                          DropdownMenuItem(
                            value: userType,
                            child: Text(userType.displayText),
                          ),
                      ],
                      value: state.userType,
                      isExpanded: true,
                      padding: const EdgeInsets.all(16.0),
                      onChanged: (value) => notifier.onChangedUserType(value),
                    ),
                  ],
                ),
              ),
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
