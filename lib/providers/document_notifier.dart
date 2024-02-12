import 'package:document_manager/models/document_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final documentProvider = StateNotifierProvider<DocumentNotifier, DocumentState>(
  (ref) => DocumentNotifier(ref),
);

class DocumentNotifier extends StateNotifier<DocumentState> {
  DocumentNotifier(this.ref) : super(kDefaultDocumentState);

  final Ref ref;

  final TextEditingController searchTextController = TextEditingController();

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  void clearSearchText() {
    state = state.copyWith(searchWord: '');
    searchTextController.clear();
  }

  void onSubmittedSearch(String searchWord) {
    state = state.copyWith(searchWord: searchWord);
    print('searchWord: ${state.searchWord}');
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }
}
