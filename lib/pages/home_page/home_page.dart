import 'package:document_manager/providers/users_notifier.dart';
import 'package:document_manager/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final users = ref.watch(usersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: Center(
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: users.length,
            itemBuilder: (context, index) => UserItem(user: users[index])),
      ),
    );
  }
}
