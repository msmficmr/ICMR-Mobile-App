import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:mhealth/isar_db_schema/attachment_db_schema.dart';

part 'questionnaire_db_schema.g.dart';

@collection
class CRAOfflineData {
  Id? id;
  String? patientId;
  String? caseId;
  String? languageCode;
  List<DoctorModel>? docDetails;
  List<CRASectionModel>? craSectionData;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'caseId': caseId,
      'languageCode': languageCode,
      'docDetails': docDetails == null
          ? []
          : List<dynamic>.from((docDetails ?? []).map(
              (e) => e.toJson(),
            )),
      'craSectionModel': List<dynamic>.from((craSectionData ?? []).map(
        (e) => e.toJson(),
      ))
    };
  }
}

@embedded
class DoctorModel {
  String? id;
  String? name;
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
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
  EHRDiagnosisReports? encounterEhrDiagnosisReports;
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
      'encounterEhrDiagnosisReports': encounterEhrDiagnosisReports?.toJson(),
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
      'questions': List<dynamic>.from((questions ?? []).map(
        (e) => e.toJson(),
      ))
    };
  }
}

@embedded
class EHRDiagnosisReports {
  List<Report>? questions;

  Map<String, dynamic> toJson() {
    return {
      'questions': List<dynamic>.from((questions ?? []).map(
        (e) => e.toJson(),
      ))
    };
  }
}

@embedded
class Report {
  String? questionId;
  String? snomed;
  String? loinc;
  List<Inputs>? inputs;
  AttachmentDb? file;
  String? value;
  DateTime? timeAsked;

  toJson() {
    return {
      "questionId": questionId,
      "snomed": snomed,
      "lonic": loinc,
      "inputs": [],
      "file": file,
      "value": value,
      "timeAsked": timeAsked?.toIso8601String(),
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
      "questionId": questionId,
      "value": value,
      "inputs": List<dynamic>.from((inputs ?? []).map(
        (e) => e.toJson(),
      )),
      "timeAsked": timeAsked?.toIso8601String(),
      "snomed": snomed,
      "lonic": lonic
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

  fromJson(Map<String, dynamic> json) {
    inputId = json["questionid"] ?? json["inputid"];
    value = json["value"];
    snomed = json["snomed"];
    loinc = json["loinc"];
    timeAsked = json["timeAsked"] == null ? null : DateTime.parse(json["timeAsked"]);
  }

  toJson() {
    return {"inputId": inputId, "value": value, "timeAsked": timeAsked?.toIso8601String(), "snomed": snomed, "loinc": loinc, "inputs": subInput};
  }
}

@embedded
class SubInput {
  String? inputId;
  String? value;
  String? snomed;
  String? loinc;

  fromJson(Map<String, dynamic> json) {
    inputId = json["questionid"] ?? json["inputid"];
    value = json["value"];
    snomed = json["snomed"];
    loinc = json["loinc"];
  }

  toJson() {
    return {"inputId": inputId, "value": value, "snomed": snomed, "loinc": loinc};
  }
}
