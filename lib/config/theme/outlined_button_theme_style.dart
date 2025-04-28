import 'package:flutter/material.dart';

import 'package:mhealth/utils/app_color_scheme.dart';

@immutable
class OutlinedButtonThemeStyle extends ButtonStyle {
  final Color? enabledButtonColor, disabledButtonColor;
  final Color? enabledTextColor, disabledTextColor;
  final Color? enabledBorderColor, disabledBorderColor;
  final EdgeInsets? buttonPadding;
  final TextStyle? customTextStyle;
  final BorderRadius? borderRadius;
  final bool hasBorder;

  const OutlinedButtonThemeStyle({
    this.enabledButtonColor,
    this.disabledButtonColor,
    this.enabledTextColor,
    this.disabledTextColor,
    this.enabledBorderColor,
    this.disabledBorderColor,
    this.buttonPadding,
    this.customTextStyle,
    this.borderRadius,
    this.hasBorder = true,
  });
  @override
  WidgetStateProperty<Color?>? get backgroundColor {
    return WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledButtonColor ?? AppColorScheme.kGrayColor.shade50;
        }

        return enabledButtonColor ?? Colors.transparent;
      },
    );
  }

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding {
    return buttonPadding == null ? const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)) : WidgetStatePropertyAll<EdgeInsets>(buttonPadding!);
  }

  @override
  WidgetStateProperty<BorderSide?>? get side {
    return WidgetStateProperty.resolveWith<BorderSide>(
      (Set<WidgetState> states) {
        if (hasBorder) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: disabledBorderColor ?? AppColorScheme.kGrayColor.shade300);
          }

          return BorderSide(color: enabledBorderColor ?? AppColorScheme.kPrimaryColor);
        } else {
          return BorderSide.none;
        }
      },
    );
  }

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape {
    return WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(50),
    ));
  }

  @override
  WidgetStateProperty<Color?>? get foregroundColor {
    return WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledTextColor ?? AppColorScheme.kGrayColor.shade400;
        }

        return enabledTextColor ?? AppColorScheme.kPrimaryColor;
      },
    );
  }

  @override
  WidgetStateProperty<TextStyle?>? get textStyle {
    return customTextStyle == null ? null : WidgetStatePropertyAll<TextStyle?>(customTextStyle);
  }
}
