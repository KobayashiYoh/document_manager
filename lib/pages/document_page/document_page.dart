import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/widgets/post_item.dart';
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
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final List<Post> posts = snapshot.data!.docs
                  .map((doc) => Post.fromJson(doc.data()))
                  .toList();
              final post = posts[index];
              return PostItem(
                post: post,
                user: kDefaultUser,
                signedInUserId: kDefaultUser.id,
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
