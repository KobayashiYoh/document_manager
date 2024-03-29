import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String schoolId,
    required String channelId,
    required String userId,
    required DateTime createdAt,
    required String message,
    required String imageUrl,
    required List<String> imageTexts,
    required List<String> readUserIds,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}

final Post kDefaultPost = Post(
  id: '',
  schoolId: '',
  channelId: '',
  userId: '',
  createdAt: DateTime(0),
  message: '',
  imageUrl: '',
  imageTexts: [],
  readUserIds: [],
);

final Post kExamplePost = Post(
  id: 'example-post',
  schoolId: kExampleSchool.id,
  channelId: kExampleChannel.id,
  userId: kExampleTeacher.id,
  createdAt: DateTime.now(),
  message: 'テスト投稿です。',
  imageUrl: '',
  imageTexts: [],
  readUserIds: [kExampleParent.id, kExampleStudent.id],
);

extension PostExtension on Post {
  int get readCount => readUserIds.length;

  String get createdAtText {
    final now = DateTime.now();
    final bool isToday = createdAt.day == now.day &&
        createdAt.month == now.month &&
        createdAt.year == now.year;
    final bool isThisYear = createdAt.year == now.year;
    if (isToday) {
      return DateFormat('HH:mm').format(createdAt);
    } else if (isThisYear) {
      return DateFormat('MM/dd HH:mm').format(createdAt);
    } else {
      return DateFormat('yyyy/MM/dd HH:mm').format(createdAt);
    }
  }
}
