import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/helpers/mask_text_input_formatter.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
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

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextInputFormatter dobInputFormatter = MaskTextInputFormatter(mask: '##/##/####', type: MaskAutoCompletionType.eager);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _aadharIDController = TextEditingController();
  final TextEditingController _medicalIDIDController = TextEditingController();
  final TextEditingController _mobileFieldController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();

  //Widget Keys
  final String KEY_BUTTON_CONSENT = "key_button_consent";
  final String KEY_FIELD_FIRST_NAME = "key_textfield_firstName";
  final String KEY_FIELD_LAST_NAME = "key_textfield_lastName";
  final String KEY_FIELD_DOB = "key_textfield_dob";
  final String KEY_FIELD_AGE = "key_textfield_age";
  final String KEY_FIELD_AADHAR_ID = "key_textfield_aadhar_id";
  final String KEY_FIELD_MEDICAL_ID = "key_textfield_medical_id";
  final String KEY_FIELD_MOBILE = "key_textfield_mobile";
  final String KEY_FIELD_DISTRICT = "key_textfield_district";
  final String KEY_FIELD_STATE = "key_textfield_state";
  final String KEY_FIELD_PINCODE = "key_textfield_pincode";
  final String KEY_FIELD_STUDY_PH = "key_textfield_study_ph";
  final String KEY_FIELD_INCOME = "key_textfield_income";
  final String KEY_FIELD_OCCUPATION_TYPE = "key_textfield_occupation_type";
  final String KEY_FIELD_OCCUPATION_INDUSTRY_TYPE = "key_textfield_occupation_industry_type";
  final String KEY_HEADING_FIRST_NAME = "key_heading_firstName";
  final String KEY_HEADING_LAST_NAME = "key_heading_lastName";
  final String KEY_HEADING_GENDER = "key_heading_gender";
  final String KEY_HEADING_DOB = "key_heading_dob";
  final String KEY_HEADING_AGE = "key_heading_age";
  final String KEY_HEADING_AADHAR_ID = "key_heading_aadhar_id";
  final String KEY_HEADING_MEDICAL_ID = "key_heading_medicak_id";
  final String KEY_HEADING_MOBILE = "key_title_mobile";
  final String KEY_HEADING_DISTRICT = "key_title_district";
  final String KEY_HEADING_STATE = "key_title_state";
  final String KEY_HEADING_PINCODE = "key_title_pincode";
  final String KEY_HEADING_SIGNED_CONSENT = "key_title_signed_consent";
  final String KEY_HEADING_STUDY_PH = "key_title_study_ph";
  final String KEY_HEADING_DISCLOSED_INCOME = "key_title_disclosed_income";
  final String KEY_HEADING_INCOME = "key_title_income";
  final String KEY_HEADING_OCCUPATION_TYPE = "key_title_occupation_type";
  final String KEY_HEADING_OCCUPATION_INDUSTRY_TYPE = "key_title_occupation_industry_type";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  //Titles
  final String TITLE_STUDY_PH = "Study PH";

  final String MOB_FIELD_PREFIX_TEXT = "+91";

  final FocusNode _dobFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();

  late ValueNotifier<String?> _gender;
  late ValueNotifier<String?> _signedConsent;
  late ValueNotifier<String?> _disclosedIncome;
  late ValueNotifier<bool> _discloseIncome;
  late ValueNotifier<bool> _buttonEnabled;


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

  List<String> getOccupationIndustryTypes() {
    LanguageViewModel languageViewModel = Provider.of<LanguageViewModel>(context, listen: false);
    switch (languageViewModel.locale.toString()) {
      case "hi":
        return HI_OCCUPATION_INDUSTRY;
      case "en_US":
      default:
        return EN_OCCUPATION_INDUSTRY;
    }
  }
  static const List<String> EN_OCCUPATION_INDUSTRY = [
    "Rubber Industry",
    "Paint Industry",
    "Chemical Industry",
    "Radiation",
    "Explosives",
    "Construction & Cement",
    "Pesticide use for farming",
    "None",
    "Remove response",
  ];

  static const List<String> HI_OCCUPATION_INDUSTRY = [
    "रबर उद्योग",
    "पेंट उद्योग",
    "रासायनिक उद्योग",
    "विकिरण",
    "विस्फोटक",
    "निर्माण एवं सीमेंट",
    "खेती के लिए कीटनाशकों का उपयोग",
    "कोई नहीं",
    "प्रतिक्रिया हटाएँ",
  ];

  @override
  void initState() {
    super.initState();
    initializeField();
  }

  initializeField() {
    _gender = ValueNotifier<String?>(null);
    _signedConsent = ValueNotifier<String?>(null);
    _disclosedIncome = ValueNotifier<String?>(null);
    _discloseIncome = ValueNotifier<bool>(false);
    _buttonEnabled = ValueNotifier<bool>(false);
  }

  onDOBChanged(String? dob) {
    if (_dobFocusNode == FocusManager.instance.primaryFocus) {
      try {
        int age = CommonFunctions.getAge(dob) ?? 0;
      } catch (e) {}
    }
  }

  onAgeChanged(String? age) {
    _dobController.clear();

    if (_ageFocusNode == FocusManager.instance.primaryFocus) {
      _dobController.text = CommonFunctions.getDob(age);
      dobInputFormatter.formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: _dobController.text));
    }
  }

  void onContinueClick() {
    GoRouter.of(context).push(RegistrationSuccessFullScreen.routeName);
  }

  void onConsentClicked() {
    GoRouter.of(context).push(ConsentScreeningScreen.routerPath);
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
                child: PrimaryFilledIconButton(
                    onPressed: () {
                      onConsentClicked();
                    },
                    isLoading: false,
                    buttonThemeStyle: const FilledButtonThemeStyle(
                      enabledTextColor: Color(0xFF2F43EE),
                      enabledButtonColor: Color(0xFFF4F5FF),
                    ),
                    icon: SvgPicture.asset(AppAssetsPath.icInfo),
                    buttonTitle: TranslationKeys.consent.translate(context),
                    widgetKey: KEY_BUTTON_CONSENT),
              ),
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
                validator: AppValidators.requiredFiled,
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
                validator: AppValidators.requiredFiled,
                inputFormatters: [
                  AppValues.stringInputFormatter,
                ],
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
              //DOB
              CustomTextField(
                controller: _dobController,
                focusNode: _dobFocusNode,
                widgetKey: Key(KEY_FIELD_DOB),
                hintText: AppConstant.HINT_TEXT_DATE,
                heading: TranslationKeys.dateOfBirth.translate(context),
                headingKey: Key(KEY_HEADING_DOB),
                hasPrefix: true,
                prefixType: TextFieldPrefixSuffixType.SVG_ASSET,
                prefixData: AppAssetsPath.icCalender,
                inputFormatters: [
                  dobInputFormatter,
                ],
                validator: AppValidators.validateDOB,
                keyboardType: TextInputType.number,
                onChanged: onDOBChanged,
              ),
              const SpaceWidget(
                height: 15,
              ),
              CustomTextField(
                controller: _ageController,
                focusNode: _ageFocusNode,
                widgetKey: Key(KEY_FIELD_AGE),
                hintText: TranslationKeys.enterHere.translate(context),
                heading: "${TranslationKeys.age.translate(context)}*",
                headingKey: Key(KEY_HEADING_AGE),
                validator: AppValidators.validateAge,
                keyboardType: TextInputType.number,
                onChanged: onAgeChanged,
              ),
              const SpaceWidget(
                height: 15,
              ),
              //AADHAR
              CustomTextField(
                controller: _aadharIDController,
                widgetKey: Key(KEY_FIELD_AADHAR_ID),
                hintText: TranslationKeys.enterHere.translate(context),
                heading: TranslationKeys.aadharId.translate(context),
                headingKey: Key(KEY_HEADING_AADHAR_ID),
                validator: AppValidators.validateAadhar,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  MaskTextInputFormatter(mask: '############'),
                ],
              ),
              const SpaceWidget(
                height: 15,
              ),
              //MEDICAL ID
              CustomTextField(
                controller: _medicalIDIDController,
                widgetKey: Key(KEY_FIELD_MEDICAL_ID),
                hintText: TranslationKeys.enterHere.translate(context),
                heading: "${TranslationKeys.medicalId.translate(context)}*",
                headingKey: Key(KEY_HEADING_MEDICAL_ID),
                validator: AppValidators.validateID,
                keyboardType: TextInputType.text,
              ),
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
              //DISTRICT
              CustomTextField(
                controller: _districtController,
                widgetKey: Key(KEY_FIELD_DISTRICT),
                hintText: TranslationKeys.enterHere.translate(context),
                heading: "${TranslationKeys.district.translate(context)}*",
                headingKey: Key(KEY_HEADING_DISTRICT),
                validator: AppValidators.requiredFiled,
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
                heading: "${TranslationKeys.state.translate(context)}*",
                headingKey: Key(KEY_HEADING_STATE),
                validator: AppValidators.requiredFiled,
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
                heading: "${TranslationKeys.pincode.translate(context)}*",
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
              //SIGNED CONSENT
              ValueListenableBuilder(
                valueListenable: _signedConsent,
                builder: (context, _, __) {
                  return CustomChipWidget<String?>(
                    shouldTranslate: true,
                    chipList: AppConstant.BINARY_LIST,
                    onChanged: (value) {
                      _signedConsent.value = value;
                    },
                    validator: AppValidators.validateBinaryQuestion,
                    selectedItem: _signedConsent.value,
                    heading: TranslationKeys.wasACopyOfSignedConsent.translate(context),
                    headingKey: Key(KEY_HEADING_SIGNED_CONSENT),
                  );
                },
              ),
              const SpaceWidget(
                height: 15,
              ),
              //STUDY
              CustomDropdown<String>(
                widgetKey: KEY_FIELD_STUDY_PH,
                heading: TITLE_STUDY_PH,
                headingKey: Key(KEY_HEADING_STUDY_PH),
                hintText: TranslationKeys.select.translate(context),
                onChanged: (val) {},
                items: [],
              ),
              const SpaceWidget(
                height: 15,
              ),
              //DISCLOSED INCOME
              ValueListenableBuilder(
                valueListenable: _disclosedIncome,
                builder: (context, _, __) {
                  return CustomChipWidget<String?>(
                    shouldTranslate: true,
                    chipList: AppConstant.BINARY_LIST,
                    onChanged: (value) {
                      _disclosedIncome.value = value;
                      _discloseIncome.value = !_discloseIncome.value;
                    },
                    validator: AppValidators.validateBinaryQuestion,
                    selectedItem: _disclosedIncome.value,
                    heading: TranslationKeys.patientDisclosedIncome.translate(context),
                    headingKey: Key(KEY_HEADING_DISCLOSED_INCOME),
                  );
                },
              ),
              const SpaceWidget(
                height: 15,
              ),
              //INCOME
              ValueListenableBuilder<bool>(
                  valueListenable: _discloseIncome,
                  builder: (context, isValid, _) {
                    return isValid ? CustomTextField(
                      controller: _incomeController,
                      widgetKey: Key(KEY_FIELD_INCOME),
                      hintText: TranslationKeys.enterHere.translate(context),
                      heading: TranslationKeys.income.translate(context),
                      headingKey: Key(KEY_HEADING_INCOME),
                      validator: AppValidators.requiredFiled,
                      keyboardType: TextInputType.number,
                    ) : const SizedBox.shrink();
                  }),
              const SpaceWidget(
                height: 15,
              ),
              //OCCUPATION TYPE
              CustomDropdown<String>(
                widgetKey: KEY_FIELD_OCCUPATION_TYPE,
                heading: TranslationKeys.occupationType.translate(context),
                headingKey: Key(KEY_HEADING_OCCUPATION_TYPE),
                hintText: TranslationKeys.select.translate(context),
                onChanged: (val) {},
                items: getOccupationTypes(),
              ),
              const SpaceWidget(
                height: 15,
              ),
              //OCCUPATION INDUSTRY TYPE
              CustomDropdown<String>(
                widgetKey: KEY_FIELD_OCCUPATION_INDUSTRY_TYPE,
                heading: TranslationKeys.occupationIndustry.translate(context),
                headingKey: Key(KEY_HEADING_OCCUPATION_INDUSTRY_TYPE),
                hintText: TranslationKeys.select.translate(context),
                onChanged: (val) {},
                items: getOccupationIndustryTypes(),
              ),
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
    );
  }
}
