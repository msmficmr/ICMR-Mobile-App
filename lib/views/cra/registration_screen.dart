import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/helpers/mask_text_input_formatter.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routerPath = "/registration";

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextInputFormatter dobInputFormatter = MaskTextInputFormatter(mask: '##/##/####', type: MaskAutoCompletionType.eager);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileFieldController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  //Widget Keys
  final String KEY_BUTTON_CONSENT = "key_button_consent";
  final String KEY_FIELD_FIRST_NAME = "key_textfield_firstName";
  final String KEY_FIELD_MIDDLE_NAME = "key_textfield_middleName";
  final String KEY_FIELD_LAST_NAME = "key_textfield_lastName";
  final String KEY_FIELD_DOB = "key_textfield_dob";
  final String KEY_TEXTFIELD_MOBILE = "key_textfield_mobile";
  final String KEY_TEXTFIELD_PINCODE = "key_textfield_pincode";
  final String KEY_HEADING_FIRST_NAME = "key_heading_firstName";
  final String KEY_HEADING_MIDDLE_NAME = "key_heading_middleName";
  final String KEY_HEADING_LAST_NAME = "key_heading_lastName";
  final String KEY_HEADING_GENDER = "key_heading_gender";
  final String KEY_HEADING_DOB = "key_heading_dob";
  final String KEY_HEADING_MOBILE = "key_title_mobile";
  final String KEY_HEADING_PINCODE = "key_title_pincode";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  //Titles
  final String TITLE_FIRST_NAME = "First Name*";
  final String TITLE_MIDDLE_NAME = "Middle Name";
  final String TITLE_LAST_NAME = "Last Name*";
  final String TITLE_GENDER = "Gender*";
  final String TITLE_DOB = "DOB*";
  final String TITLE_MOBILE = "Mobile number*";
  final String TITLE_PINCODE = "Pincode*";

  //Hint Texts
  final String HINT_TEXT_FIRST_NAME = "First Name here";
  final String HINT_TEXT_MIDDLE_NAME = "Middle Name here";
  final String HINT_TEXT_LAST_NAME = "Last Name here";
  final String HINT_TEXT_DATE = "DD/MM/YYYY";
  final String HINT_TEXT_MOBILE = "Phone number";
  final String HINT_TEXT_PINCODE = "Pincode here";

  final String MOB_FIELD_PREFIX_TEXT = "+91";

  final FocusNode _dobFocusNode = FocusNode();

  late ValueNotifier<String?> _gender;
  late ValueNotifier<bool> _buttonEnabled;

  @override
  void initState() {
    super.initState();
    initializeField();
  }

  initializeField() {
    _gender = ValueNotifier<String?>(null);
    _buttonEnabled = ValueNotifier<bool>(false);
  }

  onDOBChanged(String? dob) {
    if (_dobFocusNode == FocusManager.instance.primaryFocus) {
      try {
        int age = CommonFunctions.getAge(dob) ?? 0;
      } catch (e) {}
    }
  }

  void onMobileFieldChanged(String? input) {}

  void onContinueClick() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.TEXT,
        titleText: 'Registration',
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tack consent from patient",
                style: AppStyles.bodyMedium,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: PrimaryFilledButton(
                  buttonThemeStyle: const FilledButtonThemeStyle(enabledButtonColor: Color(0xFFF4F5FF)),
                  onPressed: () {},
                  buttonTitle: 'Consent',
                  widgetKey: KEY_BUTTON_CONSENT,
                ),
              ),
              const SpaceWidget(
                height: 15,
              ),
              //First Name Widget
              CustomTextField(
                controller: _firstNameController,
                widgetKey: Key(KEY_FIELD_FIRST_NAME),
                hintText: HINT_TEXT_FIRST_NAME,
                heading: TITLE_FIRST_NAME,
                headingKey: Key(KEY_HEADING_FIRST_NAME),
                validator: AppValidators.requiredFiled,
                inputFormatters: [
                  AppValues.stringInputFormatter,
                ],
              ),
              const SpaceWidget(
                height: 15,
              ),
              //Middle Name Widget
              CustomTextField(
                controller: _middleNameController,
                widgetKey: Key(KEY_FIELD_MIDDLE_NAME),
                hintText: HINT_TEXT_FIRST_NAME,
                heading: TITLE_MIDDLE_NAME,
                headingKey: Key(KEY_HEADING_MIDDLE_NAME),
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
                hintText: HINT_TEXT_LAST_NAME,
                heading: TITLE_LAST_NAME,
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
                    chipList: AppConstant.GENDER_LIST,
                    onChanged: (value) {
                      _gender.value = value;
                    },
                    validator: AppValidators.validateGender,
                    selectedItem: _gender.value,
                    heading: TITLE_GENDER,
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
                hintText: HINT_TEXT_DATE,
                heading: TITLE_DOB,
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
              //MOBILE
              CustomTextField(
                widgetKey: Key(KEY_TEXTFIELD_MOBILE),
                controller: _mobileFieldController,
                hasPrefix: true,
                prefixType: TextFieldPrefixSuffixType.TEXT,
                prefixData: MOB_FIELD_PREFIX_TEXT,
                hintText: HINT_TEXT_MOBILE,
                heading: TITLE_MOBILE,
                headingKey: Key(KEY_HEADING_MOBILE),
                onChanged: onMobileFieldChanged,
                validator: AppValidators.validateMobile,
                inputFormatters: [
                  MaskTextInputFormatter(mask: '##########'),
                ],
                keyboardType: TextInputType.number,
              ),
              const SpaceWidget(
                height: 15,
              ),
              //PINCODE
              CustomTextField(
                controller: _pincodeController,
                widgetKey: Key(KEY_TEXTFIELD_PINCODE),
                hintText: HINT_TEXT_PINCODE,
                heading: TITLE_PINCODE,
                headingKey: Key(KEY_HEADING_PINCODE),
                validator: AppValidators.requiredFiled,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  AppValues.numberInputFormatter,
                ],
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
                      buttonTitle: AppConstant.CONTINUE_BUTTON_TITLE,
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
