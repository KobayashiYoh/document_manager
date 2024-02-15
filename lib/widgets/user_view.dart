import 'package:document_manager/models/user.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:document_manager/widgets/circle_user_icon_image.dart';
import 'package:document_manager/widgets/gender_icon.dart';
import 'package:document_manager/widgets/user_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserView extends StatelessWidget {
  const UserView({
    Key? key,
    required this.user,
    required this.schoolName,
    this.isMyPage = false,
    this.onTapSignOut,
  }) : super(key: key);

  final User user;
  final String schoolName;
  final bool isMyPage;
  final void Function()? onTapSignOut;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
        alignment: Alignment.center,
        child: Column(
          children: [
            CircleUserIconImage(
              user: user,
              diameter: 128.w,
            ),
            SizedBox(height: 16.h),
            Text(
              user.fullName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 32.h),
            UserViewItem(
              icon: Icon(user.userType.iconData),
              text: user.userType.displayText,
            ),
            SizedBox(height: 16.h),
            UserViewItem(
              icon: const GenderIcon(),
              text: user.gender.displayText,
            ),
            SizedBox(height: 16.h),
            UserViewItem(
              icon: const Icon(Icons.location_city),
              text: schoolName,
            ),
            SizedBox(height: 16.h),
            if (isMyPage && user.email != null)
              UserViewItem(
                icon: const Icon(Icons.email),
                text: user.email!,
              ),
            SizedBox(height: 16.h),
            if (isMyPage)
              UserViewItem(
                icon: const Icon(Icons.logout),
                text: 'ログアウト',
                onTap: onTapSignOut,
              ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
