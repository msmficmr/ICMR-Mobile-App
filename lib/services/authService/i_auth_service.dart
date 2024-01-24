import 'package:http/http.dart';
import 'package:mhealth/model/send_otp_response_model.dart';
import 'package:mhealth/model/verify_otp_response_model.dart';

abstract class IAuthService {
  Future<SendOtpResponseModel?> sendOtp({required Map<String, dynamic> otpPayload});
  Future<VerifyOtpResponseModel?> verifyOtp({required Map<String, dynamic> payload});
  Future<Response> getAppVersion();
  Future<Response> logout();
}
