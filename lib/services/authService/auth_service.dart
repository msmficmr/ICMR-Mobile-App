import 'dart:developer';

import 'package:http/http.dart';
import 'package:mhealth/model/send_otp_response_model.dart';
import 'package:mhealth/model/verify_otp_response_model.dart';
import 'package:mhealth/services/authService/i_auth_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_endpoints.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';
import 'package:mhealth/utils/network/api_base_helper.dart';

class AuthService implements IAuthService {
  @override
  Future<SendOtpResponseModel?> sendOtp({required Map<String, dynamic> otpPayload}) async {
    try {
      Response? response = await ApiBaseHelper.httpPostRequest(AppEndpoints.sendOtpUrl, payload: otpPayload);
      if (response != null) {
        SendOtpResponseModel otpModel = sendOtpResponseModelFromJson(response.body);
        if (otpModel.statusCode == 20000) {
          return otpModel;
        } else {
          CommonFunctions.toastMessage(otpModel.message ?? "");
        }
      } else {
        throw AppException(null, AppConstant.ERROR_SOMETHING_WENT_WRONG, 500);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpResponseModel?> verifyOtp({required Map<String, dynamic> payload}) async {
    try {
      Response? response = await ApiBaseHelper.httpPostRequest(
        AppEndpoints.loginOtpUrl,
        payload: payload,
      );
      if (response != null) {
        VerifyOtpResponseModel otpModel = verifyOtpResponseModelFromJson(response.body);
        if (otpModel.statusCode == 20000) {
          return otpModel;
        } else {
          CommonFunctions.toastMessage(otpModel.status ?? "");
        }
      } else {
        throw AppException(null, AppConstant.ERROR_SOMETHING_WENT_WRONG, 500);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> refreshToken() async {
    Response response = await ApiBaseHelper.httpGetRequestForRefreshToken(
      AppEndpoints.refreshTokenUrl,
    );
    log("refresh token ${response.body}");
    return response;
  }
  
  @override
  Future<Response> getAppVersion() async {
    try {
      Response? response = await ApiBaseHelper.httpGetRequest(AppEndpoints.appVersionUrl);
      if (response != null) {
        return response;
      } else {
        throw AppException(null, AppConstant.ERROR_SOMETHING_WENT_WRONG, 500);
      }
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Response> logout() async {
    try {
      Response? response = await ApiBaseHelper.httpGetRequest(AppEndpoints.logoutUrl);
      if (response != null) {
        return response;
      } else {
        throw AppException(null, AppConstant.ERROR_SOMETHING_WENT_WRONG, 500);
      }
    } catch (e) {
      rethrow;
    }
  }
}
