import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';


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
    this.hintText = "000000",
    this.pinLength = 6,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String?>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      builder: (field) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 45,
            child: PinInputTextField(
              key: widgetKey,
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
              decoration: BoxLooseDecoration(
                hintText: hintText,
                strokeColorBuilder: FixedColorBuilder(AppColorScheme.kGrayColor.shade300),
                hintTextStyle: AppStyles.hintStyle.copyWith(fontFamily: AppConstant.FONT_FAMILY,fontSize: 16),
                textStyle: AppStyles.bodyMedium.copyWith(fontFamily: AppConstant.FONT_FAMILY),
                gapSpace: 5,
              ),
              cursor: Cursor(
                width: 2,
                color: AppColorScheme.kPrimaryColor,
                enabled: true,
                height: 18,
              ),
              pinLength: pinLength,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                field.didChange(value);
                if (value.length == pinLength) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
            ),
          ),
          if (field.hasError) ...[
            const SpaceWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                field.errorText ?? "",
                style: AppStyles.errorStyle.copyWith(fontFamily: AppConstant.FONT_FAMILY),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
