import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_endpoints.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';
import 'package:mhealth/viewModel/login_view_model.dart';

class HttpStatusCodeInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    String url = data.url;

    log("Request Url: ${url}");

    /// if request url is protected then we are modifying header
    /// and adding authorization parameter to it.
    String unauthorizedRequestUrl = AppEndpoints.unauthorizedRequests.firstWhere(
      (String element) {
        bool containsUrl = (url == "${Environment.runningEnv.baseUrl}$element");

        return containsUrl;
      },
      orElse: () => "",
    );
    if (unauthorizedRequestUrl.isEmpty) {
      final sharedPreferenceData = await SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.SHARED_PREFERENCE_USER_DETAILS);
      Map<String, dynamic> jsonData = jsonDecode(sharedPreferenceData as String);
      String token = jsonData['accessToken'] ?? "";
      data.headers = {
        "content-type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      };
    } else {
      data.headers = {
        "content-type": "application/json",
        "accept": "application/json",
      };
    }

    return data;
  }

  Future<void> checkResponseStatusCode({required Response data}) async {
    int statusCode = data.statusCode;
    log("${statusCode}");
    switch (statusCode) {
      /// if response status code is not 200 || 201 then throwing exception
      case HttpStatus.ok:
      case HttpStatus.created:
      case HttpStatus.notFound:
        break;
      case HttpStatus.unauthorized:
        LoginViewModel.loginViewModel.logout();
      case HttpStatus.badRequest:
        throw BadRequestException(response: data, message: "400", statusCode: statusCode);
      case HttpStatus.tooManyRequests:
        throw TooManyRequestException(response: data, message: "429", statusCode: statusCode);
      case HttpStatus.internalServerError:
        throw ServerException(response: data, message: "500", statusCode: statusCode);
      case HttpStatus.networkConnectTimeoutError:
        throw NetworkConnectTimeoutErrorException(response: data, message: "599", statusCode: statusCode);
      default:
        throw AppException(data, "Something Went Wrong", 500);
    }
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    await checkResponseStatusCode(data: data.toHttpResponse());

    return data;
  }
}
