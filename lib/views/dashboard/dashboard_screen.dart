import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/viewModel/offline_data_view_model.dart';
import 'package:mhealth/views/dashboard/widgets/count_card_widget.dart';
import 'package:mhealth/widgets/circular_avatar_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_icon_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const String routerPath = "/dashboard";

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  LoginViewModel? loginViewModel;

  late ValueNotifier<bool> _syncData;

  //Keys
  final String KEY_DASHBOARD_APPBAR = "key_dashboard_appbar";
  final String KEY_CARD_COUNT = "key_card_count";
  final String KEY_CARD_TITLE = "key_card_title";
  final String KEY_BUTTON_TAKE_CRA = "key_button_take_cra";
  final String KEY_BUTTON_SYNC = "key_button_sync";

  redirectToCRAScreen() async {
    GoRouter.of(context).push(CRAPatientScreen.routerPath);
  }

  redirectToMyAccountsScreen() async {
    await SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.SHARED_PREFERENCE_USER_DETAILS);
    GoRouter.of(context).push(MyAccountScreen.routerPath);
  }

  checkToSyncData() async {
    List<CRAOfflineData?> response = await IsarDbService.isarDbService.getListCRAOfflineData();
    if (response.isNotEmpty) {
      _syncData.value = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _syncData = ValueNotifier<bool>(false);
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    String userId = loginViewModel?.userDetails?.userId ?? "";
    Provider.of<OfflineDataViewModel>(context, listen: false).fetchOfflineSyncedNumbers(userId: userId);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        checkToSyncData();
      } else {
        _syncData.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        key: Key(KEY_DASHBOARD_APPBAR),
        hasLeading: false,
        appBarTitleType: CustomAppBarTitleType.HORIZONTAL_APP_ICON,
        centerTitle: false,
        trailingType: CustomAppBarTrailingType.SINGLE,
        trailingWidget: InkWell(
          onTap: redirectToMyAccountsScreen,
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
                      color: AppColorScheme.kGrayColor.shade900,
                    ),
                  ),
                  const SpaceWidget(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DashboardCardWidget(
                        assetPath: AppAssetsPath.icCRA,
                        count: "150",
                        title: TranslationKeys.totalCRACompleted.translate(context),
                        countKey: Key(KEY_CARD_COUNT),
                        titleKey: Key(KEY_CARD_TITLE),
                      ),
                      const SpaceWidget(
                        width: 20,
                      ),
                      Selector<OfflineDataViewModel, String>(
                        selector: (context, offlineDataViewModel) => (offlineDataViewModel.syncedNumbers ?? 0).toString(),
                        builder: (context, count, child) {
                          return DashboardCardWidget(
                            assetPath: AppAssetsPath.icSync,
                            count: count,
                            title: TranslationKeys.totalCRASync.translate(context),
                            countKey: Key(KEY_CARD_COUNT),
                            titleKey: Key(KEY_CARD_TITLE),
                          );
                        },
                      )
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
                  ValueListenableBuilder(
                    valueListenable: _syncData,
                    builder: (context, syncData, _) {
                      if (syncData) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: PrimaryFilledIconButton(
                              onPressed: () {
                                redirectToMyAccountsScreen();
                              },
                              isLoading: false,
                              buttonThemeStyle: const FilledButtonThemeStyle(
                                enabledTextColor: AppColorScheme.kEnabledButtonTextColor,
                                enabledButtonColor: AppColorScheme.kEnabledButtonColor,
                              ),
                              icon: SvgPicture.asset(
                                AppAssetsPath.icSync,
                                colorFilter: const ColorFilter.mode(AppColorScheme.kPrimaryColor, BlendMode.srcIn),
                              ),
                              buttonTitle: TranslationKeys.youAreOnlineSyncData.translate(context),
                              widgetKey: KEY_BUTTON_SYNC),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const SpaceWidget(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryFilledIconButton(
                      buttonThemeStyle: FilledButtonThemeStyle(disabledTextColor: AppColorScheme.kPrimaryIconColor),
                      buttonTitle: TranslationKeys.takeCRA.translate(context),
                      widgetKey: KEY_BUTTON_TAKE_CRA,
                      isLoading: false,
                      onPressed: () => redirectToCRAScreen(),
                      icon: SvgPicture.asset(
                        AppAssetsPath.icCRA,
                        colorFilter: ColorFilter.mode(AppColorScheme.kPrimaryIconColor, BlendMode.srcIn),
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
