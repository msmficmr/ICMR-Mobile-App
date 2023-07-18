import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/router/router_transition.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/views/screening/consent_screening_screen.dart';

import '../../views/language/language_selection_screen.dart';

class AppRouter {
  LoginViewModel loginViewModel;
  late GoRouter goRouter;

  /// List of routes which can be accessed without login in app
  List<String> unProtectedRoutes = [
    LoginHome.routerPath,
    SplashScreen.routerPath,
  ];

  AppRouter(this.loginViewModel) {
    goRouter = GoRouter(
      /// GoRouter will keep listening to LoginViewModel.
      /// we have declared [isLoggedIn] variable if we change state of variable
      /// it will call redirect callback and screen will be redirected to [LoginScreen]
      refreshListenable: loginViewModel,
      routerNeglect: true,
      initialLocation: SplashScreen.routerPath,
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return Navigator(
              onPopPage: (route, result) {
                route.didPop(result);
                return false;
              },
              pages: [MaterialPage(child: child)],
            );
          },
          routes: [
            GoRoute(
              path: SplashScreen.routerPath,
              builder: (context, state) => const SplashScreen(),
            ),
            GoRoute(
              path: LoginHome.routerPath,
              pageBuilder: (context, state) => RouterTransition(
                key: state.pageKey,
                child: const LoginHome(),
              ),
            ),
            GoRoute(
              path: HomeScreen.routerPath,
              pageBuilder: (context, state) => RouterTransition(
                key: state.pageKey,
                child: const HomeScreen(),
              ),
            ),
          ],
        )
      ],

      /// this callback will called on every time when we are trying to navigate from one screen to another
      redirect: (BuildContext context, GoRouterState state) async {
        // [state.matchedLocation] will return navigation route passed to push/go method
        String navigationRoute = state.matchedLocation;

        /// if user is not logged in and current navigation is not listed as unProtected we are forcefully
        /// navigating to login screen
        if (!loginViewModel.isLoggedIn) {
          return unProtectedRoutes.contains(navigationRoute) ? null : LoginHome.routerPath;
        }
        if (loginViewModel.isLoggedIn) {
          if (navigationRoute == LoginHome.routerPath) {
            return HomeScreen.routerPath;
          }
        }

        /// if user is logged we are null so that it will navigate from one screen to another without any redirect

        return null;
      },
    );
  }
}
