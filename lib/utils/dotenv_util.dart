import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotenvUtil {
  static String get apiKeyWeb => dotenv.get('FIREBASE_API_KEY_WEB');
  static String get appIdWeb => dotenv.get('FIREBASE_APP_ID_WEB');
  static String get apiKeyAndroid => dotenv.get('FIREBASE_API_KEY_ANDROID');
  static String get appIdAndroid => dotenv.get('FIREBASE_APP_ID_ANDROID');
  static String get apiKeyIOS => dotenv.get('FIREBASE_API_KEY_IOS');
  static String get appIdIOS => dotenv.get('FIREBASE_APP_ID_IOS');
  static String get messagingSenderId =>
      dotenv.get('FIREBASE_MESSAGING_SENDER_ID');
  static String get androidClientId => dotenv.get('FIREBASE_ANDROID_CLIENT_ID');
  static String get iosClientId => dotenv.get('FIREBASE_IOS_CLIENT_ID');
}
