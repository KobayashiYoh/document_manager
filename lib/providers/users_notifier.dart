import 'package:document_manager/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersProvider = StateNotifierProvider<UsersNotifier, List<User>>(
  (ref) => UsersNotifier(),
);

class UsersNotifier extends StateNotifier<List<User>> {
  UsersNotifier() : super([]);

  void setUsers(List<User> users) {
    state = users;
  }

  void reset() {
    state = kDefaultUsers;
  }
}
