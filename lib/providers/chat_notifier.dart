import 'package:document_manager/models/chat_state.dart';
import 'package:document_manager/providers/signed_in_school_notifier.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/providers/users_notifier.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/repository/secure_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = StateNotifierProvider.autoDispose<ChatNotifier, ChatState>(
  (ref) => ChatNotifier(ref),
);

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier(this.ref) : super(kDefaultChatState);

  final Ref ref;

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  Future<void> signOut() async {
    if (state.isLoading) {
      return;
    }
    try {
      await SecureStorageRepository.deleteSignInInfo();
      ref.read(signedInUserProvider.notifier).reset();
      ref.read(usersProvider.notifier).reset();
      ref.read(signedInSchoolProvider.notifier).reset();
      FirestoreRepository.reset();
    } catch (e) {
      setError(true);
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
