import 'package:document_manager/models/post.dart';
import 'package:document_manager/pages/document_page/document_item.dart';
import 'package:document_manager/providers/document_notifier.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/utils/post_util.dart';
import 'package:document_manager/widgets/post_search_bar.dart';
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
    final state = ref.watch(documentProvider);
    final notifier = ref.read(documentProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('プリント'),
      ),
      body: Column(
        children: [
          PostSearchBar(
            searchTextController: notifier.searchTextController,
            onSubmitted: (value) => notifier.onSubmittedSearch(
              notifier.searchTextController.text,
            ),
            onPressedClear: notifier.clearSearchText,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirestoreRepository.documentsSnapshots(
                searchWord: state.searchWord,
              ),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SizedBox.shrink();
                }
                final List<Post> posts = snapshot.data!.docs
                    .map((doc) => Post.fromJson(doc.data()))
                    .toList();
                final matchedPosts = PostUtil.searchPostFromImageText(
                  posts,
                  state.searchWord,
                );
                return GridView.builder(
                  itemCount: matchedPosts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                  itemBuilder: (context, index) {
                    return DocumentItem(post: matchedPosts[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
