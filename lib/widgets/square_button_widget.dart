
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/widgets/space_widget.dart';

class SquareButtonWidget extends StatelessWidget {
  final Key cardKey, titleKey;
  final VoidCallback onCardClick;
  final String title;
  final String svgPath;
  final Color iconColor;

  const SquareButtonWidget({
    super.key,
    required this.cardKey,
    required this.onCardClick,
    required this.title,
    required this.titleKey,
    required this.svgPath,
    this.iconColor = const Color(0xFF0F4391),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: cardKey,
      onTap: onCardClick,
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      child: Container(
        decoration: BoxDecoration(
          color: AppColorScheme.kGrayColor.shade200.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          border: Border.all(color: AppColorScheme.kGrayColor.shade50, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
            const SpaceWidget(
              height: 10,
            ),
            Text(
              title,
              key: titleKey,
              style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
