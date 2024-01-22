import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_navigation_state.freezed.dart';

@freezed
class BottomNavigationState with _$BottomNavigationState {
  const factory BottomNavigationState({
    required bool isLoading,
    required bool hasError,
    required int selectedIndex,
  }) = _BottomNavigationState;
}

const kDefaultBottomNavigationState = BottomNavigationState(
  isLoading: false,
  hasError: false,
  selectedIndex: 0,
);
