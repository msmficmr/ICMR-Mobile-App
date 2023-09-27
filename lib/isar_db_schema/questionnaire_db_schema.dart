import 'package:isar/isar.dart';

part 'questionnaire_db_schema.g.dart';

@collection
class CRAOfflineData {
  Id? id;
  String? patientId;
  String? caseId;
  String? languageCode;
  List<CRASectionModel>? craSectionData;

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'caseId': caseId,
      'languageCode': languageCode,
    'craSectionModel': List<dynamic>.from((craSectionData??[]).map((e) => e.toJson(),))
    };
  }
}

@embedded
class CRASectionModel {
  String? createdBy;
  DateTime createdTime = DateTime.now();
  String? caseId;
  String? patientId;
  String categoryStatus = "DRAFT";
  String? encounterEhrDiagnosisReports;
  String? encounterCategoryMapId;
  String? locale;
  EHRNotes? ehrNotes;

    Map<String, dynamic> toJson() {
    return {
      'createdBy': createdBy,
      'createdTime': createdTime.toIso8601String(),
      'caseId': caseId,
      'patientId': patientId,
      'categoryStatus': categoryStatus,
      'encounterEhrDiagnosisReports': encounterEhrDiagnosisReports,
      'encounterCategoryMapId': encounterCategoryMapId,
      'locale': locale,
      'ehrNotes': ehrNotes?.toJson(),
    };
  }
}

@embedded
class EHRNotes {
  String? versionNumber;
  List<CRAQuestionnaire>? questions;

    Map<String, dynamic> toJson() {
    return {
      'versionNumber': versionNumber,
      //'questions': questions?.map((question) => question.toJson()).toList(),
      'questions':  List<dynamic>.from((questions??[]).map((e) => e.toJson(),))
     // 'craSectionModel': List<dynamic>.from((craSectionData??[]).map((e) => e.toJson(),))
    };
  }
}

@embedded
class CRAQuestionnaire {
  String? questionId;
  String? value;
  List<Inputs>? inputs;
  DateTime? timeAsked;
  String? snomed;
  String? lonic;

  toJson() {
    return {
      "questionId" : questionId,
      "value" : value,
     // "inputs" : (inputs ?? []).map((Inputs e) => e.toJson()),
      "inputs" : List<dynamic>.from((inputs??[]).map((e) => e.toJson(),)),
     // 'craSectionModel': List<dynamic>.from((craSectionData??[]).map((e) => e.toJson(),))
      "timeAsked" : timeAsked?.toIso8601String(),
      "snomed" : snomed,
      "lonic" : lonic
    };
  }
}

@embedded
class Inputs {
  String? inputId;
  String? value;
  String? snomed;
  String? loinc;
  DateTime? timeAsked;
  SubInput? subInput;

  toJson() {
    return {
      "inputId" : inputId,
      "value" : value,
      "timeAsked" : timeAsked?.toIso8601String(),
      "snomed" : snomed,
      "loinc" : loinc,
      "inputs" : subInput
    };
  }
}

@embedded
class SubInput {
  String? inputId;
  String? value;
  String? snomed;
  String? loinc;

  toJson() {
    return {
      "inputId" : inputId,
      "value" : value,
      "snomed" : snomed,
      "loinc" : loinc
    };
  }
}