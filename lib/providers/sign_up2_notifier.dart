import 'package:document_manager/models/gender.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/sign_up2_state.dart';
import 'package:document_manager/models/user.dart' as model;
import 'package:document_manager/models/user_type.dart';
import 'package:document_manager/providers/sign_in_notifier.dart';
import 'package:document_manager/providers/sign_up1_notifier.dart';
import 'package:document_manager/repository/firebase_auth_repository.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUp2Provider = StateNotifierProvider<SignUp2Notifier, SignUp2State>(
  (ref) => SignUp2Notifier(ref),
);

class SignUp2Notifier extends StateNotifier<SignUp2State> {
  SignUp2Notifier(this.ref) : super(kDefaultSignUp2State) {
    _fetchSchools();
  }

  final Ref ref;

  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();

  Future<void> _fetchSchools() async {
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

  void onChangedSchool(School? school) {
    if (school == null) {
      return;
    }
    state = state.copyWith(school: school);
  }

  void onChangedUserType(UserType? userType) {
    if (userType == null) {
      return;
    }
    state = state.copyWith(userType: userType);
  }

  void onChangedGender(Gender? gender) {
    if (gender == null) {
      return;
    }
    state = state.copyWith(gender: gender);
  }

  void reset() {
    state = kDefaultSignUp2State;
    lastNameController.clear();
    firstNameController.clear();
  }

  Future<UserCredential> _signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await FirebaseAuthRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      setError(true);
      rethrow;
    }
  }

  Future<void> _createUser(model.User user) async {
    try {
      await FirestoreRepository.setUser(user);
    } catch (e) {
      setError(true);
      rethrow;
    }
  }

  Future<void> signUp() async {
    if (state.isLoading) {
      return;
    }
    final bool isNotCompleteForm = lastNameController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        state.school == null ||
        state.userType == null ||
        state.gender == null;
    if (isNotCompleteForm) {
      return;
    }
    final email = ref.read(signUp1Provider.notifier).emailController.text;
    final password = ref.read(signUp1Provider.notifier).passwordController.text;
    setError(false);
    setLoading(true);
    try {
      final userCredential = await _signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        return;
      }
      model.User user = model.User(
        id: userCredential.user!.uid,
        schoolId: state.school!.id,
        classId: '',
        channelIds: [],
        isApproved: false,
        userType: state.userType!,
        gender: state.gender!,
        iconImageUrl: '',
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: email,
      );
      user = user.copyWith(iconImageUrl: user.defaultIconImageUrl);
      await _createUser(user);
      final school = await FirestoreRepository.getSchool(user.schoolId);
      await ref.read(signInProvider.notifier).setSignInInfo(user, school);
    } catch (e) {
      setError(true);
      throw Exception('Failed to sign up: $e');
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    lastNameController.dispose();
    firstNameController.dispose();
    super.dispose();
  }
}
