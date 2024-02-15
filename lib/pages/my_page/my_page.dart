import 'package:document_manager/providers/sign_in_notifier.dart';
import 'package:document_manager/providers/signed_in_school_notifier.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/widgets/user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPage extends ConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signedInUser = ref.watch(signedInUserProvider);
    final signedInSchool = ref.watch(signedInSchoolProvider);
    final signInNotifier = ref.read(signInProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
      ),
      body: UserView(
        user: signedInUser!,
        schoolName: signedInSchool!.name,
        isMyPage: true,
        onTapSignOut: signInNotifier.signOut,
      ),
    );
  }
}
