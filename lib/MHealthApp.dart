import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/config/router/app_router.dart';
import 'package:mhealth/config/theme/app_theme.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/services/network_status_service.dart';
import 'package:mhealth/utils/app_localization.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
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
        ChangeNotifierProvider<LanguageViewModel>(
          lazy: false,
          create: (BuildContext createContext) => LanguageViewModel(),
        ),
        ChangeNotifierProvider<ChatBotViewModel>(
          lazy: false,
          create: (BuildContext createContext) => ChatBotViewModel(),
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
