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
  }) = _School;

  factory School.fromJson(Map<String, Object?> json) => _$SchoolFromJson(json);
}

const School kDefaultSchool = School(
  id: '',
  iconImageUrl: '',
  name: '',
  description: '',
);

const School kExampleSchool = School(
  id: '7166a822-12b1-476c-bd27-90d6c8224ca4',
  iconImageUrl: '',
  name: 'デバッグ小学校',
  description: 'デバッグ小学校です。',
);
