import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/sign_up_state.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:document_manager/repository/firebase_auth_repository.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(),
);

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier() : super(kDefaultSignUpState) {
    _initialize();
  }

  Future<void> _initialize() async {
    List<School> schools = [];
    setLoading(true);
    try {
      schools = await FirestoreRepository.getSchool();
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

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    if (state.isLoading) {
      return;
    }
    UserCredential result;
    setError(false);
    setLoading(true);
    try {
      result = await FirebaseAuthRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      setError(true);
      rethrow;
    } finally {
      setLoading(false);
    }
    print('result: $result');
  }
}