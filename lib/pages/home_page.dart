import 'package:document_manager/providers/users_notifier.dart';
import 'package:document_manager/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final users = ref.watch(usersProvider);
    print('users: ${users.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホームページ'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) => UserItem(user: users[index])),
      ),
    );
  }
}
