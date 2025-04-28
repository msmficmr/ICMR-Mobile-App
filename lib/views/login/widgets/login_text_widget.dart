import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';

class LoginTextWidget extends StatelessWidget {
  /// [widgetKey] is assigned to [LoginTextWidget] so that it can used for automation
  final String widgetKey;

  /// if you want show to which login-type to redirect, then pass [loginType] as a parameter
  final String loginType;

  /// pass the callback function to perform action when clicked on [loginType]
  final void Function()? onTap;

  const LoginTextWidget({
    Key? key,
    required this.loginType,
    required this.widgetKey,
    required this.onTap,
  }) : super(key: key);

  final String LOGIN_1 = "Login with your ";
  final String LOGIN_2 = " account ";

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: Key(widgetKey),
      text: TextSpan(
        style: AppStyles.bodyMedium.copyWith(height: 1.5, fontFamily: AppConstant.FONT_FAMILY),
        children: [
          TextSpan(text: LOGIN_1),
          WidgetSpan(
            child: InkWell(
              onTap: onTap,
              child: Text(
                loginType,
                style: AppStyles.bodyMedium.copyWith(height: 1.5, color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
              ),
            ),
          ),
          if (loginType == AppConstant.EMAIL)
            TextSpan(text: LOGIN_2)
        ],
      ),
    );
  }
}
