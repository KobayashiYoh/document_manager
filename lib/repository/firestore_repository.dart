import 'package:cloud_firestore/cloud_firestore.dart';
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
}
