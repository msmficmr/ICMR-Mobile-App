import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/widgets/space_widget.dart';

class NewChatHeader extends StatelessWidget {
  final bool hasBorder;

  const NewChatHeader({Key? key, this.hasBorder = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Hero(
            tag: AppConstant.CONSENT_HEADER_BACKGROUND_TAG,
            child: Container(
              decoration: BoxDecoration(color: AppColorScheme.kPrimaryColor, borderRadius: hasBorder ? const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)) : null),
              padding: const EdgeInsets.symmetric(vertical: 50),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: AppConstant.CONSENT_HEADER_LOGO_TAG,
                      child: SvgPicture.asset(
                        AppAssetsPath.appIcon,
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(AppColorScheme.kPrimaryIconColor, BlendMode.srcIn),
                        height: 25,
                      ),
                    ),
                    const SpaceWidget(width: 10),
                    Hero(
                      tag: AppConstant.CONSENT_HEADER_HEADING_TAG,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          AppConstant.M_HEALTH_LABEL,
                          style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kPrimaryIconColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Hero(
                  tag: AppConstant.CONSENT_HEADER_SUB_HEADING_TAG,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      AppConstant.AI_BASED_CANCER_RISK_ASSESSMENT,
                      style: AppStyles.bodySmall.copyWith(color: AppColorScheme.kGrayColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
