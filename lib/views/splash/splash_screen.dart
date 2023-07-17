import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/utils/app_assets_path.dart';

class SplashScreen extends StatefulWidget {
  static const String routerPath = "/";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Timer? _timer;
  int _start = 5;

  @override
  void initState() {
    super.initState();
    splashTimer();
  }

  void splashTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec, (Timer timer) {
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

  redirectToNextScreen() {
    GoRouter.of(context).go(LoginHome.routerPath);
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssetsPath.appIcon),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(AppAssetsPath.icShield),
          )
        ],
      ),
    );
  }
}
