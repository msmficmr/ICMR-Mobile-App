import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';

class CustomCheckBox extends StatefulWidget {
  /// initial value of checkbox
  final bool value;

  /// Callback to change status of checkbox
  final Function(bool)? onChanged;

  /// List of inline spans to display Text of checkbox
  final List<InlineSpan>? children;

  /// widget key which can be used for testing
  final Key widgetKey;
  final CrossAxisAlignment crossAxisAlignment;

  const CustomCheckBox({Key? key, required this.widgetKey, required this.value, required this.children, this.onChanged, this.crossAxisAlignment = CrossAxisAlignment.start}) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "semantice_${widget.widgetKey.toString()}",
      checked: widget.value,
      child: InkWell(
        onTap: widget.onChanged != null
            ? () {
          widget.onChanged!(!widget.value);
        }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: widget.crossAxisAlignment,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: widget.value ? SvgPicture.asset(AppAssetsPath.icCheckboxChecked, color: AppColorScheme.kPrimaryColor,) : SvgPicture.asset(AppAssetsPath.icCheckboxUnChecked),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: RichText(
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: AppStyles.bodySmall.copyWith(height: 1.5, fontFamily: AppConstant.FONT_FAMILY),
                    children: widget.children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
