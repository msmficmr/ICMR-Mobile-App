import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/isar_db_schema/attachment_db_schema.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/helpers/mask_text_input_formatter.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/viewModel/registration_view_model.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/primary_filled_icon_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routerPath = "/registration";

  // final AttachmentModel? selectedAttachment; // Add this line

  //RegistrationScreen({Key? key, this.selectedAttachment}) : super(key: key); // Add this line

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late AttachmentModel? _selectedAttachment;
  late QuestionnaireViewModel questionnaireViewModel;
  TextInputFormatter dobInputFormatter = MaskTextInputFormatter(mask: '##/##/####', type: MaskAutoCompletionType.eager);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> consentKey = GlobalKey<FormFieldState>();


  AttachmentModel? consent;

  late TextEditingController _dateOfVisitController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _tempAddressController = TextEditingController();
  final TextEditingController _permanentAddressController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _mobileFieldController = TextEditingController();
  final TextEditingController _alternateNumberFieldController = TextEditingController();
  final TextEditingController _medicalRecordNumberController = TextEditingController();
  final TextEditingController _aadharIDController = TextEditingController();
  late TextEditingController _consentDateController = TextEditingController();

  //Widget Keys
  final String KEY_BUTTON_CONSENT = "key_button_consent";
  final String KEY_FIELD_DATE_OF_VISIT = "key_textfield_date_of_visit";
  final String KEY_FIELD_INSTITUTION_CODE = "key_textfield_institution_code";
  final String KEY_FIELD_STUDY_PH = "key_textfield_study_ph";
  final String KEY_FIELD_FIRST_NAME = "key_textfield_firstName";
  final String KEY_FIELD_LAST_NAME = "key_textfield_lastName";
  final String KEY_FIELD_AGE = "key_textfield_age";
  final String KEY_FIELD_TEMP_ADDRESS = "key_textfield_temp_address";
  final String KEY_FIELD_PERMANENT_ADDRESS = "key_textfield_permanent_address";
  final String KEY_FIELD_DISTRICT = "key_textfield_district";
  final String KEY_FIELD_STATE = "key_textfield_state";
  final String KEY_FIELD_PINCODE = "key_textfield_pincode";
  final String KEY_FIELD_OCCUPATION_TYPE = "key_textfield_occupation_type";
  final String KEY_FIELD_MOBILE = "key_textfield_mobile";
  final String KEY_FIELD_ALTERNATE_NUMBER = "key_textfield_alternate_number";
  final String KEY_FIELD_MEDICAL_RECORD_NUMBER = "key_textfield_medical_record_number";
  final String KEY_FIELD_AADHAR_ID = "key_textfield_aadhar_id";
  final String KEY_FIELD_SIGNED_CONSENT = "key_textfield_signed_consent";
  final String KEY_FIELD_SIGNED_CONSENT_NO = "key_textfield_signed_consent_no";
  final String KEY_HEADING_FIRST_NAME = "key_heading_firstName";
  final String KEY_HEADING_DOV = "key_heading_date_of_visit";
  final String KEY_HEADING_INSTITUTION_CODE = "key_title_institutution_code";
  final String KEY_HEADING_STUDY_PH = "key_title_study_ph";
  final String KEY_HEADING_LAST_NAME = "key_heading_lastName";
  final String KEY_HEADING_GENDER = "key_heading_gender";
  final String KEY_HEADING_AGE = "key_heading_age";
  final String KEY_HEADING_TEMP_ADDRESS = "key_heading_temp_address";
  final String KEY_HEADING_PERMANENT_ADDRESS = "key_heading_permanent_address";
  final String KEY_HEADING_DISTRICT = "key_title_district";
  final String KEY_HEADING_STATE = "key_title_state";
  final String KEY_HEADING_PINCODE = "key_title_pincode";
  final String KEY_HEADING_OCCUPATION_TYPE = "key_title_occupation_type";
  final String KEY_HEADING_MOBILE = "key_title_mobile";
  final String KEY_HEADING_ALTERNATE_NUMBER = "key_title_alternate_number";
  final String KEY_HEADING_MEDICAL_RECORD_NUMBER = "key_heading_medical_record_number";
  final String KEY_HEADING_AADHAR_ID = "key_heading_aadhar_id";
  final String KEY_HEADING_SIGNED_CONSENT = "key_title_signed_consent";
  final String KEY_HEADING_SIGNED_CONSENT_NO = "key_title_signed_consent_no";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  //Titles
  final String DATE_OF_VISIT_TITLE = "Date Of Visit*";
  final String INSTITUTUION_TITLE = "Institution Code ID";
  final String TITLE_STUDY_CODE = "Study Code*";
  final String ADDRESS_TITLE = "Address";
  final String PERMANENT_ADDRESS_TITLE = "Permanent Address";
  final String ALTERNATE_PHONE_NUMBER_TITLE = "Alternate Phone number";
  final String AADHAR_NUMBER_TITLE = "Aadhar No/ Voter ID/ PAN No.";
  final String CONSENT_OBTAINED_DATE_TITLE = "Date on which informed consent obtained*";
  final String SIGNED_CONSENT_HANDED_TITLE = "Was a copy of the signed consent form handed over to the patient*";
  final String SECIFY_TITLE = "If no, specify why:";

  final String MOB_FIELD_PREFIX_TEXT = "+91";

  final FocusNode _dovFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();

  late ValueNotifier<String?> _institutionCode;
  late ValueNotifier<String?> _studyCode;
  late ValueNotifier<String?> _gender;
  late ValueNotifier<String?> _occupation;
  late ValueNotifier<String?> _signedConsent;
  late ValueNotifier<String?> _signConsent;
  late ValueNotifier<bool> _signedConsentCopy;
  late ValueNotifier<String?> _signedConsentNoReason;
  late ValueNotifier<bool> _buttonEnabled;
  late ValueNotifier<bool> _isConsentButtonActiveNotifier;

  late RegistrationViewModel registrationViewModel;


  //TODO: Only for the UI purpose the list has been hardcoded for now

  List<String> getOccupationTypes() {
    LanguageViewModel languageViewModel = Provider.of<LanguageViewModel>(context, listen: false);
    switch (languageViewModel.locale.toString()) {
      case "hi":
        return HI_OCCUPATION_TYPES;
      case "en_US":
      default:
        return EN_OCCUPATION_TYPES;
    }
  }

  static const List<String> EN_OCCUPATION_TYPES = [
    "Unemployed",
    "Student",
    "Self Employed(Shop owner, Vegetable, Fruit Service)",
    "Service",
    "Retired",
    "Manual Labour(Cycle rikshaw, Construction)",
    "Skilled Labour(Painter, Electrician, Plumber)",
    "Home maker",
    "Remove response",
  ];

  static const List<String> HI_OCCUPATION_TYPES = [
    "बेरोजगार",
    "विद्यार्थी",
    "स्व-रोज़गार (दुकान मालिक, सब्जी, फल सेवा)",
    "सेवा",
    "सेवानिवृत्त",
    "शारीरिक श्रम (साइकिल रिक्शा, निर्माण)",
    "कुशल श्रमिक (प्लंबर, इलेक्ट्रीशियन, पेंटर)",
    "गृह निर्माता",
    "प्रतिक्रिया हटाएँ",
  ];

  @override
  void initState() {
    super.initState();
    _isConsentButtonActiveNotifier = ValueNotifier<bool>(false);
    _buttonEnabled = ValueNotifier<bool>(true);
    _dateOfVisitController = TextEditingController(text: CommonFunctions.currentDate());
    _consentDateController = TextEditingController(text: CommonFunctions.currentDate());
    registrationViewModel = Provider.of<RegistrationViewModel>(context, listen: false);
    questionnaireViewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    initializeField();
  }

  initializeField() {
    _institutionCode = ValueNotifier<String?>(null);
    _studyCode = ValueNotifier<String?>(null);
    _gender = ValueNotifier<String?>(null);
    _occupation = ValueNotifier<String?>(null);
    _signedConsent = ValueNotifier<String?>(null);
    _signedConsentNoReason = ValueNotifier<String?>(null);
    _signConsent = ValueNotifier<String?>(null);
    _signedConsentCopy = ValueNotifier<bool>(false);
  }

  void onContinueClick() {
    if (formKey.currentState!.validate()) {
      AttachmentDb attachment = AttachmentDb()
        ..fileName = _selectedAttachment!.fileName
        ..dataBytes = _selectedAttachment!.baseImage;
      String patientId = CommonFunctions.randomNumber(6);
      questionnaireViewModel.savePatientId(patientId);
      IsarDbService.isarDbService.savePatient(PatientRegistration()
        ..visitDate = CommonFunctions.textToDateTime(_dateOfVisitController.text)
        ..institutionCodeID = _institutionCode.value ?? ""
        ..studyCode = _studyCode.value ?? ""
        ..firstName = _firstNameController.text
        ..lastName = _lastNameController.text
        ..age = _ageController.text
        ..gender = _gender.value
        ..address = _tempAddressController.text
        ..district = _districtController.text
        ..state = _stateController.text
        ..pincode = _pincodeController.text
        ..permanentAddress = _permanentAddressController.text
        ..occupation = _occupation.value ?? ""
        ..phoneNumber = _mobileFieldController.text
        ..alternatePhoneNumber = _alternateNumberFieldController.text
        ..medicalRecordNumber = _medicalRecordNumberController.text
        ..aadharId = _aadharIDController.text
        ..consentDate = CommonFunctions.textToDateTime(_consentDateController.text)
        ..signedConsent = _signedConsent.value ?? ""
        ..signedConsentNoReason = _signedConsentNoReason.value ?? ""
        ..consent = attachment
        ..patientId = patientId);

      GoRouter.of(context).push(RegistrationSuccessFullScreen.routerPath);
    }
  }

  void onConsentClicked() async {
    AttachmentModel? result = await GoRouter.of(context).push(ConsentScreeningScreen.routerPath);
    if (result != null) {
      _selectedAttachment = result;
      _isConsentButtonActiveNotifier.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.TEXT,
        titleText: TranslationKeys.registration.translate(context),
        centerTitle: false,
        onLeadingClick: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TranslationKeys.pleaseTakeConsentFromCitizen.translate(context),
                  style: AppStyles.bodyMedium,
                ),
                const SpaceWidget(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _isConsentButtonActiveNotifier,
                    builder: (context, isButtonActive, child) {
                      return PrimaryFilledIconButton(
                        onPressed: () {
                          onConsentClicked();
                        },
                        isLoading: false,
                        buttonThemeStyle: FilledButtonThemeStyle(
                          enabledTextColor: isButtonActive ? Color(0xFFF4F5FF) : Color(0xFF2F43EE),
                          enabledButtonColor: isButtonActive ? AppColorScheme.kGreen : Color(0xFFF4F5FF),
                        ),
                        icon: SvgPicture.asset(AppAssetsPath.icInfo),
                        buttonTitle: TranslationKeys.consent.translate(context),
                        widgetKey: KEY_BUTTON_CONSENT,
                      );
                    },
                  ),
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //DATE OF VISIT
                CustomTextField(
                  controller: _dateOfVisitController,
                  focusNode: _dovFocusNode,
                  widgetKey: Key(KEY_FIELD_DATE_OF_VISIT),
                  hintText: AppConstant.HINT_TEXT_DATE,
                  heading: DATE_OF_VISIT_TITLE,
                  headingKey: Key(KEY_HEADING_DOV),
                  hasPrefix: true,
                  prefixType: TextFieldPrefixSuffixType.SVG_ASSET,
                  prefixData: AppAssetsPath.icCalender,
                  inputFormatters: [
                    dobInputFormatter,
                  ],
                  validator: AppValidators.validateDate,
                  keyboardType: TextInputType.number,
                ),
                const SpaceWidget(
                  height: 15,
                ),
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
                        items: [],
                      );
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                //STUDY
                ValueListenableBuilder<String?>(
                    valueListenable: _studyCode,
                    builder: (context, _, __) {
                      return CustomDropdown<String>(
                        widgetKey: KEY_FIELD_STUDY_PH,
                        heading: TITLE_STUDY_CODE,
                        headingKey: Key(KEY_HEADING_STUDY_PH),
                        hintText: TranslationKeys.select.translate(context),
                        onChanged: (val) {
                          _studyCode.value = val;
                        },
                        selectedItem: _studyCode.value,
                        items: [],
                        // validator: AppValidators.requiredField,
                      );
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                //First Name Widget
                CustomTextField(
                  controller: _firstNameController,
                  widgetKey: Key(KEY_FIELD_FIRST_NAME),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: "${TranslationKeys.firstName.translate(context)}*",
                  headingKey: Key(KEY_HEADING_FIRST_NAME),
                  validator: AppValidators.requiredField,
                  inputFormatters: [
                    AppValues.stringInputFormatter,
                  ],
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //Last Name Widget
                CustomTextField(
                  controller: _lastNameController,
                  widgetKey: Key(KEY_FIELD_LAST_NAME),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: "${TranslationKeys.lastName.translate(context)}*",
                  headingKey: Key(KEY_HEADING_LAST_NAME),
                  validator: AppValidators.requiredField,
                  inputFormatters: [
                    AppValues.stringInputFormatter,
                  ],
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //AGE
                CustomTextField(
                  controller: _ageController,
                  focusNode: _ageFocusNode,
                  widgetKey: Key(KEY_FIELD_AGE),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: "${TranslationKeys.age.translate(context)}*",
                  headingKey: Key(KEY_HEADING_AGE),
                  validator: AppValidators.validateAge,
                  keyboardType: TextInputType.number,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //Gender
                ValueListenableBuilder(
                  valueListenable: _gender,
                  builder: (context, _, __) {
                    return CustomChipWidget<String?>(
                      shouldTranslate: true,
                      chipList: AppConstant.GENDER_LIST,
                      onChanged: (value) {
                        _gender.value = value;
                      },
                      validator: AppValidators.validateGender,
                      selectedItem: _gender.value,
                      heading: "${TranslationKeys.gender.translate(context)}*",
                      headingKey: Key(KEY_HEADING_GENDER),
                    );
                  },
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //ADDRESS
                CustomTextField(
                  controller: _tempAddressController,
                  widgetKey: Key(KEY_FIELD_TEMP_ADDRESS),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: ADDRESS_TITLE,
                  headingKey: Key(KEY_HEADING_TEMP_ADDRESS),
                  maxLines: 3,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //DISTRICT
                CustomTextField(
                  controller: _districtController,
                  widgetKey: Key(KEY_FIELD_DISTRICT),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.district.translate(context),
                  headingKey: Key(KEY_HEADING_DISTRICT),
                  keyboardType: TextInputType.text,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //STATE
                CustomTextField(
                  controller: _stateController,
                  widgetKey: Key(KEY_FIELD_STATE),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.state.translate(context),
                  headingKey: Key(KEY_HEADING_STATE),
                  keyboardType: TextInputType.text,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //PINCODE
                CustomTextField(
                  controller: _pincodeController,
                  widgetKey: Key(KEY_FIELD_PINCODE),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.pincode.translate(context),
                  headingKey: Key(KEY_HEADING_PINCODE),
                  validator: AppValidators.validatePincode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '######'),
                  ],
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //PERMANENT ADDRESS
                CustomTextField(
                  controller: _permanentAddressController,
                  widgetKey: Key(KEY_FIELD_PERMANENT_ADDRESS),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: PERMANENT_ADDRESS_TITLE,
                  headingKey: Key(KEY_HEADING_PERMANENT_ADDRESS),
                  maxLines: 3,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //OCCUPATION TYPE
                ValueListenableBuilder<String?>(
                    valueListenable: _occupation,
                    builder: (context, _, __) {
                      return CustomDropdown<String>(
                        widgetKey: KEY_FIELD_OCCUPATION_TYPE,
                        heading: TranslationKeys.occupationType.translate(context),
                        headingKey: Key(KEY_HEADING_OCCUPATION_TYPE),
                        hintText: TranslationKeys.select.translate(context),
                        onChanged: (val) {
                          _occupation.value = val;
                        },
                        selectedItem: _occupation.value,
                        items: getOccupationTypes(),
                        validator: AppValidators.requiredField,
                      );
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                //MOBILE
                CustomTextField(
                  widgetKey: Key(KEY_FIELD_MOBILE),
                  controller: _mobileFieldController,
                  hasPrefix: true,
                  prefixType: TextFieldPrefixSuffixType.TEXT,
                  prefixData: MOB_FIELD_PREFIX_TEXT,
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: "${TranslationKeys.mobileNumber.translate(context)}*",
                  headingKey: Key(KEY_HEADING_MOBILE),
                  validator: AppValidators.validateMobile,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '##########'),
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //ALTERNATE MOBILE NUMBER
                CustomTextField(
                  widgetKey: Key(KEY_FIELD_ALTERNATE_NUMBER),
                  controller: _alternateNumberFieldController,
                  hasPrefix: true,
                  prefixType: TextFieldPrefixSuffixType.TEXT,
                  prefixData: MOB_FIELD_PREFIX_TEXT,
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: ALTERNATE_PHONE_NUMBER_TITLE,
                  headingKey: Key(KEY_HEADING_ALTERNATE_NUMBER),
                  validator: AppValidators.validateAlternateNumber,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '##########'),
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //MEDICAL RECORD NUMBER
                CustomTextField(
                  controller: _medicalRecordNumberController,
                  widgetKey: Key(KEY_FIELD_MEDICAL_RECORD_NUMBER),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.medicalId.translate(context),
                  headingKey: Key(KEY_HEADING_MEDICAL_RECORD_NUMBER),
                  keyboardType: TextInputType.text,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //AADHAR
                CustomTextField(
                  controller: _aadharIDController,
                  widgetKey: Key(KEY_FIELD_AADHAR_ID),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: AADHAR_NUMBER_TITLE,
                  headingKey: Key(KEY_HEADING_AADHAR_ID),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '############'),
                  ],
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //DATE OF CONSENT OBTAINED
                CustomTextField(
                  controller: _consentDateController,
                  widgetKey: Key(KEY_FIELD_DATE_OF_VISIT),
                  heading: CONSENT_OBTAINED_DATE_TITLE,
                  headingKey: Key(KEY_HEADING_DOV),
                  hasPrefix: true,
                  prefixType: TextFieldPrefixSuffixType.SVG_ASSET,
                  prefixData: AppAssetsPath.icCalender,
                  inputFormatters: [
                    dobInputFormatter,
                  ],
                  validator: AppValidators.validateDate,
                  keyboardType: TextInputType.number,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //SIGNED CONSENT
                ValueListenableBuilder(
                  valueListenable: _signConsent,
                  builder: (context, _, __) {
                    return CustomChipWidget<String?>(
                      shouldTranslate: true,
                      chipList: AppConstant.BINARY_LIST,
                      onChanged: (value) {
                        _signConsent.value = value;
                        if (value == 'n') {
                          _signedConsentCopy.value = true;
                        } else {
                          _signedConsentCopy.value = false;
                        }
                      },
                      validator: AppValidators.validateBinaryQuestion,
                      selectedItem: _signConsent.value,
                      heading: SIGNED_CONSENT_HANDED_TITLE,
                      headingKey: Key(KEY_FIELD_SIGNED_CONSENT),
                    );
                  },
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //SIGNED CONSENT COPY REASON
                ValueListenableBuilder<bool>(
                    valueListenable: _signedConsentCopy,
                    builder: (context, isValid, _) {
                      return isValid
                          ? ValueListenableBuilder<String?>(
                              valueListenable: _signedConsentNoReason,
                              builder: (context, _, __) {
                                return CustomDropdown<String>(
                                  widgetKey: KEY_FIELD_SIGNED_CONSENT_NO,
                                  heading: SECIFY_TITLE,
                                  headingKey: Key(KEY_HEADING_SIGNED_CONSENT_NO),
                                  hintText: TranslationKeys.select.translate(context),
                                  onChanged: (val) {
                                    _signedConsentNoReason.value = val;
                                  },
                                  selectedItem: _signedConsentNoReason.value,
                                  items: [],
                                );
                              })
                          : const SizedBox.shrink();
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _buttonEnabled,
                    builder: (context, isValid, _) {
                      return PrimaryFilledButton(
                        buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                        buttonTitle: TranslationKeys.continueText.translate(context),
                        widgetKey: KEY_BUTTON_CONTINUE,
                        isLoading: false,
                        onPressed: !isValid
                            ? null
                            : () {
                          onContinueClick();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
