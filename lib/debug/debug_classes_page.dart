import 'dart:async';

import 'package:document_manager/debug/debug_class_item.dart';
import 'package:document_manager/models/class.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:flutter/material.dart';

class DebugClassesPage extends StatefulWidget {
  const DebugClassesPage({Key? key}) : super(key: key);

  @override
  State<DebugClassesPage> createState() => _DebugClassesPageState();
}

class _DebugClassesPageState extends State<DebugClassesPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _setClasses() async {
    try {
      await FirestoreRepository.setClass(
        name: _nameController.text,
        description: _descriptionController.text,
      );
    } catch (e) {
      rethrow;
    }
    _nameController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DebugClasssPage'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              StreamBuilder(
                stream: FirestoreRepository.classSnapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<Class> homeroomClasses = snapshot.data!.docs
                          .map((doc) => Class.fromJson(doc.data()))
                          .toList();
                      return DebugClassItem(
                        homeroomClass: homeroomClasses[index],
                      );
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
                        controller: _nameController,
                        decoration: const InputDecoration(
                          label: Text('name'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          label: Text('description'),
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
        onPressed: () => _setClasses(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
