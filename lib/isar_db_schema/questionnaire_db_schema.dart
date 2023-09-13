import 'package:isar/isar.dart';

part 'questionnaire_db_schema.g.dart';

@collection
class CRAOfflineData {
  Id? id;
  String? patientId;
  String? caseId;
  String? languageCode;
  List<CRASectionModel>? craSectionData;
}

@embedded
class CRASectionModel {
  String? createdBy;
  DateTime createdTime = DateTime.now();
  String? caseId;
  String? patientId;
  String categoryStatus = "DRAFT";
  String? encounterEhrDiagnosisReports;
  String? ehrCategoryMapId;
  String? locale;
  EHRNotes? ehrNotes;
}

@embedded
class EHRNotes {
  String? versionNumber;
  List<CRAQuestionnaire>? questions;
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
      "inputs" : (inputs ?? []).map((Inputs e) => e.toJson()),
      "timeAsked" : timeAsked,
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
      "timeAsked" : timeAsked,
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