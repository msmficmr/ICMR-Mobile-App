import 'package:flutter/material.dart';
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

  bool _isLoggedIn = false;
  LoginScreenTypes _loginScreenType = LoginScreenTypes.MOBILE_NUMBER;
  LoginScreenTypes _authFlow = LoginScreenTypes.MOBILE_NUMBER;
  String _mobileNo = "";
  bool _isLoading = false;
  bool _isOTPValidating = false;

  bool get isLoggedIn => _isLoggedIn;
  LoginScreenTypes get loginScreenType => _loginScreenType;
  LoginScreenTypes get authFlow => _authFlow;
  String get mobileNo => _mobileNo;
  bool get isLoading => _isLoading;
  bool get isOTPValidating => _isOTPValidating;

  final List<String> loginTypes = ["Email", "Mobile number"];

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isOTPValidating(bool value) {
    _isOTPValidating = value;
    notifyListeners();
  }

  set loginScreenType(LoginScreenTypes value) {
    _loginScreenType = value;
    notifyListeners();
  }

  set mobileNo(String value) {
    _mobileNo = value;
  }

  set authFlow(LoginScreenTypes value) {
    _authFlow = value;
  }

  resetProvider() {
    _loginScreenType = LoginScreenTypes.MOBILE_NUMBER;
    _mobileNo = "";
  }

  loginUser() {
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<bool> sendOtp({required String mobileNo}) async {
    bool isOtpSentSuccess = false;
    try {
      isLoading = true;
      loginScreenType = LoginScreenTypes.OTP_SCREEN;
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    } finally {
      isLoading = false;
    }

    return isOtpSentSuccess;
  }

  Future<void> validateOtp({required String otp}) async {
    try {
      isOTPValidating = true;
      loginUser();
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    } finally {
      isOTPValidating = false;
    }
  }

}