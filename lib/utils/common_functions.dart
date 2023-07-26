import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mhealth/services/permission_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/widgets/custom_alert_dialog.dart';
import 'package:mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/widgets/image_view_widget.dart';
import 'package:provider/provider.dart';

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
}
