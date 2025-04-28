import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/widgets/space_widget.dart';

class AccountCard extends StatelessWidget {
  /// if AccountCard doesn't have leading widget then set [hasLeading] parameter to `false` default value is `true`
  /// if AccountCard doesn't have trailing widget then set [hasTrailing] parameter to `false` default value is `true`
  final bool hasLeading, hasTrailing;

  /// [leadingIconPath] is used to show icon as leading widget
  /// [trailingIconPath] is used to show icon as leading widget
  /// [titleText] is used to set title as string
  final String leadingIconPath, cardTitleText;
  final String? trailingIconPath;

  final TextStyle? textStyle;

  /// [onTap]
  final Function()? onTap;

  final double? iconSize;

  final Key? cardKey;
  
  final Color? iconColor;

  const AccountCard({
    super.key,
    this.iconSize,
    this.onTap,
    this.textStyle,
    this.trailingIconPath,
    this.hasLeading = true,
    this.hasTrailing = true,
    this.cardKey,
    required this.leadingIconPath,
    required this.cardTitleText,
    this.iconColor ,
  });

  //KEY
  final String KEY_OPTION_SELECT = "key_option_select";

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return InkWell(
      key: cardKey,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all(color: AppColorScheme.kGrayColor.shade200)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (hasLeading)
                SvgPicture.asset(
                  leadingIconPath,
                  height: isSmallScreen ? 25 : 35,
                  width: isSmallScreen ? 25 : 35,
                ),
              const SpaceWidget(width: 15),
              Expanded(
                child: Text(
                  cardTitleText,
                  key: Key(KEY_OPTION_SELECT),
                  style: textStyle ?? AppStyles.bodyMedium,
                ),
              ),
              if (hasTrailing)
                SvgPicture.asset(
                  trailingIconPath!,
                  height: isSmallScreen ? 15 : 25,
                  width: isSmallScreen ? 15 : 25
                )
            ],
          ),
        ),
      ),
    );
  }
}
