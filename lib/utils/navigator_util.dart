import 'package:document_manager/widgets/common_cupertino_alert_dialog.dart';
import 'package:document_manager/widgets/common_material_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtil {
  static void showCommonAlertDialog(
    BuildContext context, {
    required String titleText,
    required String contentText,
    required void Function()? onPressedCancel,
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
}
