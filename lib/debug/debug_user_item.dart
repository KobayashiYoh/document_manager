import 'package:document_manager/models/user.dart';
import 'package:flutter/material.dart';

class DebugUserItem extends StatelessWidget {
  const DebugUserItem({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Text(
          'ID: ${user.id}, type: ${user.userType.name}, last name: ${user.lastName}, first name: ${user.firstName}'),
    );
  }
}
