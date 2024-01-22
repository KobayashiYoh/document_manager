import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'chat_room_state.freezed.dart';

@freezed
class ChatRoomState with _$ChatRoomState {
  const factory ChatRoomState({
    required bool isLoading,
    required bool hasError,
    required XFile? image,
    required bool showSearchBar,
    required String searchWord,
  }) = _ChatRoomState;
}

const kDefaultChatRoomState = ChatRoomState(
  isLoading: false,
  hasError: false,
  image: null,
  showSearchBar: true,
  searchWord: '',
);

extension ChatRoomStateExtension on ChatRoomState {
  bool isNotMachPost(Post post, User user) {
    return searchWord.isNotEmpty && !isMachPost(post, user);
  }

  bool isMachPost(Post post, User user) {
    final bool isMachMessage = post.message.contains(searchWord);
    final bool isMachFullNameWithUserType =
        user.fullNameWithUserType.contains(searchWord);
    bool isMachImageTexts = false;
    for (final imageText in post.imageTexts) {
      if (imageText.contains(searchWord)) {
        isMachImageTexts = true;
        break;
      }
    }
    return searchWord.isNotEmpty &&
        (isMachMessage || isMachFullNameWithUserType || isMachImageTexts);
  }
}
