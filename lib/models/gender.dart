enum Gender {
  female,
  male,
  none;

  String get text {
    switch (this) {
      case Gender.female:
        return 'female';
      case Gender.male:
        return 'male';
      case Gender.none:
        return 'none';
    }
  }

  String get displayText {
    switch (this) {
      case Gender.female:
        return '女性';
      case Gender.male:
        return '男性';
      case Gender.none:
        return '無回答';
    }
  }
}
