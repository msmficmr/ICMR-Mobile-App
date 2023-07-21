import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';

class AppStyles {
  static final AppStyles _instance = AppStyles._();
  AppStyles._();
  factory AppStyles.init(BuildContext con) {
    return _instance;
  }

  /// used for app bar title
  static TextStyle appBarStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColorScheme.kGrayColor.shade800);

  /// used for button text
  static TextStyle buttonStyle = const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: AppConstant.FONT_FAMILY);

  /// used to give style to hint hint of TextFormField,dropdown button
  static TextStyle hintStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColorScheme.kGrayColor.shade500);

  /// used to give style to error text of TextFormField,dropdown items
  static TextStyle errorStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColorScheme.errorTextColor);

  /// used to give style to text such as privacy policy. terms and conditions
  static TextStyle bodySmall = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColorScheme.kGrayColor.shade500);

  /// used to give style to text of TextFormField, dropdowns items
  static TextStyle bodyMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColorScheme.kGrayColor.shade800);

  /// used to give style for title for TextFormField dropdown items
  static TextStyle titleSmall = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColorScheme.kGrayColor.shade700);
  static TextStyle titleMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColorScheme.kGrayColor.shade800);
  static TextStyle titleBig = TextStyle(fontSize: 36, fontWeight: FontWeight.w600, color: AppColorScheme.kGrayColor.shade900);

  static TextStyle headlineMedium = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColorScheme.kPrimaryColor);
}
