import 'package:document_manager/debug/debug_channels_page.dart';
import 'package:document_manager/debug/debug_classes_page.dart';
import 'package:document_manager/debug/debug_posts_page.dart';
import 'package:document_manager/debug/debug_schools_page.dart';
import 'package:document_manager/debug/debug_users_page.dart';
import 'package:flutter/material.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DebugUsersPage(),
                ),
              );
            },
            child: const Text('DebugUsersPage'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DebugPostsPage(),
                ),
              );
            },
            child: const Text('DebugPostsPage'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DebugChannelsPage(),
                ),
              );
            },
            child: const Text('DebugChannelsPage'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DebugClassesPage(),
                ),
              );
            },
            child: const Text('DebugClassessPage'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DebugSchoolsPage(),
                ),
              );
            },
            child: const Text('DebugSchoolsPage'),
          ),
        ],
      ),
    );
  }
}
