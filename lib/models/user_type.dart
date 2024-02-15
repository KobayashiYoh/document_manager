import 'package:flutter/material.dart';

enum UserType {
  teacher,
  parent,
  student,
}

const UserType kDefaultUserType = UserType.parent;

extension UserTypeExtension on UserType {
  String get text {
    switch (this) {
      case (UserType.teacher):
        return 'teacher';
      case (UserType.parent):
        return 'parent';
      case (UserType.student):
        return 'student';
    }
  }

  String get displayText {
    switch (this) {
      case (UserType.teacher):
        return '教師';
      case (UserType.parent):
        return '保護者';
      case (UserType.student):
        return '学生';
    }
  }

  IconData get iconData {
    switch (this) {
      case (UserType.teacher):
        return Icons.admin_panel_settings_sharp;
      case (UserType.parent):
        return Icons.family_restroom;
      case (UserType.student):
        return Icons.school;
    }
  }
}
