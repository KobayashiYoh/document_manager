import 'package:document_manager/models/user.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/widgets/unapproved_user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  AdminPageState createState() => AdminPageState();
}

class AdminPageState extends ConsumerState<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('管理者'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StreamBuilder(
            stream: FirestoreRepository.unapprovedUserSnapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const SizedBox.shrink();
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    const Text(
                      '未承認ユーザー',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final List<User> users = snapshot.data!.docs
                            .map((doc) => User.fromJson(doc.data()))
                            .toList();
                        return UnapprovedUserItem(
                          user: users[index],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
