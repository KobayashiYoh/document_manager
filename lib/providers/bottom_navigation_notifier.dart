import 'package:document_manager/models/bottom_navigation_state.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/providers/signed_in_school_notifier.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/providers/users_notifier.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/repository/secure_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationProvider = StateNotifierProvider.autoDispose<
    BottomNavigationNotifier, BottomNavigationState>(
  (ref) => BottomNavigationNotifier(ref),
);

class BottomNavigationNotifier extends StateNotifier<BottomNavigationState> {
  BottomNavigationNotifier(this.ref) : super(kDefaultBottomNavigationState) {
    _initialize();
  }

  final Ref ref;

  Future<void> _initialize() async {
    setLoading(true);
    String signedInUserId;
    User signedInUser;
    List<User> users;
    School school;
    try {
      signedInUserId = await SecureStorageRepository.readUserId() ?? '';
      signedInUser = await FirestoreRepository.getUser(signedInUserId);
      users = await FirestoreRepository.getUsers();
      school = await FirestoreRepository.getSchool(signedInUser.schoolId);
    } catch (e) {
      setError(true);
      rethrow;
    } finally {
      setLoading(false);
    }
    ref.read(signedInUserProvider.notifier).setSignedInUser(signedInUser);
    ref.read(usersProvider.notifier).setUsers(users);
    ref.read(signedInSchoolProvider.notifier).setSignedInSchool(school);
    FirestoreRepository.initilezed(
      schoolId: signedInUser.schoolId,
      userId: signedInUserId,
    );
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  void onItemTapped(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}
