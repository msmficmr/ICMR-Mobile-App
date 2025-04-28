import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/config/router/app_router.dart';
import 'package:mhealth/config/theme/app_theme.dart';
import 'package:mhealth/viewModel/patient_list_view_model.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/services/network_status_service.dart';
import 'package:mhealth/utils/app_localization.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/viewModel/offline_data_view_model.dart';
import 'package:mhealth/viewModel/registration_view_model.dart';
import 'package:probeintegration/services/probe_provider.dart';
import 'package:provider/provider.dart';

class MHealthApp extends StatelessWidget {
  const MHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          lazy: false,
          create: (BuildContext createContext) => LoginViewModel.loginViewModel,
        ),
        ChangeNotifierProvider<NetworkStatusService>(
          lazy: false,
          create: (BuildContext createContext) => NetworkStatusService(),
        ),
        ChangeNotifierProvider<ProbeProvider>(
          lazy: false,
          create: (BuildContext createContext) => ProbeProvider(),
        ),
        ChangeNotifierProvider<LanguageViewModel>(
          lazy: false,
          create: (BuildContext createContext) => LanguageViewModel.languageViewModel,
        ),
        ChangeNotifierProvider<RegistrationViewModel>(
          lazy: false,
          create: (BuildContext createContext) => RegistrationViewModel(),
        ),
        ChangeNotifierProvider<PatientListViewModel>(
          lazy: false,
          create: (BuildContext createContext) => PatientListViewModel(),
        ),
         ChangeNotifierProvider<OfflineDataViewModel>(
          lazy: false,
          create: (BuildContext createContext) => OfflineDataViewModel(),
        ),
        Provider<AppRouter>(
          lazy: false,
          create: (BuildContext createContext) {
            LoginViewModel loginModel = Provider.of<LoginViewModel>(createContext, listen: false);
            return AppRouter(loginModel);
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final router = Provider.of<AppRouter>(context, listen: false).goRouter;

          return Consumer<LanguageViewModel>(builder: (context, provider, child) {
            return MaterialApp.router(
              scaffoldMessengerKey: AppValues.scaffoldMessengerKey,
              routerDelegate: router.routerDelegate,
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
              title: Environment.runningEnv.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(context),
              darkTheme: AppTheme.light(context),
              themeMode: ThemeMode.light,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: provider.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              localeResolutionCallback: AppLocalizations.localeResolutionCallBack,
            );
          });
        },
      ),
    );
  }
}
