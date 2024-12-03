import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/utils/custom_input_formatter.dart';
import 'package:mhealth/utils/helpers/mask_text_input_formatter.dart';

class AppValues {
  AppValues._();

  static double get kAppPadding => 16.0;
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static TextInputFormatter get numberInputFormatter => CustomInputFormatter(regx: r'^[0-9]*$');
  static TextInputFormatter get mobileInputFormatter => MaskTextInputFormatter(mask: '##########');
  static TextInputFormatter get emailInputFormatter => CustomInputFormatter(regx: r'^[a-zA-Z0-9-._@+]*$');
  static TextInputFormatter get stringInputFormatter => CustomInputFormatter(regx: r'^[a-zA-Z ]*$');
  static TextInputFormatter get textInputFormatter => CustomInputFormatter(regx: r'^[a-zA-Z0-9 ]*$');
  static TextInputFormatter get textWithDotInputFormatter =>  CustomInputFormatter(regx: r'^[a-zA-Z][a-zA-Z. ]*$');


  static int get kOtpTimer => 30;

  static BorderRadius get circularBorderRadius10 => BorderRadius.circular(10);
  static BorderRadius get circularBorderRadius30 => BorderRadius.circular(30);

  static String dobDateFormat = "dd/MM/yyyy";
  static String idDateTimeFormat = "ddMMyyHHmm";
  static TextInputFormatter get idInputFormatter => CustomInputFormatter(regx: r"^[a-zA-Z0-9\-]*$");
  static RegExp primaryIdPattern = RegExp(r'^[A-Za-z]{2}-[A-Za-z]{2}-\d{10}$');

}

