import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/class.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user.dart';
import 'package:uuid/uuid.dart';

/// CloudFirestoreのRepositoryクラスです。
class FirestoreRepository {
  static final _userId = kExampleParent.id;

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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    try {
      final data = FirebaseFirestore.instance.collection('users').snapshots();
      return data;
    } catch (e) {
      throw Exception('Failed to set user: $e');
    }
  }

  static Future<void> setPost(String message) async {
    final String uuid = const Uuid().v4();
    final Post post = Post(
      id: uuid,
      userId: _userId,
      createdAt: DateTime.now(),
      message: message,
      imageUrl: '',
      readUserIds: [],
    );
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(uuid)
          .set(post.toJson());
    } catch (e) {
      throw Exception('Failed to set post: $e');
    }
  }

  static Future<void> setChannel({
    required String name,
    required String description,
    required List<String> userIds,
    required List<String> postIds,
  }) async {
    final String uuid = const Uuid().v4();
    final Channel channel = Channel(
      id: uuid,
      iconImageUrl: '',
      name: name,
      description: description,
      userIds: userIds,
      postIds: postIds,
    );
    try {
      await FirebaseFirestore.instance
          .collection('channels')
          .doc(uuid)
          .set(channel.toJson());
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
          .set(school.toJson());
    } catch (e) {
      throw Exception('Failed to set school: $e');
    }
  }
}
