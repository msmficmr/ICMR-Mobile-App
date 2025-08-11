import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/services/directory_db_service.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/views/questionair/viewmodel/question_view_model.dart';

class PatientListViewModel with ChangeNotifier {
  final TextEditingController searchFieldController = TextEditingController();
  List<PatientRegistration> _registeredPatients = [];
  List<PatientRegistration> _filteredItems = [];
  bool _isLoading = false;
  int _completedCRAcount = 0;
  bool _isLoadingCraCount = false;

  String? _currentUser;
  String? get currentUser => _currentUser;

  List<PatientRegistration> get registeredPatients => _registeredPatients;
  List<PatientRegistration> get filteredItems => _filteredItems;
  int get completedCRAcount => _completedCRAcount;
  bool get isLoadingCraCount => _isLoadingCraCount;

  bool get isLoading => _isLoading;

  set isLoadingCraCount(bool st) {
    _isLoadingCraCount = st;
    notifyListeners();
  }

  set completedCRAcount(int data) {
    _completedCRAcount = data;
    notifyListeners();
  }

  set isLoading(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  PatientRegistration? getPatientByPatientId(String patientId) {
    int index = registeredPatients.indexWhere(
      (element) => element.patientId == patientId,
    );
    if (index != -1) {
      return registeredPatients[index];
    }
    return null;
  }

  bindPatientScreen() {
    _filteredItems = _registeredPatients;
    updateCraStatus();
  }

  Future<void> loadRegisteredPatients() async {
    if (_registeredPatients.isNotEmpty) return;
    try {
      isLoading = true;
      _registeredPatients = await DirectoryDbService().getAllPatients();
      _filteredItems = _registeredPatients;
      updateCraStatus();
    } catch (e) {
      _registeredPatients = [];
      _filteredItems = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCompletedCRA() async {
    try {
      isLoadingCraCount = true;
      List<CRAOfflineData?> response = await IsarDbService.isarDbService.getListCRAOfflineData();

      ///logic to remove patients
      response = response.where(
        (element) {
          String? patientId = element?.patientId;
          return _registeredPatients.any(
            (element) => element.patientId == patientId,
          );
        },
      ).toList();

      completedCRAcount = response
          .where((element) =>
              element?.craSectionData?.any(
                (el) => el.encounterCategoryMapId == QuestionViewModel.sectionList.last.id,
              ) ??
              false)
          .length;
    } finally {
      isLoadingCraCount = false;
    }
  }

  Future<bool> registerPatient(PatientRegistration data) async {
    bool isSuccess = false;
    print(data.toJson());
    int index = _registeredPatients.indexWhere(
      (element) => element.primaryId == data.primaryId,
    );
    if (index == -1) {
      isSuccess = await DirectoryDbService().savePatient(data);
      if (isSuccess) {
        _registeredPatients.insert(0, data);
        searchPatient(searchFieldController.text);
        notifyListeners();
      }
    } else {
      CommonFunctions.toastMessage("Patient already registered");
    }
    return isSuccess;
  }

  markPatientAsSynced(String primaryId, bool increaseCount) async {
    int orgListIndex = _registeredPatients.indexWhere((element) => element.primaryId == primaryId);
    int filterIndex = _filteredItems.indexWhere((element) => element.primaryId == primaryId);
    if (orgListIndex != -1) {
      _registeredPatients[orgListIndex].isSynced = true;
      _registeredPatients[orgListIndex].visitCount = _registeredPatients[orgListIndex].visitCount + (increaseCount ? 1 : 0);
      _registeredPatients[orgListIndex].caseId = null;
    }
    if (filterIndex != -1) {
      _filteredItems[filterIndex].isSynced = true;
      _filteredItems[filterIndex].visitCount = _registeredPatients[orgListIndex].visitCount;

      _registeredPatients[orgListIndex].caseId = null;
    }
    await DirectoryDbService().markPatientSynced(_registeredPatients[orgListIndex]);
    notifyListeners();
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
    /* if (patientDetails.isCompleted) {
      return;
    } */
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
      return ("${element.firstName} ${element.lastName}".toLowerCase().contains(name.toLowerCase())) ||
          element.primaryId.contains(name.toUpperCase()) ||
          element.secondaryId.contains(name.toUpperCase());
    }).toList();
    notifyListeners();
  }

  setCurrentUser(String firstName, String lastName) {
    _currentUser = "$firstName $lastName";
    notifyListeners();
  }
}
