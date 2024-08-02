import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthUtils {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<bool> isAccess() async {
    String? res = await storage.read(key: 'accessToken');
    if (res == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> clearStorage() async {
    await storage.write(key: 'refreshToken', value: null);
    await storage.write(key: 'accessToken', value: null);
  }

  static Future<void> setToken(String rToken, String aToken) async {
    await storage.write(key: 'refreshToken', value: null);
    await storage.write(key: 'accessToken', value: null);
  }

  static Future<String?> getToken(String key) async {
    return await storage.read(key: key);
  }
}
