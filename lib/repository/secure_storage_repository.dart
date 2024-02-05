import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  static const _storage = FlutterSecureStorage();
  static const _userIdKey = 'user_id';
  static const _schoolIdKey = 'school_id';

  static Future<String?> readUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  static Future<String?> readSchoolId() async {
    return await _storage.read(key: _schoolIdKey);
  }

  static Future<void> deleteSignInInfo() async {
    await _storage.delete(key: _userIdKey);
    await _storage.delete(key: _schoolIdKey);
  }

  static Future<void> writeSignInInfo({
    required String? userId,
    required String? schoolId,
  }) async {
    await _storage.write(key: _userIdKey, value: userId);
    await _storage.write(key: _schoolIdKey, value: schoolId);
  }

  static Future<bool> isUserIdSaved() async {
    final String? userId = await readUserId();
    final String? schoolId = await readSchoolId();
    return userId != null && schoolId != null;
  }
}
