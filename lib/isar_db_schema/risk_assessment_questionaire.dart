import 'package:isar/isar.dart';

part 'risk_assessment_questionaire.g.dart';

@collection
class RiskAssessmentQuestionaire {
  Id? id;
  String? locale;
  List<QuestionnairesModel>? sections;
}

@embedded
class QuestionnairesModel {
  String? sectionName;
  String? uiTemplateId;
  String? templateName;
  String? versionNumber;
  String? firstQuestionId;
  List<QuestionObj>? questionObj;
}

@embedded
class QuestionObj {
  String? type;
  String? questionId;
  String? questionText;
  String? requiredValue;
  String? validationMessage;
  String? regex;
  String? hintText;
  int? minvalidator;
  int? maxValidator;
  String? filter;
  List<Option>? options;
  String? placeholder;
  List<Followup>? followup;
  String? prevQuestionId;
  String? nextQuestionId;
  bool? lastQuestion;

  toJson() {
    return {
      "options": (options ?? []).map((Option e) => e.toJson()),
      "followup": (followup ?? []).map((Followup e) => e.toJson()),
    };
  }
}

@embedded
class Followup {
  String? inputId;
  String? inputText;
  String? requiredValue;
  List<Option>? options;
  String? regex;
  String? minValidator;
  String? maxValidator;
  String? type;
  List<Followup>? followup;
  String? forOptionKey;
  String? placeholder;
  String? rangeValidator;
  toJson() {
    return {
      "inputText": inputText,
      "followup": (followup ?? []).map((Followup e) => e.toJson()),
    };
  }
}

@embedded
class Option {
  String? id;
  String? displayText;

  Option toObject(Map<String, dynamic> json) {
    Option obj = Option();
    obj.id = json["id"];
    obj.displayText = json["displayText"];

    return obj;
  }

  toJson() {
    return {"id": id, "displayText": displayText};
  }
}
