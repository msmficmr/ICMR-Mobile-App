import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mhealth/services/permission_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/widgets/custom_alert_dialog.dart';
import 'package:mhealth/widgets/image_view_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CommonFunctions {
  /// opens browser with privacy policy link
  static void onPrivacyPolicyClick() {
    //TODO: add url launcher implementation
  }

// open the Location service setting
  static void openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  /// opens the apps settings
  static void openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  /// call this method to display dialog within app
  /// it accepts 3 parameter
  /// 1. context of current screen
  /// subtitle : text that will be description message for dialog
  /// buttonText : text of the button
  /// action: this is optional parameter if we don't pass it will popup the dialog
  static Future<T> openDialog<T>({
    required BuildContext context,
    required String subtitle,
    required String buttonText,
    required Function(BuildContext context)? action,
    String? title,
    Function(BuildContext context)? onCancelAction,
    String? buttonCancelText,
  }) async {
    const String _ALERT = "Alert";
    const String _KEY_TITLE = "key_text_title";
    const String _KEY_SUBTITLE = "key_text_subtitle";
    const String _KEY_BUTTON = "key_button_dialog";
    const String _KEY_BUTTON_NO = "key_button_no_dialog";

    return await showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: true,
      builder: (context) => CustomAlertDialog(
        title: title ?? _ALERT,
        subtitle: subtitle,
        buttonText: buttonText,
        titleKey: _KEY_TITLE,
        subtitleKey: _KEY_SUBTITLE,
        buttonKey: _KEY_BUTTON,
        buttonCancelKey: _KEY_BUTTON_NO,
        buttonCancelText: buttonCancelText,
        onCancelPress: onCancelAction == null
            ? null
            : () {
                onCancelAction(context);
              },
        onOkPressed: action == null
            ? null
            : () {
                action(context);
              },
      ),
    );
  }

  /// opens browser with Terms and conditions link
  static void onTermsConditionClick() {
    //TODO: add url launcher implementation
  }

  /// displays toast message on screen
  static void toastMessage(String message) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_LONG, fontSize: 16.0);
  }

  static int? getAge(String? dob) {
    try {
      if (dob == null || dob.isEmpty) {
        return null;
      }
      if (dob.isNotEmpty) {
        DateTime birthDate = DateFormat(AppValues.dobDateFormat).parse(dob);

        DateTime today = DateTime.now();
        Duration duration = today.difference(birthDate);

        return (duration.inDays / 365).round();
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static String getDob(String? age) {
    if (age == null) {
      return "";
    }
    int? intAge = int.tryParse(age);
    if (intAge == null) {
      return "";
    }
    DateTime currentDate = DateTime.now();

    return DateFormat(AppValues.dobDateFormat).format(DateTime(currentDate.year - intAge, currentDate.month, currentDate.day));
  }

  static void viewImage({required BuildContext context, required List<int> bytes}) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => ImageViewWidget(
        imageList: bytes,
      ),
    );
  }

  static Future<XFile?> getImage({required BuildContext context, required ImageSource imageSource}) async {
    bool hasCameraPermission = await PermissionService.permissionService.checkCameraPermission(context);
    if (hasCameraPermission) {
      XFile? file = await ImagePicker().pickImage(source: imageSource);
      return file;
    }
  }

  static void showRetrySnackbar() {
    try {
      if (AppValues.scaffoldMessengerKey.currentState?.mounted ?? false) {
        AppValues.scaffoldMessengerKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text("No Internet Connection"),
          ),
        );
      }
    } catch (e) {}
  }

  static String currentDate() {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    String formattedDate = dateFormat.format(now);
    return formattedDate;
  }

  static String getText({required String language, required String engText, required String hindiText}) {
    String text = "";
    if (language == LanguageCodes.en_US.toString()) {
      return engText;
    } else if (language == LanguageCodes.hi.toString()) {
      return hindiText;
    }
    return text;
  }

  static Future<String?> getLanguageKey() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(AppConstant.LANGUAGE_KEY)) {
      String? languageKey = sharedPreferences.getString(AppConstant.LANGUAGE_KEY);
      return languageKey;
    } else {
      return "en_US";
    }
  }

  /// Calculates the age based on passed [dob]
  static int getAgeFromDob(String dob) {
    if (dob.isEmpty) {
      return 1;
    }
    DateTime birthDate = DateTime.parse(dob);
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (age >= 1) {
      // their birth month lies after our checking month
      // so they they haven't completed their last year
      // fully,
      if ((today.month - birthDate.month) < 0) {
        return age - 1;
      }
      // if our checking month is equal to our birth month
      // we check if date greater than birthdate if not,
      // they haven't completed their last year fully.
      else if (today.month == birthDate.month) {
        if (birthDate.day <= today.day) {
          return age;
        } else {
          return age - 1;
        }
      }
      // if checking month is greater than birth month
      // user has definitely completed his last year fully
      else {
        return age;
      }
    }
    return 0;
  }

  static String toLocale(key, currentLanguage, [patientName]) {
    Map<String, String> questionsMap = {
      "mobileNo": "Please enter your mobile number",
      "email": "Please enter your Email Id",
      "verify_otp": "We have sent an OTP on your registered mobile number, enter OTP to continue",
      "resend_otp": "Invalid OTP, please select from the options below",
      "otp_try_again": "Enter OTP Again",
      "otp_resend": "Resend OTP",
      "welcome_back": "Welcome back $patientName, you are already registered with us, please proceed with the assessment."
    };
    var conversionMap = {
      AppConstant.ENGLISH_LANGUAGE_CODE_KEY: questionsMap,
      AppConstant.HINDI_LANGUAGE_CODE_KEY: questionsMap,
    };
    return conversionMap[currentLanguage]?[key] ?? "";
  }

  static String randomNumber(int length) {
    const uuid = Uuid();
    final randomUuid = uuid.v4().toString().substring(0, length);
    return randomUuid;
  }
}
