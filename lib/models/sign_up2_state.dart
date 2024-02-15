import 'package:document_manager/models/gender.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up2_state.freezed.dart';

@freezed
class SignUp2State with _$SignUp2State {
  const factory SignUp2State({
    required bool isLoading,
    required bool hasError,
    required List<School> schools,
    required School? school,
    required UserType? userType,
    required Gender? gender,
  }) = _SignUp2State;
}

const SignUp2State kDefaultSignUp2State = SignUp2State(
  isLoading: false,
  hasError: false,
  schools: [],
  school: null,
  userType: null,
  gender: null,
);
