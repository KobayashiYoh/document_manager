enum Gender {
  female,
  male,
  none;

  String get text {
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
