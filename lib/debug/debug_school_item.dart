import 'package:document_manager/models/school.dart';
import 'package:flutter/material.dart';

class DebugSchoolItem extends StatelessWidget {
  const DebugSchoolItem({Key? key, required this.school}) : super(key: key);

  final School school;

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
          'ID: ${school.id}, name: ${school.name}, description: ${school.description}'),
    );
  }
}
