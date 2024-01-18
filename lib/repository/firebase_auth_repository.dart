import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository {
  static Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final UserCredential result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  }

  static Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final UserCredential result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  }
}
