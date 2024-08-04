import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wg_app/app/utils/local_utils.dart';

class AuthUtils {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<bool> login(String login, pass) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: login,
        password: pass,
      );
      String? token = await userCredential.user?.getIdToken();
      log(token.toString());

      if (token != null) {
        await LocalUtils.setToken(token);
        return true;
      } else {
        return false;
      }

      // You can now use the token as needed
    } on FirebaseAuthException catch (e) {
      return false;
      // Handle error
    }
  }
}
