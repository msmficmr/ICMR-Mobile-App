import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/config/router/app_router.dart';
import 'package:mhealth/config/theme/app_theme.dart';
import 'package:mhealth/utils/app_values.dart';

class MHealthApp extends StatelessWidget {
  const MHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().goRouter,
      scaffoldMessengerKey: AppValues.scaffoldMessengerKey,
      title: Environment.runningEnv.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(context),
      darkTheme: AppTheme.light(context),
      themeMode: ThemeMode.light,
    );
  }
}