import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/model/offline_data_model.dart';
import 'package:mhealth/model/offlne_sync_response_model.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/services/offlineDataService/offline_data_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/views/questionair/viewmodel/question_view_model.dart';

class OfflineDataViewModel extends ChangeNotifier {
  int? _syncNumber;
  //int? _patientRegistered;

  int? get syncedNumbers => _syncNumber;
  //int? get patientRegistered => _patientRegistered;

  bool _isPatientCountLoading = false;
  bool get isPatientCountLoading => _isPatientCountLoading;

  set isPatientCountLoading(bool value) {
    _isPatientCountLoading = value;
    notifyListeners();
  }

  /* Future<void> fetchRegisteredPatient() async {
    List<PatientRegistration> patientListResponse = await IsarDbService.isarDbService.getPatientsList();
    _patientRegistered = patientListResponse.length;
    notifyListeners();
  } */

  bool _syncData = false;
  bool get syncData => _syncData;

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

  Future<bool> postOfflineData({required String? caseId, required String? primaryId, required Map<String, dynamic> payLoadObj, required List<String> fileDeleteList}) async {
    bool isSuccess = false;
    try {
      OfflineSyncResponseModel? response = await OfflineDataService().saveOfflineDataSync(payLoadObj: payLoadObj);
      if (response?.status == 201) {
        if (caseId != null) {
          await IsarDbService.isarDbService.deleteByCaseId(caseId);
        }

        //await IsarDbService.isarDbService.markPatientAsSynced(primaryId);
        for (String path in fileDeleteList) {
          await CommonFunctions().deleteFile(path);
        }
        isSuccess = true;
      }
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    }
    return isSuccess;
  }
}
