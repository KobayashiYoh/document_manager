import 'package:document_manager/models/gender.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up1_state.freezed.dart';

@freezed
class SignUp1State with _$SignUp1State {
  const factory SignUp1State({
    required bool isLoading,
    required bool hasError,
    required bool obscureText,
  }) = _SignUp1State;
}

const SignUp1State kDefaultSignUp1State = SignUp1State(
  isLoading: false,
  hasError: false,
  obscureText: true,
);
