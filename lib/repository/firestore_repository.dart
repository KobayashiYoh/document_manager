import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/class.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/user.dart';

/// CloudFirestoreのRepositoryクラスです。
class FirestoreRepository {
  static Future<void> setUser(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      throw Exception('失敗しました。$e');
    }
  }

  static Future<void> setPost(Post post) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(post.id)
          .set(post.toJson());
    } catch (e) {
      throw Exception('失敗しました。$e');
    }
  }

  static Future<void> setChannel(Channel channel) async {
    try {
      await FirebaseFirestore.instance
          .collection('channel')
          .doc(channel.id)
          .set(channel.copyWith(posts: [], users: []).toJson());
      await FirebaseFirestore.instance
          .collection('channel')
          .doc(channel.id)
          .collection('list')
          .add({
        'posts': [for (Post post in channel.posts) post.toJson()],
        'users': [for (User user in channel.users) user.toJson()],
      });
    } catch (e) {
      throw Exception('Failed to set channel: $e');
    }
  }

  static Future<void> setClass(Class schoolClass) async {
    try {
      await FirebaseFirestore.instance
          .collection('class')
          .doc(schoolClass.id)
          .set(schoolClass.toJson());
    } catch (e) {
      throw Exception('Failed to set class: $e');
    }
  }
}
