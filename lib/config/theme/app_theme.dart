import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/config/router/router_transition.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';

class AppTheme {

  AppTheme._();

  static ThemeData light(BuildContext _) => ThemeData.light(useMaterial3: false).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CustomTransitionBuilder(),
      TargetPlatform.android: CustomTransitionBuilder(),
      TargetPlatform.windows: CustomTransitionBuilder(),
    }),
    textTheme: Theme.of(_).textTheme.apply(
      fontFamily: AppConstant.FONT_FAMILY,
    ),
    primaryColor: AppColorScheme.kPrimaryColor,
    colorScheme: const ColorScheme.light(
      primary: AppColorScheme.kPrimaryColor,
      secondary: AppColorScheme.kPrimaryColor,
      error: Colors.red,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColorScheme.kGrayColor.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColorScheme.kGrayColor.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColorScheme.kGrayColor.shade300)),
      outlineBorder: BorderSide(color: AppColorScheme.kGrayColor.shade300),
      activeIndicatorBorder: BorderSide(color: AppColorScheme.kGrayColor.shade300),
      isDense: true,
      hintStyle: AppStyles.hintStyle,
      errorStyle: AppStyles.errorStyle,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: Colors.white,
      elevation: 0,
    ),
    useMaterial3: false,
  );

}