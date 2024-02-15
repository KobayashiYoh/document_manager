import 'package:document_manager/utils/date_time_util.dart';

class ImageUrls {
  static const String _baseUrl =
      'https://firebasestorage.googleapis.com/v0/b/resukuru-mobile.appspot.com/o';
  static final String _queryParams = 'alt=media&v=${DateTimeUtil.timeStamp}';
  static const String _defaultUserPath = 'users%2Fdefault%2F';

  static String _generateUserImageUrl(String fileName) {
    return '$_baseUrl/$_defaultUserPath$fileName?$_queryParams';
  }

  static String get defaultFemaleParent =>
      _generateUserImageUrl('parent_woman.png');
  static String get defaultMaleParent =>
      _generateUserImageUrl('parent_man.png');
  static String get defaultFemaleTeacher =>
      _generateUserImageUrl('teacher_woman.jpeg');
  static String get defaultMaleTeacher =>
      _generateUserImageUrl('teacher_man.jpeg');
  static String get defaultFemaleStudent =>
      _generateUserImageUrl('parent_woman.png');
  static String get defaultMaleStudent =>
      _generateUserImageUrl('parent_man.png');
  static String get defaultUser => _generateUserImageUrl('default_user.png');
}
