// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/services/location_service.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:mhealth/utils/app_color_scheme.dart';

class PermissionHome extends StatefulWidget {
  static const String routerPath = "/permission";
  const PermissionHome({super.key});

  @override
  State<PermissionHome> createState() => _PermissionHomeState();
}

class _PermissionHomeState extends State<PermissionHome> {
  final String CONSENT_PAGE_TITLE = "We require following permission";
  final String ALLOW_BUTTON = "Allow";

  final String KEY_BUTTON_ALLOW = "key_button_allow";
  final String KEY_BUTTON_TITLE = "key_text_title";
  final String KEY_BUTTON_SUBTITLE = "key_text_subtitle";

  void onContinueClick() async {
    bool hasLocationPermission = await LocationService.locationServiceInstance.checkPermission(context);
    if (hasLocationPermission) {
      //TODO: add next screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        hasLeading: false,
        appBarTitleType: CustomAppBarTitleType.HORIZONTAL_APP_ICON,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SpaceWidget(
              height: 30,
            ),
            Text(
              CONSENT_PAGE_TITLE,
              key: Key(KEY_BUTTON_TITLE),
              style: AppStyles.headlineMedium.copyWith(color: AppColorScheme.kGrayColor.shade800),
            ),
            const SpaceWidget(
              height: 30,
            ),
            SvgPicture.asset(AppAssetsPath.locPermissionConsent),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryFilledButton(
                      buttonTitle: ALLOW_BUTTON,
                      widgetKey: KEY_BUTTON_ALLOW,
                      onPressed: onContinueClick,
                    ),
                  ),
                ),
              ),
            ),
            const SpaceWidget(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
