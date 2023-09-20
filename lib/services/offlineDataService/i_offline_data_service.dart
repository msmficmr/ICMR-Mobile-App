import 'package:mhealth/model/offline_data_model.dart';
import 'package:mhealth/model/offlne_sync_response_model.dart';

abstract class IOfflineDataService {
  Future<OfflineDataModel?> fetchDataSync({required String userId});
  Future<OfflineSyncResponseModel?> saveOfflineDataSync({required Map<String, dynamic> payLoadObj});
}
