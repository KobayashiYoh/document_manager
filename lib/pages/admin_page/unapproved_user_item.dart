import 'package:document_manager/models/user.dart';
import 'package:document_manager/widgets/circle_icon_image.dart';
import 'package:flutter/material.dart';

class UnapprovedUserItem extends StatelessWidget {
  const UnapprovedUserItem({
    Key? key,
    required this.user,
    required this.onPressedRejection,
    required this.onPressedApproval,
  }) : super(key: key);

  final User user;
  final void Function()? onPressedRejection;
  final void Function()? onPressedApproval;

  final _buttonSize = const Size(80.0, 32.0);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          CircleIconImage(
            imageUrl: user.iconImageUrl,
            errorImagePath: 'assets/images/default_user.png',
          ),
          const SizedBox(width: 8.0),
          Text(
            user.fullNameWithUserType,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: _buttonSize.width,
            height: _buttonSize.height,
            child: ElevatedButton(
              onPressed: onPressedRejection,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
              ),
              child: const Text(
                '拒否',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: _buttonSize.width,
            height: _buttonSize.height,
            child: ElevatedButton(
              onPressed: onPressedApproval,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                '承認',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
