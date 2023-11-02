import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';

class QuestionnaireService {
  Future<RiskAssessmentQuestionaire?> loadQuestionnaireAsset(String locale) async {
    List<String> sectionPath = [...AppAssetsPath.questionnairesPath];
    try {
      for (int i = 0; i < sectionPath.length; i++) {
        String path = "assets/json/${locale}_${sectionPath[i]}";
        sectionPath[i] = path;
      }

      RiskAssessmentQuestionaire object = RiskAssessmentQuestionaire();
      List<QuestionnairesModel>? sections = [];
      for (int i = 0; i < sectionPath.length; i++) {
        String input = await rootBundle.loadString(sectionPath[i]);
        Map<String, dynamic> result = jsonDecode(input);

        sections.add(parseJson(result));
      }
      object.locale = locale;
      object.sections = sections;
      return sections.isEmpty ? null : object;
    } on FlutterError catch (e) {
      if (e.message.contains("Unable to load asset")) {
        String? language = AppConstant.languages.firstWhere((element) => element["locale"]==locale)["name"];
        CommonFunctions.toastMessage("questionnaire for ${language} is not available");
      } else {
        CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
      }
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    }
  }

  QuestionnairesModel parseJson(Map<String, dynamic> data) {
    QuestionnairesModel object = QuestionnairesModel();
    object.uiTemplateId = data["uiTemplateId"];
    object.sectionName = getSectionName(data["uiTemplateId"]);
    object.templateName = data["templateName"];
    object.versionNumber = data["versionNumber"];
    object.firstQuestionId = data["firstQuestionId"];

    Map<String, dynamic> fields = data["fields"];
    List<String> questionIds = fields.keys.toList();

    List<QuestionObj> questions = [];

    for (int i = 0; i < questionIds.length; i++) {
      String questionId = questionIds[i];
      Map<String, dynamic> object = fields[questionId];
      Map<String, dynamic> questionObject = object["questionObject"];

      QuestionObj questionObj = QuestionObj();
      questionObj.type = questionObject["type"];
      questionObj.questionId = questionObject["questionId"];
      questionObj.questionText = questionObject["questionText"];
      questionObj.requiredValue = questionObject["required"];
      questionObj.validationMessage = questionObject["validationMessage"];
      questionObj.regex = questionObject["regex"];
      questionObj.hintText = questionObject["hintText"];
      questionObj.minvalidator = questionObject["minvalidator"];
      questionObj.maxValidator = questionObject["maxValidator"];
      questionObj.filter = questionObject["filter"] == null ? null : jsonEncode(questionObject["filter"]);
      questionObj.placeholder = questionObject["placeholder"];
      questionObj.nextQuestionId = questionObject["nextQuestionId"];
      questionObj.prevQuestionId = questionObject["previousQuestionId"];
      questionObj.lastQuestion = questionObject["lastQuestion"];
      questionObj.options = questionObject["options"] == null ? null : ((questionObject["options"] ?? []) as List<dynamic>).map((e) => Option().toObject(e)).toList();
      questionObj.followup = questionObject["followup"] == null ? null : generateFollowUp(questionObject["followup"]);
      questions.add(questionObj);
    }

    object.questionObj = questions;

    return object;
  }

  String getSectionName(String fullTemplateId) {
    String commonPrefix = "risk_assessment_risk_assessment_";
    if (fullTemplateId.startsWith(commonPrefix)) {
      return fullTemplateId.substring(commonPrefix.length);
    }
    return fullTemplateId;
  }

  List<Followup> generateFollowUp(List<dynamic> followupList) {
    List<Followup> followUpQuestionList = [];
    if (followupList.isEmpty) {
      return followUpQuestionList;
    }

    for (int i = 0; i < followupList.length; i++) {
      Map<String, dynamic> followUpQuestionMap = followupList[i];
      followUpQuestionList.add(parseFollowupQuestion(followUpQuestionMap));
    }

    return followUpQuestionList;
  }

  Followup parseFollowupQuestion(Map<String, dynamic> input) {
    Followup question = Followup();

    question.inputId = input["inputId"];
    question.inputText = input["inputText"];
    question.requiredValue = input["required"];
    question.regex = input["regex"];
    question.minValidator = input["minValidator"];
    question.type = input["type"];
    question.forOptionKey = input["forOptionKey"];
    question.placeholder = input["placeholder"];
    question.rangeValidator = input["rangeValidator"];
    question.options = input["options"] == null ? null : ((input["options"] ?? []) as List<dynamic>).map((e) => Option().toObject(e)).toList();
    question.followup = input["followup"] == null ? null : generateFollowUp(input["followup"]);
    return question;
  }
}
