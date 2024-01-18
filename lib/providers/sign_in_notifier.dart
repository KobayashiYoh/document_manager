import 'package:document_manager/models/sign_in_state.dart';
import 'package:document_manager/repository/firebase_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>(
  (ref) => SignInNotifier(),
);

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier() : super(kDefaultSignInState);

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  void switchObscureText() {
    state = state.copyWith(obscureText: !state.obscureText);
  }

  Future<void> signIn({
    required String email,
    required String password,
    required String lastName,
    required String firstName,
  }) async {
    if (state.isLoading) {
      return;
    }
    setError(false);
    setLoading(true);
    try {
      await FirebaseAuthRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      setError(true);
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
