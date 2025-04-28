import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardCardWidget extends StatelessWidget {
  final Key titleKey, countKey;

  /// [assetPath] is the icon for the card
  /// [count] is the total count of the particular type
  /// [title] name of the title of card
  String assetPath, count, title;
  bool isLoading;

  DashboardCardWidget({
    Key? key,
    required this.isLoading,
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
            isLoading
                ? Skeletonizer(
                    enabled: true,
                    child: Skeleton.shade(
                      shade: true,
                      child: Container(
                        height: 40,
                        width: 40,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    count,
                    key: countKey,
                    style: AppStyles.titleBig,
                  ),
            const SpaceWidget(height: 5),
            Text(
              title,
              key: titleKey,
              style: AppStyles.bodySmall.copyWith(color: AppColorScheme.kGrayColor.shade700),
            )
          ],
        ),
      ),
    );
  }
}
