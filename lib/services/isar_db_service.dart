import 'package:isar/isar.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:path_provider/path_provider.dart';

class IsarDbService {
  late Future<Isar> isar;

  IsarDbService._() {
    isar = openIsarDb();
  }
  static Future<Isar> openIsarDb() async {
    final dir = await getApplicationSupportDirectory();
    return Isar.open([PatientRegistrationSchema, RiskAssessmentQuestionaireSchema], directory: dir.path);
  }

  static IsarDbService isarDbService = IsarDbService._();

  Future<void> savePatient(PatientRegistration patientRegistration) async {
    Isar? db = await isar;
    await db.writeTxn(() async {
      await db.patientRegistrations.put(patientRegistration);
    });
  }
    Future<List<PatientRegistration?>> getRegisteredPatientList() async {
    Isar? db = await isar;
    final registeredPatientList = await db.patientRegistrations.where().findAll();
    return registeredPatientList;
  }

  Future<void> saveRiskAssessmentQuestionaire(RiskAssessmentQuestionaire riskAssessmentQuestionaire) async {
    Isar? db = await isar;
    await db.writeTxn(() async {
      await db.riskAssessmentQuestionaires.put(riskAssessmentQuestionaire);
    });
  }

  Future<RiskAssessmentQuestionaire?> getRiskAssessmentQuestionaireById() async {
    Isar? db = await isar;
    final riskAssessmentQuestionaire = await db.riskAssessmentQuestionaires.where().findFirst();
    return riskAssessmentQuestionaire;
  }

  Future<RiskAssessmentQuestionaire?> getRiskAssessmentQuestionaireBySectionName(String sectionName) async {
    Isar? db = await isar;
    final riskAssessmentQuestionaire = await db.riskAssessmentQuestionaires.filter().sectionsElement((q) => q.sectionNameEqualTo(sectionName)).findFirst();
    return riskAssessmentQuestionaire;
  }

  Future<RiskAssessmentQuestionaire?> updateRiskAssessmentQuestionaire(String locale,RiskAssessmentQuestionaire riskAssessmentQuestionaire) async {
    Isar? db = await isar;
    final response = await db.riskAssessmentQuestionaires.filter().localeEqualTo(locale).findFirst();
    if (response != null) {
      await db.writeTxn(() async {
        await db.riskAssessmentQuestionaires.put(riskAssessmentQuestionaire);
      });
      return riskAssessmentQuestionaire;
    } else {
      return null;
    }
  }

  Future<RiskAssessmentQuestionaire?> getRAQuestionaireByLocale(String locale) async {
    Isar? db = await isar;
    final riskAssessmentQuestionaire = await db.riskAssessmentQuestionaires.filter().localeEqualTo(locale).findFirst();
    return riskAssessmentQuestionaire;
  }
}

