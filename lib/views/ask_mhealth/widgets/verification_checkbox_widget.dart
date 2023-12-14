import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/widgets/custom_check_box.dart';

class QuestionnaireCheckBox extends StatelessWidget {
  /// checkboxStatus required parameter it will allow you to check/uncheck checkbox
  final bool checkboxStatus;

  /// callback for checkbox
  final void Function(bool)? onChanged;

  /// enable you test the widget
  final String widgetKey;

  /// a bool variable to check if there is any error if the widget is mandatory
  bool errorText;

  final String text;

  QuestionnaireCheckBox({
    Key? key,
    required this.checkboxStatus,
    required this.widgetKey,
    this.onChanged,
    required this.text,
    this.errorText = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCheckBox(
          widgetKey: Key(widgetKey),
          value: checkboxStatus,
          onChanged: onChanged,
          children: [
            TextSpan(
              text: text,
            ),
          ],
        ),
        if (errorText)
          Text(AppConstant.FIELD_REQUIRED, style: AppStyles.bodySmall.copyWith(color: AppColorScheme.errorTextColor),)
      ],
    );
  }
}
