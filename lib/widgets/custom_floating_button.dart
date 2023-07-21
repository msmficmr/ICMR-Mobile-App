import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';

class CustomFloatingButton extends StatelessWidget {
  /// This widget support to pass Two type of button asset default is set to [CustomFloatingAssetTypes.ICON]
  /// 1. SVG
  /// 2. IconData
  final CustomFloatingAssetTypes buttonAssetType;

  /// Color of icon default is set to [Colors.white]
  final Color iconColor;

  /// Color of the button default is set to primaryColor
  final Color buttonColor;

  /// callback for on button click
  final VoidCallback? onPressed;

  /// key for the button
  final Key? buttonKey;

  /// Pass Icon Data if [buttonAssetType] is set to  [CustomFloatingAssetTypes.ICON]
  final IconData? icon;

  /// pass svg asset path if [buttonAssetType] is set to [CustomFloatingAssetTypes.SVG]
  final String? assetPath;

  static _getIconAssert(CustomFloatingAssetTypes buttonAssetType, IconData? icon, String? assetPath) {
    if (buttonAssetType == CustomFloatingAssetTypes.ICON && icon == null) {
      throw Exception("buttonAssetType is set to [ICON]. Pass icon");
    }
    if (buttonAssetType == CustomFloatingAssetTypes.SVG && assetPath == null) {
      throw Exception("buttonAssetType is set to [SVG]. Pass assetPath");
    }

    return true;
  }

  static _getKeyAssert(buttonKey, onPressed) {
    if (onPressed != null && buttonKey == null) {
      throw Exception("onPressed is not null. Pass buttonKey");
    }

    return true;
  }

  CustomFloatingButton({
    super.key,
    this.onPressed,
    this.buttonKey,
    this.icon,
    this.assetPath,
    this.buttonColor = AppColorScheme.kPrimaryColor,
    this.buttonAssetType = CustomFloatingAssetTypes.ICON,
    this.iconColor = Colors.white,
  })  : assert(_getIconAssert(buttonAssetType, icon, assetPath)),
        assert(_getKeyAssert(buttonKey, onPressed));

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onPressed == null ? buttonColor.withOpacity(0.5) : buttonColor,
      borderRadius: AppValues.circularBorderRadius30,
      child: InkWell(
        key: buttonKey,
        onTap: onPressed,
        borderRadius: AppValues.circularBorderRadius30,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Center(
            child: buttonAssetType == CustomFloatingAssetTypes.ICON
                ? Icon(
              icon,
              color: onPressed == null ? iconColor.withOpacity(0.5) : iconColor,
            )
                : SvgPicture.asset(
              assetPath!,
              colorFilter: ColorFilter.mode(onPressed == null ? iconColor.withOpacity(0.5) : iconColor, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
