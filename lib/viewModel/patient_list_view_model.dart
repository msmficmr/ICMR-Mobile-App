import 'package:flutter/foundation.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';

class PatientListViewModel with ChangeNotifier {
  late List<PatientRegistration?> _registeredPatients = [];
  bool _isLoading = false;

  List<PatientRegistration?> get registeredPatients => _registeredPatients;
   bool get isLoading => _isLoading;

  Future<void> loadRegisteredPatients() async {
    try {
      _isLoading = true;
      _registeredPatients = await IsarDbService.isarDbService.getPatientsList();
      notifyListeners();
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
