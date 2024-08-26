import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/primary_outlined_button.dart';
import 'package:mhealth/widgets/space_widget.dart';

class CustomSignatureWidget extends StatelessWidget {
  final VoidCallback onButtonClick;
  final Uint8List? signatureData;
  final String buttonText;
  final String buttonKey;
  final String? errorText;
  final VoidCallback? onRemoveClick;
  final Key? removeButtonKey;
  final GlobalKey<FormFieldState> formFieldState;

  CustomSignatureWidget({
    super.key,
    required this.onButtonClick,
    required this.buttonText,
    required this.buttonKey,
    this.onRemoveClick,
    this.signatureData,
    this.errorText,
    this.removeButtonKey,
    required this.formFieldState,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<Uint8List?>(
      key: formFieldState,
      initialValue: signatureData,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: errorText == null
          ? null
          : (value) {
              if (value == null) {
                return errorText;
              } else if (signatureData == null) {
                return errorText;
              }

              return null;
            },
      builder: (field) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (signatureData == null)
              SizedBox(
                width: double.infinity,
                child: PrimaryFilledButton(
                  buttonThemeStyle: const FilledButtonThemeStyle(
                    enabledTextColor: AppColorScheme.kEnabledButtonTextColor,
                    enabledButtonColor: AppColorScheme.kEnabledButtonColor,
                  ),
                  buttonTitle: buttonText,
                  widgetKey: buttonKey,
                  onPressed: onButtonClick,
                ),
              )
            else
              AspectRatio(
                aspectRatio: 1 / 0.5,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColorScheme.kGrayColor.shade400),
                        ),
                        child: Image.memory(signatureData!),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: InkWell(
                        key: removeButtonKey,
                        onTap: onRemoveClick,
                        borderRadius: BorderRadius.circular(40),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssetsPath.icClose,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
        );
      },
    );
  }
}
