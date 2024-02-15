import 'package:document_manager/providers/signed_in_school_notifier.dart';
import 'package:document_manager/providers/users_notifier.dart';
import 'package:document_manager/widgets/user_list_item.dart';
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
    final school = ref.watch(signedInSchoolProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (school != null)
              Container(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: Text(
                  school.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) => UserListItem(user: users[index]),
            ),
          ],
        ),
      ),
    );
  }
}
