import 'package:document_manager/models/class.dart';
import 'package:flutter/material.dart';

class DebugClassItem extends StatelessWidget {
  const DebugClassItem({
    Key? key,
    required this.homeroomClass,
  }) : super(key: key);

  final Class homeroomClass;

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
          'ID: ${homeroomClass.id}, name: ${homeroomClass.name}, description: ${homeroomClass.description}'),
    );
  }
}
