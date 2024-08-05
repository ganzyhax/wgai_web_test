import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/generated/codegen_loader.g.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyAkf3CJf_KDapHnHwSDTd0FlDBal2alaDc",
  //         authDomain: "aiweglobal.firebaseapp.com",
  //         projectId: "aiweglobal",
  //         storageBucket: "aiweglobal.appspot.com",
  //         messagingSenderId: "879472760468",
  //         appId: "1:879472760468:web:ab83ae3ea4df834faa0681",
  //         measurementId: "G-FML3QDSHMW"));
  // await LocalUtils.clearStorage();
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('ru'),
        Locale('kk'),
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('ru'),
      assetLoader: CodegenLoader(),
      child: WeGlobalApp()));
}
