import 'package:document_manager/models/user.dart';
import 'package:document_manager/pages/sign_in_page/sign_in_page.dart';
import 'package:document_manager/pages/user_page/user_page.dart';
import 'package:document_manager/widgets/common_cupertino_alert_dialog.dart';
import 'package:document_manager/widgets/common_material_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtil {
  static void showCommonAlertDialog(
    BuildContext context, {
    required String titleText,
    required String contentText,
    void Function()? onPressedCancel,
    required void Function()? onPressedOK,
    bool hideCancel = false,
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CommonCupertinoAlertDialog(
          titleText: titleText,
          contentText: contentText,
          onPressedCancel: onPressedCancel,
          onPressedOK: onPressedOK,
          hideCancel: hideCancel,
        ),
      );
    } else {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CommonMaterialAlertDialog(
            titleText: titleText,
            contentText: contentText,
            onPressedCancel: onPressedCancel,
            onPressedOK: onPressedOK,
            hideCancel: hideCancel,
          );
        },
      );
    }
  }

  static void goToUserPage(
    BuildContext context, {
    required User user,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserPage(user: user),
      ),
    );
  }

  static void backToSignInPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SignInPage()),
      (route) => false,
    );
  }

  static void showSignOutAlertDialog(
    BuildContext context, {
    void Function()? onPressedOK,
  }) {
    showCommonAlertDialog(
      context,
      titleText: 'ログアウトしますか？',
      contentText: '再度ログインするにはメールアドレスをパスワード入力する必要があります。',
      onPressedOK: onPressedOK,
    );
  }
}
