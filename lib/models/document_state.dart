import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_state.freezed.dart';

@freezed
class DocumentState with _$DocumentState {
  const factory DocumentState({
    required bool isLoading,
    required bool hasError,
    required String searchWord,
  }) = _DocumentState;
}

const DocumentState kDefaultDocumentState = DocumentState(
  isLoading: false,
  hasError: false,
  searchWord: '',
);
