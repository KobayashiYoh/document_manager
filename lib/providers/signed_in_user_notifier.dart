import 'package:document_manager/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signedInUserProvider = StateNotifierProvider<SignedInUserNotifier, User?>(
  (ref) => SignedInUserNotifier(),
);

class SignedInUserNotifier extends StateNotifier<User?> {
  SignedInUserNotifier() : super(null);

  bool get isSignedIn => state != null;

  void setSignedInUser(User user) {
    state = user;
  }

  void reset() {
    state = null;
  }
}
