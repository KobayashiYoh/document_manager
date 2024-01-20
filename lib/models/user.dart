import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/class.dart';
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
    required UserType userType,
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
}

const User kDefaultUser = User(
  id: '',
  schoolId: '',
  classId: '',
  channelIds: [],
  userType: UserType.student,
  iconImageUrl: '',
  firstName: '',
  lastName: '',
);

const List<User> kDefaultUsers = [];

final User kExampleStudent = User(
  id: 'example-student',
  schoolId: kExampleSchool.id,
  classId: kDefaultClass.id,
  channelIds: [kDefaultChannel.id],
  userType: UserType.student,
  iconImageUrl: '',
  firstName: '学生',
  lastName: '佐藤',
  parentId1: 'example-mother',
  parentId2: 'example-father',
);

final User kExampleParent = User(
  id: 'example-parent',
  schoolId: kExampleSchool.id,
  classId: kDefaultClass.id,
  channelIds: [kDefaultChannel.id],
  userType: UserType.parent,
  iconImageUrl: '',
  firstName: '保護者',
  lastName: '佐藤',
);

final User kExampleTeacher = User(
  id: 'example-teacher',
  schoolId: kExampleSchool.id,
  classId: kDefaultClass.id,
  channelIds: [kDefaultChannel.id],
  userType: UserType.teacher,
  iconImageUrl: '',
  firstName: '先生',
  lastName: '田中',
);
