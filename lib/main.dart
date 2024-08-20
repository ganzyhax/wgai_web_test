import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wg_app/app/api/auth_utils.dart';
import 'package:wg_app/app/app.dart';
import 'package:wg_app/app/utils/di.dart';
import 'package:wg_app/app/utils/local_utils.dart';
import 'package:wg_app/generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // LocalUtils.clearStorage();
  // setupLocator();
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
