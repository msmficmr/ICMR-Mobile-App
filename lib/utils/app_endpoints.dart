class AppEndpoints {
  AppEndpoints._();

  static List<String> get unauthorizedRequests => [sendOtpUrl, loginOtpUrl];

  static String get sendOtpUrl => "/auth/otp";
  static String get loginOtpUrl => "/auth/user/login/";
}
