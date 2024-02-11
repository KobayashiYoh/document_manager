import 'package:document_manager/models/post.dart';
import 'package:document_manager/pages/document_page/document_item.dart';
import 'package:document_manager/repository/firestore_repository.dart';
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
      body: StreamBuilder(
        stream: FirestoreRepository.documentsSnapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SizedBox.shrink();
          }
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemBuilder: (context, index) {
              final List<Post> posts = snapshot.data!.docs
                  .map((doc) => Post.fromJson(doc.data()))
                  .toList();
              final post = posts[index];
              return DocumentItem(
                post: post,
                onLongPressCheck: () {},
                onPressedCheck: () {},
              );
            },
          );
        },
      ),
    );
  }
}
