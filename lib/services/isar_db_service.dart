import 'package:isar/isar.dart';
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

  Future<void> saveCRA(CRAOfflineData craData) async {
    Isar? db = await isar;
    await db.writeTxn(() async {
      await db.cRAOfflineDatas.put(craData);
    });
  }

  Future<void> saveRiskAssessmentQuestionnaire(RiskAssessmentQuestionaire riskAssessmentQuestionnaire) async {
    Isar? db = await isar;
    await db.writeTxn(() async {
      await db.riskAssessmentQuestionaires.put(riskAssessmentQuestionnaire);
    });
  }

  Future<RiskAssessmentQuestionaire?> getRiskAssessmentQuestionaireById() async {
    Isar? db = await isar;
    final riskAssessmentQuestionnaire = await db.riskAssessmentQuestionaires.where().findFirst();
    return riskAssessmentQuestionnaire;
  }

  Future<RiskAssessmentQuestionaire?> getRiskAssessmentQuestionnaireBySectionName(String sectionName) async {
    Isar? db = await isar;
    final riskAssessmentQuestionnaire = await db.riskAssessmentQuestionaires.filter().sectionsElement((q) => q.sectionNameEqualTo(sectionName)).findFirst();
    return riskAssessmentQuestionnaire;
  }

  Future<RiskAssessmentQuestionaire?> updateRiskAssessmentQuestionnaire(String locale,RiskAssessmentQuestionaire riskAssessmentQuestionnaire) async {
    Isar? db = await isar;
    final response = await db.riskAssessmentQuestionaires.filter().localeEqualTo(locale).findFirst();
    if (response != null) {
      await db.writeTxn(() async {
        await db.riskAssessmentQuestionaires.put(riskAssessmentQuestionnaire);
      });
      return riskAssessmentQuestionnaire;
    } else {
      return null;
    }
  }

  Future<RiskAssessmentQuestionaire?> getRAQuestionnaireByLocale(String locale) async {
    Isar? db = await isar;
    final riskAssessmentQuestionnaire = await db.riskAssessmentQuestionaires.filter().localeEqualTo(locale).findFirst();
    return riskAssessmentQuestionnaire;
  }
}

