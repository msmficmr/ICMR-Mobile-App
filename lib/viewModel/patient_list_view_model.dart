import 'package:flutter/foundation.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';

class PatientListViewModel with ChangeNotifier {
    late List<PatientRegistration?>  _registeredPatients = [];

  List<PatientRegistration?> get registeredPatients => _registeredPatients;

  Future<void> loadRegisteredPatients() async {
    _registeredPatients = await IsarDbService.isarDbService.getRegisteredPatientList();
    notifyListeners(); // Notify listeners when the data has been loaded
  }
}
