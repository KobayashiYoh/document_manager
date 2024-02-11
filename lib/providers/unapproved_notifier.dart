import 'package:document_manager/models/unapproved_state.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final unapprovedProvider =
    StateNotifierProvider.autoDispose<UnapprovedNotifier, UnapprovedState>(
  (ref) => UnapprovedNotifier(ref),
);

class UnapprovedNotifier extends StateNotifier<UnapprovedState> {
  UnapprovedNotifier(this.ref) : super(kDefaultUnapprovedState) {
    _approvedUsersStream = FirestoreRepository.getUsersStream();
    _approvedUsersStream.listen(_listener);
  }

  late Stream<List<User>> _approvedUsersStream;

  final Ref ref;

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  Future<void> _listener(List<User> users) async {
    final signedInUser = ref.read(signedInUserProvider);
    if (signedInUser == null) {
      return;
    }
    final user = users.firstWhere(
      (element) => element.id == signedInUser.id,
      orElse: () => kDefaultUser,
    );
    final signedInUserNotifier = ref.read(signedInUserProvider.notifier);
    // 承認と非承認が切り替わった場合のみユーザーにそのことが伝わるよう1秒待機する。
    if (user.isApproved != signedInUser.isApproved) {
      setLoading(true);
      await Future.delayed(const Duration(seconds: 1));
    } else {
      return;
    }
    if (user == kDefaultUser) {
      state = state.copyWith(userIsDeleted: true);
      signedInUserNotifier.setSignedInUser(
        null,
      );
    } else if (user.isApproved) {
      signedInUserNotifier.setSignedInUser(
        signedInUser.copyWith(isApproved: true),
      );
    } else {
      signedInUserNotifier.setSignedInUser(
        signedInUser.copyWith(isApproved: false),
      );
    }
    setLoading(false);
  }
}
