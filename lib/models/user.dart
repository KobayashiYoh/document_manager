import 'package:document_manager/models/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required UserType userType,
    required String iconImageUrl,
    required String firstName,
    required String lastName,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

const User kDefaultUser = User(
  id: '',
  userType: UserType.student,
  iconImageUrl: '',
  firstName: '',
  lastName: '',
);