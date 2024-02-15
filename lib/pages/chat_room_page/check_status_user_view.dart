import 'package:document_manager/models/user.dart';
import 'package:document_manager/widgets/user_list_item.dart';
import 'package:flutter/material.dart';

class CheckStatusUserView extends StatefulWidget {
  const CheckStatusUserView({
    Key? key,
    required this.sameSchoolUsers,
    required this.channelUserIds,
    required this.readUserIds,
  }) : super(key: key);

  final List<User> sameSchoolUsers;
  final List<String> channelUserIds;
  final List<String> readUserIds;

  @override
  State<CheckStatusUserView> createState() => _CheckStatusUserViewState();
}

class _CheckStatusUserViewState extends State<CheckStatusUserView> {
  final List<User> _readUsers = [];
  final List<User> _unreadUsers = [];

  @override
  void initState() {
    super.initState();
    final sameChannelUsers = widget.sameSchoolUsers
        .where((user) => widget.channelUserIds.contains(user.id));
    for (final sameChannelUser in sameChannelUsers) {
      final bool isReadUser = widget.readUserIds.contains(sameChannelUser.id);
      if (isReadUser) {
        _readUsers.add(sameChannelUser);
      } else {
        _unreadUsers.add(sameChannelUser);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = _readUsers.length + _unreadUsers.length + 2;
    return ListView.builder(
      itemCount: itemCount,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemBuilder: (context, index) {
        if (index == 0) {
          return _readUsers.isEmpty
              ? const SizedBox.shrink()
              : const Text('チェック済');
        } else if (index < _readUsers.length + 1) {
          return UserListItem(user: _readUsers[index - 1]);
        } else if (index == _readUsers.length + 1) {
          return _unreadUsers.isEmpty
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(top: _readUsers.isEmpty ? 0 : 32.0),
                  child: const Text('未チェック'),
                );
        } else {
          return UserListItem(
              user: _unreadUsers[index - _readUsers.length - 2]);
        }
      },
    );
  }
}
