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
  id: '5e1c342a-6e8f-4baf-81f4-9bc68968392d',
  schoolId: kExampleSchool.id,
  iconImageUrl: '1-1',
  name: 'デバッグ用チャンネル',
  description: '1年1組のグループです。',
  userIds: [kExampleTeacher.id, kExampleStudent.id, kExampleParent.id],
);
