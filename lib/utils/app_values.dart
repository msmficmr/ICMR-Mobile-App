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
}
