import 'package:flutter/foundation.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';

class PatientListViewModel with ChangeNotifier {
  List<PatientRegistration> _registeredPatients = [];
  List<PatientRegistration> _filteredItems = [];
  bool _isLoading = false;

  List<PatientRegistration?> get registeredPatients => _registeredPatients;

  List<PatientRegistration> get filteredItems => _filteredItems;

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

  void searchPatient(String name) {
    _filteredItems = _registeredPatients.where((element) => element.firstName.toLowerCase().contains(name.toLowerCase()) || element.lastName.toLowerCase().contains(name.toLowerCase())).toList();
    notifyListeners();
  }
}
