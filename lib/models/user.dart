import 'package:document_manager/models/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required UserType userType,
    required String iconImageUrl,
    required String firstName,
    required String lastName,
  }) = _User;
}
