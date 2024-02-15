import 'package:document_manager/models/user.dart';
import 'package:document_manager/providers/signed_in_school_notifier.dart';
import 'package:document_manager/widgets/user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends ConsumerState<UserPage> {
  @override
  Widget build(BuildContext context) {
    final signedInSchool = ref.watch(signedInSchoolProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー'),
      ),
      body: UserView(
        user: widget.user,
        schoolName: signedInSchool!.name,
      ),
    );
  }
}
