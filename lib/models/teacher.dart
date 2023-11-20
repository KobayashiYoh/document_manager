import 'package:freezed_annotation/freezed_annotation.dart';

part 'teacher.freezed.dart';

@freezed
class Teachers with _$Teachers {
  const factory Teachers({
    required String id,
    required String iconImageUrl,
    required String firstName,
    required String lastName,
  }) = _Teachers;
}
