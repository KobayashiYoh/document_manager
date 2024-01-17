import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required bool isLoading,
    required bool hasError,
  }) = _SignUpState;
}

const SignUpState kDefaultSignUpState = SignUpState(
  isLoading: false,
  hasError: false,
);
