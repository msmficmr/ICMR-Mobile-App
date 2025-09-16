import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/router/router_transition.dart';
import 'package:mhealth/services/permission_service.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/views/doctor/doctor_name_screen.dart';
import 'package:mhealth/views/probe_screens/probe_screen.dart';
import 'package:mhealth/views/questionair/view/question_screen_view.dart';
import 'package:mhealth/views/storage_permission/storage_permission_screen.dart';

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
          path: DashboardScreen.routerPath,
          redirect: (context, state) async {
            bool containsLanguage = await SharedPreferencesService.sharedPreferencesService.hasKey(AppConstant.LANGUAGE_KEY);
            if (!containsLanguage) {
              return LanguageSelectionScreen.routerPath;
            }
            bool containsDoctorName = await SharedPreferencesService.sharedPreferencesService.hasKey(AppConstant.SHREAD_PREF_DOC_KEY);
            if (!containsDoctorName) {
              return DoctorNameScreen.routerPath;
            }

            /* bool hasStoragePermission = await PermissionService.hasStoragePermission();
            if (!hasStoragePermission) {
              return StoragePermissionScreen.routerPath;
            } */

            return null;
          },
          pageBuilder: (context, state) => RouterTransition(
            key: state.pageKey,
            child: DashboardScreen(),
          ),
        ),
        GoRoute(
          path: StoragePermissionScreen.routerPath,
          pageBuilder: (context, state) => RouterTransition(
            key: state.pageKey,
            child: const StoragePermissionScreen(),
          ),
        ),
        GoRoute(
          path: CRAPatientScreen.routerPath,
          pageBuilder: (context, state) => RouterTransition(
            key: state.pageKey,
            child: const CRAPatientScreen(),
          ),
        ),
        GoRoute(
          path: DoctorNameScreen.routerPath,
          pageBuilder: (context, state) {
            bool showBackButton = state.extra == null ? false : state.extra as bool;
            return RouterTransition(
              key: state.pageKey,
              child: DoctorNameScreen(
                shouldShowBackButton: showBackButton,
              ),
            );
          },
        ),
        GoRoute(
          path: RegistrationScreen.routerPath,
          pageBuilder: (context, state) {
            final String? patientId = state.extra as String?;
            bool isEditable = patientId != null ? false : true;

            return RouterTransition(
              key: state.pageKey,
              child: RegistrationScreen(
                patientId: patientId,
                isEditable: isEditable,
              ),
            );
          },
        ),
        GoRoute(
            path: LanguageSelectionScreen.routerPath,
            pageBuilder: (context, state) {
              bool showBackButton = state.extra == null ? false : state.extra as bool;
              return RouterTransition(
                key: state.pageKey,
                child: LanguageSelectionScreen(displayBackButton: showBackButton),
              );
            }),
        GoRoute(
          path: ConsentScreeningScreen.routerPath,
          pageBuilder: (context, state) => RouterTransition(
            key: state.pageKey,
            child: const ConsentScreeningScreen(),
          ),
        ),
        GoRoute(
          path: RegistrationSuccessFullScreen.routerPath,
          pageBuilder: (context, state) {
            Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
            return RouterTransition(
              key: state.pageKey,
              child: RegistrationSuccessFullScreen(
                thePatientId: extra["patientId"],
              ),
            );
          },
        ),
        GoRoute(
          path: MyAccountScreen.routerPath,
          pageBuilder: (context, state) => RouterTransition(
            key: state.pageKey,
            child: MyAccountScreen(),
          ),
        ),
        GoRoute(
          path: QuestionScreenView.routerPath,
          pageBuilder: (context, state) {
            Map<String, dynamic> jsonData = state.extra as Map<String, dynamic>;

            return RouterTransition(
              key: state.pageKey,
              child: QuestionScreenView(
                caseId: jsonData["caseId"],
                patientId: jsonData["patientId"],
                sectionId: jsonData["sectionId"],
              ),
            );
          },
        ),
        GoRoute(
          path: CriteriaScreen.routerPath,
          pageBuilder: (context, state) {
            Map<String, dynamic> extra = state.extra as Map<String, dynamic>;

            return RouterTransition(
              key: state.pageKey,
              child: CriteriaScreen(
                theCaseId: extra["caseId"],
                thePatientId: extra["patientId"],
              ),
            );
          },
        ),
      ],

      /// this callback will called on every time when we are trying to navigate from one screen to another
      redirect: (BuildContext context, GoRouterState state) async {
        // [state.matchedLocation] will return navigation route passed to push/go method
        String navigationRoute = state.matchedLocation;

        /// if user is not logged in and current navigation is not listed as unProtected we are forcefully
        /// navigating to login screen
        /// 
        if (!loginViewModel.isLoggedIn) {
          return unProtectedRoutes.contains(navigationRoute) ? null : LoginHome.routerPath;
        }
        if (loginViewModel.isLoggedIn) {
          if (navigationRoute == LoginHome.routerPath) {
            return LanguageSelectionScreen.routerPath;
          }
          if (navigationRoute == SplashScreen.routerPath) {
            return DashboardScreen.routerPath;
          }
        }

        /// if user is logged we are null so that it will navigate from one screen to another without any redirect

        return null;
      },
    );
  }
}
