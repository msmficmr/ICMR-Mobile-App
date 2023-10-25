import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/model/static_questionnaire_model.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/section_name_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class PeriodontalScreen extends StatefulWidget {
  static const routerPath = "/periodontalScreen";

  PeriodontalScreen({Key? key}) : super(key: key);

  @override
  State<PeriodontalScreen> createState() => _PeriodontalScreenState();
}

class _PeriodontalScreenState extends State<PeriodontalScreen> {

  late ValueNotifier<String?> _upper_right_third_molar;
  late ValueNotifier<String?> _upper_right_central_incisor;
  late ValueNotifier<String?> _upper_left_third_molar;
  late ValueNotifier<String?> _lower_right_third_molar;
  late ValueNotifier<String?> _lower_left_first_molar;
  late ValueNotifier<String?> _lower_left_third_molar;
  late ValueNotifier<bool> _buttonEnabled;

  //Titles
  final String UPPER_RIGHT_THRID_MOLAR_DROPDOWN = "17/16";
  final String UPPER_RIGHT_CENTRAL_INCISOR_DROPDOWN = "11";
  final String UPPER_LEFT_THIRD_MOLAR_DROPDOWN = "26/27";
  final String LOWER_RIGHT_THIRD_MOLAR_DROPDOWN = "47/46";
  final String LOWER_LEFT_FIRST_MOLAR_DROPDOWN = "31";
  final String LOWER_LEFT_THIRD_MOLAR_DROPDOWN = "36/37";

  //Widget Keys
  final String KEY_HEADING_UPPER_RIGHT_THRID_MOLAR = "key_heading_upper_right_third_molar";
  final String KEY_HEADING_UPPER_RIGHT_CENTRAL_INCISOR = "key_heading_upper_right_central_incisor";
  final String KEY_HEADING_UPPER_LEFT_THIRD_MOLAR = "key_heading_upper_left_third_molar";
  final String KEY_HEADING_LOWER_RIGHT_THIRD_MOLAR = "key_heading_lower_right_third_molar";
  final String KEY_HEADING_LOWER_LEFT_FIRST_MOLAR = "key_heading_lower_left_first_molar";
  final String KEY_HEADING_LOWER_LEFT_THIRD_MOLAR = "key_heading_lower_left_third_molar";
  final String KEY_FIELD_UPPER_RIGHT_THRID_MOLAR = "key_textfield_upper_right_third_molar";
  final String KEY_FIELD_UPPER_RIGHT_CENTRAL_INCISOR = "key_textfield_upper_right_central_incisor";
  final String KEY_FIELD_UPPER_LEFT_THIRD_MOLAR = "key_textfield_upper_left_third_molar";
  final String KEY_FIELD_LOWER_RIGHT_THIRD_MOLAR = "key_textfield_lower_right_third_molar";
  final String KEY_FIELD_LOWER_LEFT_FIRST_MOLAR = "key_textfield_lower_left_first_molar";
  final String KEY_FIELD_LOWER_LEFT_THIRD_MOLAR = "key_textfield_lower_left_third_molar";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  List<String> items = ["0", "1", "2", "3", "4"];
  List<StaticQuestionModel> staticQuestionnaires = [];
  List<String> codesDescription = [];

  @override
  void initState() {
    super.initState();
    initializeField();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCPITNCodes();
  }

  initializeField() {
    _upper_right_third_molar = ValueNotifier<String?>(null);
    _upper_right_central_incisor = ValueNotifier<String?>(null);
    _upper_left_third_molar = ValueNotifier<String?>(null);
    _lower_right_third_molar = ValueNotifier<String?>(null);
    _lower_left_first_molar = ValueNotifier<String?>(null);
    _lower_left_third_molar = ValueNotifier<String?>(null);
    _buttonEnabled = ValueNotifier<bool>(true);
  }

  getCPITNCodes() {
    String codes = TranslationKeys.cpitnCodesDescription.translate(context);
    codesDescription = CommonFunctions.convertStringToList(codes);
  }

  redirectToQuestionnaire() {
    GoRouter.of(context).push(QuestionnaireScreen.routerPath, extra: "community_risk_assessment_details_of_habits");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        redirectToQuestionnaire();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          onLeadingClick: () => redirectToQuestionnaire(),
          appBarTitleType: CustomAppBarTitleType.TEXT,
          titleText: AppConstant.RISK_ASSESSMENT,
        ),
        body: Padding(
          padding: EdgeInsets.all(AppValues.kAppPadding),
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionNameWidget(sectionName: TranslationKeys.periodontalSection.translate(context)),
                      Image.asset(
                        AppAssetsPath.periodontalStatusImage,
                        width: width,
                      ),
                      const SpaceWidget(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        child: ExpansionTile(
                          initiallyExpanded: true,
                          tilePadding: const EdgeInsets.symmetric(horizontal: 14),
                          childrenPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          shape: Border.all(color: Colors.transparent),
                          backgroundColor: AppColorScheme.kEnabledButtonColor,
                          collapsedBackgroundColor: AppColorScheme.kEnabledButtonColor,
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          expandedAlignment: Alignment.topLeft,
                          title: Text(TranslationKeys.cpitnCodes.translate(context)),
                          children: List.generate(codesDescription.length, (index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(codesDescription[index]),
                                const SpaceWidget(height: 5),
                              ],
                            );
                          },)
                        ),
                      ),
                      const SpaceWidget(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: ValueListenableBuilder<String?>(
                                  valueListenable: _upper_right_third_molar,
                                  builder: (context, _, __) {
                                    return CustomDropdown(
                                      hintText: TranslationKeys.select.translate(context),
                                      heading: UPPER_RIGHT_THRID_MOLAR_DROPDOWN,
                                      headingKey: Key(KEY_HEADING_UPPER_RIGHT_THRID_MOLAR),
                                      widgetKey: KEY_FIELD_UPPER_RIGHT_THRID_MOLAR,
                                      items: items,
                                      onChanged: (val) {
                                        saveQuestion(UPPER_RIGHT_THRID_MOLAR_DROPDOWN, val!);
                                        _upper_right_third_molar.value = val;
                                      },
                                    );
                                  }
                                ),
                              ),
                              const SpaceWidget(
                                width: 20,
                              ),
                              Flexible(
                                child: ValueListenableBuilder<String?>(
                                    valueListenable: _upper_right_central_incisor,
                                    builder: (context, _, __) {
                                    return CustomDropdown(
                                      hintText: TranslationKeys.select.translate(context),
                                      heading: UPPER_RIGHT_CENTRAL_INCISOR_DROPDOWN,
                                      headingKey: Key(KEY_HEADING_UPPER_RIGHT_CENTRAL_INCISOR),
                                      widgetKey: KEY_FIELD_UPPER_RIGHT_CENTRAL_INCISOR,
                                      items: items,
                                      onChanged: (val) {
                                        saveQuestion(UPPER_RIGHT_CENTRAL_INCISOR_DROPDOWN, val!);
                                        _upper_right_central_incisor.value = val;
                                      },
                                    );
                                  }
                                ),
                              ),
                              const SpaceWidget(
                                width: 20,
                              ),
                              Flexible(
                                child: ValueListenableBuilder<String?>(
                                    valueListenable: _upper_left_third_molar,
                                    builder: (context, _, __)  {
                                    return CustomDropdown(
                                      hintText: TranslationKeys.select.translate(context),
                                      heading: UPPER_LEFT_THIRD_MOLAR_DROPDOWN,
                                      headingKey: Key(KEY_HEADING_UPPER_LEFT_THIRD_MOLAR),
                                      widgetKey: KEY_FIELD_UPPER_LEFT_THIRD_MOLAR,
                                      items: items,
                                      onChanged: (val) {
                                        saveQuestion(UPPER_LEFT_THIRD_MOLAR_DROPDOWN, val!);
                                        _upper_left_third_molar.value = val;
                                      },
                                    );
                                  }
                                ),
                              ),
                            ],
                          ),
                          const SpaceWidget(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: ValueListenableBuilder<String?>(
                                    valueListenable: _lower_right_third_molar,
                                    builder: (context, _, __)  {
                                    return CustomDropdown(
                                      hintText: TranslationKeys.select.translate(context),
                                      heading: LOWER_RIGHT_THIRD_MOLAR_DROPDOWN,
                                      headingKey: Key(KEY_HEADING_LOWER_RIGHT_THIRD_MOLAR),
                                      widgetKey: KEY_FIELD_LOWER_RIGHT_THIRD_MOLAR,
                                      items: items,
                                      onChanged: (val) {
                                        saveQuestion(LOWER_RIGHT_THIRD_MOLAR_DROPDOWN, val!);
                                        _lower_right_third_molar.value = val;
                                      },
                                    );
                                  }
                                ),
                              ),
                              const SpaceWidget(
                                width: 20,
                              ),
                              Flexible(
                                child: ValueListenableBuilder<String?>(
                                    valueListenable: _lower_left_first_molar,
                                    builder: (context, _, __)  {
                                    return CustomDropdown(
                                      hintText: TranslationKeys.select.translate(context),
                                      heading: LOWER_LEFT_FIRST_MOLAR_DROPDOWN,
                                      headingKey: Key(KEY_HEADING_LOWER_LEFT_FIRST_MOLAR),
                                      widgetKey: KEY_FIELD_LOWER_LEFT_FIRST_MOLAR,
                                      items: items,
                                      onChanged: (val) {
                                        saveQuestion(LOWER_LEFT_FIRST_MOLAR_DROPDOWN, val!);
                                        _lower_left_first_molar.value = val;
                                      },
                                    );
                                  }
                                ),
                              ),
                              const SpaceWidget(
                                width: 20,
                              ),
                              Flexible(
                                child: ValueListenableBuilder<String?>(
                                    valueListenable: _lower_left_third_molar,
                                    builder: (context, _, __)  {
                                    return CustomDropdown(
                                      hintText: TranslationKeys.select.translate(context),
                                      heading: LOWER_LEFT_THIRD_MOLAR_DROPDOWN,
                                      headingKey: Key(KEY_HEADING_LOWER_LEFT_THIRD_MOLAR),
                                      widgetKey: KEY_FIELD_LOWER_LEFT_THIRD_MOLAR,
                                      items: items,
                                      onChanged: (val) {
                                        saveQuestion(LOWER_LEFT_THIRD_MOLAR_DROPDOWN, val!);
                                        _lower_left_third_molar.value = val;
                                      },
                                    );
                                  }
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SpaceWidget(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: double.infinity,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _buttonEnabled,
                      builder: (context, isValid, _) {
                        return PrimaryFilledButton(
                          buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                          buttonTitle: TranslationKeys.continueText.translate(context),
                          widgetKey: KEY_BUTTON_CONTINUE,
                          isLoading: false,
                          onPressed: () async {
                            await savePeriodontalData();
                            GoRouter.of(context).push(LesionLocationScreen.routerPath);
                          },
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  saveQuestion(String questionId, String value) {
    final staticQuestion = StaticQuestionModel(questionId, value, null, null, DateTime.now(), null, null);
    for (int i = 0; i < staticQuestionnaires.length; i++) {
      if (staticQuestionnaires[i].questionid == staticQuestion.questionid) {
        staticQuestionnaires.removeAt(i);
      }
    }
    staticQuestionnaires.add(staticQuestion);
  }

  savePeriodontalData() async {
    final questionnaireViewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    await questionnaireViewModel.setNextSectionData("community_risk_assessment_periodontal_status", context, staticSectionsData: staticQuestionnaires);
  }
}
