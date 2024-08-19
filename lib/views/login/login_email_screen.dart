import 'package:flutter/material.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/privacy_policy_widget.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class LoginEmailScreen extends StatefulWidget {
  static const String routerPath = "/login-email";

  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  late ValueNotifier<bool> _isValidEmail;
  late ValueNotifier<bool> _hasConsent;
  late ValueNotifier<bool> _buttonEnabled;
  late LoginViewModel loginViewModel;

  final TextEditingController _emailFieldController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // constant text
  final String EMAIL_FIELD_TITLE = "Enter your Email ID";
  final String EMAIL_FIELD_HINT_TEXT = "Email ID";

  //Widget Keys
  final String KEY_CHECKBOX_CONSENT = "key_checkbox_consent";
  final String KEY_TEXTFIELD_MOBILE = "key_textfield_mobile";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";
  final String KEY_TITLE_MOBILE = "key_title_mobile";
  final String KEY_LOGIN_TYPE = "key_login_type";

  @override
  void initState() {
    super.initState();
    _isValidEmail = ValueNotifier<bool>(false);
    _hasConsent = ValueNotifier<bool>(false);
    _buttonEnabled = ValueNotifier<bool>(false);
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    loginViewModel.resetLoginScreen();
  }

  void onEmailFieldChanged(String? input) {
    String? isEmailValid = AppValidators.validateEmail(input);
    _isValidEmail.value = isEmailValid == null;
    isButtonEnabled();
  }

  void onConsentChanged(bool? input) {
    _hasConsent.value = input ?? false;
    isButtonEnabled();
  }

  isButtonEnabled() {
    _buttonEnabled.value = (_isValidEmail.value && _hasConsent.value);
  }

  Future<void> onContinueClick() async {
    if (formKey.currentState?.validate() ?? false) {
      loginViewModel.isEmailLogin = true;
      loginViewModel.authFlow = LoginScreenTypes.EMAIL;
      await loginViewModel.sendOtp(mobileNumberOrEmailText: _emailFieldController.text,authType: AuthType.email);
    }
  }

  redirectToLoginMobileScreen() {
    loginViewModel.loginScreenType = LoginScreenTypes.MOBILE_NUMBER;
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
                      controller: _emailFieldController,
                      hasPrefix: true,
                      prefixType: TextFieldPrefixSuffixType.SVG_ASSET,
                      prefixData: AppAssetsPath.icEmail,
                      hintText: EMAIL_FIELD_HINT_TEXT,
                      heading: TranslationKeys.enterEmailId.translate(context),
                      headingKey: Key(KEY_TITLE_MOBILE),
                      onChanged: onEmailFieldChanged,
                      validator: AppValidators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
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
                  /// Need to enable, when login with mobile is required
                  /*LoginTextWidget(
                    widgetKey: KEY_LOGIN_TYPE,
                    loginType: loginViewModel.loginTypes[1],
                    onTap: redirectToLoginMobileScreen,
                  ),*/
                  const SpaceWidget(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Selector<LoginViewModel, bool>(
                      selector: (_, provider) => provider.isLoading,
                      builder: (context, isLoading, __) {
                        return ValueListenableBuilder<bool>(
                          valueListenable: _buttonEnabled,
                          builder: (context, isValid, _) {
                            return PrimaryFilledButton(
                              buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                              buttonTitle: AppConstant.CONTINUE_BUTTON_TITLE,
                              widgetKey: KEY_BUTTON_CONTINUE,
                              isLoading: isLoading,
                              onPressed: !isValid
                                  ? null
                                  : () {
                                      onContinueClick();
                                    },
                            );
                          },
                        );
                      }
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
