import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/services/network_status_service.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/views/probe_screens/probe_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routerPath = "/";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late NetworkStatusService networkStatusService;

  Timer? _timer;
  int _start = 5;

  @override
  void initState() {
    super.initState();
    networkStatusService = Provider.of<NetworkStatusService>(context, listen: false);
    splashTimer();
  }

  void splashTimer() async {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          cancelTimer();
          redirectToNextScreen();
        } else {
          _start--;
        }
      },
    );
  }

  cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  redirectToNextScreen() async {
    final userDetails = await SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.SHARED_PREFERENCE_USER_DETAILS);
    if (userDetails == null) {
      if (context.mounted) {
        GoRouter.of(context).go(LoginEmailScreen.routerPath);
      }
    } else {
      String? locale = await SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.LANGUAGE_KEY);
      context.read<LanguageViewModel>().setAppLanguage(locale ?? "");
      context.read<LanguageViewModel>().setSelectedLanguage(selectedLanguage: locale ?? "");

      await LoginViewModel.loginViewModel.loginUser(userDetails);
    }
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AppAssetsPath.appLogo, height: MediaQuery.of(context).size.height / 6),
      ),
    );
  }
}
