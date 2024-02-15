import 'package:document_manager/models/sign_up1_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUp1Provider = StateNotifierProvider<SignUp1Notifier, SignUp1State>(
  (ref) => SignUp1Notifier(ref),
);

class SignUp1Notifier extends StateNotifier<SignUp1State> {
  SignUp1Notifier(this.ref) : super(kDefaultSignUp1State);

  final Ref ref;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  void switchObscureText() {
    state = state.copyWith(obscureText: !state.obscureText);
  }

  void reset() {
    state = kDefaultSignUp1State;
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
