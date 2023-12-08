import 'package:flutter/material.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/views/login/login_otp_screen.dart';
import 'package:provider/provider.dart';

class LoginHome extends StatefulWidget {
  static const String routerPath = "/login-home";

  const LoginHome({Key? key}) : super(key: key);

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  late LoginViewModel loginViewModel;

  @override
  void initState() {
    super.initState();
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    loginViewModel.resetProvider();
  }

  @override
  void dispose() {
    loginViewModel.resetProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Selector<LoginViewModel, LoginScreenTypes>(
        selector: (_, provider) => provider.loginScreenType,
        builder: (context, LoginScreenTypes value, child) {
          switch (value) {
            case LoginScreenTypes.OTP_SCREEN:
              return const LoginOtpScreen();
            case LoginScreenTypes.EMAIL:
              default:
              return const LoginEmailScreen();
            /*case LoginScreenTypes.MOBILE_NUMBER:
            default:
              return const LoginMobileScreen();*/
          }
        },
      ),
    );
  }
}
