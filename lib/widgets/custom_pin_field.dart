import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinField extends StatelessWidget {
  /// Hint Text for custom pin field
  final String hintText;

  /// Length of pin fields
  final int pinLength;

  /// input formatter for pin filed
  final List<TextInputFormatter>? inputFormatters;

  /// TextEditingController for text pin field
  final TextEditingController? controller;

  ///Keyboard type of pin field
  final TextInputType keyboardType;

  /// validator for pin field
  final String? Function(String?)? validator;

  /// callback to detect onChanged on pinField
  final void Function(String)? onChanged;

  /// widget key for testing
  final Key widgetKey;

  const CustomPinField({
    super.key,
    this.inputFormatters,
    this.controller,
    this.validator,
    this.onChanged,
    required this.widgetKey,
    this.hintText = "0",
    this.pinLength = 6,
    this.keyboardType = TextInputType.number,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PinCodeTextField(
          appContext: context,
          inputFormatters: inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
          length: pinLength,
          obscureText: false,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          validator: validator,
          // hintCharacter: hintText,
          hintStyle: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kGrayColor.shade500),
          pastedTextStyle: AppStyles.titleSmall,
          textStyle: AppStyles.bodyMedium,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            selectedBorderWidth: 1.5,
            borderWidth: 1.5,
            activeBorderWidth: 1.5,
            errorBorderWidth: 1.5,
            disabledBorderWidth: 1.5,
            inactiveBorderWidth: 1.5,
            activeFillColor: Colors.white,
            selectedFillColor: Colors.white,
            selectedColor: AppColorScheme.kGrayColor.shade300,
            inactiveColor: AppColorScheme.kGrayColor.shade300,
            inactiveFillColor: Colors.white,
            activeColor: AppColorScheme.kGrayColor.shade300,
          ),
          cursorColor: AppColorScheme.kPrimaryColor,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          controller: controller,
          keyboardType: TextInputType.number,
          enablePinAutofill: true,
          errorTextSpace: 25,
          beforeTextPaste: (text) {
            var numeric = RegExp('^\\d{$pinLength}\$');
            bool hasMatch = numeric.hasMatch(text ?? "");
            return hasMatch;
          },
          boxShadows: const [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          onCompleted: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
        ),
      ],
    );
  }
}
