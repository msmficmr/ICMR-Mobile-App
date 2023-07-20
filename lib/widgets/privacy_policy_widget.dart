import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/widgets/custom_check_box.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  /// checkboxStatus required parameter it will allow you to check/uncheck checkbox
  final bool checkboxStatus;

  /// callback for checkbox
  final void Function(bool)? onChanged;

  /// enable you test the widget
  final String widgetKey;

  /// get the [locale] selected by the user, to show the privacy text in the selected language
  final Locale locale;

  PrivacyPolicyWidget({
    super.key,
    required this.checkboxStatus,
    required this.widgetKey,
    required this.locale,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCheckBox(
      widgetKey: Key(widgetKey),
      value: checkboxStatus,
      onChanged: onChanged,
      children: privacyText(),
    );
  }

  List<InlineSpan> privacyText() {
    switch (locale.toString()) {
      case "hi":
        return hindiText;
      case "en_US":
      default:
        return englishText;
    }
  }

  List<InlineSpan> hindiText = [
    const TextSpan(
      text: "जारी रखते हुए, आप हमारे ",
    ),
    WidgetSpan(
      child: InkWell(
        onTap: CommonFunctions.onPrivacyPolicyClick,
        child: Text(
          "नियम और शर्तों",
          style: AppStyles.bodySmall.copyWith(height: 1.0, color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w500),
        ),
      ),
    ),
    const TextSpan(
      text: " और ",
    ),
    WidgetSpan(
      child: InkWell(
        onTap: CommonFunctions.onPrivacyPolicyClick,
        child: Text(
          "गोपनीयता नीति",
          style: AppStyles.bodySmall.copyWith(height: 1.0, color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w500),
        ),
      ),
    ),
    const TextSpan(
      text: " से सहमत हैं और mHealth से ",
    ),
    TextSpan(
        text: "व्हाट्सएप",
        style: AppStyles.bodySmall.copyWith(height: 1.5, color: AppColorScheme.kGreen, fontWeight: FontWeight.w500)
    ),
    const TextSpan(
      text: " पर संचार प्राप्त करने के लिए सहमत हैं",
    ),
  ];

  List<InlineSpan> englishText = [
    const TextSpan(
      text: "By continuing, you agree to our ",
    ),
    WidgetSpan(
      child: InkWell(
        onTap: CommonFunctions.onPrivacyPolicyClick,
        child: Text(
          "Terms & Conditions ",
          style: AppStyles.bodySmall.copyWith(height: 1.5, color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w500),
        ),
      ),
    ),
    const TextSpan(
      text: "and ",
    ),
    WidgetSpan(
      child: InkWell(
        onTap: CommonFunctions.onPrivacyPolicyClick,
        child: Text(
          "Privacy Policy",
          style: AppStyles.bodySmall.copyWith(height: 1.5, color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w500),
        ),
      ),
    ),
    const TextSpan(
      text: " and agree to receive communication on",
    ),
    TextSpan(
        text: " WhatsApp",
        style: AppStyles.bodySmall.copyWith(height: 1.5, color: AppColorScheme.kGreen, fontWeight: FontWeight.w500)
    ),
    const TextSpan(
      text: " from mHealth.",
    ),
  ];
}
