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
}
