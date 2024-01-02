import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/network/http_status_code_interceptor.dart';
import 'package:mhealth/utils/network/retry_policy_interceptor.dart';

class ApiBaseHelper {
  static final InterceptedClient client = InterceptedClient.build(
    interceptors: [
      /// checking status code and throwing exception if status is not 200 || 201
      HttpStatusCodeInterceptor(),
    ],

    /// calls to refresh token if api returns 401
    retryPolicy: RetryPolicyInterceptor(),
  );

  static Future<Response?> httpGetRequest(String requestUrl) async {
    try {
      Response response = await client.get(
        Uri.parse('${Environment.runningEnv.baseUrl}$requestUrl'),
      );
      return response;
    } on SocketException {
      CommonFunctions.showRetrySnackbar();
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response?> httpPostRequest(String requestUrl, {required Map<dynamic, dynamic> payload}) async {
    try {
      Response response = await client.post(
        Uri.parse('${Environment.runningEnv.baseUrl}$requestUrl'),
        body: json.encode(payload),
      );
      return response;
    } on SocketException {
      CommonFunctions.showRetrySnackbar();
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response?> httpMultiPartRequest(String requestUrl, {required Map<String, dynamic> payload, required List<MultipartFile> files, String requestType = "POST"}) async {
    try {
      MultipartRequest baseRequest = MultipartRequest(
        requestType,
        Uri.parse('${Environment.runningEnv.baseUrl}$requestUrl'),
      );

      Map<String, String> fields = payload.map((key, value) => MapEntry(key, value.toString()));

      baseRequest.fields.addAll(fields);
      baseRequest.files.addAll(files);
      // String token = LoginViewModel.loginViewModel.userDetails?.tokendata ?? "";
      baseRequest.headers.addAll({
        "accept": "application/json",
        //     'Authorization': 'Bearer $token',
        "Content-type": "multipart/form-data",
      });

      StreamedResponse streamResponse = await baseRequest.send();
      Response response = await Response.fromStream(streamResponse);
      HttpStatusCodeInterceptor().checkResponseStatusCode(data: response);

      return response;
    } on SocketException {
      CommonFunctions.showRetrySnackbar();
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response?> httpPatchRequest(String requestUrl, {required Map<dynamic, dynamic> payload}) async {
    try {
      Response response = await client.patch(
        Uri.parse('${Environment.runningEnv.baseUrl}$requestUrl'),
        body: json.encode(payload),
      );

      return response;
    } on SocketException {
      CommonFunctions.showRetrySnackbar();
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future httpGetRequestForRefreshToken(String requestUrl) async {
    try {
      var header = await _authorizationRefreshToken();
      Response response = await get(
        Uri.parse('${Environment.runningEnv.baseUrl}$requestUrl'),
        headers: header,
      );
      if (response.statusCode == HttpStatus.ok) {
        //TODO : set access token
      }

      return response;
    } catch (e) {}
  }

  static Future<Map<String, String>> _authorizationRefreshToken() async {
    final sharedPreferenceData = await SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.SHARED_PREFERENCE_USER_DETAILS);
    Map<String, dynamic> jsonData = jsonDecode(sharedPreferenceData as String);
    String token = jsonData['accessToken'] ?? "";
    String refreshToken = jsonData['refreshToken'] ?? "";

    return {
      "content-type": "application/json; charset=utf-8",
      "accept": "application/json",
      'Authorization': 'Bearer $token',
      'refresh-token': refreshToken,
    };
  }
}
