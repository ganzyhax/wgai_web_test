import 'package:flutter/material.dart';

const String kInterFontFamily = 'Inter';

class AppTextStyle {
  static const TextStyle heading1 = TextStyle(
    fontFamily: kInterFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle titleHeading = TextStyle(
    fontFamily: kInterFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: kInterFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: kInterFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: kInterFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyTextSmall = TextStyle(
    fontFamily: kInterFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyTextVerySmall = TextStyle(
    fontFamily: kInterFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
