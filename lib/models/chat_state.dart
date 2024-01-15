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
