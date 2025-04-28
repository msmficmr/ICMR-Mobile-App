class StaticQuestionnaireModel {
  String? ehrCategoryMap;
  List<StaticQuestionModel>? questionnaireList;

  StaticQuestionnaireModel(this.ehrCategoryMap, this.questionnaireList);

  Map<String, dynamic> toJson() => {'ehrCategoryMapId': ehrCategoryMap, 'ehrNotes': (questionnaireList ?? []).map((StaticQuestionModel e) => e.toJson())};
}

class StaticQuestionModel {
  String? questionid;
  String? value;
  List<String>? inputs;
  String? versionNumber;
  DateTime timeAsked;
  String? snomed;
  String? loinc;

  StaticQuestionModel(this.questionid, this.value, this.inputs, this.versionNumber, this.timeAsked, this.snomed, this.loinc);

  Map<String, dynamic> toJson() => {
    'questionid' : questionid,
    'value' : value,
    'inputs' : inputs,
    'versionNumber' : versionNumber,
    'timeAsked' : timeAsked,
    'snomed' : snomed,
    'loinc' : loinc
  };
}
