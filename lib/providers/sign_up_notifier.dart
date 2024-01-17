import 'package:document_manager/models/sign_up_state.dart';
import 'package:document_manager/repository/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(),
);

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier() : super(kDefaultSignUpState);

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
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
