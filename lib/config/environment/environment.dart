import 'dart:io';

import 'package:media_store_plus/media_store_plus.dart';
import 'package:mhealth/config/environment/dev_environment.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_constant.dart';

mixin Environment {
  static Environment runningEnv = DEVEnvironment();
  final String releaseVersion = "0.6.4";

  String get currentEnv => const String.fromEnvironment(AppConstant.ENV_KEY);
  String get appName => const String.fromEnvironment(AppConstant.APP_NAME_KEY);
  String get baseUrl => const String.fromEnvironment(AppConstant.BASE_URL_KEY);
  String get sourceAppName => const String.fromEnvironment(AppConstant.SOURCE_APP_NAME_KEY);
  String get encryptionKey => const String.fromEnvironment(AppConstant.ENCRYPTION_KEY);

  bindServices() async {
    await SharedPreferencesService.init();
    if (Platform.isAndroid) {
      MediaStore.appFolder = "LesionImages";
      await MediaStore.ensureInitialized();
    }
  }
}
