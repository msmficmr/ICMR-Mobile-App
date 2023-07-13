import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/views/dashboard/widgets/count_card_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
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
                    "Dashboard",
                    style: AppStyles.headlineMedium.copyWith(
                      color: const Color(0xFF212121),
                    ),
                  ),
                  const SpaceWidget(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      childAspectRatio: 1.25,
                      crossAxisCount: 2,
                      primary: false,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        CountCardWidget(assetPath: AppAssetsPath.icCRA, count: "150", title: "Total CRA Completed"),
                        CountCardWidget(assetPath: AppAssetsPath.icSync, count: "130", title: "Total CRA Sync"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PrimaryFilledButton(
                buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                buttonTitle: AppConstant.TAKE_CRA_BUTTON_TITLE,
                widgetKey: KEY_BUTTON_TAKE_CRA,
                isLoading: false,
                onPressed: () => takeCRA(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
