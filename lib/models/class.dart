import 'package:document_manager/models/school.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'class.freezed.dart';
part 'class.g.dart';

@freezed
class Class with _$Class {
  const factory Class({
    required String id,
    required String schoolId,
    required String name,
    required String description,
  }) = _Class;

  factory Class.fromJson(Map<String, Object?> json) => _$ClassFromJson(json);
}

const Class kDefaultClass = Class(
  id: '',
  schoolId: '',
  name: '',
  description: '',
);

final Class kExampleClass = Class(
  id: 'example-class',
  schoolId: kExampleSchool.id,
  name: '1年1組',
  description: '1年1組のクラスです。',
);
