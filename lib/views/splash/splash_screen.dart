import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/services/network_status_service.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
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
    await networkStatusService.initConnectivity();
    if (networkStatusService.networkStatus == NetworkStatus.online) {
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
    } else {
      CommonFunctions.toastMessage("No internet connection");
    }
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
