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

  static Stream<QuerySnapshot<Map<String, dynamic>>> userSnapshots() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

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

  static Stream<QuerySnapshot<Map<String, dynamic>>> postSnapshots() {
    return FirebaseFirestore.instance.collection('posts').snapshots();
  }

  static Future<void> setPost(
    String id,
    String message,
    String imageUrl,
  ) async {
    final Post post = Post(
      id: id,
      userId: _userId,
      createdAt: DateTime.now(),
      message: message,
      imageUrl: imageUrl,
      readUserIds: [],
    );
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(id)
          .set(post.toJson());
    } catch (e) {
      throw Exception('Failed to set post: $e');
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> channelSnapshots() {
    return FirebaseFirestore.instance.collection('channels').snapshots();
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> classSnapshots() {
    return FirebaseFirestore.instance.collection('classes').snapshots();
  }

  static Future<void> setClass({
    required String name,
    required String description,
    required List<String> teacherIds,
    required List<String> studentIds,
    required List<String> parentIds,
  }) async {
    final String uuid = const Uuid().v4();
    final Class homeroomClass = Class(
      id: uuid,
      name: name,
      description: description,
      teacherIds: teacherIds,
      studentIds: studentIds,
      parentIds: parentIds,
    );
    try {
      await FirebaseFirestore.instance
          .collection('classes')
          .doc(uuid)
          .set(homeroomClass.toJson());
    } catch (e) {
      throw Exception('Failed to set class: $e');
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> schoolSnapshots() {
    return FirebaseFirestore.instance.collection('schools').snapshots();
  }

  static Future<void> setSchool({
    required String name,
    required String description,
    required List<String> channelIds,
    required List<String> classIds,
    required List<String> userIds,
  }) async {
    final String uuid = const Uuid().v4();
    final School school = School(
      id: uuid,
      iconImageUrl: '',
      name: name,
      description: description,
      channelIds: channelIds,
      classIds: classIds,
      userIds: userIds,
    );
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
