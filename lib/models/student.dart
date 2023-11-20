import 'package:document_manager/models/parent.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';

@freezed
class Student with _$Student {
  const factory Student({
    required String id,
    required String iconImageUrl,
    required String firstName,
    required String lastName,
    required List<Parent> parents,
  }) = _Student;
}
