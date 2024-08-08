import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/views/questionair/viewmodel/question_view_model.dart';

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
    if (patientDetails.id == null) {
      return;
    }
    if (patientDetails.isCompleted) {
      return;
    }
    String? caseId;
    bool isCompleted = false;
    int mySectionFilledCount = 0;
    CRAOfflineData? craData = await IsarDbService.isarDbService.getCRAData(patientId);
    if (craData != null) {
      caseId = craData.caseId;
      List<String?>? sections = craData.craSectionData?.map((e) => e.encounterCategoryMapId).toList();
      mySectionFilledCount = sections?.length ?? 0;
      if (sections != null && sections.isNotEmpty && sections.contains(QuestionViewModel.sectionList.last.id)) {
        isCompleted = true;
      }
    }
    int regPatientIndex = _registeredPatients.indexWhere((element) => element.patientId == patientId);
    int filterPatientIndex = _filteredItems.indexWhere((element) => element.patientId == patientId);

    _filteredItems[filterPatientIndex].caseId = caseId;
    _registeredPatients[filterPatientIndex].caseId = caseId;

    _filteredItems[filterPatientIndex].totalCompletedSections = mySectionFilledCount;
    _registeredPatients[filterPatientIndex].totalCompletedSections = mySectionFilledCount;

    if (patientDetails.isCompleted != isCompleted) {
      _filteredItems[filterPatientIndex].isCompleted = isCompleted;
      _registeredPatients[regPatientIndex].isCompleted = isCompleted;
    }
    notifyListeners();
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
