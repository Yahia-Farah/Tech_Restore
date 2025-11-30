import 'package:flutter/material.dart';

abstract class AppColors {
  static const background = Color(0xffFAFAFA);
  static const primary = Color(0xff617AFA);
  static const secondary = Color(0xff000000);
  static const hint = Color(0xff3D404A);
  static const buttons = Color(0xffEDF0F2);
  static const Color grey = Color(0xFFEDF0F2);

  static const MaterialColor white = MaterialColor(0xFFF9F9F9, <int, Color>{
    10: Color(0xFFFEFEFE),
    20: Color(0xFFFDFDFD),
    30: Color(0xFFFCFCFC),
    40: Color(0xFFFBFBFB),
    50: Color(0xFFFAFAFA),
    0: Color(0xFFF9F9F9), // BASE
    60: Color(0xFFD0D0D0),
    70: Color(0xFFA6A6A6),
    80: Color(0xFF7D7D7D),
    90: Color(0xFF535353),
    100: Color(0xFF323232),
  });

  static const MaterialColor black = MaterialColor(0xFF0C1015, <int, Color>{
    10: Color(0xFFCECFD0),
    20: Color(0xFFAEAFB1),
    30: Color(0xFF86888A),
    40: Color(0xFF5D6063),
    50: Color(0xFF34383C),
    0: Color(0xFF0C1015), // BASE
    60: Color(0xFF0A0D12),
    70: Color(0xFF080B0E),
    80: Color(0xFF06080B),
    90: Color(0xFF040507),
    100: Color(0xFF020304),
  });
}
