import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/model/static_questionnaire_model.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
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

  late ValueNotifier<String?> _dropdown1;
  late ValueNotifier<String?> _dropdown2;
  late ValueNotifier<String?> _dropdown3;
  late ValueNotifier<String?> _dropdown4;
  late ValueNotifier<String?> _dropdown5;
  late ValueNotifier<String?> _dropdown6;
  late ValueNotifier<bool> _buttonEnabled;

  //Titles
  final String DROPDOWN1 = "17/16";
  final String DROPDOWN2 = "11";
  final String DROPDOWN3 = "26/27";
  final String DROPDOWN4 = "47/46";
  final String DROPDOWN5 = "31";
  final String DROPDOWN6 = "36/37";

  //Widget Keys
  final String KEY_HEADING_DROPDOWN1 = "key_heading_dropdown_1";
  final String KEY_HEADING_DROPDOWN2 = "key_heading_dropdown_2";
  final String KEY_HEADING_DROPDOWN3 = "key_heading_dropdown_3";
  final String KEY_HEADING_DROPDOWN4 = "key_heading_dropdown_4";
  final String KEY_HEADING_DROPDOWN5 = "key_heading_dropdown_5";
  final String KEY_HEADING_DROPDOWN6 = "key_heading_dropdown_6";
  final String KEY_FIELD_DROPDOWN1 = "key_textfield_dropdown_1";
  final String KEY_FIELD_DROPDOWN2 = "key_textfield_dropdown_2";
  final String KEY_FIELD_DROPDOWN3 = "key_textfield_dropdown_3";
  final String KEY_FIELD_DROPDOWN4 = "key_textfield_dropdown_4";
  final String KEY_FIELD_DROPDOWN5 = "key_textfield_dropdown_5";
  final String KEY_FIELD_DROPDOWN6 = "key_textfield_dropdown_6";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  List<String> items = ["0", "1", "2", "3", "4"];
  List<StaticQuestionModel> staticQuestionnaires = [];

  @override
  void initState() {
    super.initState();
    initializeField();
  }

  initializeField() {
    _dropdown1 = ValueNotifier<String?>(null);
    _dropdown2 = ValueNotifier<String?>(null);
    _dropdown3 = ValueNotifier<String?>(null);
    _dropdown4 = ValueNotifier<String?>(null);
    _dropdown5 = ValueNotifier<String?>(null);
    _dropdown6 = ValueNotifier<String?>(null);
    _buttonEnabled = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        onLeadingClick: () => GoRouter.of(context).pop(),
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
                    const SectionNameWidget(sectionName: "Periodontal Status"),
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
                        title: const Text('CPITN Codes'),
                        children: const <Widget>[
                          Text('0 = Healthy'),
                          SpaceWidget(
                            height: 5,
                          ),
                          Text('1 = Bleeding on probing'),
                          SpaceWidget(
                            height: 5,
                          ),
                          Text('2 = Calculus or plaque retention factor'),
                          SpaceWidget(
                            height: 5,
                          ),
                          Text('3 = Shallow pocket 4 or 5mm'),
                          SpaceWidget(
                            height: 5,
                          ),
                          Text('4 = Deep pocket 6mm or more'),
                        ],
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
                                valueListenable: _dropdown1,
                                builder: (context, _, __) {
                                  return CustomDropdown(
                                    hintText: TranslationKeys.select.translate(context),
                                    heading: DROPDOWN1,
                                    headingKey: Key(KEY_HEADING_DROPDOWN1),
                                    widgetKey: KEY_FIELD_DROPDOWN1,
                                    items: items,
                                    onChanged: (val) {
                                      saveQuestion(DROPDOWN1, val!);
                                      _dropdown1.value = val;
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
                                  valueListenable: _dropdown2,
                                  builder: (context, _, __) {
                                  return CustomDropdown(
                                    hintText: TranslationKeys.select.translate(context),
                                    heading: DROPDOWN2,
                                    headingKey: Key(KEY_HEADING_DROPDOWN2),
                                    widgetKey: KEY_FIELD_DROPDOWN2,
                                    items: items,
                                    onChanged: (val) {
                                      saveQuestion(DROPDOWN2, val!);
                                      _dropdown2.value = val;
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
                                  valueListenable: _dropdown3,
                                  builder: (context, _, __)  {
                                  return CustomDropdown(
                                    hintText: TranslationKeys.select.translate(context),
                                    heading: DROPDOWN3,
                                    headingKey: Key(KEY_HEADING_DROPDOWN3),
                                    widgetKey: KEY_FIELD_DROPDOWN3,
                                    items: items,
                                    onChanged: (val) {
                                      saveQuestion(DROPDOWN3, val!);
                                      _dropdown3.value = val;
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
                                  valueListenable: _dropdown4,
                                  builder: (context, _, __)  {
                                  return CustomDropdown(
                                    hintText: TranslationKeys.select.translate(context),
                                    heading: DROPDOWN4,
                                    headingKey: Key(KEY_HEADING_DROPDOWN4),
                                    widgetKey: KEY_FIELD_DROPDOWN4,
                                    items: items,
                                    onChanged: (val) {
                                      saveQuestion(DROPDOWN4, val!);
                                      _dropdown4.value = val;
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
                                  valueListenable: _dropdown5,
                                  builder: (context, _, __)  {
                                  return CustomDropdown(
                                    hintText: TranslationKeys.select.translate(context),
                                    heading: DROPDOWN5,
                                    headingKey: Key(KEY_HEADING_DROPDOWN5),
                                    widgetKey: KEY_FIELD_DROPDOWN5,
                                    items: items,
                                    onChanged: (val) {
                                      saveQuestion(DROPDOWN5, val!);
                                      _dropdown5.value = val;
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
                                  valueListenable: _dropdown6,
                                  builder: (context, _, __)  {
                                  return CustomDropdown(
                                    hintText: TranslationKeys.select.translate(context),
                                    heading: DROPDOWN6,
                                    headingKey: Key(KEY_HEADING_DROPDOWN6),
                                    widgetKey: KEY_FIELD_DROPDOWN6,
                                    items: items,
                                    onChanged: (val) {
                                      saveQuestion(DROPDOWN6, val!);
                                      _dropdown6.value = val;
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
                      height: 20,
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
    );
  }

  saveQuestion(String questionId, String value) {
    final staticQuestion = StaticQuestionModel(questionId, value, null, null, DateTime.now(), null, null);
    staticQuestionnaires.add(staticQuestion);
  }

  savePeriodontalData() async {
    final questionnaireViewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    await questionnaireViewModel.setNextSectionData("community_risk_assessment_periodontal_status", context, staticSectionsData: staticQuestionnaires);
  }
}
