class AppEndpoints {
  AppEndpoints._();

  static List<String> get unauthorizedRequests => [sendOtpUrl, loginOtpUrl];

  static String get sendOtpUrl => "/auth/otp";
  static String get loginOtpUrl => "/auth/otp/login";
  static String get logoutUrl => "/logout";
}
