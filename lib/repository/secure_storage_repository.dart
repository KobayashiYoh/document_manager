import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  static const _storage = FlutterSecureStorage();
  static const _key = 'user_id';

  static Future<String?> readUserId() async {
    return await _storage.read(key: _key);
  }

  static Future<void> deleteUserId() async {
    await _storage.delete(key: _key);
  }

  static Future<void> writeUserId(String? value) async {
    await _storage.write(key: _key, value: value);
  }

  static Future<bool> isUserIdSaved() async {
    final String? userId = await readUserId();
    return userId != null;
  }
}
