import 'package:document_manager/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String userId,
    required DateTime createdAt,
    required String message,
    required String imageUrl,
    required List<User> readUsers,
  }) = _Post;
}
