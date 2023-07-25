import 'package:http/http.dart';
import 'package:mhealth/model/send_otp_response_model.dart';
import 'package:mhealth/model/verify_otp_response_model.dart';
import 'package:mhealth/services/authService/i_auth_service.dart';
import 'package:mhealth/utils/app_endpoints.dart';
import 'package:mhealth/utils/network/api_base_helper.dart';

class AuthService implements IAuthService {
  @override
  Future<SendOtpResponseModel?> sendOtp({required Map<String, dynamic> otpPayload}) async {
    try {
      Response? response = await ApiBaseHelper.httpPostRequest(AppEndpoints.sendOtpUrl, payload: otpPayload);
      return response == null ? null : sendOtpResponseModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpResponseModel?> verifyOtp({required Map<String, dynamic> payload}) async {
    try {
      // Map<String, dynamic> payload = {
      //   "email": email,
      //   "otp": otp,
      // };

      Response? response = await ApiBaseHelper.httpPostRequest(
        AppEndpoints.loginOtpUrl,
        payload: payload,
      );

      return response == null ? null : verifyOtpResponseModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
