import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/views/dashboard/widgets/count_card_widget.dart';
import 'package:mhealth/widgets/circular_avatar_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_icon_button.dart';
import 'package:mhealth/widgets/space_widget.dart';

class DashboardScreen extends StatefulWidget {
  static const String routerPath = "/dashboard";

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //Widget Keys
  final String KEY_BUTTON_TAKE_CRA = "key_button_take_cra";
  final String KEY_BUTTON_SYNC = "key_button_sync";

  takeCRA() {
    GoRouter.of(context).go(CRAPatientScreen.routerPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hasLeading: false,
        appBarTitleType: CustomAppBarTitleType.HORIZONTAL_APP_ICON,
        centerTitle: false,
        trailingType: CustomAppBarTrailingType.SINGLE,
        trailingWidget: InkWell(
          onTap: (){},
          child: const SizedBox(
            width: 30,
            height: 30,
            child: CircularAvatar(
              childType: CircularAvatarFieldChildType.SVG_ASSET,
              childData: AppAssetsPath.icProfile,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TranslationKeys.dashboard.translate(context),
                    style: AppStyles.headlineMedium.copyWith(
                      color: const Color(0xFF212121),
                    ),
                  ),
                  const SpaceWidget(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CountCardWidget(assetPath: AppAssetsPath.icCRA, count: "150", title: TranslationKeys.totalCRACompleted.translate(context)),
                      const SpaceWidget(
                        width: 20,
                      ),
                      CountCardWidget(assetPath: AppAssetsPath.icSync, count: "130", title: TranslationKeys.totalCRASync.translate(context)),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: PrimaryFilledIconButton(
                        onPressed: () {},
                        isLoading: false,
                        buttonThemeStyle: const FilledButtonThemeStyle(
                          enabledTextColor: Color(0xFF2F43EE),
                          enabledButtonColor: Color(0xFFF4F5FF),
                        ),
                        icon: SvgPicture.asset(
                          AppAssetsPath.icSync,
                          colorFilter: const ColorFilter.mode(AppColorScheme.kPrimaryColor, BlendMode.srcIn),
                        ),
                        buttonTitle: TranslationKeys.youAreOnlineSyncData.translate(context),
                        widgetKey: KEY_BUTTON_SYNC),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryFilledIconButton(
                      buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                      buttonTitle: TranslationKeys.takeCRA.translate(context),
                      widgetKey: KEY_BUTTON_TAKE_CRA,
                      isLoading: false,
                      onPressed: () => takeCRA(),
                      icon: SvgPicture.asset(
                        AppAssetsPath.icCRA,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
