import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mhealth/model/send_otp_response_model.dart';
import 'package:mhealth/model/user_model.dart';
import 'package:mhealth/model/verify_otp_response_model.dart';
import 'package:mhealth/services/authService/auth_service.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';

class LoginViewModel extends ChangeNotifier {
  static LoginViewModel loginViewModel = LoginViewModel._();

  LoginViewModel._() {
    _isLoggedIn = false;
  }

  factory LoginViewModel() {
    return loginViewModel;
  }
  VerifyOtpResponseModel? _authDetails;
  UserModel? _userDetails;
  UserModel? get userDetails => _userDetails;
  VerifyOtpResponseModel? get authDetails => _authDetails;

  bool _isLoggedIn = false;
  LoginScreenTypes _loginScreenType = LoginScreenTypes.MOBILE_NUMBER;
  LoginScreenTypes _authFlow = LoginScreenTypes.MOBILE_NUMBER;
  String _mobileNoOrEmailText = "";
  bool _isEmailLogin = false;
  bool _isLoading = false;

  bool get isLoggedIn => _isLoggedIn;
  LoginScreenTypes get loginScreenType => _loginScreenType;
  LoginScreenTypes get authFlow => _authFlow;
  String get mobileNoOrEmailText => _mobileNoOrEmailText;
  bool get isEmailLogin => _isEmailLogin;
  bool get isLoading => _isLoading;

  final List<String> loginTypes = ["Email", "Mobile number"];

  resetLoginScreen() {
    _isLoading = false;
  }

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set loginScreenType(LoginScreenTypes value) {
    _loginScreenType = value;
    notifyListeners();
  }

  set mobileNoOrEmailText(String value) {
    _mobileNoOrEmailText = value;
  }

  set isEmailLogin(bool value) {
    _isEmailLogin = false;
  }

  set authFlow(LoginScreenTypes value) {
    _authFlow = value;
  }

  resetProvider() {
    _loginScreenType = LoginScreenTypes.MOBILE_NUMBER;
    _mobileNoOrEmailText = "";
  }

  loginUser(String data) {
    _authDetails = verifyOtpResponseModelFromJson(data);
    _userDetails = _authDetails?.user;
    _isLoggedIn = true;
    notifyListeners();
  }

  /// function will helps to send otp to mobile no
  /// [sendOtp] method require mobileNo as parameter
  /// it will call [AuthService().sendOtp()] method
  /// method will return [SendOtpResponseModel] object i.e nullable
  /// if we get any exception it will return null
  /// object has property called success if otp sent success this property will be `true`
  /// if we get success property as true then we are redirecting to otp validation screen
  /// otherwise we will display message property of [SendOtpResponseModel]
  Future<bool> sendOtp({required String mobileNumberOrEmailText, AuthType authType = AuthType.mobile}) async {
    bool isOtpSentSuccess = false;
    isLoading = true;
    Map<String, dynamic> otpPayload = {};
    if (authType == AuthType.email) {
      _isEmailLogin = true;
      otpPayload = {"email": mobileNumberOrEmailText};
    } else {
      otpPayload = {"mobile": mobileNumberOrEmailText};
    }
    try {
      SendOtpResponseModel? response = await AuthService().sendOtp(otpPayload: otpPayload);
      if (response != null) {
        _mobileNoOrEmailText = mobileNumberOrEmailText;
        isOtpSentSuccess = true;
        loginScreenType = LoginScreenTypes.OTP_SCREEN;
      }
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG + e.toString());
    } finally {
      isLoading = false;
    }

    return isOtpSentSuccess;
  }

  Future<void> validateOtp({required String otp}) async {
    try {
      isLoading = true;
      Map<String, dynamic> payload = {};
      if (loginViewModel.isEmailLogin == true) {
        payload = {"email": loginViewModel.mobileNoOrEmailText, "otp": otp};
      } else {
        payload = {"mobile": loginViewModel.mobileNoOrEmailText, "otp": otp};
      }
      VerifyOtpResponseModel? response = await AuthService().verifyOtp(payload: payload);
      if (response != null) {
        String userDetails = jsonEncode(response.toJson());
        await SharedPreferencesService.sharedPreferencesService.writeString(key: AppConstant.SHARED_PREFERENCE_USER_DETAILS, value: userDetails);
        await SharedPreferencesService.sharedPreferencesService.writeString(key: AppConstant.SHARED_PREFERENCE_LOGIN_TIME, value: DateTime.now().toIso8601String());
        loginUser(jsonEncode(response.toJson()));
      }
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.INVALID_OTP);
    } finally {
      isLoading = false;
    }
  }

  Future<Response> getAppVersion() async {
    try {
      Response response = await AuthService().getAppVersion();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Returning a true value if the status code of the logout is [200]
  Future<bool> logout() async {
    try {
      await SharedPreferencesService.sharedPreferencesService.clearAll();
      _userDetails = null;
      _isLoggedIn = false;
      await AuthService().logout();
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  int checkLoginTimestamp() {
    try {
      String temp = authDetails?.refreshTokenExpiresIn ?? "";
      temp = temp.substring(0, temp.length - 1);
      int loginTimestamp = int.parse(temp);
      String? dateStr = SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.SHARED_PREFERENCE_LOGIN_TIME);
      DateTime loginDate = dateStr == null ? DateTime.now() : DateTime.parse(dateStr); //DateTime(2024, 07, 25);
      DateTime logOutdate = loginDate.add(Duration(seconds: loginTimestamp));
      return logOutdate.difference(DateTime.now()).inDays;
    } catch (e) {
      return 0;
    }
  }
}
