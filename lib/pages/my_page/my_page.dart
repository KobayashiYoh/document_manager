import 'package:document_manager/providers/sign_in_notifier.dart';
import 'package:document_manager/providers/signed_in_school_notifier.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/utils/navigator_util.dart';
import 'package:document_manager/widgets/user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPage extends ConsumerStatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends ConsumerState<MyPage> {
  Future<void> _signOut() async {
    await ref.read(signInProvider.notifier).signOut();
    if (!mounted) return;
    NavigatorUtil.backToSignInPage(context);
  }

  Future<void> _onTapSignOut(BuildContext context) async {
    NavigatorUtil.showSignOutAlertDialog(
      context,
      onPressedOK: _signOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final signedInUser = ref.watch(signedInUserProvider);
    final signedInSchool = ref.watch(signedInSchoolProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
      ),
      body: UserView(
        user: signedInUser!,
        schoolName: signedInSchool!.name,
        isMyPage: true,
        onTapSignOut: () => _onTapSignOut(context),
      ),
    );
  }
}
