import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/views/ask_mhealth/widgets/section_name_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';

// ignore: must_be_immutable
class CriteriaScreen extends StatelessWidget {
  static const routerPath = "/criteriaScreen";

  CriteriaScreen({Key? key}) : super(key: key);

  //Widget Keys
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  List<String> subText1 = ['1. Clinically suspecious oral lesions (including leukoplakia, erythroplakia,lichen planus,benign lesions –epithelial tumors, ulcers, vesiculobullous lesions like pemphigus vulgaris) which are indicated for biopsy.', '2. More than 18 years of age'];
  List<String> subText2 = ['1. Less than or equal to 18 years of age.', '2. Currently undergoing treatment for malignancy', '3. Pregnancy', '4. Under treatment for tuberculosis or suffering from any acute illness'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeadingClick: () {},
        appBarTitleType: CustomAppBarTitleType.TEXT,
        titleText: AppConstant.RISK_ASSESSMENT,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppValues.kAppPadding),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  const SectionNameWidget(sectionName: "Criteria"),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: AppColorScheme.kEnabledButtonColor,
                      borderRadius: BorderRadius.all(Radius.circular(10),),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Inclusion Criteria",
                          style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kEnabledButtonTextColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(subText1[0]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(subText1[1]),
                        )
                      ],
                    ),
                  ),
                  const SpaceWidget(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: AppColorScheme.kEnabledButtonColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Exclusion Criteria",
                          style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kEnabledButtonTextColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(subText2[0]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(subText2[1]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  width: double.infinity,
                  child: PrimaryFilledButton(
                    buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                    buttonTitle: TranslationKeys.continueText.translate(context),
                    widgetKey: KEY_BUTTON_CONTINUE,
                    isLoading: false,
                    onPressed: () {
                      GoRouter.of(context).push(QuestionnaireScreen.routerPath);
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
