import 'dart:io';

import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/services/authService/auth_service.dart';
import 'package:mhealth/utils/app_endpoints.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';
import 'package:http_interceptor/http_interceptor.dart';

class RetryPolicyInterceptor extends RetryPolicy {
  @override
  int maxRetryAttempts = 5;

   @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    String url = response.request!.url;

    String status = AppEndpoints.unauthorizedRequests.firstWhere(
      (String element) {
        bool containsUrl = (url == "${Environment.runningEnv.baseUrl}$element");

        return containsUrl;
      },
      orElse: () => "",
    );
    if (response.statusCode == HttpStatus.unauthorized) {
      if (status.isEmpty) {
        await AuthService.refreshToken();
        return true;
      } else {
        throw UnAuthorizedException(response: response.toHttpResponse(), message: "401", statusCode: response.statusCode);
      }
    }

    return false;
  }

}
