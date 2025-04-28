import 'package:mhealth/config/environment/environment.dart';

class AppEndpoints {
  AppEndpoints._();

  static List<String> get unauthorizedRequests => [sendOtpUrl, loginOtpUrl];

  static String get sendOtpUrl => "/auth/otp?sourceAppName=${Environment.runningEnv.sourceAppName}";
  static String get loginOtpUrl => "/auth/otp/login";
  static String get syncNumber => "/sync/offline-data";
  static String get logoutUrl => "/logout";
  static String get syncData => "/sync/offline-data";
  static String get refreshTokenUrl => "/refresh-token";
  static String get appVersionUrl => '/store/app-version/${Environment.runningEnv.sourceAppName}';
}
