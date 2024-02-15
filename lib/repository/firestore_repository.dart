import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_manager/models/channel.dart';
import 'package:document_manager/models/class.dart';
import 'package:document_manager/models/post.dart';
import 'package:document_manager/models/school.dart';
import 'package:document_manager/models/user.dart';
import 'package:uuid/uuid.dart';

/// CloudFirestoreのRepositoryクラスです。
class FirestoreRepository {
  static String _schoolId = '';
  static String _userId = '';

  static void initilezed({
    required String schoolId,
    required String userId,
  }) {
    if (_schoolId.isNotEmpty && _userId.isNotEmpty) {
      return;
    }
    _schoolId = schoolId;
    _userId = userId;
  }

  static void reset() {
    _schoolId = '';
    _userId = '';
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> userSnapshots({
    bool isApproved = true,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('schoolId', isEqualTo: _schoolId)
        .where('isApproved', isEqualTo: isApproved)
        .orderBy('lastName', descending: true)
        .snapshots();
  }

  static Stream<List<User>> getUsersStream() async* {
    try {
      final querySnapshot = FirebaseFirestore.instance
          .collection('users')
          .where('schoolId', isEqualTo: _schoolId)
          .orderBy('userType')
          .orderBy('lastName')
          .orderBy('firstName')
          .snapshots();
      await for (var snapshot in querySnapshot) {
        final List<User> users =
            snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
        yield users;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<User>> getUsers({bool isApproved = true}) async {
    List<User> users = [];
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .where('schoolId', isEqualTo: _schoolId)
          .where('isApproved', isEqualTo: isApproved)
          .orderBy('userType')
          .orderBy('gender')
          .orderBy('lastName')
          .orderBy('firstName')
          .get();
      users = doc.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              User.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
    return users;
  }

  static Future<User> getUser(String userId) async {
    User user;
    try {
      final response = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      user = User.fromJson(response.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
    return user;
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

  static Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('user').doc(userId).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> postSnapshots({
    required String channelId,
    String? searchWord,
  }) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('schoolId', isEqualTo: _schoolId)
        .where('channelId', isEqualTo: channelId)
        .orderBy('createdAt')
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> documentsSnapshots({
    String? searchWord,
  }) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('schoolId', isEqualTo: _schoolId)
        .where('imageUrl', isNotEqualTo: '')
        .snapshots();
  }

  static Future<void> setPost({
    required String postId,
    required String channelId,
    required String message,
    required String imageUrl,
    required List<String> imageTexts,
  }) async {
    final Post post = Post(
      id: postId,
      schoolId: _schoolId,
      channelId: channelId,
      userId: _userId,
      createdAt: DateTime.now(),
      message: message,
      imageUrl: imageUrl,
      imageTexts: imageTexts,
      readUserIds: [],
    );
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .set(post.toJson());
    } catch (e) {
      throw Exception('Failed to set post: $e');
    }
  }

  static Future<void> updatePost({required Post post}) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(post.id)
          .set(post.toJson());
    } catch (e) {
      throw Exception('Failed to update post: $e');
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

  static Future<School> getSchool(String schoolId) async {
    School school;
    try {
      final doc = await FirebaseFirestore.instance
          .collection('schools')
          .doc(schoolId)
          .get();
      school = School.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
    return school;
  }

  static Future<List<School>> getSchools() async {
    List<School> schools = [];
    try {
      final response = await FirebaseFirestore.instance
          .collection('schools')
          .orderBy('name')
          .get();
      schools = response.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              School.fromJson(doc.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
    return schools;
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
