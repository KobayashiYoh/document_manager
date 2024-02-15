import 'package:document_manager/models/gender.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required bool isLoading,
    required bool hasError,
    required bool obscureText,
    required List<School> schools,
    required School? school,
    required UserType? userType,
    required Gender? gender,
  }) = _SignUpState;
}

const SignUpState kDefaultSignUpState = SignUpState(
  isLoading: false,
  hasError: false,
  obscureText: true,
  schools: [],
  school: null,
  userType: null,
  gender: null,
);
