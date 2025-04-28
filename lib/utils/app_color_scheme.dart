import 'package:flutter/material.dart';

class AppColorScheme {
  AppColorScheme._();
  static Color get kWhite => const Color(0xFFFFFFFF);
  static const Color errorTextColor = Color(0xffF16063);
  static Color get kLightGreen => const Color(0xFFE9F6E8);
  static Color get kLightRed => const Color(0xFFFDEAEA);
  static Color get kGreen => const Color(0xFF4DC85B);
  static Color get kGreenLight => const Color(0xFFE9F6E8);
  static Color get kBlack => const Color(0xFF000000);
  static const Color kLightBlue = Color(0xFFF7FBFE);
  static const Color kBlueColor = Color(0xFF3C5B9E);
  static const Color kEnabledButtonTextColor = Color(0xFF2F43EE);
  static const Color kEnabledButtonColor = Color(0xFFF4F5FF);
  static const Color kTextGreyColor = Color(0xFF616161);
  static const Color kSuccessStatusColor = Color(0xff66CB9F);

  static Color get kPrimaryIconColor => Colors.white;

  static const Color selectedBackgroundColor = Color(0xFFF6FBFE);

  static const MaterialColor kPrimaryColor = MaterialColor(
    0xFF3042EE,
    {
      900: Color(0xFF4454EF),
      800: Color(0xFF5967F1),
      600: Color(0xFF6E7AF3),
      500: Color(0xFF828DF4),
      400: Color(0xFF97A0F6),
      300: Color(0xFFACB3F8),
      200: Color(0xFFC0C6F9),
      100: Color(0xFFD5D9FB),
      50: Color(0xFFEAECFD),
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
