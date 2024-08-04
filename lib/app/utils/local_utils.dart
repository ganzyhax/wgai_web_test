import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalUtils {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<void> setLanguage(String lang) async {
    await storage.write(key: 'localLang', value: lang.toString());
  }

  static Future<String> getLanguage() async {
    String lang = await storage.read(key: 'localLang') ?? 'null';
    return lang;
  }

  static Future<bool> isFirstTime() async {
    String? res = await storage.read(key: 'isFirstTime');
    if (res == null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> setFirstTime() async {
    await storage.write(key: 'isFirstTime', value: 'false');
  }

  static Future<bool> isLogged() async {
    String? res = await storage.read(key: 'accessToken');
    if (res == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> clearStorage() async {
    await storage.deleteAll();
  }

  static Future<void> setToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  static Future<String?> getToken(String key) async {
    return await storage.read(key: key);
  }
}
