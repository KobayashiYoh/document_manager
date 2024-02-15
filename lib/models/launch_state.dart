import 'package:freezed_annotation/freezed_annotation.dart';

part 'launch_state.freezed.dart';

@freezed
class LaunchState with _$LaunchState {
  const factory LaunchState({
    required bool isLoading,
    required bool hasError,
  }) = _LaunchState;
}

const LaunchState kDefaultLaunchState = LaunchState(
  isLoading: false,
  hasError: false,
);
