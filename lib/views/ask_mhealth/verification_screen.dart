import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/model/static_questionnaire_model.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/helpers/mask_text_input_formatter.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/section_name_widget.dart';
import 'package:mhealth/views/ask_mhealth/widgets/verification_checkbox_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/custom_signature_widget.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  static const routerPath = "/verificationScreen";

  bool? redirectFromCRA;

  VerificationScreen({Key? key, required this.redirectFromCRA}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late ValueNotifier<String?> _institutionCode;
  late ValueNotifier<String?> _visitType;
  late ValueNotifier<bool> _hasConsent;
  late ValueNotifier<Uint8List?> _patientConsent;
  late ValueNotifier<bool> _buttonEnabled;
  late ValueNotifier<bool> _errorText;
  late QuestionnaireViewModel questionnaireViewModel;

  static const String pageTemplate = "community_risk_assessment_verification_form";

  List<StaticQuestionModel> staticQuestionnaires = [];
  List<String> institutionCodes = [];

  TextInputFormatter dobInputFormatter = MaskTextInputFormatter(mask: '##/##/####', type: MaskAutoCompletionType.eager);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _participantController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();

  //Widget Keys
  final String KEY_FIELD_INSTITUTION_CODE = "key_textfield_institution_code";
  final String KEY_FIELD_PARTICIPANT_ID = "key_textfield_participant_id";
  final String KEY_FIELD_VISIT_TYPE = "key_textfield_visit_type";
  final String KEY_FIELD_FROM_DATE = "key_textfield_from_date";
  final String KEY_HEADING_INSTITUTION_CODE = "key_title_institutution_code";
  final String KEY_HEADING_PARTICIPANT_ID = "key_title_participant_id";
  final String KEY_HEADING_VISIT_TYPE = "key_title_visit_type";
  final String KEY_HEADING_FROM_DATE = "key_title_from_date";
  final String KEY_CHECKBOX_CONSENT = "key_checkbox_consent";
  final String KEY_BUTTON_ADD_INVESTIGATORS = "key_button_add_investigators";
  final String KEY_BUTTON_CONSENT = "key_button_consent";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  //Titles
  final String INSTITUTUION_TITLE = "Institution Code";
  final String PARTICIPANT_TITLE = "Participant ID";
  final String VISIT_TYPE_TITLE = "Visit Type";
  final String FORM_DATE_TITLE = "Form Date";
  final String CONSENT_TEXT = 'I have reviewed all the Case Report Forms for the above participant and agree that they are accurate and complete.';
  final String ADD_INVESTIGATORS_TITLE = "Add Investigator's signature";
  final String ERROR_CONSENT = "Please sign consent";

  @override
  void initState() {
    super.initState();
    initializeField();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getInstitutionCodes();
  }

  initializeField() {
    questionnaireViewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    _participantController = TextEditingController(text: questionnaireViewModel.patientId ?? questionnaireViewModel.selectedPatientId);
    _institutionCode = ValueNotifier<String?>(null);
    _visitType = ValueNotifier<String?>(null);
    _hasConsent = ValueNotifier<bool>(false);
    _errorText = ValueNotifier<bool>(false);
    _patientConsent = ValueNotifier<Uint8List?>(null);
    _buttonEnabled = ValueNotifier<bool>(true);
  }

  void onConsentChanged(bool? input) {
    _errorText.value = false;
    _hasConsent.value = input ?? false;
  }

  Future<void> getSignature() async {
    _patientConsent.value = await Navigator.push(context, MaterialPageRoute(builder: (_) => const SignatureScreen()));
  }

  getInstitutionCodes() {
    String institutionData = TranslationKeys.institutionCodes.translate(context);
    institutionCodes = CommonFunctions.convertStringToListOfNames(institutionData);
  }

  final Map<String, String> visitTypes = {
    "1": "1st Visit",
    "2": "2nd Visit",
    "3": "3rd Visit",
    "4": "4th Visit",
    "5": "5th Visit",
    "6": "6th Visit",
    "7": "7th Visit",
    "8": "8th Visit",
    "9": "9th Visit",
    "10": "10th Visit",
    "11": "11th Visit",
    "12": "12th Visit",
    "13": "13th Visit",
    "14": "14th Visit",
    "15": "15th Visit",
    "16": "16th Visit",
    "17": "17th Visit",
    "18": "18th Visit",
    "19": "19th Visit",
    "20": "20th Visit"
  };

  redirectToQuestionnaire() async {
    if (widget.redirectFromCRA ?? false) {
      await context.read<QuestionnaireViewModel>().resetAll();
      GoRouter.of(context).pop();
    } else {
      GoRouter.of(context).push(QuestionnaireScreen.routerPath, extra: "community_risk_assessment_baseline_signs_or_symptoms");
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionNameWidget(sectionName: "Verification Form"),
                        //INSTITUTION CODE
                        ValueListenableBuilder<String?>(
                          valueListenable: _institutionCode,
                          builder: (context, _, __) {
                            return CustomDropdown<String>(
                              widgetKey: KEY_FIELD_INSTITUTION_CODE,
                              heading: INSTITUTUION_TITLE,
                              headingKey: Key(KEY_HEADING_INSTITUTION_CODE),
                              hintText: TranslationKeys.select.translate(context),
                              onChanged: (val) {
                                _institutionCode.value = val;
                              },
                              selectedItem: _institutionCode.value,
                              items: institutionCodes,
                            );
                          },
                        ),
                        const SpaceWidget(
                          height: 15,
                        ),
                        //PARTICIPANT ID
                        CustomTextField(
                          enabled: false,
                          controller: _participantController,
                          widgetKey: Key(KEY_FIELD_PARTICIPANT_ID),
                          hintText: TranslationKeys.enterHere.translate(context),
                          heading: PARTICIPANT_TITLE,
                          headingKey: Key(KEY_HEADING_PARTICIPANT_ID),
                          inputFormatters: [
                            AppValues.stringInputFormatter,
                          ],
                        ),
                        const SpaceWidget(
                          height: 15,
                        ),
                        //VISIT TYPE
                        ValueListenableBuilder<String?>(
                          valueListenable: _visitType,
                          builder: (context, _, __) {
                            return CustomDropdown<String>(
                              widgetKey: KEY_FIELD_VISIT_TYPE,
                              heading: VISIT_TYPE_TITLE,
                              headingKey: Key(KEY_HEADING_VISIT_TYPE),
                              hintText: TranslationKeys.select.translate(context),
                              onChanged: (val) {
                                _visitType.value = val;
                              },
                              selectedItem: _visitType.value,
                              items: visitTypes.values.map((e) => e).toList(),
                            );
                          },
                        ),
                        const SpaceWidget(
                          height: 15,
                        ),
                        //FROM DATE
                        CustomTextField(
                          controller: _fromDateController,
                          widgetKey: Key(KEY_FIELD_FROM_DATE),
                          hintText: AppConstant.HINT_TEXT_DATE,
                          heading: FORM_DATE_TITLE,
                          headingKey: Key(KEY_HEADING_FROM_DATE),
                          hasPrefix: true,
                          prefixType: TextFieldPrefixSuffixType.SVG_ASSET,
                          prefixData: AppAssetsPath.icCalender,
                          inputFormatters: [
                            dobInputFormatter,
                          ],
                          keyboardType: TextInputType.number,
                          validator: AppValidators.validateCalenderDate,
                        ),
                        const SpaceWidget(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                          valueListenable: _hasConsent,
                          builder: (context, _, __) {
                            return ValueListenableBuilder(
                              valueListenable: _errorText,
                              builder: (context, _, __) {
                                return QuestionnaireCheckBox(
                                  onChanged: onConsentChanged,
                                  checkboxStatus: _hasConsent.value,
                                  widgetKey: KEY_CHECKBOX_CONSENT,
                                  text: CONSENT_TEXT,
                                  errorText: _errorText.value,
                                );
                              },
                            );
                          },
                        ),
                        const SpaceWidget(
                          height: 15,
                        ),
                        ValueListenableBuilder<Uint8List?>(
                          valueListenable: _patientConsent,
                          builder: (context, _, __) {
                            return CustomSignatureWidget(
                              onButtonClick: getSignature,
                              signatureData: _patientConsent.value,
                              buttonText: ADD_INVESTIGATORS_TITLE,
                              buttonKey: KEY_BUTTON_CONSENT,
                              errorText: ERROR_CONSENT,
                              onRemoveClick: () {
                                _patientConsent.value = null;
                              },
                            );
                          },
                        ),
                        const SpaceWidget(
                          height: 80,
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
                          buttonTitle: TranslationKeys.submit.translate(context),
                          widgetKey: KEY_BUTTON_CONTINUE,
                          isLoading: false,
                          onPressed: () async {
                            if (_hasConsent.value == false) {
                              _errorText.value = true;
                              CommonFunctions.toastMessage(AppConstant.FIELD_REQUIRED);
                            } else {
                              saveVerificationData();
                              await questionnaireViewModel.setNextSectionData(sectionName: "community_risk_assessment_verification_form",context: context, staticSectionsData: []);
                              await questionnaireViewModel.removeAllAttachment();
                              GoRouter.of(context).push(DashboardScreen.routerPath);
                            }
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
      ),
    );
  }

  saveVerificationData() {
    if (_institutionCode.value != null) {
      staticQuestionnaires.add(StaticQuestionModel("institution_code", _institutionCode.value,  null, null, DateTime.now(), null, null));
    }
    if (_participantController.text.isNotEmpty) {
      staticQuestionnaires.add(StaticQuestionModel("participant_id", _participantController.text,  null, null, DateTime.now(), null, null));
    }
    if (_visitType.value != null) {
      staticQuestionnaires.add(StaticQuestionModel("visit_type", _visitType.value,  null, null, DateTime.now(), null, null));
    }
    if (_fromDateController.text.isNotEmpty) {
      staticQuestionnaires.add(StaticQuestionModel("from_date", _fromDateController.text,  null, null, DateTime.now(), null, null));
    }
    if (_patientConsent.value != null) {
      staticQuestionnaires.add(StaticQuestionModel("patient_signature", base64Encode(_patientConsent.value!),  null, null, DateTime.now(), null, null));
    }
    final questionnaireViewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    questionnaireViewModel.setNextSectionData(sectionName: pageTemplate,context: context, staticSectionsData: staticQuestionnaires);
  }
}
