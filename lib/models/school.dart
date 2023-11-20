import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/class.dart';
import 'package:document_manager/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'school.freezed.dart';

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
}
