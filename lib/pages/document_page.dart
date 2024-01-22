import 'package:flutter/material.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({Key? key}) : super(key: key);

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
