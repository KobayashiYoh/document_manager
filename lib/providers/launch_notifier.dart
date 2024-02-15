import 'package:document_manager/models/launch_state.dart';
import 'package:document_manager/providers/signed_in_school_notifier.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/providers/users_notifier.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/repository/secure_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final launchProvider = StateNotifierProvider<LaunchNotifier, LaunchState>(
  (ref) => LaunchNotifier(ref),
);

class LaunchNotifier extends StateNotifier<LaunchState> {
  LaunchNotifier(this.ref) : super(kDefaultLaunchState);

  final Ref ref;

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  Future<void> _signIn(String userId) async {
    try {
      final signedInUser = await FirestoreRepository.getUser(userId);
      FirestoreRepository.initilezed(
        schoolId: signedInUser.schoolId,
        userId: userId,
      );
      final users = await FirestoreRepository.getUsers();
      final school = await FirestoreRepository.getSchool(signedInUser.schoolId);
      ref.read(signedInUserProvider.notifier).setSignedInUser(signedInUser);
      ref.read(usersProvider.notifier).setUsers(users);
      ref.read(signedInSchoolProvider.notifier).setSignedInSchool(school);
    } catch (e) {
      setError(false);
      throw Exception('Failed to fetch sign in info: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<bool> isSignedIn() async {
    setLoading(true);
    setError(false);
    final signedInUserId = await SecureStorageRepository.readUserId();
    if (signedInUserId == null) {
      setLoading(false);
      return false;
    }
    try {
      await _signIn(signedInUserId);
    } catch (e) {
      setError(true);
      throw Exception('Failed to judge signed in: $e');
    } finally {
      setLoading(false);
    }
    return true;
  }
}
