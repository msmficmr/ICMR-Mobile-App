import 'package:flutter/material.dart';
import 'package:mhealth/config/theme/outlined_button_theme_style.dart';

class PrimaryOutlinedButton extends StatefulWidget {
  /// [buttonTitle] is button text
  /// [widgetKey] is assigned to [FilledButton] so that it can used for automation
  final String buttonTitle, widgetKey;

  /// [buttonThemeStyle] is optional. if its not set i will access it from [OutlinedButtonThemeStyle] of [AppTheme.light] method
  final OutlinedButtonThemeStyle? buttonThemeStyle;

  /// callback for button click
  final void Function()? onPressed;

  final bool isLoading;
  const PrimaryOutlinedButton({
    super.key,
    required this.buttonTitle,
    required this.widgetKey,
    this.onPressed,
    this.buttonThemeStyle,
    this.isLoading = false,
  });

  @override
  State<PrimaryOutlinedButton> createState() => _PrimaryOutlinedButtonState();
}

class _PrimaryOutlinedButtonState extends State<PrimaryOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: widget.isLoading
          ? const SizedBox(
              child: CircularProgressIndicator(),
            )
          : OutlinedButton(
            
              key: Key(widget.widgetKey),
              onPressed: widget.onPressed,
              style: widget.buttonThemeStyle,
              child: Text(widget.buttonTitle),
              
            ),
    );
  }
}
