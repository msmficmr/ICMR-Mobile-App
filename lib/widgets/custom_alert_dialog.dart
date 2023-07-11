import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';

class CustomAlertDialog extends StatelessWidget {
  /// [title] is title text for alert dialog
  /// [subtitle] is description for alert dialog
  /// [buttonText] is button text of alert dialog
  final String title, subtitle, buttonText;

  /// keys that can used for testing
  final String titleKey, subtitleKey, buttonKey;

  /// [onOkPressed] action for button of alertDialog
  /// if [onOkPressed] is not passed then default action will close the popup.
  final VoidCallback? onOkPressed;
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.onOkPressed,
    required this.titleKey,
    required this.subtitleKey,
    required this.buttonKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                key: Key(titleKey),
                style: AppStyles.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColorScheme.kPrimaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                subtitle,
                key: Key(subtitleKey),
                style: AppStyles.titleMedium,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: PrimaryFilledButton(
                  buttonTitle: buttonText,
                  widgetKey: buttonKey,
                  onPressed: onOkPressed ??
                      () {
                        Navigator.pop(context);
                      },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
