import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel.freezed.dart';

@freezed
class Channel with _$Channel {
  const factory Channel({
    required String id,
    required String iconImageUrl,
    required String name,
    required String description,
    required List<User> users,
    required List<Post> posts,
  }) = _Channel;
}

const Channel kDefaultChannel = Channel(
  id: '',
  iconImageUrl: '',
  name: '',
  description: '',
  users: [],
  posts: [],
);
