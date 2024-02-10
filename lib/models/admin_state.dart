import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_state.freezed.dart';

@freezed
class AdminState with _$AdminState {
  const factory AdminState({
    required bool isLoading,
    required bool hasError,
  }) = _AdminState;
}

const AdminState kDefaultAdminState = AdminState(
  isLoading: false,
  hasError: false,
);
