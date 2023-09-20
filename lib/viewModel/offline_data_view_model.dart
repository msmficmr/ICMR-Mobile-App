import 'package:flutter/material.dart';
import 'package:mhealth/model/offline_data_model.dart';
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


}
