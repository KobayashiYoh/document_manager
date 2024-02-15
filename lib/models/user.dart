import 'package:document_manager/constants/image_urls.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/class.dart';
import 'package:document_manager/models/gender.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String schoolId,
    required String classId,
    required List<String> channelIds,
    required bool isApproved,
    required UserType userType,
    required Gender gender,
    required String iconImageUrl,
    required String firstName,
    required String lastName,
    String? email,
    String? parentId1,
    String? parentId2,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

extension UserExtension on User {
  String get fullName => '$lastName $firstName';
  String get fullNameWithUserType => '$fullName（${userType.displayText}）';

  bool get isAdmin => userType == UserType.teacher;
  bool get isNotApproved => !isApproved;

  bool get isFemaleParent =>
      gender == Gender.female && userType == UserType.parent;
  bool get isMaleParent => gender == Gender.male && userType == UserType.parent;
  bool get isFemaleTeacher =>
      gender == Gender.female && userType == UserType.teacher;
  bool get isMaleTeacher =>
      gender == Gender.male && userType == UserType.teacher;
  bool get isFemaleStudent =>
      gender == Gender.female && userType == UserType.teacher;
  bool get isMaleStudent =>
      gender == Gender.male && userType == UserType.student;

  String get defaultIconImageUrl {
    if (isFemaleParent) {
      return ImageUrls.femaleParent;
    } else if (isMaleParent) {
      return ImageUrls.maleParent;
    } else if (isFemaleTeacher) {
      return ImageUrls.femaleTeacher;
    } else if (isMaleTeacher) {
      return ImageUrls.maleTeacher;
    } else if (isFemaleStudent) {
      return ImageUrls.femaleStudent;
    } else if (isMaleStudent) {
      return ImageUrls.maleStudent;
    }
    return ImageUrls.defaultUser;
  }
}

const User kDefaultUser = User(
  id: '',
  schoolId: '',
  classId: '',
  channelIds: [],
  isApproved: false,
  userType: UserType.student,
  gender: Gender.none,
  iconImageUrl: '',
  firstName: '',
  lastName: '',
);

const List<User> kDefaultUsers = [];

final User _kExampleUser = User(
  id: 'example-parent',
  schoolId: kExampleSchool.id,
  classId: kDefaultClass.id,
  channelIds: [kDefaultChannel.id],
  isApproved: false,
  userType: UserType.parent,
  gender: Gender.none,
  iconImageUrl: '',
  firstName: '苗字',
  lastName: '名前',
);

final User kExampleParent = _kExampleUser.copyWith(
  id: 'example-parent',
  userType: UserType.parent,
  gender: Gender.female,
  firstName: '山田',
  lastName: 'ホゴシャコ',
);

final User kExampleStudent = _kExampleUser.copyWith(
  id: 'example-student',
  userType: UserType.student,
  gender: Gender.male,
  firstName: '山田',
  lastName: '学',
  parentId1: 'example-parent',
);

final User kExampleTeacher = _kExampleUser.copyWith(
  id: 'example-teacher',
  userType: UserType.teacher,
  gender: Gender.male,
  firstName: '谷山',
  lastName: '教授郎',
);
