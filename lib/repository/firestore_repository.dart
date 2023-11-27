import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/class.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/school.dart';
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
      throw Exception('Failed to set user: $e');
    }
  }

  static Future<void> setPost(Post post) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(post.id)
          .set(post.toJson());
    } catch (e) {
      throw Exception('Failed to set post: $e');
    }
  }

  static Future<void> setChannel(Channel channel) async {
    try {
      await FirebaseFirestore.instance
          .collection('channels')
          .doc(channel.id)
          .set(channel.copyWith(posts: []).toJson());
      await FirebaseFirestore.instance
          .collection('channels')
          .doc(channel.id)
          .collection('list')
          .add({
        'posts': [for (Post post in channel.posts) post.toJson()],
      });
    } catch (e) {
      throw Exception('Failed to set channel: $e');
    }
  }

  static Future<void> setClass(Class schoolClass) async {
    try {
      await FirebaseFirestore.instance
          .collection('classes')
          .doc(schoolClass.id)
          .set(schoolClass.toJson());
    } catch (e) {
      throw Exception('Failed to set class: $e');
    }
  }

  static Future<void> setSchool(School school) async {
    try {
      await FirebaseFirestore.instance
          .collection('schools')
          .doc(school.id)
          .set(school.copyWith(channels: [], users: [], classes: []).toJson());
      await FirebaseFirestore.instance
          .collection('schools')
          .doc(school.id)
          .collection('list')
          .add({
        'channels': [
          for (Channel channel in school.channels)
            channel.copyWith(posts: []).toJson()
        ],
        'users': [for (User user in school.users) user.toJson()],
        'classes': [for (Class classroom in school.classes) classroom.toJson()],
      });
    } catch (e) {
      throw Exception('Failed to set school: $e');
    }
  }
}
