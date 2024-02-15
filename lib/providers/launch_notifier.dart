import 'package:document_manager/models/launch_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final launchProvider = StateNotifierProvider<LaunchNotifier, LaunchState>(
  (ref) => LaunchNotifier(ref),
);

class LaunchNotifier extends StateNotifier<LaunchState> {
  LaunchNotifier(this.ref) : super(kDefaultLaunchState);

  final Ref ref;

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }
}
