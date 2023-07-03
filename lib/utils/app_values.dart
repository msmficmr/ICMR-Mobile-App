import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/utils/custom_input_formatter.dart';
import 'package:mhealth/utils/helpers/mask_text_input_formatter.dart';

class AppValues {

  AppValues._();

  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static TextInputFormatter get stringInputFormatter => CustomInputFormatter(regx: r'^[a-zA-Z]*$');
  static TextInputFormatter get numberInputFormatter => CustomInputFormatter(regx: r'^[0-9]*$');
  static TextInputFormatter get addressInputFormatter => CustomInputFormatter(regx: r"^[a-zA-Z0-9 ',&-.()\\\/]*$");
  static TextInputFormatter get emailIDInputFormatter => CustomInputFormatter(regx: r'^[a-zA-Z0-9-._@]*$');

  static TextInputFormatter get mobileInputFormatter => MaskTextInputFormatter(mask: '##########');

  static int get kOtpTimer => 30;


}