import 'package:document_manager/models/user.dart';
import 'package:document_manager/utils/navigator_util.dart';
import 'package:document_manager/widgets/circle_user_icon_image.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorUtil.goToUserPage(context, user: user),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          children: [
            CircleUserIconImage(user: user),
            const SizedBox(width: 8.0),
            Text(
              user.fullNameWithUserType,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
