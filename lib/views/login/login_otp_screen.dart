import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/widgets/countdown_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_pin_field.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({Key? key}) : super(key: key);

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  final String PAGE_TITLE = "Enter the 6-digit OTP sent to";
  final String SEC_TEXT = " Sec";
  final String RESEND_TEXT = "Resend In ";

  //Widget Keys
  final String KEY_LEADING = "key_leading";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";
  final String KEY_BUTTON_RESEND = "key_button_resend";
  final String KEY_TEXTFIELD_PIN = "key_textfield_pin";

  late LoginViewModel loginViewModel;
  final TextEditingController _pinFieldController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late ValueNotifier<int> _countDown;
  late ValueNotifier<bool> _showResendButton, _isContinueButtonEnabled;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    _countDown = ValueNotifier<int>(AppValues.kOtpTimer);
    _showResendButton = ValueNotifier<bool>(false);
    _isContinueButtonEnabled = ValueNotifier<bool>(false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _startResendTimer();
    });
  }

  Future<bool> onBackPress() async {
    _cancelTimer();
    if (loginViewModel.authFlow == LoginScreenTypes.MOBILE_NUMBER) {
      loginViewModel.loginScreenType = LoginScreenTypes.MOBILE_NUMBER;
    } else {
      loginViewModel.loginScreenType = LoginScreenTypes.EMAIL;
    }
    return false;
  }

  /// Implemented functionality resend otp to user mobile
  // after sending otp we will disable functionality of [onResendClick] for 30 sec.
  onResendClick() async {
    bool isOtpSent = await loginViewModel.sendOtp(mobileNumberOrEmailText: loginViewModel.mobileNoOrEmailText, authType: loginViewModel.isEmailLogin ? AuthType.email : AuthType.mobile);
    if (isOtpSent) {
      _startResendTimer();
    }
  }

  /// implemented functionality to validate otp
  onContinueClick() async {
    if (_formKey.currentState?.validate() ?? false) {
      await loginViewModel.validateOtp(otp: _pinFieldController.text);
    }
  }

  /// Function will call after entering digits in every textbox of OTP Field
  onPinFieldChange(String? value) {
    _isContinueButtonEnabled.value = (value?.length ?? 0) == 6;
  }

  /// implemented functionality to show countdown on
  /// we will decrease the value of [AppValues.kOtpTimer] after every 1 sec
  /// if countdown values reach to 0 we will enable resend button and hide count down text.
  void _startResendTimer() {
    _cancelTimer();
    _showResendButton.value = false;
    _countDown.value = AppValues.kOtpTimer;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countDown.value--;
      if (_countDown.value <= 0) {
        _cancelTimer();
        _showResendButton.value = true;
      }
    });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hasLeading: true,
        onLeadingClick: onBackPress,
        appBarTitleType: CustomAppBarTitleType.HORIZONTAL_APP_ICON,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Text(
                              TranslationKeys.enterOTP.translate(context),
                              style: AppStyles.titleMedium,
                            ),
                          ),
                          WidgetSpan(
                            child: Text(
                              loginViewModel.mobileNoOrEmailText,
                              style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SpaceWidget(
                      height: 20,
                    ),
                    CustomPinField(
                      controller: _pinFieldController,
                      widgetKey: Key(KEY_TEXTFIELD_PIN),
                      validator: AppValidators.validateOTP,
                      onChanged: onPinFieldChange,
                    ),
                    const SpaceWidget(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                TranslationKeys.resendOTPHeading.translate(context),
                                style: AppStyles.titleSmall.copyWith(fontFamily: AppConstant.FONT_FAMILY),
                              ),
                            ),
                            Selector<LoginViewModel, bool>(
                              selector: (_, provider) => provider.isLoading,
                              builder: (context, isLoading, __) {
                                return ValueListenableBuilder(
                                  valueListenable: _showResendButton,
                                  builder: (context, isVisible, __) {
                                    return !isVisible
                                        ? const SizedBox.shrink()
                                        : isLoading
                                            ? const SizedBox(
                                                height: 24,
                                                width: 24,
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 3.0,
                                                  ),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: onResendClick,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    TranslationKeys.resendOTPTitle.translate(context),
                                                    style: AppStyles.titleSmall.copyWith(color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ValueListenableBuilder(
                            valueListenable: _countDown,
                            builder: (context, count, __) {
                              TextStyle? textStyle = AppStyles.titleSmall.copyWith(color: AppColorScheme.kGrayColor.shade700, fontWeight: FontWeight.w500);

                              return count == 0
                                  ? const SizedBox.shrink()
                                  : RichText(
                                      text: TextSpan(
                                        style: textStyle,
                                        children: [
                                          WidgetSpan(
                                            child: Text(
                                              RESEND_TEXT,
                                              style: textStyle,
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: CountdownWidget(
                                              buttonTitle: " ${count.toString()} ",
                                              textStyle: AppStyles.titleSmall.copyWith(color: AppColorScheme.kGrayColor, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: Text(
                                              SEC_TEXT,
                                              style: textStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Selector<LoginViewModel, bool>(
                selector: (_, provider) => provider.isLoading,
                builder: (context, isLoading, __) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: _isContinueButtonEnabled,
                    builder: (context, isEnabled, _) {
                      return PrimaryFilledButton(
                        buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                        buttonTitle: AppConstant.CONTINUE_BUTTON_TITLE,
                        widgetKey: KEY_BUTTON_CONTINUE,
                        onPressed: !isEnabled ? null : onContinueClick,
                         isLoading: isLoading,
                      );
                    },
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
