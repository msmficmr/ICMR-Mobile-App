import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';

class PatientListViewModel with ChangeNotifier {
  List<PatientRegistration> _registeredPatients = [];
  List<PatientRegistration> _filteredItems = [];
  bool _isLoading = false;

  String? _currentUser;
  String? get currentUser => _currentUser;

  List<PatientRegistration> get filteredItems => _filteredItems;

  bool get isLoading => _isLoading;

  Future<void> loadRegisteredPatients() async {
    try {
      _isLoading = true;
      _registeredPatients = await IsarDbService.isarDbService.getPatientsList();
      _filteredItems = _registeredPatients;
      updateCraStatus();
    } catch (e) {
      _registeredPatients = [];
      _filteredItems = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  updateCraStatus() {
    _registeredPatients.forEach((patient) {
      String patientId = patient.patientId;
      checkCraStatus(patientId);
    });
  }

  checkCraStatus(String patientId) async {
    PatientRegistration patientDetails = _registeredPatients.firstWhere(
      (element) => element.patientId == patientId,
      orElse: () => PatientRegistration(),
    );
    if (patientDetails.isCompleted) {
      return;
    }
    bool isCompleted = false;
    CRAOfflineData? craData = await IsarDbService.isarDbService.getCRAData(patientId);
    if (craData != null) {
      List<String?>? sections = craData.craSectionData?.map((e) => e.encounterCategoryMapId).toList();
      if (sections != null && sections.isNotEmpty && sections.last == "community_risk_assessment_verification_form") {
        isCompleted = true;
      }
    }
    if (patientDetails.isCompleted != isCompleted) {
      int regPatientIndex = _registeredPatients.indexWhere((element) => element.patientId == patientId);
      int filterPatientIndex = _filteredItems.indexWhere((element) => element.patientId == patientId);
      _filteredItems[filterPatientIndex].isCompleted = isCompleted;
      _registeredPatients[regPatientIndex].isCompleted = isCompleted;
      notifyListeners();
    }
  }

  void searchPatient(String name) {
    _filteredItems = _registeredPatients.where((element) {
      return "${element.firstName} ${element.lastName}".toLowerCase().contains(name.toLowerCase());
    }).toList();
    notifyListeners();
  }

  setCurrentUser(String firstName, String lastName) {
    _currentUser = "$firstName $lastName";
    notifyListeners();
  }
}
