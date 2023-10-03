import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mhealth/model/offline_data_model.dart';
import 'package:mhealth/model/offlne_sync_response_model.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/services/offlineDataService/offline_data_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';

class OfflineDataViewModel extends ChangeNotifier {
  int? _syncNumber;

  int? get syncedNumbers => _syncNumber;

  Future<void> fetchOfflineSyncedNumbers({required String userId}) async {
    try {
      OfflineDataModel? response = await OfflineDataService().fetchDataSync(userId: userId);
      if (response != null) {
        _syncNumber = response.numberOfElements;
        notifyListeners();
      }
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    }
  }

  Future<void> postOffllineData({required String? caseId, required String? patientId, required Map<String, dynamic> payLoadObj}) async {
    try {
      OfflineSyncResponseModel? response = await OfflineDataService().saveOfflineDataSync(payLoadObj: payLoadObj);
      if (response?.status == 201) {
        await IsarDbService.isarDbService.deleteByCaseId(caseId);
        await IsarDbService.isarDbService.deleteByPatientId(patientId);
      }
    } catch (e) {
       CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    }
  }
}
