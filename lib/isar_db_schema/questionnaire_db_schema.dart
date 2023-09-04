import 'package:isar/isar.dart';

part 'questionnaire_db_schema.g.dart';

@collection
class CRAOfflineData {
  Id? id;
  String? patientId;
  String? caseId;
  String? versionNumber;
  String? languageCode;
  List<CRASectionModel>? craSectionData;
}

@embedded
class CRASectionModel {
  String? ehrCategoryMap;
  List<CRAQuestionnaire>? questionnaireList;
}

@embedded
class CRAQuestionnaire {
  String? questionId;
  String? value;
  List<Inputs>? inputs;
  String? versionNumber;
  DateTime? timeAsked;
  String? snomed;
  String? lonic;

  toJson() {
    return {
      "questionId" : questionId,
      "value" : value,
      "inputs" : (inputs ?? []).map((Inputs e) => e.toJson()),
      "versionNumber" : versionNumber,
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
  InputsBranch? inputsBranch;

  toJson() {
    return {
      "inputId" : inputId,
      "value" : value,
      "timeAsked" : timeAsked,
      "snomed" : snomed,
      "loinc" : loinc,
      "inputs" : inputsBranch
    };
  }
}

@embedded
class InputsBranch {
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