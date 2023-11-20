import 'package:freezed_annotation/freezed_annotation.dart';

part 'parent.freezed.dart';

@freezed
class Parent with _$Parent {
  const factory Parent({
    required String id,
    required String iconImageUrl,
    required String firstName,
    required String lastName,
  }) = _Parent;
}
