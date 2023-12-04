import 'dart:async';

import 'package:document_manager/debug/debug_user_item.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:flutter/material.dart';

class DebugUsersPage extends StatefulWidget {
  const DebugUsersPage({Key? key}) : super(key: key);

  @override
  State<DebugUsersPage> createState() => _DebugUsersPageState();
}

class _DebugUsersPageState extends State<DebugUsersPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();

  Future<void> _setUser(User user) async {
    try {
      await FirestoreRepository.setUser(user);
    } catch (e) {
      rethrow;
    }
    _idController.clear();
    _lastNameController.clear();
    _firstNameController.clear();
  }

  @override
  void dispose() {
    _idController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DebugUsersPage'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              StreamBuilder(
                stream: FirestoreRepository.userSnapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<User> users = snapshot.data!.docs
                          .map((doc) => User.fromJson(doc.data()))
                          .toList();
                      return DebugUserItem(user: users[index]);
                    },
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 80.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                height: 160.0,
                child: Column(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _idController,
                        decoration: const InputDecoration(
                          label: Text('ID'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          label: Text('苗字'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          label: Text('名前'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _setUser(
          User(
            id: _idController.text,
            userType: UserType.parent,
            iconImageUrl: '',
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
