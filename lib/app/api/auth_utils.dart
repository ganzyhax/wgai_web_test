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
        await LocalUtils.setAccessToken(data['accessToken']);
        await LocalUtils.setRefreshToken(data['refreshToken']);
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
}
