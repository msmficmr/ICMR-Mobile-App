import 'package:flutter/material.dart';

import '../../../utils/app_color_scheme.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_styles.dart';

class CustomLanguageCardWidget extends StatefulWidget {
  /// [buttonTitle] is button text
  /// [widgetKey] is assigned to [FilledButton] so that it can used for automation
  final String cardTile, widgetKey, cardTitleKey;
  final bool isLoading;
  final TextStyle? customTextStyle;
  final Color? borderColor, cardColor;
  final BoxDecoration? customBoxDecoration;

  const CustomLanguageCardWidget({
    super.key,
    required this.cardTile,
    required this.widgetKey,
    required this.cardTitleKey,
    this.isLoading = false,
    this.customTextStyle,
    this.customBoxDecoration,
    this.borderColor,
    this.cardColor,
  });

  @override
  State<CustomLanguageCardWidget> createState() => _CustomLanguageCardWidgetState();
}

class _CustomLanguageCardWidgetState extends State<CustomLanguageCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: widget.isLoading
          ? const SizedBox(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              key: Key(widget.widgetKey),
              decoration: widget.customBoxDecoration ??
                  BoxDecoration(
                    color: widget.cardColor ?? AppColorScheme.kPrimaryColor.shade500.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
              //padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 25),
              child: Center(
                child: Text(
                  widget.cardTile,
                  key: Key(widget.cardTitleKey),
                  style: widget.customTextStyle ?? AppStyles.titleSmall.copyWith(color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w600, fontFamily: AppConstant.FONT_FAMILY),
                ),
              ),
            ),
    );
  }
}
