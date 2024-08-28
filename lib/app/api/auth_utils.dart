import 'dart:developer';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/constants/app_constant.dart';
import 'package:http/http.dart' as http;

class AuthUtils {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<dynamic> login(String username, String password) async {
    final url = Uri.parse(AppConstant.baseUrl + 'api/auth/login');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Mobapp-Version': mbVer,
          },
          body: jsonEncode({'email': username, 'password': password}));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await LocalUtils.setToken(data['accessToken']);
        return true;
      } else {
        if (data.containsKey('message')) {
          return data['message'];
        }
      }
    } catch (e) {
      return 'Try again...';
    }
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  static Future<void> saveToken(String key, String value) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(value);

    // await storage.write(
    //     key: 'userId', value: decodedToken['user_id'].toString());
    // await storage.write(
    //     key: 'userName', value: decodedToken['user']['username']);
    // await storage.write(
    //     key: 'userEmail', value: decodedToken['user']['email'].toString());
    await storage.write(key: key, value: value);
  }
}
