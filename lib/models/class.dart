import 'package:document_manager/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'class.freezed.dart';
part 'class.g.dart';

@freezed
class Class with _$Class {
  const factory Class({
    required String id,
    required String name,
    required String description,
    required List<String> teacherIds,
    required List<String> studentIds,
    required List<String> parentIds,
  }) = _Class;

  factory Class.fromJson(Map<String, Object?> json) => _$ClassFromJson(json);
}

const Class kDefaultClass = Class(
  id: '',
  name: '',
  description: '',
  teacherIds: [],
  studentIds: [],
  parentIds: [],
);

final Class kExampleClass = Class(
  id: 'example-class',
  name: '1年1組',
  description: '1年1組のクラスです。',
  teacherIds: [kExampleTeacher.id],
  studentIds: [kExampleStudent.id],
  parentIds: [kExampleParent.id],
);
