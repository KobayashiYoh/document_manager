import 'package:document_manager/models/home_page_state.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user.dart';
import 'package:document_manager/providers/signed_in_school_notifier.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/repository/secure_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageProvider = StateNotifierProvider<HomePageNotifier, HomePageState>(
  (ref) => HomePageNotifier(ref),
);

class HomePageNotifier extends StateNotifier<HomePageState> {
  HomePageNotifier(this.ref) : super(kDefaultHomePageState) {
    initialize();
  }

  final Ref ref;

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  Future<void> initialize() async {
    setLoading(true);
    String userId;
    User user;
    School school;
    try {
      userId = await SecureStorageRepository.readUserId() ?? '';
      user = await FirestoreRepository.getUser(userId);
      school = await FirestoreRepository.getSchool(user.schoolId);
    } catch (e) {
      setError(true);
      rethrow;
    } finally {
      setLoading(false);
    }
    ref.read(signedInUserProvider.notifier).setSignedInUser(user);
    ref.read(signedInSchoolProvider.notifier).setSignedInSchool(school);
    FirestoreRepository.initilezed(
      schoolId: user.schoolId,
      userId: userId,
    );
  }

  Future<void> signOut() async {
    if (state.isLoading) {
      return;
    }
    try {
      await SecureStorageRepository.deleteUserId();
      ref.read(signedInUserProvider.notifier).reset();
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
