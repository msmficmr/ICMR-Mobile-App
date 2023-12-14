import 'package:flutter/material.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/helpers/mask_text_input_formatter.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/views/login/widgets/login_text_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/privacy_policy_widget.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class LoginMobileScreen extends StatefulWidget {
  static const String routerPath = "/login-mobile";

  const LoginMobileScreen({Key? key}) : super(key: key);

  @override
  State<LoginMobileScreen> createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState extends State<LoginMobileScreen> {
  late ValueNotifier<bool> _isValidMobile;
  late ValueNotifier<bool> _hasConsent;
  late ValueNotifier<bool> _buttonEnabled;
  late LoginViewModel loginViewModel;
  late LanguageViewModel languageViewModel;

  final TextEditingController _mobileFieldController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // constant text
  final String MOB_FIELD_TITLE = "Enter your mobile number";
  final String MOB_FIELD_HINT_TEXT = "Mobile number";
  final String MOB_FIELD_PREFIX_TEXT = "+91";

  //Widget Keys
  final String KEY_CHECKBOX_CONSENT = "key_checkbox_consent";
  final String KEY_TEXTFIELD_MOBILE = "key_textfield_mobile";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";
  final String KEY_TITLE_MOBILE = "key_title_mobile";
  final String KEY_LOGIN_TYPE = "key_login_type";

  @override
  void initState() {
    super.initState();
    _isValidMobile = ValueNotifier<bool>(false);
    _hasConsent = ValueNotifier<bool>(false);
    _buttonEnabled = ValueNotifier<bool>(false);
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    languageViewModel = Provider.of<LanguageViewModel>(context, listen: false);
  }

  void onMobileFieldChanged(String? input) {
    String? isMobileNoValid = AppValidators.validateMobile(input);
    _isValidMobile.value = isMobileNoValid == null;
    if (_isValidMobile.value) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    isButtonEnabled();
  }

  void onConsentChanged(bool? input) {
    _hasConsent.value = input ?? false;
    isButtonEnabled();
  }

  isButtonEnabled() {
    _buttonEnabled.value = (_isValidMobile.value && _hasConsent.value);
  }

  Future<void> onContinueClick() async {
    if (formKey.currentState?.validate() ?? false) {
      loginViewModel.authFlow = LoginScreenTypes.MOBILE_NUMBER;
      await loginViewModel.sendOtp(mobileNumberOrEmailText: _mobileFieldController.text);
    }
  }

  redirectToLoginEmailScreen() {
    loginViewModel.loginScreenType = LoginScreenTypes.EMAIL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.HORIZONTAL_APP_ICON,
        hasLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      widgetKey: Key(KEY_TEXTFIELD_MOBILE),
                      controller: _mobileFieldController,
                      hasPrefix: true,
                      prefixType: TextFieldPrefixSuffixType.TEXT,
                      prefixData: MOB_FIELD_PREFIX_TEXT,
                      hintText: MOB_FIELD_HINT_TEXT,
                      heading: TranslationKeys.enterMobileNumber.translate(context),
                      headingKey: Key(KEY_TITLE_MOBILE),
                      onChanged: onMobileFieldChanged,
                      validator: AppValidators.validateMobile,
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '##########'),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    const SpaceWidget(
                      height: 20,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _hasConsent,
                      builder: (context, _, __) {
                        return PrivacyPolicyWidget(
                          checkboxStatus: _hasConsent.value,
                          widgetKey: KEY_CHECKBOX_CONSENT,
                          onChanged: onConsentChanged,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  LoginTextWidget(widgetKey: KEY_LOGIN_TYPE, loginType: loginViewModel.loginTypes[0], onTap: redirectToLoginEmailScreen,),
                  const SpaceWidget(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _buttonEnabled,
                      builder: (context, isValid, _) {
                        return PrimaryFilledButton(
                          buttonThemeStyle: const FilledButtonThemeStyle(
                            disabledTextColor: Colors.white
                          ),
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
          ],
        ),
      ),
    );
  }
}