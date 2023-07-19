import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';

class DashboardScreen extends StatefulWidget {
  static const String routerPath = "/dashboard";

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //Widget Keys
  final String KEY_BUTTON_TAKE_CRA = "key_button_take_cra";

  redirectToCRAScreen() {
    GoRouter.of(context).push(CRAPatientScreen.routerPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text("Dashboard Screen"),
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
              onPressed: () {
                redirectToCRAScreen();
              },
            ),
          )
        ],
      ),
    );
  }
}
