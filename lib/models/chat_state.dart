import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    required bool isLoading,
    required bool hasError,
  }) = _ChatState;
}

const ChatState kDefaultChatState = ChatState(
  isLoading: false,
  hasError: false,
);
