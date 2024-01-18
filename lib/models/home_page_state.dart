import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    required bool isLoading,
    required bool hasError,
  }) = _HomePageState;
}

const HomePageState kDefaultHomePageState = HomePageState(
  isLoading: false,
  hasError: false,
);
