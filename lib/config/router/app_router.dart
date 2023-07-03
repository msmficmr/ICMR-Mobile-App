import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';

class AppRouter {
  late GoRouter goRouter;

  List<String> unProtectedRoutes = [SplashScreen.routerPath];

  AppRouter() {
    goRouter = GoRouter(
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
          ],
        )
      ],
    );
  }
}
