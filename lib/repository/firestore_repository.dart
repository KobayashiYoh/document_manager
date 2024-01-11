import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/class.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user.dart';
import 'package:uuid/uuid.dart';

/// CloudFirestoreのRepositoryクラスです。
class FirestoreRepository {
  static final _schoolId = kExampleSchool.id;
  static final _channelId = kExampleChannel.id;
  static final _userId = kExampleParent.id;

  static Stream<QuerySnapshot<Map<String, dynamic>>> userSnapshots() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('schoolId', isEqualTo: _schoolId)
        .orderBy('lastName', descending: true)
        .snapshots();
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> postSnapshots({
    required String channelId,
  }) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('schoolId', isEqualTo: _schoolId)
        .where('channelId', isEqualTo: channelId)
        .orderBy('createdAt')
        .snapshots();
  }

  static Future<void> setPost(
    String id,
    String message,
    String imageUrl,
  ) async {
    final Post post = Post(
      id: id,
      schoolId: _schoolId,
      channelId: _channelId,
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
    return FirebaseFirestore.instance
        .collection('channels')
        .where('schoolId', isEqualTo: _schoolId)
        .orderBy('name')
        .snapshots();
  }

  static Future<void> setChannel({
    required String name,
    required String description,
    required List<String> userIds,
  }) async {
    final String uuid = const Uuid().v4();
    final Channel channel = Channel(
      id: uuid,
      schoolId: _schoolId,
      iconImageUrl: '',
      name: name,
      description: description,
      userIds: userIds,
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
    return FirebaseFirestore.instance
        .collection('classes')
        .where('schoolId', isEqualTo: _schoolId)
        .orderBy('name')
        .snapshots();
  }

  static Future<void> setClass({
    required String name,
    required String description,
  }) async {
    final String uuid = const Uuid().v4();
    final Class homeroomClass = Class(
      id: uuid,
      schoolId: _schoolId,
      name: name,
      description: description,
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
    return FirebaseFirestore.instance
        .collection('schools')
        .orderBy('name')
        .snapshots();
  }

  static Future<void> setSchool({
    required String name,
    required String description,
  }) async {
    final String uuid = const Uuid().v4();
    final School school = School(
      id: uuid,
      iconImageUrl: '',
      name: name,
      description: description,
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
