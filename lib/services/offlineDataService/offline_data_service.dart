import 'dart:developer';

import 'package:http/http.dart';
import 'package:mhealth/model/offline_data_model.dart';
import 'package:mhealth/model/offlne_sync_response_model.dart';
import 'package:mhealth/services/offlineDataService/i_offline_data_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_endpoints.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';
import 'package:mhealth/utils/network/api_base_helper.dart';

class OfflineDataService implements IOfflineDataService {
  @override
  Future<OfflineDataModel?> fetchDataSync({required String userId}) async {
    try {
      Response? response = await ApiBaseHelper.httpGetRequest("${AppEndpoints.syncNumber}?userId=$userId&syncStatus=true");
      if (response != null) {
        OfflineDataModel syncNumber = offlineDataModelFromJson(response.body);
        return syncNumber;
      } else {
        throw AppException(null, AppConstant.ERROR_SOMETHING_WENT_WRONG, 500);
      }
    } catch (e) {}
  }

  @override
  Future<OfflineSyncResponseModel?> saveOfflineDataSync({required Map<String, dynamic> payLoadObj}) async {
    try {
      Response? response = await ApiBaseHelper.httpPostRequest(
        AppEndpoints.syncData,
        payload: payLoadObj,
      );
      if (response != null) {
        OfflineSyncResponseModel result = offlineSyncResponseModelFromJson(response.body);
        return result;
      }
    } catch (e) {
      rethrow;
    }
  }
}
