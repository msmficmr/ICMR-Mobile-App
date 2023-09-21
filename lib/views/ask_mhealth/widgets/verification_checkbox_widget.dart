import 'package:flutter/material.dart';
import 'package:mhealth/widgets/custom_check_box.dart';

class QuestionnaireCheckBox extends StatelessWidget {
  /// checkboxStatus required parameter it will allow you to check/uncheck checkbox
  final bool checkboxStatus;

  /// callback for checkbox
  final void Function(bool)? onChanged;

  /// enable you test the widget
  final String widgetKey;

  final String text;

  const QuestionnaireCheckBox({
    Key? key,
    required this.checkboxStatus,
    required this.widgetKey,
    this.onChanged,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCheckBox(
      widgetKey: Key(widgetKey),
      value: checkboxStatus,
      onChanged: onChanged,
      children: [
        TextSpan(
          text: text,
        ),
      ],
    );
  }
}
