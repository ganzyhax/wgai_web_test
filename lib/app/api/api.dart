import 'dart:developer';

import 'package:wg_app/app/api/auth_utils.dart';
import 'package:wg_app/constants/app_constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static Future<dynamic> get(String endpoint) async {
    // String mbVer = await AuthUtils.getIndexMobileVersion();
    final url = Uri.parse(AppConstant.baseUrl.toString() + endpoint);

    final token = await AuthUtils.getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      // 'Mobapp-Version': mbVer
      // 'Mobapp-Language': mbLang
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        'success': true,
        'data': jsonDecode(response.body),
        'status': response.statusCode.toString()
      };
    } else {
      return {
        'success': false,
        'data': jsonDecode(response.body),
        'status': response.statusCode.toString()
      };
    }
  }

  static Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    // String mbVer = await AuthUtils.getIndexMobileVersion();
    final url = Uri.parse(AppConstant.baseUrl.toString() + endpoint);
    final token = await AuthUtils.getToken();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        // 'Mobapp-Version': mbVer
      },
      body: jsonEncode(data),
    );
    log(response.body.toString());
    // await _handleResponse(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'success': true, 'data': jsonDecode(response.body)};
    } else {
      return {'success': false, 'data': jsonDecode(response.body)};
    }
  }

  static Future<dynamic> postUnAuth(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    // String mbVer = await AuthUtils.getIndexMobileVersion();
    final url = Uri.parse(AppConstant.baseUrl.toString() + endpoint);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',

        // 'Mobapp-Version': mbVer
      },
      body: jsonEncode(data),
    );
    log(response.body.toString());
    // await _handleResponse(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'success': true, 'data': jsonDecode(response.body)};
    } else {
      return {'success': false, 'data': jsonDecode(response.body)};
    }
  }

  static Future<dynamic> getUnAuth(String endpoint) async {
    // String mbVer = await AuthUtils.getIndexMobileVersion();
    final url = Uri.parse(AppConstant.baseUrl.toString() + endpoint);
    log(AppConstant.baseUrl.toString() + endpoint);
    final token = await AuthUtils.getToken();
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',

      // 'Mobapp-Version': mbVer
    });
    log(response.body.toString());
    // await _handleResponse(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'success': true, 'data': jsonDecode(response.body)};
    } else {
      return {'success': false, 'data': jsonDecode(response.body)};
    }
  }

  // static Future<void> _handleResponse(http.Response response) async {
  //   if (response.statusCode == 401) {
  //     await _refreshToken();
  //   }
  // }

  // static Future<void> _refreshToken() async {
  //   final refreshToken = await AuthUtils.getToken();
  //   final url = Uri.parse(AppConstant.baseUrl + 'api/v1/users/token/refresh/');
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     },
  //     body: jsonEncode({'refresh': refreshToken}),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     await AuthUtils.saveToken('accessToken', data['access']);
  //   } else {
  //     print('Failed to refresh token');
  //   }
  // }
}
