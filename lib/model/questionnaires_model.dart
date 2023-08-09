import 'dart:convert';

QuestionnairesModel questionnairesModelFromJson(
    String str) =>
    QuestionnairesModel.fromJson(json.decode(str));

String questionnairesModelToJson(
    QuestionnairesModel data) =>
    json.encode(data.toJson());

class QuestionnairesModel {
  QuestionnairesModel({
    this.uiTemplateId,
    this.templateName,
    this.versionNumber,
    this.jsonVersion,
    this.fields,
  });

  String? uiTemplateId;
  String? templateName;
  String? versionNumber;
  String? jsonVersion;
  List<Field>? fields;

  factory QuestionnairesModel.fromJson(
      Map<String, dynamic> json) =>
      QuestionnairesModel(
        uiTemplateId:
        json["uiTemplateId"] == null ? null : json["uiTemplateId"],
        templateName:
        json["templateName"] == null ? null : json["templateName"],
        versionNumber:
        json["versionNumber"] == null ? null : json["versionNumber"],
        jsonVersion: json["jsonVersion"] == null ? null : json["jsonVersion"],
        fields: json["fields"] == null
            ? null
            : List<Field>.from(
            json["fields"].map((val) => Field.fromJson(val))),
      );

  Map<String, dynamic> toJson() => {
    "uiTemplateId": uiTemplateId == null ? null : uiTemplateId,
    "templateName": templateName == null ? null : templateName,
    "versionNumber": versionNumber == null ? null : versionNumber,
    "jsonVersion": jsonVersion == null ? null : jsonVersion,
    "fields": fields == null
        ? null
        : List<dynamic>.from(fields!.map((val) => val.toJson())),
  };
}

class Field {
  Field({
    this.type,
    this.questionId,
    this.questionText,
    this.requiredValue,
    this.validationMessage,
    this.regex,
    this.hintText,
    this.minvalidator,
    this.maxValidator,
    this.filter,
    this.options,
    this.placeholder,
    this.followup,
    this.prevQuestionId,
    this.nextQuestionId,
  });

  String? type;
  String? questionId;
  String? questionText;
  String? requiredValue;
  String? validationMessage;
  dynamic regex;
  dynamic hintText;
  dynamic minvalidator;
  dynamic maxValidator;
  dynamic filter;
  List<Option>? options;
  dynamic placeholder;
  List<Followup>? followup;
  dynamic prevQuestionId;
  dynamic nextQuestionId;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    type: json["type"] == null ? null : json["type"],
    questionId: json["questionId"] == null ? null : json["questionId"],
    questionText:
    json["questionText"] == null ? null : json["questionText"],
    requiredValue: json["required"] == null ? null : json["required"],
    validationMessage: json["validationMessage"] == null
        ? null
        : json["validationMessage"],
    regex: json["regex"],
    hintText: json["hintText"],
    minvalidator: json["minvalidator"],
    maxValidator: json["maxValidator"],
    filter: json["filter"] == null ? null : json["filter"],
    options: json["options"] == null
        ? null
        : List<Option>.from(
        json["options"].map((val) => Option.fromJson(val))),
    placeholder: json["placeholder"],
    followup: json["followup"] == null
        ? null
        : List<Followup>.from(
        json["followup"].map((val) => Followup.fromJson(val))),
    prevQuestionId: json["prevQuestionId"],
    nextQuestionId: json["nextQuestionId"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "questionId": questionId == null ? null : questionId,
    "questionText": questionText == null ? null : questionText,
    "required": requiredValue == null ? null : requiredValue,
    "validationMessage": validationMessage,
    "regex": regex,
    "hintText": hintText,
    "minvalidator": minvalidator,
    "maxValidator": maxValidator,
    "filter": filter == null ? null : filter,
    "options": options == null
        ? null
        : List<dynamic>.from(options!.map((x) => x.toJson())),
    "placeholder": placeholder,
    "followup": followup == null
        ? null
        : List<dynamic>.from(followup!.map((x) => x.toJson())),
    "prevQuestionId": prevQuestionId,
    "nextQuestionId": nextQuestionId,
  };
}

class Followup {
  Followup({
    this.inputId,
    this.inputText,
    this.requiredValue,
    this.options,
    this.regex,
    this.minValidator,
    this.maxValidator,
    this.type,
    this.followup,
    this.forOptionKey,
    this.placeholder,
    this.rangeValidator,
  });

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

  factory Followup.fromJson(Map<String, dynamic> json) => Followup(
    inputId: json["inputId"] == null ? null : json["inputId"],
    inputText: json["inputText"] == null ? null : json["inputText"],
    requiredValue: json["required"] == null ? null : json["required"],
    options: json["options"] == null
        ? null
        : List<Option>.from(
        json["options"].map((val) => Option.fromJson(val))),
    regex: json["regex"] == null ? null : json["regex"],
    minValidator:
    json["minValidator"] == null ? null : json["minValidator"],
    maxValidator:
    json["maxValidator"] == null ? null : json["maxValidator"],
    type: json["type"] == null ? null : json["type"],
    followup: json["followup"] == null
        ? null
        : List<Followup>.from(
        json["followup"].map((val) => Followup.fromJson(val))),
    forOptionKey:
    json["forOptionKey"] == null ? null : json["forOptionKey"],
    placeholder: json["placeholder"] == null ? null : json["placeholder"],
    rangeValidator:
    json["rangeValidator"] == null ? null : json["rangeValidator"],
  );

  Map<String, dynamic> toJson() => {
    "inputId": inputId == null ? null : inputId,
    "inputText": inputText == null ? null : inputText,
    "required": requiredValue == null ? null : requiredValue,
    "options": options == null
        ? null
        : List<dynamic>.from(options!.map((val) => val.toJson())),
    "regex": regex == null ? null : regex,
    "minValidator": minValidator == null ? null : minValidator,
    "maxValidator": maxValidator == null ? null : maxValidator,
    "type": type == null ? null : type,
    "followup": followup == null
        ? null
        : List<dynamic>.from(followup!.map((val) => val.toJson())),
    "forOptionKey": forOptionKey == null ? null : forOptionKey,
    "placeholder": placeholder,
    "rangeValidator": rangeValidator,
  };
}

class Option {
  Option({
    this.id,
    this.displayText,
  });

  String? id;
  String? displayText;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"] == null ? null : json["id"],
    displayText: json["displayText"] == null ? null : json["displayText"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "displayText": displayText == null ? null : displayText,
  };
}
