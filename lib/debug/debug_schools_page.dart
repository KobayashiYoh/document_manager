import 'dart:async';

import 'package:document_manager/debug/debug_school_item.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:flutter/material.dart';

class DebugSchoolsPage extends StatefulWidget {
  const DebugSchoolsPage({Key? key}) : super(key: key);

  @override
  State<DebugSchoolsPage> createState() => _DebugSchoolsPageState();
}

class _DebugSchoolsPageState extends State<DebugSchoolsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _setSchools() async {
    try {
      await FirestoreRepository.setSchool(
        name: _nameController.text,
        description: _descriptionController.text,
        channelIds: kExampleSchool.channelIds,
        classIds: kExampleSchool.classIds,
        userIds: kExampleSchool.userIds,
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
        title: const Text('DebugSchoolsPage'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              StreamBuilder(
                stream: FirestoreRepository.schoolSnapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final List<School> schools = snapshot.data!.docs
                          .map((doc) => School.fromJson(doc.data()))
                          .toList();
                      return DebugSchoolItem(school: schools[index]);
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
        onPressed: () => _setSchools(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
