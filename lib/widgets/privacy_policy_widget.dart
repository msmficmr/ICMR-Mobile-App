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

  const PrivacyPolicyWidget({
    super.key,
    required this.checkboxStatus,
    required this.widgetKey,
    this.onChanged,
  });

  final String TERMS_1 = "By continuing, you agree to our ";
  final String TERMS_2 = "Terms & Conditions ";
  final String TERMS_3 = "and ";
  final String TERMS_4 = "Privacy Policy";

  @override
  Widget build(BuildContext context) {
    return CustomCheckBox(
      widgetKey: Key(widgetKey),
      value: checkboxStatus,
      onChanged: onChanged,
      children: [
        TextSpan(
          text: TERMS_1,
        ),
        WidgetSpan(
          child: InkWell(
            onTap: CommonFunctions.onPrivacyPolicyClick,
            child: Text(
              TERMS_2,
              style: AppStyles.bodySmall.copyWith(height: 1.5, color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        TextSpan(
          text: TERMS_3,
        ),
        WidgetSpan(
          child: InkWell(
            onTap: CommonFunctions.onPrivacyPolicyClick,
            child: Text(
              TERMS_4,
              style: AppStyles.bodySmall.copyWith(height: 1.5, color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
