import 'package:document_manager/models/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    required bool isLoading,
    required bool hasError,
    required XFile? image,
    required bool showSearchBar,
    required String searchWord,
  }) = _ChatState;
}

const kDefaultChatState = ChatState(
  isLoading: false,
  hasError: false,
  image: null,
  showSearchBar: true,
  searchWord: '',
);

extension ChatStateExtension on ChatState {
  bool isNotMachPost(Post post) {
    return searchWord.isNotEmpty && !isMachPost(post);
  }

  bool isMachPost(Post post) {
    final bool isMachMessage = post.message.contains(searchWord);
    bool isMachImageTexts = false;
    for (final imageText in post.imageTexts) {
      if (imageText.contains(searchWord)) {
        isMachImageTexts = true;
        break;
      }
    }
    return searchWord.isNotEmpty && (isMachMessage || isMachImageTexts);
  }
}
