import 'package:flutter/material.dart';

class AppColorScheme {
  AppColorScheme._();

  static Color get errorTextColor => const Color(0xffF16063);
  static Color get kLightGreen => const Color(0xFFE9F6E8);
  static Color get kLightRed => const Color(0xFFFDEAEA);
  static Color get kPrimaryIconColor => Colors.white;

  static const MaterialColor kPrimaryColor = MaterialColor(
    0xFF3042EE,
    {
      900: Color(0xFF4454ef),
      800: Color(0xFF5967F1),
      700: Color(0xFF6E7AF3),
      600: Color(0xFF828DF4),
      500: Color(0xFF97A0f6),
      400: Color(0xFFACB3f8),
      300: Color(0xFFC0C6F9),
      200: Color(0xFFD5D9FB),
      100: Color(0xFFEAECFD),
    },
  );

  static const MaterialColor kGrayColor = MaterialColor(
    0xFF212121,
    {
      900: Color(0xFF212121),
      800: Color(0xFF424242),
      700: Color(0xFF616161),
      600: Color(0xFF757575),
      500: Color(0xFF9E9E9E),
      400: Color(0xFFBDBDBD),
      300: Color(0xFFE0E0E0),
      200: Color(0xFFEEEEEE),
      100: Color(0xFFF5F5F5),
      50: Color(0xFFFAFAFA),
    },
  );
}
