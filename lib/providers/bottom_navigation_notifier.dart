import 'package:document_manager/models/bottom_navigation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationProvider = StateNotifierProvider.autoDispose<
    BottomNavigationNotifier, BottomNavigationState>(
  (ref) => BottomNavigationNotifier(ref),
);

class BottomNavigationNotifier extends StateNotifier<BottomNavigationState> {
  BottomNavigationNotifier(this.ref) : super(kDefaultBottomNavigationState);

  final Ref ref;

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(bool value) {
    state = state.copyWith(hasError: value);
  }

  void onItemTapped(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}
