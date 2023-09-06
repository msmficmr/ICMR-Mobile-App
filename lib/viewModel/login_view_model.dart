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
  UserModel? _userDetails;

  bool _isLoggedIn = false;
  LoginScreenTypes _loginScreenType = LoginScreenTypes.MOBILE_NUMBER;
  LoginScreenTypes _authFlow = LoginScreenTypes.MOBILE_NUMBER;
  String _mobileNoOrEmailText = "";
  bool _isEmailLogin = false;
  bool _isLoading = false;
  bool _isOTPValidating = false;

  bool get isLoggedIn => _isLoggedIn;
  LoginScreenTypes get loginScreenType => _loginScreenType;
  LoginScreenTypes get authFlow => _authFlow;
  String get mobileNoOrEmailText => _mobileNoOrEmailText;
  bool get isEmailLogin => _isEmailLogin;
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
    _userDetails = UserModel.fromJson(jsonDecode(data));
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
  Future<bool> sendOtp({required String mobileNumberOrEmailText,AuthType authType=AuthType.mobile}) async {
    bool isOtpSentSuccess = false;
    Map<String, dynamic> otpPayload = {};
    if (authType == AuthType.email) {
      _isEmailLogin = true;
      otpPayload = {"email": mobileNumberOrEmailText};
    } else {
      otpPayload = {"mobile": mobileNumberOrEmailText};
    }
    try {
      isLoading = true;
      SendOtpResponseModel? response = await AuthService().sendOtp(otpPayload: otpPayload);
      if (response != null) {
          _mobileNoOrEmailText = mobileNumberOrEmailText;
          loginScreenType = LoginScreenTypes.OTP_SCREEN;
      }
    } catch (e) {
      log(e.toString());
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG+e.toString());
    } finally {
      isLoading = false;
    }

    return isOtpSentSuccess;
  }

  Future<void> validateOtp({required String otp}) async {
    try {
      isOTPValidating = true;
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
            loginUser(userDetails);
      }
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    } finally {
      isOTPValidating = false;
    }
  }

  Future<bool> logout() async {
    try {
      final Response response = await AuthService().logout();
      if (response.statusCode == 200) {
        await SharedPreferencesService.sharedPreferencesService.clearAll();
        return true;
      }
      return false;
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
      rethrow;
    }
  }
}
