import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentPage extends ConsumerStatefulWidget {
  const DocumentPage({super.key});

  @override
  DocumentPageState createState() => DocumentPageState();
}

class DocumentPageState extends ConsumerState<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プリント'),
      ),
      body: const Center(
        child: Text('プリント'),
      ),
    );
  }
}
