import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/custom_alert_dialog.dart';

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
}
