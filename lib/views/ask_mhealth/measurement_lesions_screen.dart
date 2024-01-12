import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/model/static_questionnaire_model.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/section_name_widget.dart';
import 'package:mhealth/views/cra/cra_patients_screen.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class MeasurementLesionsScreen extends StatefulWidget {
  static const routerPath = "/measurementLesionsScreen";

  bool? redirect;

  MeasurementLesionsScreen({Key? key, required this.redirect}) : super(key: key);

  @override
  State<MeasurementLesionsScreen> createState() => _MeasurementLesionsScreenState();
}

class _MeasurementLesionsScreenState extends State<MeasurementLesionsScreen> {
  late ValueNotifier<bool> _onSiteValue;
  late ValueNotifier<String?> _onSiteSpecialist;
  late ValueNotifier<bool> _buttonEnabled;
  late QuestionnaireViewModel questionnaireViewModel;

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

  final List<String> autofluorescenceValues = ["Normal", "Loss", "Gain", "NA"];
  final Map<int, String> provisionalDiagnosisValues = {
    1: "Normal",
    2: "Benign",
    3: "Tobacco pouch keratosis",
    4: "Homogenous leukoplakia",
    5: "Non Homogenous Leukoplakia",
    6: "Verrucous Leukoplakia",
    7: "Oral Lichen Planus",
    8: "OSMF",
    9: "Malignancy",
    10: "Other"
  };
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

  final _lesionsController = TextEditingController();
  final _lengthControllers = <TextEditingController>[];
  final _breadthControllers = <TextEditingController>[];
  final _productControllers = <TextEditingController>[];
  final _otherControllers = <TextEditingController>[];
  List<ValueNotifier<String?>> _fhpOpinions = [];
  List<ValueNotifier<bool>> _fhpOpinionValue = [];
  List<ValueNotifier<String?>> _autofluorescenceImpression = [];
  List<ValueNotifier<String?>> _provisionalDiagnosis = [];

  @override
  void initState() {
    super.initState();
    initializeField();
  }

  initializeField() {
    _onSiteSpecialist = ValueNotifier<String?>(null);
    _onSiteValue = ValueNotifier<bool>(false);
    _buttonEnabled = ValueNotifier<bool>(true);
    questionnaireViewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    _lesionsController.text =
        questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList.length.toString() : questionnaireViewModel.attachmentList.length.toString();
    _fhpOpinions = List.generate(questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList.length : questionnaireViewModel.attachmentList.length,
        (_) => ValueNotifier<String?>(null));
    _fhpOpinionValue = List.generate(questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList.length : questionnaireViewModel.attachmentList.length,
        (_) => ValueNotifier<bool>(false));
    _autofluorescenceImpression = List.generate(
        questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList.length : questionnaireViewModel.attachmentList.length,
        (_) => ValueNotifier<String?>(null));
    _provisionalDiagnosis = List.generate(
        questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList.length : questionnaireViewModel.attachmentList.length,
        (_) => ValueNotifier<String?>(null));
    getLesionsData();
  }

  getLesionsData() {
    for (var element in (questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList : questionnaireViewModel.attachmentList)) {
      var lengthController = TextEditingController();
      _lengthControllers.add(lengthController);
      var breadthController = TextEditingController();
      _breadthControllers.add(breadthController);
      var productController = TextEditingController();
      _productControllers.add(productController);
      var otherController = TextEditingController();
      _otherControllers.add(otherController);
    }
  }

  redirectToQuestionnaire() async {
    if (widget.redirect ?? false) {
      GoRouter.of(context).go(CRAPatientScreen.routerPath);
    } else {
      GoRouter.of(context).push(LesionLocationScreen.routerPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeadingClick: () => redirectToQuestionnaire(),
        appBarTitleType: CustomAppBarTitleType.TEXT,
        titleText: AppConstant.RISK_ASSESSMENT,
      ),
      body: WillPopScope(
        onWillPop: () async {
          redirectToQuestionnaire();
          return false;
        },
        child: Padding(
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
                              enabled: false,
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
                                    if (value == 'yes') {
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
                            ListView.builder(
                              itemCount: questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList.length : questionnaireViewModel.attachmentList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${index + 1}. ${questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList[index] : questionnaireViewModel.attachmentList[index]?.fileName ?? ""}",
                                      style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                    const SpaceWidget(
                                      height: 20,
                                    ),
                                    CustomTextField(
                                      controller: _lengthControllers[index],
                                      keyboardType: TextInputType.number,
                                      widgetKey: Key(KEY_FIELD_LENGTH),
                                      hintText: TranslationKeys.enterHere.translate(context),
                                      heading: LENGTH_TITLE,
                                      headingKey: Key(KEY_HEADING_LENGTH),
                                      validator: AppValidators.requiredField,
                                    ),
                                    const SpaceWidget(
                                      height: 20,
                                    ),
                                    CustomTextField(
                                      controller: _breadthControllers[index],
                                      keyboardType: TextInputType.number,
                                      widgetKey: Key(KEY_FIELD_LENGTH),
                                      hintText: TranslationKeys.enterHere.translate(context),
                                      heading: BREADTH_TITLE,
                                      headingKey: Key(KEY_HEADING_BREADTH),
                                      validator: AppValidators.requiredField,
                                    ),
                                    const SpaceWidget(
                                      height: 20,
                                    ),
                                    CustomTextField(
                                      controller: _productControllers[index],
                                      keyboardType: TextInputType.number,
                                      widgetKey: Key(KEY_FIELD_PRODUCT),
                                      hintText: TranslationKeys.enterHere.translate(context),
                                      heading: PRODUCT_TITLE,
                                      headingKey: Key(KEY_HEADING_PRODUCT),
                                      validator: AppValidators.requiredField,
                                    ),
                                    const SpaceWidget(
                                      height: 20,
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: _fhpOpinions[index],
                                      builder: (context, _, __) {
                                        return CustomChipWidget<String?>(
                                          shouldTranslate: true,
                                          chipList: AppConstant.BINARY_LIST,
                                          onChanged: (value) {
                                            _fhpOpinions[index].value = value;
                                            if (value == 'no') {
                                              _fhpOpinionValue[index].value = false;
                                            } else {
                                              _fhpOpinionValue[index].value = true;
                                            }
                                          },
                                          validator: AppValidators.validateBinaryQuestion,
                                          selectedItem: _fhpOpinions[index].value,
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
                                                  valueListenable: _autofluorescenceImpression[index],
                                                  builder: (context, _, __) {
                                                    return CustomDropdown<String>(
                                                      widgetKey: KEY_FIELD_AUTOFLOURESCENCE,
                                                      heading: AUTOFLOURANCE_TITLE,
                                                      headingKey: Key(KEY_HEADING_AUTOFLOURESCENCE),
                                                      hintText: TranslationKeys.select.translate(context),
                                                      onChanged: (val) {
                                                        _autofluorescenceImpression[index].value = val;
                                                      },
                                                      selectedItem: _autofluorescenceImpression[index].value,
                                                      items: autofluorescenceValues,
                                                    );
                                                  }),
                                              const SpaceWidget(
                                                height: 20,
                                              ),
                                              ValueListenableBuilder<String?>(
                                                  valueListenable: _provisionalDiagnosis[index],
                                                  builder: (context, _, __) {
                                                    return CustomDropdown<String>(
                                                      widgetKey: KEY_FIELD_PROVISIONAL_DIAGNOSIS,
                                                      heading: PROVISIONAL_DIAGNOSIS_TITLE,
                                                      headingKey: Key(KEY_HEADING_PROVISIONAL_DIAGNOSIS),
                                                      hintText: TranslationKeys.select.translate(context),
                                                      onChanged: (val) {
                                                        _provisionalDiagnosis[index].value = val;
                                                      },
                                                      selectedItem: _provisionalDiagnosis[index].value,
                                                      items: provisionalDiagnosisValues.values.map((e) => e).toList(),
                                                    );
                                                  }),
                                              const SpaceWidget(
                                                height: 20,
                                              ),
                                              ValueListenableBuilder<String?>(
                                                  valueListenable: _provisionalDiagnosis[index],
                                                  builder: (context, provisionalDiagnosis, __) {
                                                    if (provisionalDiagnosis == "Other") {
                                                      return CustomTextField(
                                                        controller: _otherControllers[index],
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
                                );
                              },
                            )
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
                        onPressed: () async {
                          await saveMeasurementLesionsData();
                          GoRouter.of(context).push(QuestionnaireScreen.routerPath, extra: "community_risk_assessment_baseline_signs_or_symptoms");
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  saveMeasurementLesionsData() async {
    if (_lesionsController.text.isNotEmpty) {
      staticQuestionnaires.add(StaticQuestionModel("number_of_lesion", _lesionsController.text, null, null, DateTime.now(), null, null));
    }
    for (int i = 0; i < _lengthControllers.length; i++) {
      if (_lengthControllers[i].text.isNotEmpty) {
        staticQuestionnaires.add(StaticQuestionModel(
            "${questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList[i]?.replaceAll(" ", "").replaceAll("_", "").toLowerCase() : questionnaireViewModel.attachmentList[i]!.fileName.questionText.replaceAll(" ", "").replaceAll("_", "").toLowerCase()}_length",
            _lengthControllers[i].text,
            null,
            null,
            DateTime.now(),
            null,
            null));
      }
    }
    for (int i = 0; i < _breadthControllers.length; i++) {
      staticQuestionnaires.add(StaticQuestionModel(
          "${questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList[i]?.replaceAll(" ", "").replaceAll("_", "").toLowerCase() : questionnaireViewModel.attachmentList[i]!.fileName.questionText.replaceAll(" ", "").replaceAll("_", "").toLowerCase()}_breadth",
          _breadthControllers[i].text,
          null,
          null,
          DateTime.now(),
          null,
          null));
    }
    for (int i = 0; i < _productControllers.length; i++) {
      staticQuestionnaires.add(StaticQuestionModel(
          "${questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList[i]?.replaceAll(" ", "").replaceAll("_", "").toLowerCase() : questionnaireViewModel.attachmentList[i]!.fileName.questionText.replaceAll(" ", "").replaceAll("_", "").toLowerCase()}_product",
          _productControllers[i].text,
          null,
          null,
          DateTime.now(),
          null,
          null));
    }
    for (int i = 0; i < _otherControllers.length; i++) {
      staticQuestionnaires.add(StaticQuestionModel(
          "${questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList[i]?.replaceAll(" ", "").replaceAll("_", "").toLowerCase() : questionnaireViewModel.attachmentList[i]!.fileName.questionText.replaceAll(" ", "").replaceAll("_", "").toLowerCase()}_other_clinical_impression",
          _otherControllers[i].text,
          null,
          null,
          DateTime.now(),
          null,
          null));
    }
    for (int i = 0; i < _fhpOpinions.length; i++) {
      staticQuestionnaires.add(StaticQuestionModel(
          "${questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList[i]?.replaceAll(" ", "").replaceAll("_", "").toLowerCase() : questionnaireViewModel.attachmentList[i]!.fileName.questionText.replaceAll(" ", "").replaceAll("_", "").toLowerCase()}_fhp_opinion_suspicious",
          _fhpOpinionValue[i].value.toString(),
          null,
          null,
          DateTime.now(),
          null,
          null));
    }
    for (int i = 0; i < _autofluorescenceImpression.length; i++) {
      staticQuestionnaires.add(StaticQuestionModel(
          "${questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList[i]?.replaceAll(" ", "").replaceAll("_", "").toLowerCase() : questionnaireViewModel.attachmentList[i]!.fileName.questionText.replaceAll(" ", "").replaceAll("_", "").toLowerCase()}_autoflorescence_impression",
          _autofluorescenceImpression[i].value,
          null,
          null,
          DateTime.now(),
          null,
          null));
    }
    for (int i = 0; i < _provisionalDiagnosis.length; i++) {
      staticQuestionnaires.add(StaticQuestionModel(
          "${questionnaireViewModel.selectedAttachmentList.isNotEmpty ? questionnaireViewModel.selectedAttachmentList[i]?.replaceAll(" ", "").replaceAll("_", "").toLowerCase() : questionnaireViewModel.attachmentList[i]!.fileName.questionText.replaceAll(" ", "").replaceAll("_", "").toLowerCase()}_provisional_diagnosis",
          _provisionalDiagnosis[i].value,
          null,
          null,
          DateTime.now(),
          null,
          null));
    }
    await questionnaireViewModel.setNextSectionData(sectionName: "community_risk_assessment_measurement_lesions", context: context, staticSectionsData: staticQuestionnaires);
  }
}
