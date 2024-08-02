// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> kk = {
  "hello": "Salem",
  "splash_subtitle": "Университетке түсу және мансаптық кеңес беру бойынша жеке AI"
};
static const Map<String,dynamic> ru = {
  "hello": "Privet",
  "s": "cx",
  "splash_subtitle": "Ваш личный ИИ для поступления в университет и карьерного консультирования"
};
static const Map<String,dynamic> en = {
  "hello": "Hello",
  "splash_subtitle": "Your personal AI for university admission and career guidance"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"kk": kk, "ru": ru, "en": en};
}
