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

  static Future<void> openDialog({
    required BuildContext context,
    required String subtitle,
    required String buttonText,
    VoidCallback? action,
  }) async {
    const String _ALERT = "Alert";
    const String _KEY_TITLE = "key_text_title";
    const String _KEY_SUBTITLE = "key_text_subtitle";
    const String _KEY_BUTTON = "key_button_dialog";
    await showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: true,
      builder: (context) => CustomAlertDialog(
        title: _ALERT,
        subtitle: subtitle,
        buttonText: buttonText,
        titleKey: _KEY_TITLE,
        subtitleKey: _KEY_SUBTITLE,
        buttonKey: _KEY_BUTTON,
        onOkPressed: action == null
            ? null
            : () {
                action();
                Navigator.pop(context);
              },
      ),
    );
  }
}
