import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/class.dart';
import 'package:document_manager/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'school.freezed.dart';
part 'school.g.dart';

@freezed
class School with _$School {
  const factory School({
    required String id,
    required String iconImageUrl,
    required String name,
    required String description,
    required List<Channel> channels,
    required List<Class> classes,
    required List<User> users,
  }) = _School;

  factory School.fromJson(Map<String, Object?> json) => _$SchoolFromJson(json);
}

const School kDefaultSchool = School(
  id: '',
  iconImageUrl: '',
  name: '',
  description: '',
  channels: [],
  classes: [],
  users: [],
);

final School kExampleSchool = School(
  id: 'example-school',
  iconImageUrl: '',
  name: 'デバッグ小学校',
  description: 'デバッグ小学校です。',
  channels: [kExampleChannel],
  classes: [kExampleClass],
  users: [kExampleParent, kExampleStudent, kExampleTeacher],
);
