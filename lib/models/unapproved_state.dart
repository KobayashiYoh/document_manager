import 'package:document_manager/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unapproved_state.freezed.dart';

@freezed
class UnapprovedState with _$UnapprovedState {
  const factory UnapprovedState({
    required bool isLoading,
    required bool hasError,
    required List<User> approvedUser,
    required bool userIsDeleted,
  }) = _UnapprovedState;
}

const UnapprovedState kDefaultUnapprovedState = UnapprovedState(
  isLoading: false,
  hasError: false,
  approvedUser: [],
  userIsDeleted: false,
);
