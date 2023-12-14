import 'package:mhealth/config/environment/sit_environment.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_constant.dart';

mixin Environment {
  static Environment runningEnv = SITEnvironment();
  final String releaseVersion = "0.1.0";

  String get currentEnv => const String.fromEnvironment(AppConstant.ENV_KEY);
  String get appName => const String.fromEnvironment(AppConstant.APP_NAME_KEY);
  String get baseUrl => const String.fromEnvironment(AppConstant.BASE_URL_KEY);
  bindServices() async {
    await SharedPreferencesService.init();
  }
}