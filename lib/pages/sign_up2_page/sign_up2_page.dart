import 'package:document_manager/models/gender.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:document_manager/providers/sign_up1_notifier.dart';
import 'package:document_manager/widgets/bottom_navigation.dart';
import 'package:document_manager/widgets/form_item.dart';
import 'package:document_manager/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp2Page extends ConsumerStatefulWidget {
  const SignUp2Page({super.key});

  @override
  SignUp2PageState createState() => SignUp2PageState();
}

class SignUp2PageState extends ConsumerState<SignUp2Page> {
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameKey = GlobalKey();

  Future<void> _onPressedSignUp() async {
    // final notifier = ref.read(signUp1Provider.notifier);
    // await notifier.signUp(
    //   lastName: _lastNameController.text,
    //   firstName: _firstNameController.text,
    // );
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const BottomNavigation()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    super.dispose();
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
              title: const Text('新規ユーザー登録2/2'),
            ),
            body: ListView(
              padding: const EdgeInsets.all(32.0),
              children: [
                Row(
                  children: [
                    Expanded(
                      key: _lastNameKey,
                      child: FormItem(
                        label: '姓',
                        child: TextFormField(
                          controller: _lastNameController,
                          autofillHints: const <String>[
                            AutofillHints.familyName,
                          ],
                          decoration: const InputDecoration(hintText: '山田'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32.0),
                    Expanded(
                      child: FormItem(
                        label: '名',
                        child: TextFormField(
                          controller: _firstNameController,
                          autofillHints: const <String>[
                            AutofillHints.givenName,
                          ],
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
                        value: state.school,
                        isExpanded: true,
                        padding: const EdgeInsets.all(16.0),
                        onChanged: notifier.onChangedSchool,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                Row(
                  children: [
                    Expanded(
                      child: FormItem(
                        label: 'ユーザーの種類',
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
                              onChanged: notifier.onChangedUserType,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 32.0),
                    Expanded(
                      child: FormItem(
                        label: '性別',
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
                                for (Gender gender in Gender.values)
                                  DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender.displayText),
                                  ),
                              ],
                              value: state.gender,
                              isExpanded: true,
                              padding: const EdgeInsets.all(16.0),
                              onChanged: notifier.onChangedGender,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
          if (state.isLoading) const LoadingView(),
        ],
      ),
    );
  }
}
