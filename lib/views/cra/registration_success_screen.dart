import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/views/cra/widgets/cardWidget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/space_widget.dart';

class RegistrationSuccessFullScreen extends StatefulWidget {
  static const routerPath = "/registrationSuccessFullScreen";

  const RegistrationSuccessFullScreen({Key? key}) : super(key: key);
  @override
  State<RegistrationSuccessFullScreen> createState() => _RegistrationSuccessFullScreenState();
}

class _RegistrationSuccessFullScreenState extends State<RegistrationSuccessFullScreen> {

  //Widget Keys
  final String KEY_TAKE_CRA_CARD = "key_take_cra_card";
  final String KEY_NEW_REGISTRATION_CARD = "key_new_registration_card";

  final String patientName = "Aparna"; 
  final String REGISTRATION_SUCCESSFUL = "Registration Successful";
  final String YOUR_NEXT_STEP = 'Your Next Step';

  double horizontalSpacing = 10;

  @override
  void initState() {
    super.initState();
  }

  redirectToDashboard() {
    GoRouter.of(context).go(DashboardScreen.routerPath);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        redirectToDashboard();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: false,
          onLeadingClick: () {
            redirectToDashboard();
          },
          titleText: TranslationKeys.registration.translate(context),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                  decoration: const BoxDecoration(
                    color: AppColorScheme.kLightBlue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssetsPath.icRegistrationOk),
                      const SpaceWidget(
                        height: 10,
                      ),
                      Text(
                        TranslationKeys.registrationSuccessful.translate(context),
                        style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const SpaceWidget(
                        height: 20,
                      ),
                      Text(
                        "${TranslationKeys.thankYou.translate(context)}, $patientName \n ${TranslationKeys.registeredSuccessfully.translate(context)}.",
                        textAlign: TextAlign.center,
                        style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kGrayColor.shade500, fontWeight: FontWeight.w400, fontFamily: AppConstant.FONT_FAMILY),
                      ),
                    ],
                  ),
                ),
                const SpaceWidget(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    TranslationKeys.yourNextStep.translate(context),
                    style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kGrayColor.shade800, fontWeight: FontWeight.w600, fontFamily: AppConstant.FONT_FAMILY),
                  ),
                ),
                const SpaceWidget(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardWidget(key: Key(KEY_TAKE_CRA_CARD), title: TranslationKeys.takeCRA.translate(context), image: AppAssetsPath.icCRA, onTap: () {
                      GoRouter.of(context).push(CriteriaScreen.routerPath);
                    },),
                    CardWidget(key: Key(KEY_NEW_REGISTRATION_CARD), title: TranslationKeys.newRegistration.translate(context), image: AppAssetsPath.icAddCircular),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
