import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/model/static_questionnaire_model.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/views/ask_mhealth/questionnaire_screen.dart';
import 'package:mhealth/views/ask_mhealth/widgets/section_name_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class MeasurementLesionsScreen extends StatefulWidget {
  static const routerPath = "/measurementLesionsScreen";

  const MeasurementLesionsScreen({Key? key}) : super(key: key);

  @override
  State<MeasurementLesionsScreen> createState() => _MeasurementLesionsScreenState();
}

class _MeasurementLesionsScreenState extends State<MeasurementLesionsScreen> {
  late ValueNotifier<bool> _onSiteValue;
  late ValueNotifier<String?> _onSiteSpecialist;
  late ValueNotifier<String?> _fhpOpinion;
  late ValueNotifier<bool> _fhpOpinionValue;
  late ValueNotifier<String?> _autofluorescenceImpression;
  late ValueNotifier<String?> _provisionalDiagnosis;
  late ValueNotifier<bool> _buttonEnabled;

  //Titles
  final String TOTAL_LESIONS_TITLE = "Number of Lesion";
  final String ON_SITE_TITLE = "Onsite specialist";
  final String LENGTH_TITLE = "Length (mm)";
  final String BREADTH_TITLE = "Breadth (mm)";
  final String PRODUCT_TITLE = "Product (mm^2)";
  final String FHP_TITLE = "FHP Opinion Suspicious";
  final String AUTOFLOURANCE_TITLE = "Autofluorescence Impression";
  final String PROVISIONAL_DIAGNOSIS_TITLE = "Provisional diagnosis by an Onsite specialist";
  final String OTHER_CLINICAL_TITLE = "Other clinical impression";

  final _lesionsController = TextEditingController();
  final _lengthController = TextEditingController();
  final _breadthController = TextEditingController();
  final _productController = TextEditingController();
  final _otherClinicalController = TextEditingController();

  final List<String> autofluorescenceValues = ["Normal", "Loss", "Gain", "NA"];
  final List<String> provisionalDiagnosisValues = [
    "Normal",
    "Benign",
    "Tobacco pouch keratosis",
    "Homogenous leukoplakia",
    "Non Homogenous Leukoplakia",
    "Verrucous Leukoplakia",
    "Oral Lichen Planus",
    "OSMF",
    "Malignancy",
    "Other"
  ];
  List<StaticQuestionModel> staticQuestionnaires = [];

  //Widget Keys
  final String KEY_FIELD_TOTAL_LESIONS = "key_textfield_total_lesions";
  final String KEY_FIELD_ON_SITE = "key_textfield_on_site";
  final String KEY_FIELD_LENGTH = "key_textfield_length";
  final String KEY_FIELD_BREADTH = "key_textfield_breadth";
  final String KEY_FIELD_PRODUCT = "key_textfield_product";
  final String KEY_FIELD_AUTOFLOURESCENCE = "key_textfield_autofluorescence";
  final String KEY_FIELD_PROVISIONAL_DIAGNOSIS = "key_textfield_provisional_diagnosis";
  final String KEY_FIELD_OTHER_IMPRESSION = "key_textfield_other_impression";
  final String KEY_HEADING_TOTAL_LESIONS = "key_heading_total_lesions";
  final String KEY_HEADING_LENGTH = "key_heading_length";
  final String KEY_HEADING_BREADTH = "key_heading_breadth";
  final String KEY_HEADING_PRODUCT = "key_heading_product";
  final String KEY_HEADING_AUTOFLOURESCENCE = "key_heading_autofluorescence";
  final String KEY_HEADING_PROVISIONAL_DIAGNOSIS = "key_heading_provisional_diagnosis";
  final String KEY_HEADING_OTHER_IMPRESSION = "key_heading_other_impression";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  @override
  void initState() {
    super.initState();
    initializeField();
  }

  initializeField() {
    _onSiteSpecialist = ValueNotifier<String?>(null);
    _onSiteValue = ValueNotifier<bool>(false);
    _fhpOpinion = ValueNotifier<String?>(null);
    _fhpOpinionValue = ValueNotifier<bool>(false);
    _autofluorescenceImpression = ValueNotifier<String?>(null);
    _provisionalDiagnosis = ValueNotifier<String?>(null);
    _buttonEnabled = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
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
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionNameWidget(sectionName: "Measurement of lesions"),
                          CustomTextField(
                            controller: _lesionsController,
                            widgetKey: Key(KEY_FIELD_TOTAL_LESIONS),
                            hintText: TranslationKeys.enterHere.translate(context),
                            heading: TOTAL_LESIONS_TITLE,
                            headingKey: Key(KEY_HEADING_TOTAL_LESIONS),
                            validator: AppValidators.requiredField,
                            inputFormatters: [
                              AppValues.stringInputFormatter,
                            ],
                          ),
                          const SpaceWidget(
                            height: 20,
                          ),
                          ValueListenableBuilder(
                            valueListenable: _onSiteSpecialist,
                            builder: (context, _, __) {
                              return CustomChipWidget<String?>(
                                shouldTranslate: true,
                                chipList: AppConstant.BINARY_LIST,
                                onChanged: (value) {
                                  _onSiteSpecialist.value = value;
                                  if (value == 'y') {
                                    _onSiteValue.value = true;
                                  } else {
                                    _onSiteValue.value = false;
                                  }
                                  staticQuestionnaires.add(StaticQuestionModel("onsite_specialist", _onSiteSpecialist.value, null, null, DateTime.now(), null, null));
                                },
                                validator: AppValidators.validateBinaryQuestion,
                                selectedItem: _onSiteSpecialist.value,
                                heading: ON_SITE_TITLE,
                                headingKey: Key(KEY_FIELD_ON_SITE),
                              );
                            },
                          ),
                          const SpaceWidget(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: _lengthController,
                            keyboardType: TextInputType.number,
                            widgetKey: Key(KEY_FIELD_LENGTH),
                            hintText: TranslationKeys.enterHere.translate(context),
                            heading: LENGTH_TITLE,
                            headingKey: Key(KEY_HEADING_LENGTH),
                            validator: AppValidators.requiredField,
                            inputFormatters: [
                              AppValues.stringInputFormatter,
                            ],
                          ),
                          const SpaceWidget(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: _breadthController,
                            keyboardType: TextInputType.number,
                            widgetKey: Key(KEY_FIELD_LENGTH),
                            hintText: TranslationKeys.enterHere.translate(context),
                            heading: BREADTH_TITLE,
                            headingKey: Key(KEY_HEADING_BREADTH),
                            validator: AppValidators.requiredField,
                            inputFormatters: [
                              AppValues.stringInputFormatter,
                            ],
                          ),
                          const SpaceWidget(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: _productController,
                            keyboardType: TextInputType.number,
                            widgetKey: Key(KEY_FIELD_PRODUCT),
                            hintText: TranslationKeys.enterHere.translate(context),
                            heading: PRODUCT_TITLE,
                            headingKey: Key(KEY_HEADING_PRODUCT),
                            validator: AppValidators.requiredField,
                            inputFormatters: [
                              AppValues.stringInputFormatter,
                            ],
                          ),
                          const SpaceWidget(
                            height: 20,
                          ),
                          ValueListenableBuilder(
                            valueListenable: _fhpOpinion,
                            builder: (context, _, __) {
                              return CustomChipWidget<String?>(
                                shouldTranslate: true,
                                chipList: AppConstant.BINARY_LIST,
                                onChanged: (value) {
                                  _fhpOpinion.value = value;
                                  if (value == 'n') {
                                    _fhpOpinionValue.value = true;
                                  } else {
                                    _fhpOpinionValue.value = false;
                                  }
                                  staticQuestionnaires.add(StaticQuestionModel("fhp_opinion_suspicious", _fhpOpinionValue.value.toString(), null, null, DateTime.now(), null, null));
                                },
                                validator: AppValidators.validateBinaryQuestion,
                                selectedItem: _fhpOpinion.value,
                                heading: FHP_TITLE,
                                headingKey: Key(KEY_FIELD_ON_SITE),
                              );
                            },
                          ),
                          const SpaceWidget(
                            height: 20,
                          ),
                          ValueListenableBuilder(
                            valueListenable: _onSiteValue,
                            builder: (context, ifYes, __) {
                              if (ifYes) {
                                return Column(
                                  children: [
                                    ValueListenableBuilder<String?>(
                                        valueListenable: _autofluorescenceImpression,
                                        builder: (context, _, __) {
                                          return CustomDropdown<String>(
                                            widgetKey: KEY_FIELD_AUTOFLOURESCENCE,
                                            heading: AUTOFLOURANCE_TITLE,
                                            headingKey: Key(KEY_HEADING_AUTOFLOURESCENCE),
                                            hintText: TranslationKeys.select.translate(context),
                                            onChanged: (val) {
                                              _autofluorescenceImpression.value = val;
                                              staticQuestionnaires.add(StaticQuestionModel("autoflorescence_impression", _autofluorescenceImpression.value, null, null, DateTime.now(), null, null));
                                            },
                                            selectedItem: _autofluorescenceImpression.value,
                                            items: autofluorescenceValues,
                                          );
                                        }),
                                    const SpaceWidget(
                                      height: 20,
                                    ),
                                    ValueListenableBuilder<String?>(
                                        valueListenable: _provisionalDiagnosis,
                                        builder: (context, _, __) {
                                          return CustomDropdown<String>(
                                            widgetKey: KEY_FIELD_PROVISIONAL_DIAGNOSIS,
                                            heading: PROVISIONAL_DIAGNOSIS_TITLE,
                                            headingKey: Key(KEY_HEADING_PROVISIONAL_DIAGNOSIS),
                                            hintText: TranslationKeys.select.translate(context),
                                            onChanged: (val) {
                                              _provisionalDiagnosis.value = val;
                                              staticQuestionnaires.add(StaticQuestionModel("provisional_diagnosis", _provisionalDiagnosis.value, null, null, DateTime.now(), null, null));
                                            },
                                            selectedItem: _provisionalDiagnosis.value,
                                            items: provisionalDiagnosisValues,
                                          );
                                        }),
                                    const SpaceWidget(
                                      height: 20,
                                    ),
                                    ValueListenableBuilder<String?>(
                                        valueListenable: _provisionalDiagnosis,
                                        builder: (context, provisionalDiagnosis, __) {
                                          if (provisionalDiagnosis == "Other") {
                                            return CustomTextField(
                                              controller: _otherClinicalController,
                                              widgetKey: Key(KEY_FIELD_OTHER_IMPRESSION),
                                              hintText: TranslationKeys.enterHere.translate(context),
                                              heading: OTHER_CLINICAL_TITLE,
                                              headingKey: Key(KEY_HEADING_OTHER_IMPRESSION),
                                              validator: AppValidators.requiredField,
                                              inputFormatters: [
                                                AppValues.stringInputFormatter,
                                              ],
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        }),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          const SpaceWidget(
                            height: 50,
                          ),
                        ],
                      ),
                    )
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
                      onPressed: () {
                        saveMeasurementLesionsData();
                        GoRouter.of(context).push(QuestionnaireScreen.routerPath, extra: "community_risk_assessment_investigation");
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  saveMeasurementLesionsData() {
    if (_lesionsController.text.isNotEmpty) {
      staticQuestionnaires.add(StaticQuestionModel("number_of_lesion", _lesionsController.text, null, null, DateTime.now(), null, null));
    }
    if (_lengthController.text.isNotEmpty) {
      staticQuestionnaires.add(StaticQuestionModel("length", _lengthController.text, null, null, DateTime.now(), null, null));
    }
    if (_breadthController.text.isNotEmpty) {
      staticQuestionnaires.add(StaticQuestionModel("breadth", _breadthController.text, null, null, DateTime.now(), null, null));
    }
    if (_productController.text.isNotEmpty) {
      staticQuestionnaires.add(StaticQuestionModel("product", _productController.text, null, null, DateTime.now(), null, null));
    }
    if (_otherClinicalController.text.isNotEmpty) {
      staticQuestionnaires.add(StaticQuestionModel("product", _productController.text, null, null, DateTime.now(), null, null));
    }
    final questionnaireViewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    questionnaireViewModel.setNextSectionData("community_risk_assessment_measurement_lesions", context, staticSectionsData: staticQuestionnaires);
  }
}
