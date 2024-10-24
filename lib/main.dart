import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/constants/app_hive_constants.dart';
import 'package:wg_app/firebase_options.dart';
import 'package:wg_app/generated/codegen_loader.g.dart';
import 'package:wg_app/utils/fcm_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  if (kIsWeb) {
    log('Initializeing web Instanta');
    WebViewPlatform.instance = WebWebViewPlatform();
  } else {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await FCMService().subscribeToAllTopicBeforeLogin();
  }

  await BookmarkData().init();
  await BookmarkData().clearList(AppHiveConstants.kzUniversities);
  await BookmarkData().clearList(AppHiveConstants.professions);
  await BookmarkData().clearList(AppHiveConstants.globalUniversities);

  runApp(EasyLocalization(
      supportedLocales: [
        Locale('ru'),
        Locale('kk'),
        // Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('ru'),
      assetLoader: CodegenLoader(),
      child: WeGlobalApp()));
}
