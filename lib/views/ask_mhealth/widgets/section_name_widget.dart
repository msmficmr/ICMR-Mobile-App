import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';

class SectionNameWidget extends StatelessWidget {
  final String sectionName;
  const SectionNameWidget({Key? key, required this.sectionName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              AppAssetsPath.dottedIcon,
            ),
            SizedBox(
              width: width * 0.01,
            ),
            Expanded(
              child: Text(
                sectionName,
                style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kPrimaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
