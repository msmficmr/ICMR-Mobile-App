import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/services/location_service.dart';
import 'package:mhealth/services/questinnaire_service.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/views/dashboard/dashboard_screen.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';
import 'widget/custom_language_card_widget.dart';

class LanguageSelectionScreen extends StatefulWidget {
  static const String routerPath = "/languageSelectionScreen";
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late LanguageViewModel languageViewModel;
  late ValueNotifier<bool> _buttonEnabled;

  //TITLE
  static const String TITLE_PREFERRED_LANGUAGE = "Choose Your Preferred Language";
  static const String TITLE_SELECT_LANGUAGE = "Please select your language";

  //KEY
  final String KEY_PREFERRED_LANGUAGE = "key_preferred_language";
  final String KEY_SELECT_LANGUAGE = "key_select_language";

  onContinueClick() async {
    if (_buttonEnabled.value) {
      await LocationService.locationServiceInstance.checkPermission(context);
      String? locale = languageViewModel.selectedLanguage;
      languageViewModel.isLoading = true;
      RiskAssessmentQuestionaire? rAQuestions = await QuestionnaireService().loadQuestionnaireAsset(locale);
      if (rAQuestions != null) {
        await IsarDbService.isarDbService.updateRiskAssessmentQuestionnaire(locale, rAQuestions);
      } else {
        CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
      }
      GoRouter.of(context).go(DashboardScreen.routerPath);
    }
  }

  @override
  void initState() {
    super.initState();
    _buttonEnabled = ValueNotifier<bool>(false);
    languageViewModel = Provider.of<LanguageViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.HORIZONTAL_APP_ICON,
        hasLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.kAppPadding),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SpaceWidget(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  TITLE_PREFERRED_LANGUAGE,
                  key: Key(KEY_PREFERRED_LANGUAGE),
                  style: AppStyles.headlineMedium.copyWith(color: AppColorScheme.kGrayColor, fontWeight: FontWeight.w700, fontFamily: AppConstant.FONT_FAMILY),
                ),
              ),
            ],
          ),
          const SpaceWidget(
            height: 10,
          ),
          Text(
            TITLE_SELECT_LANGUAGE,
            key: Key(KEY_SELECT_LANGUAGE),
            style: AppStyles.titleSmall.copyWith(color: AppColorScheme.kGrayColor.shade700, fontFamily: AppConstant.FONT_FAMILY),
          ),
          const SpaceWidget(
            height: 30,
          ),
          Expanded(
            child: Selector<LanguageViewModel, int>(
                selector: (context, provider) => provider.selectedIndex,
                builder: (context, currentSelectedIndex, child) {
                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20, childAspectRatio: 1 / 0.4),
                      itemCount: AppConstant.languages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = AppConstant.languages[index];

                        return InkWell(
                          onTap: () {
                            if (languageViewModel.selectedIndex == index) {
                              _buttonEnabled.value = false;
                              languageViewModel.setSelectedLanguage(
                                  selectedLanguage: item['name'] ?? "", selectedIndex: -1, locale: Locale(item['locale'] ?? "")); // Unselect the item if already selected
                            } else {
                              _buttonEnabled.value = true;
                              languageViewModel.setSelectedLanguage(selectedLanguage: item['locale'] ?? "", selectedIndex: index, locale: Locale(item['locale'] ?? "")); // Update the selected index
                            }
                          },
                          child: Center(
                            child: CustomLanguageCardWidget(
                              isSelected: languageViewModel.selectedIndex == index,
                              cardTile: item['name'] ?? "",
                              cardTitleKey: "key_language_${item['name']}",
                              widgetKey: "Key_${item['locale']}card_widget",
                            ),
                          ),
                        );
                      });
                }),
          ),
          const SpaceWidget(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Selector<LanguageViewModel, bool>(
              selector: (_, provider) => provider.isLoading,
              builder: (context, isLoading, __) {
                return ValueListenableBuilder<bool>(
                    valueListenable: _buttonEnabled,
                    builder: (context, isValid, _) {
                      return PrimaryFilledButton(
                        buttonThemeStyle: FilledButtonThemeStyle(disabledTextColor: AppColorScheme.kPrimaryIconColor),
                        buttonTitle: AppConstant.CONTINUE_BUTTON_TITLE,
                        widgetKey: AppConstant.KEY_BUTTON_CONTINUE,
                        isLoading: isLoading,
                        onPressed: !isValid
                            ? null
                            : () {
                                onContinueClick();
                              },
                      );
                    });
              }
            ),
          ),
          const SpaceWidget(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
