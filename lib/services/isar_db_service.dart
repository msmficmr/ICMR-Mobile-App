import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:mhealth/isar_db_schema/attachment_db_schema.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:path_provider/path_provider.dart';

class IsarDbService {
  late Future<Isar> isar;

  IsarDbService._() {
    isar = openIsarDb();
  }

  static Future<Isar> openIsarDb() async {
    final dir = await getApplicationSupportDirectory();
    return Isar.open([PatientRegistrationSchema, RiskAssessmentQuestionaireSchema, CRAOfflineDataSchema], directory: dir.path);
  }

  static IsarDbService isarDbService = IsarDbService._();

  Future<void> savePatient(PatientRegistration patientRegistration) async {
    Isar? db = await isar;
    await db.writeTxn(() async {
      await db.patientRegistrations.put(patientRegistration);
    });
  }

  Future<List<PatientRegistration>> getPatientsList() async {
    Isar? db = await isar;
    final registeredPatientList = await db.patientRegistrations.where().findAll();
    return registeredPatientList;
  }

  ///[COMMENTING CODE as this may need in future]
  // Future<void> updatePatientRegistration({required String patientId, required AttachmentDb attachment}) async {
  //   Isar? db = await isar;
  //   final patientToBeUpdated = await db.patientRegistrations.filter().patientIdEqualTo(patientId).findFirst();
  //   if (patientToBeUpdated != null) {
  //     patientToBeUpdated.consent = [attachment, ...?patientToBeUpdated.consent];
  //     await db.writeTxn(() async {
  //       db.patientRegistrations.put(patientToBeUpdated);
  //     });
  //   }
  // }

  Future<void> saveCRA(CRAOfflineData craData) async {
    Isar? db = await isar;

    await db.writeTxn(() async {
      await db.cRAOfflineDatas.put(craData);
    });
  }

  Future<void> updateCRA({required String caseId, required CRASectionModel craData, required List<DoctorModel> docDetails}) async {
    Isar? db = await isar;
    final questionnaire = await db.cRAOfflineDatas.filter().caseIdEqualTo(caseId).findFirst();
    if (questionnaire != null) {
      CRAOfflineData? questionnaireToBeUpdated = await db.cRAOfflineDatas.get(questionnaire.id ?? 0);

      questionnaireToBeUpdated?.docDetails = docDetails;

      List<CRASectionModel>? previousData = questionnaireToBeUpdated?.craSectionData ?? [];
      int index = previousData.indexWhere((element) => element.encounterCategoryMapId == craData.encounterCategoryMapId);
      if (index != -1) {
        previousData[index] = craData;
      } else {
        previousData = [...previousData, craData];
      }
      questionnaireToBeUpdated!.craSectionData = [...previousData];
      await db.writeTxn(() async {
        await db.cRAOfflineDatas.put(questionnaireToBeUpdated);
      });
    }
  }

  Future<bool> checkIfCRADataPresent(String caseId) async {
    Isar? db = await isar;
    final questionnaire = await db.cRAOfflineDatas.filter().caseIdEqualTo(caseId).findFirst();
    if (questionnaire != null) return true;
    return false;
  }

  Future<void> saveRiskAssessmentQuestionnaire(RiskAssessmentQuestionaire riskAssessmentQuestionnaire) async {
    Isar? db = await isar;
    await db.writeTxn(() async {
      await db.riskAssessmentQuestionaires.put(riskAssessmentQuestionnaire);
    });
  }

  Future<RiskAssessmentQuestionaire?> getRiskAssessmentQuestionnaireById() async {
    Isar? db = await isar;
    final riskAssessmentQuestionnaire = await db.riskAssessmentQuestionaires.where().findFirst();
    return riskAssessmentQuestionnaire;
  }

  Future<RiskAssessmentQuestionaire?> getRiskAssessmentQuestionnaireBySectionName(String sectionName) async {
    Isar? db = await isar;
    final riskAssessmentQuestionnaire = await db.riskAssessmentQuestionaires.filter().sectionsElement((q) => q.sectionNameEqualTo(sectionName)).findFirst();
    return riskAssessmentQuestionnaire;
  }

  Future<RiskAssessmentQuestionaire?> updateRiskAssessmentQuestionnaire(String locale, RiskAssessmentQuestionaire riskAssessmentQuestionnaire) async {
    Isar? db = await isar;
    final response = await db.riskAssessmentQuestionaires.filter().localeEqualTo(locale).findFirst();
    if (response == null) {
      await db.writeTxn(() async {
        await db.riskAssessmentQuestionaires.put(riskAssessmentQuestionnaire);
      });
      return riskAssessmentQuestionnaire;
    } else {
      return response;
    }
  }

  Future<RiskAssessmentQuestionaire?> getRAQuestionnaireByLocale(String locale) async {
    Isar? db = await isar;
    final riskAssessmentQuestionnaire = await db.riskAssessmentQuestionaires.filter().localeEqualTo(locale).findFirst();
    return riskAssessmentQuestionnaire;
  }

  Future<List<CRAOfflineData?>> getListCRAOfflineData() async {
    Isar? db = await isar;
    final craOfflineData = await db.cRAOfflineDatas.where().findAll();
    return craOfflineData;
  }

  Future<PatientRegistration?> getPatientDetails(String patientId) async {
    Isar? db = await isar;
    final patientData = await db.patientRegistrations.filter().patientIdEqualTo(patientId).findFirst();
    return patientData;
  }

  Future<void> deleteByPatientId(String? patientId) async {
    Isar? db = await isar;
    await db.writeTxn(() async {
      await db.patientRegistrations.filter().patientIdEqualTo(patientId!).deleteFirst();
    });
  }

  Future<void> markPatientAsSynced(String? patientId) async {
    Isar? db = await isar;
    await db.writeTxn(() async {
      PatientRegistration? registration = await db.patientRegistrations.filter().patientIdEqualTo(patientId!).findFirst();
      if (registration != null) {
        registration.isSynced = true;
        await db.patientRegistrations.put(registration);
      }
    });
  }

  Future<void> deleteByCaseId(String? caseId) async {
    Isar? db = await isar;
    await db.writeTxn(() async {
      await db.cRAOfflineDatas.filter().caseIdEqualTo(caseId).deleteFirst();
    });
  }

  Future<CRAOfflineData?> getCRAData(String patientId) async {
    Isar? db = await isar;
    final craData = await db.cRAOfflineDatas.filter().patientIdEqualTo(patientId).findFirst();
    return craData;
  }

  Future<RiskAssessmentQuestionaire?> getTemplate({required String local}) async {
    Isar? db = await isar;
    final filteredQuestionnaires = await db.riskAssessmentQuestionaires.filter().localeEqualTo(local).findFirst();
    return filteredQuestionnaires;
  }

  Future<CRAOfflineData?> getCRAByPatientAndCase(String patientId, String caseId) async {
    Isar? db = await isar;
    final craData = await db.cRAOfflineDatas.filter().patientIdEqualTo(patientId).caseIdEqualTo(caseId).findFirst();
    return craData;
  }
}
