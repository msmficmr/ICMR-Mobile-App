import 'package:flutter/material.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/model/offline_data_model.dart';
import 'package:mhealth/model/offlne_sync_response_model.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/services/offlineDataService/offline_data_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';

class OfflineDataViewModel extends ChangeNotifier {
  int? _syncNumber;
  int? _patientRegistered;
  int? _completedCRAcount;

  int? get syncedNumbers => _syncNumber;
  int? get patientRegistered => _patientRegistered;
  int? get completedCRAcount => _completedCRAcount;
  bool _isPatientCountLoading = false;
  bool get isPatientCountLoading => _isPatientCountLoading;

  bool _isCRAcountLoading = false;
  bool get isCRAcountLoading => _isCRAcountLoading;

  set isCRAcountLoading(bool value) {
    _isCRAcountLoading = value;
    notifyListeners();
  }

  set isPatientCountLoading(bool value) {
    _isPatientCountLoading = value;
    notifyListeners();
  }

  Future<void> fetchRegisteredPatient() async {
      List<PatientRegistration> patientListResponse = await IsarDbService.isarDbService.getPatientsList();
      _patientRegistered = patientListResponse.length;
      notifyListeners();

  }

  Future<void> fetchCompletedCRA() async {
      List<CRAOfflineData?> response = await IsarDbService.isarDbService.getListCRAOfflineData();
      _completedCRAcount = response.where((element) => element?.craSectionData?.any((el) => el.encounterCategoryMapId == "community_risk_assessment_verification_form") ?? false).length;
      notifyListeners();
  }

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

  Future<void> postOfflineData({required String? caseId, required String? patientId, required Map<String, dynamic> payLoadObj}) async {
    try {
      OfflineSyncResponseModel? response = await OfflineDataService().saveOfflineDataSync(payLoadObj: payLoadObj);
      if (response?.status == 201) {
        if (caseId != null) {
          await IsarDbService.isarDbService.deleteByCaseId(caseId);
        }
        await IsarDbService.isarDbService.deleteByPatientId(patientId);
      }
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    }
  }
}
