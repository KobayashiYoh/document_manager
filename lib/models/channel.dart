import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel.freezed.dart';
part 'channel.g.dart';

@freezed
class Channel with _$Channel {
  const factory Channel({
    required String id,
    required String schoolId,
    required String iconImageUrl,
    required String name,
    required String description,
    required List<String> userIds,
  }) = _Channel;

  factory Channel.fromJson(Map<String, Object?> json) =>
      _$ChannelFromJson(json);
}

const Channel kDefaultChannel = Channel(
  id: '',
  schoolId: '',
  iconImageUrl: '',
  name: '',
  description: '',
  userIds: [],
);

final Channel kExampleChannel = Channel(
  id: 'example-channel',
  schoolId: kExampleSchool.id,
  iconImageUrl: '',
  name: 'デバッグ用チャンネル',
  description: 'デバッグ用のチャンネルです。',
  userIds: [kExampleTeacher.id, kExampleStudent.id, kExampleParent.id],
);
