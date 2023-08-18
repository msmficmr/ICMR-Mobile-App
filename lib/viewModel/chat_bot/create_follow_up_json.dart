import 'dart:developer';
import 'package:mhealth/model/questionnaires_model.dart';
import 'package:mhealth/utils/extensions/map_extension.dart';

const CHIP_OPTIONS = 'CHIP_OPTIONS';
const SINGLE_CHOICE_TOGGLE = "SINGLE_CHOICE_TOGGLE";
const SINGLE_CHOICE_TOGGLE_TEXTFORM = "SINGLE_CHOICE_TOGGLE_TEXTFORM";
const SINGLE_CHOICE_TOGGLE_WITH_MULTI_INPUT = "SINGLE_CHOICE_TOGGLE_WITH_MULTI_INPUT";
const SINGLE_CHOICE_TOGGLE_WITH_AUTOSUGGEST = "SINGLE_CHOICE_TOGGLE_WITH_AUTOSUGGEST";
const CHIP_OPTIONS_WITH_TEXTFORM = "CHIP_OPTIONS_WITH_TEXTFORM";
const CHIP_OPTIONS_WITH_MULTI_INPUT = "CHIP_OPTIONS_WITH_MULTI_INPUT";
const CHIP_OPTIONS_WITH_AUTOSUGGEST = "CHIP_OPTIONS_WITH_AUTOSUGGEST";
const CHIP_OPTIONS_WITH_CONDITIONAL = "CHIP_OPTIONS_WITH_CONDITIONAL";
const SINGLE_TEXT_FIELD = "SINGLE_TEXT_FIELD";
const String TEXT_AREA = "TEXT_AREA";
const String BMI = "BMI";
const CHIP_WITH_MULTISELECT_TEXTFORM = "CHIP_WITH_MULTISELECT_TEXTFORM";
const String CHIP_WITH_SINGLE_SELECT_CHIP = "CHIP_WITH_SINGLE_SELECT_CHIP";
const SINGLE_MULTI_MULTI_CHIP_OPTIONS = "SINGLE_MULTI_MULTI_CHIP_OPTIONS";

Map<String, dynamic> generateFollowUpQuestionsMapObject({required Field field}) {
  Map<String, dynamic> followupMap = {};
  List<Followup> followUpList = field.followup ?? [];
  followupMap.clear();

  if (field.type == BMI) {
    try {
      followupMap[""] = generateFollowUpJson(followUpList: followUpList);
      return followupMap;
    } catch (error, stackTrace) {
      log("BMI Widget Error: $error");
      log("BMI Widget stackTrace: $stackTrace");
      return followupMap;
    }
  } else if (field.type == CHIP_WITH_SINGLE_SELECT_CHIP ||
      field.type == SINGLE_CHOICE_TOGGLE_TEXTFORM ||
      field.type == SINGLE_MULTI_MULTI_CHIP_OPTIONS ||
      field.type == CHIP_WITH_MULTISELECT_TEXTFORM) {
    try {
      List<Option> mainOptionsList = field.options!;
      List<String> mainOptionIdsList = [];
      mainOptionsList.forEach((element) {
        mainOptionIdsList.add(element.id ?? "");
      });
      List<Map<String, dynamic>> followUpListMap = generateFollowUpJson(followUpList: followUpList);

      followupMap = formatFollowUpJson(mainOptionIdsList: mainOptionIdsList, followUpListMap: followUpListMap, sectionId: field.type) ?? {};
    } catch (error, stackTrace) {
      log("${field.type} Widget Error: $error");
      log("${field.type} Widget stackTrace: $stackTrace");
      return followupMap;
    }
  }
  return followupMap;
}

/// This [formatFollowUpJson] method generates follow Questions Map Object
/// in particular structure

Map<String, dynamic>? formatFollowUpJson({
  required List<String> mainOptionIdsList,
  required List<Map<String, dynamic>> followUpListMap,
  String? sectionId,
}) {
  try {
    Map<String, dynamic> inputs = {};
    mainOptionIdsList.forEach((mainOptionID) {
      List<Map<String, dynamic>> mapList = [];
      followUpListMap.forEach((element) {
        if (mainOptionID == element["forOptionKey"]) {
          String optionId = mainOptionID;
          Map<String, String> optionsData = {};
          List<Map<String, dynamic>>? optionsList = [];

          if (element["options"] != null) {
            optionsList = (element["options"] as List).map((e) => e as Map<String, dynamic>).toList();
          }

          if (optionsList.isNotEmpty) {
            optionsList.forEach((followUpOptions) {
              optionsData[followUpOptions["id"]] = followUpOptions["displayText"];
            });

            List<Map<String, dynamic>> nestedFollowUpListMap = [];
            if (element["inputs"] != null && element["inputs"].isNotEmpty) {
              nestedFollowUpListMap = (element["inputs"] as List).map((e) => e as Map<String, dynamic>).toList();

              /// Here we are calling [formatFollowUpJson] method again as recursively
              element["inputs"] = formatFollowUpJson(mainOptionIdsList: optionsData.keys.toList(), followUpListMap: nestedFollowUpListMap);
            }

            if (optionsData.keys.toList().isNotEmpty) {
              element["optionKeys"] = optionsData.keys.toList();
              element["suggestions"] = optionsData.values.toList();
            }
            element["selectedOptionKeys"] = [];
            element["selectedOptions"] = [];
            element["hasFollowUp"] = (element["inputs"] != null && element["inputs"].isNotEmpty) ? true : false;
            element["isSubmitted"] = false;
          }

          if (sectionId == SINGLE_CHOICE_TOGGLE_TEXTFORM) {
            element.updateKey(currentKey: "type", newKey: "chipType");
            element["chipType"] = SINGLE_CHOICE_TOGGLE_TEXTFORM;
            element["forAnswerKey"] = optionId;
          }

          mapList.add(element);
          inputs[optionId] = mapList;
        }
      });
    });
    return inputs;
  } catch (error, stackTrace) {
    log("GenerateMainJson method error: $error");
    log("GenerateMainJson method stackTrace: $stackTrace");
  }
  return null;
}

/// This [generateFollowUpJson] method is used to generate new Map object
/// with updated keys
List<Map<String, dynamic>> generateFollowUpJson({List<Followup>? followUpList}) {
  List<Map<String, dynamic>> followUpListMap = [];

  try {
    if (followUpList != null && followUpList.isNotEmpty) {
      followUpList.forEach((element) {
        Map<String, dynamic> nestedFollowUpQuestionObject = {};
        nestedFollowUpQuestionObject.clear();
        nestedFollowUpQuestionObject = element.toJson();
        nestedFollowUpQuestionObject.updateKey(currentKey: "inputId", newKey: "questionId");
        nestedFollowUpQuestionObject.updateKey(currentKey: "inputText", newKey: "question");

        if (nestedFollowUpQuestionObject.containsKey("followup")) {
          nestedFollowUpQuestionObject.updateKey(currentKey: "followup", newKey: "inputs");
        }

        if (nestedFollowUpQuestionObject["inputs"] != null && nestedFollowUpQuestionObject["inputs"].isNotEmpty) {
          List<Map<String, dynamic>> nestedMap2 = [];
          nestedMap2 = (nestedFollowUpQuestionObject["inputs"] as List).map((e) => e as Map<String, dynamic>).toList();
          nestedFollowUpQuestionObject["inputs"] = generateFollowUpNestedJson(nestedMap: nestedMap2);
        }
        followUpListMap.add(nestedFollowUpQuestionObject);
      });
    }
  } catch (error, stackTrace) {
    log("Generate FollowUp Json Method Error: $error");
    log("Generate FollowUp Json Method stackTrace: $stackTrace");
    return followUpListMap;
  }
  return followUpListMap;
}

/// This [generateFollowUpNestedJson] method is used to generate new Map object
/// with updated keys
List<Map<String, dynamic>> generateFollowUpNestedJson({List<Map<String, dynamic>>? nestedMap}) {
  List<Map<String, dynamic>> followUpNestedListMap = [];
  try {
    if (nestedMap != null && nestedMap.isNotEmpty) {
      nestedMap.forEach((nestedFollowUpQuestionObject) {
        nestedFollowUpQuestionObject.updateKey(currentKey: "inputId", newKey: "questionId");
        nestedFollowUpQuestionObject.updateKey(currentKey: "inputText", newKey: "question");

        if (nestedFollowUpQuestionObject.containsKey("followup")) {
          nestedFollowUpQuestionObject.updateKey(currentKey: "followup", newKey: "inputs");
        }

        if (nestedFollowUpQuestionObject["inputs"] != null && nestedFollowUpQuestionObject["inputs"].isNotEmpty) {
          List<Map<String, dynamic>> nestedMap2 = (nestedFollowUpQuestionObject["inputs"] as List).map((e) => e as Map<String, dynamic>).toList();
          nestedFollowUpQuestionObject["inputs"] = generateFollowUpNestedJson(nestedMap: nestedMap2);
        }
        followUpNestedListMap.add(nestedFollowUpQuestionObject);
      });
    }
    return followUpNestedListMap;
  } catch (error, stackTrace) {
    log("Generate FollowUp NestedJson Method Error: $error");
    log("Generate FollowUp NestedJson Method stackTrace: $stackTrace");
    return followUpNestedListMap;
  }
}
