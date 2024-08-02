import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xffF2F2F7);
  static const Color primary = Color(0xff052DC1);
  static final Color primaryDisabled = Color(0xff052DC1).withOpacity(0.5);
  static const Color blackForText = Color(0xff32384A);
  static const Color grayForText = Color(0xff8E8E93);
  static const Color blockOnTheWhite = Color(0xffE5E5EA73);
  static const Color whiteForText = Color(0xffFFFFFF);
  static final Color choiceColor = Color(0xff052DC126);
  static final Color cardOnTheBlue = Color(0xffE5E5EA4D);
  static final Color cardOnTheBlue2 = Color(0xffE5E5EAB2);
  static final LinearGradient gradientPrimary = const LinearGradient(
    colors: [Color(0xff052DC1), Color(0xff052DC1)],
    stops: [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static final LinearGradient gradientWhite = const LinearGradient(
    colors: [Colors.white, Colors.white],
    stops: [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static final LinearGradient gradientGrey = const LinearGradient(
    colors: [Color(0xff9fadb9), Color(0xff9fadb9)],
    stops: [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
