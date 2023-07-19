import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/widgets/space_widget.dart';

class DashboardCardWidget extends StatelessWidget {

  final Key titleKey, countKey;

  /// [assetPath] is the icon for the card
  /// [count] is the total count of the particular type
  /// [type] name of the type of card
  String assetPath, count, title;

  DashboardCardWidget({
    Key? key,
    required this.titleKey,
    required this.countKey,
    required this.assetPath,
    required this.count,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          color: AppColorScheme.kGrayColor.shade50,
          borderRadius: AppValues.circularBorderRadius10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(assetPath),
            const SpaceWidget(height: 5),
            Text(
              count, key: countKey,
              style: AppStyles.bodyMedium.copyWith(color: const Color(0xFF212121), fontSize: 36, fontWeight: FontWeight.w600),
            ),
            const SpaceWidget(height: 5),
            Text(
              title, key: titleKey,
              style: AppStyles.bodySmall.copyWith(color: const Color(0xFF616161)),
            )
          ],
        ),
      ),
    );
  }
}
