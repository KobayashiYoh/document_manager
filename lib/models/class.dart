import 'package:document_manager/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'class.freezed.dart';

@freezed
class Class with _$Class {
  const factory Class({
    required String id,
    required String name,
    required String description,
    required User teacher,
    required List<User> students,
  }) = _Class;
}

const Class kDefaultClass = Class(
  id: '',
  name: '',
  description: '',
  teacher: kDefaultUser,
  students: [],
);
