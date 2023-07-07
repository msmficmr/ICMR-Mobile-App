import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/config/router/app_router.dart';
import 'package:mhealth/config/theme/app_theme.dart';
import 'package:mhealth/utils/app_values.dart';
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
        Provider<AppRouter>(
          lazy: false,
          create: (BuildContext createContext) {
            LoginViewModel loginModel = Provider.of<LoginViewModel>(createContext, listen: false);
            return AppRouter(loginModel);
          },
        ),
      ],
      child: Builder(builder: (context) {
        final router = Provider.of<AppRouter>(context, listen: false).goRouter;

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
        );
      },),
    );
  }
}
