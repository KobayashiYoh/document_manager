import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    required bool isLoading,
    required bool hasError,
    required bool obscureText,
  }) = _SignInState;
}

const SignInState kDefaultSignInState = SignInState(
  isLoading: false,
  hasError: false,
  obscureText: true,
);
