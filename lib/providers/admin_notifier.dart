import 'package:document_manager/models/admin_state.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminProvider = StateNotifierProvider<AdminNotifier, AdminState>(
  (ref) => AdminNotifier(ref),
);

class AdminNotifier extends StateNotifier<AdminState> {
  AdminNotifier(this.ref) : super(kDefaultAdminState);

  final Ref ref;

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  Future<void> reject(User user) async {
    if (state.isLoading) {
      return;
    }
    setLoading(true);
    try {
      await FirestoreRepository.deleteUnapprovedUser(user.id);
    } catch (e) {
      setError(true);
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> approve(User user) async {
    if (state.isLoading) {
      return;
    }
    setLoading(true);
    try {
      await FirestoreRepository.setUser(user);
      await FirestoreRepository.deleteUnapprovedUser(user.id);
    } catch (e) {
      setError(true);
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
