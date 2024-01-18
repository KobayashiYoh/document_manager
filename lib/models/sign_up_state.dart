import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required bool isLoading,
    required bool hasError,
    required List<School> schools,
    required School? selectedSchool,
    required double userTypeFieldWidth,
    required UserType userType,
  }) = _SignUpState;
}

const SignUpState kDefaultSignUpState = SignUpState(
  isLoading: false,
  hasError: false,
  schools: [],
  selectedSchool: null,
  userTypeFieldWidth: 0,
  userType: kDefaultUserType,
);
