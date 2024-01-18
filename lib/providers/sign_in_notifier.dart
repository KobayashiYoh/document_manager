import 'package:document_manager/models/sign_in_state.dart';
import 'package:document_manager/models/user.dart' as custom;
import 'package:document_manager/providers/signed_in_user_notifier.dart';
import 'package:document_manager/repository/firebase_auth_repository.dart';
import 'package:document_manager/repository/firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>(
  (ref) => SignInNotifier(ref),
);

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier(this.ref) : super(kDefaultSignInState);

  final Ref ref;

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
  }) async {
    if (state.isLoading) {
      return;
    }
    UserCredential userCredential;
    custom.User user;
    setError(false);
    setLoading(true);
    try {
      userCredential = await FirebaseAuthRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        return;
      }
      user = await FirestoreRepository.getUser(userCredential.user!.uid);
    } catch (e) {
      setError(true);
      rethrow;
    } finally {
      setLoading(false);
    }
    ref.read(signedInUserProvider.notifier).setSignedInUser(user);
    FirestoreRepository.initilezed(
      schoolId: user.schoolId,
      userId: user.id,
    );
  }
}
