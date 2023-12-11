import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepository {
  static Future<void> put(File file, String storagePath) async {
    final storageRef = FirebaseStorage.instance.ref().child(storagePath);
    final metadata = SettableMetadata(contentType: 'image/png');
    try {
      await storageRef.putFile(file);
      await storageRef.updateMetadata(metadata);
    } catch (e) {
      throw Exception('Firebase Cloud Storageへのファイルのアップロードに失敗しました: $e');
    }
  }

  static Future<void> delete(String storagePath) async {
    final storageRef = FirebaseStorage.instance.ref().child(storagePath);
    try {
      await storageRef.delete();
    } catch (e) {
      throw Exception('Firebase Cloud Storageのファイルの削除に失敗しました: $e');
    }
  }
}
