import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/sign_up_state.dart';
import 'package:document_manager/models/user.dart' as custom;
import 'package:document_manager/models/user_type.dart';
import 'package:document_manager/providers/signed_in_school_notifier.dart';
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/repository/firebase_auth_repository.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:document_manager/repository/secure_storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(ref),
);

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier(this.ref) : super(kDefaultSignUpState) {
    _initialize();
  }

  final Ref ref;

  Future<void> _initialize() async {
    List<School> schools = [];
    setLoading(true);
    try {
      schools = await FirestoreRepository.getSchools();
    } catch (e) {
      setError(true);
      rethrow;
    } finally {
      setLoading(false);
    }
    state = state.copyWith(schools: schools);
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  void switchObscureText() {
    state = state.copyWith(obscureText: !state.obscureText);
  }

  void onChangedSchool(School? school) {
    if (school == null) {
      return;
    }
    state = state.copyWith(selectedSchool: school);
  }

  void onChangedUserType(UserType? userType) {
    if (userType == null) {
      return;
    }
    state = state.copyWith(userType: userType);
  }

  void setUserTypeFieldWidth(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    state = state.copyWith(
      userTypeFieldWidth: renderBox!.size.width,
    );
  }

  Future<void> _setSignInInfo(custom.User user, School school) async {
    ref.read(signedInUserProvider.notifier).setSignedInUser(user);
    ref.read(signedInSchoolProvider.notifier).setSignedInSchool(school);
    FirestoreRepository.initilezed(
      schoolId: user.schoolId,
      userId: user.id,
    );
    await SecureStorageRepository.writeSignInInfo(
      userId: user.id,
      schoolId: school.id,
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String lastName,
    required String firstName,
  }) async {
    if (state.isLoading) {
      return;
    }
    UserCredential userCredential;
    custom.User user;
    School school;
    setError(false);
    setLoading(true);
    try {
      userCredential = await FirebaseAuthRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      setError(true);
      rethrow;
    }
    if (userCredential.user == null) {
      return;
    }
    user = custom.User(
      id: userCredential.user!.uid,
      schoolId: state.selectedSchool!.id,
      classId: '',
      channelIds: [],
      isApproved: false,
      userType: state.userType,
      iconImageUrl: '',
      firstName: firstName,
      lastName: lastName,
      email: userCredential.user?.email,
    );
    try {
      await FirestoreRepository.setUnapprovedUser(user);
      school = await FirestoreRepository.getSchool(user.schoolId);
      await _setSignInInfo(user, school);
    } catch (e) {
      setError(true);
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
