import 'dart:developer';

import 'package:mhealth/model/questionnaires_model.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/extensions/map_extension.dart';

Future<Map<String, dynamic>> generateFollowUpQuestionsMapObject({required Field field}) async {
  Map<String, dynamic> followupMap = {};
  List<Followup> followUpList = field.followup ?? [];
  followupMap.clear();

  try {
    List<Option> mainOptionsList = field.options!;
    List<String> mainOptionIdsList = [];
    for (var element in mainOptionsList) {
      mainOptionIdsList.add(element.id ?? "");
    }
    List<Map<String, dynamic>> followUpListMap = generateFollowUpJson(followUpList: followUpList);
    followupMap = formatFollowUpJson(mainOptionIdsList: mainOptionIdsList, followUpListMap: followUpListMap, sectionId: field.type) ?? {};
  } catch (error) {
    return followupMap;
  }
  return followupMap;
}

/// This [formatFollowUpJson] method generates follow Questions Map Object
/// in particular structure
Map<String, dynamic>? formatFollowUpJson({required List<String> mainOptionIdsList, required List<Map<String, dynamic>> followUpListMap, String? sectionId}) {
  try {
    Map<String, dynamic> inputs = {};
    for (var mainOptionID in mainOptionIdsList) {
      List<Map<String, dynamic>> mapList = [];
      for (var element in followUpListMap) {
        log("Line 34 ${element["forOptionKey"]}");
        if (mainOptionID == element["forOptionKey"]) {
          String optionId = mainOptionID;
          Map<String, String> optionsData = {};
          List<Map<String, dynamic>>? optionsList = [];

          if (element["options"] != null) {
            optionsList = (element["options"] as List)
                .map((e) => e as Map<String, dynamic>)
                .toList();
          }

          if (optionsList.isNotEmpty) {
            for (var followUpOptions in optionsList) {
              optionsData[followUpOptions["id"]] =
              followUpOptions["displayText"];
            }

            List<Map<String, dynamic>> nestedFollowUpListMap = [];
            if (element["inputs"] != null && element["inputs"].isNotEmpty) {
              nestedFollowUpListMap = (element["inputs"] as List)
                  .map((e) => e as Map<String, dynamic>)
                  .toList();

              /// Here we are calling [formatFollowUpJson] method again as recursively
              element["inputs"] = formatFollowUpJson(
                  mainOptionIdsList: optionsData.keys.toList(),
                  followUpListMap: nestedFollowUpListMap);
            }

            if (optionsData.keys.toList().isNotEmpty) {
              element["optionKeys"] = optionsData.keys.toList();
              element["suggestions"] = optionsData.values.toList();
            }
            element["selectedOptionKeys"] = [];
            element["selectedOptions"] = [];
            element["hasFollowUp"] =
            (element["inputs"] != null && element["inputs"].isNotEmpty)
                ? true
                : false;
            element["isSubmitted"] = false;
          }

          if (sectionId == AppConstant.SINGLE_CHOICE_TOGGLE_TEXTFORM) {
            element.updateKey(currentKey: "type", newKey: "chipType");
            element["chipType"] = AppConstant.SINGLE_CHOICE_TOGGLE_TEXTFORM;
            element["forAnswerKey"] = optionId;
          }

          mapList.add(element);
          inputs[optionId] = mapList;
        }
      }
    }
  } catch (error) {}
  return null;
}

/// This [generateFollowUpJson] method is used to generate new Map object
/// with updated keys
List<Map<String, dynamic>> generateFollowUpJson(
    {List<Followup>? followUpList}) {
  List<Map<String, dynamic>> followUpListMap = [];

  try {
    if (followUpList != null && followUpList.isNotEmpty) {
      for (var element in followUpList) {
        Map<String, dynamic> nestedFollowUpQuestionObject = {};
        nestedFollowUpQuestionObject.clear();
        nestedFollowUpQuestionObject = element.toJson();
        nestedFollowUpQuestionObject.updateKey(currentKey: "inputId", newKey: "questionId");
        nestedFollowUpQuestionObject.updateKey(currentKey: "inputText", newKey: "question");

        if (nestedFollowUpQuestionObject.containsKey("followup")) {
          nestedFollowUpQuestionObject.updateKey(currentKey: "followup", newKey: "inputs");
        }

        if (nestedFollowUpQuestionObject["inputs"] != null &&
            nestedFollowUpQuestionObject["inputs"].isNotEmpty) {
          List<Map<String, dynamic>> nestedMap2 = [];
          nestedMap2 = (nestedFollowUpQuestionObject["inputs"] as List).map((e) => e as Map<String, dynamic>).toList();
          nestedFollowUpQuestionObject["inputs"] = generateFollowUpNestedJson(nestedMap: nestedMap2);
        }
        followUpListMap.add(nestedFollowUpQuestionObject);
      }
    }
  } catch (error) {
    return followUpListMap;
  }
  return followUpListMap;
}

/// This [generateFollowUpNestedJson] method is used to generate new Map object
/// with updated keys
List<Map<String, dynamic>> generateFollowUpNestedJson(
    {List<Map<String, dynamic>>? nestedMap}) {
  List<Map<String, dynamic>> followUpNestedListMap = [];
  try {
    if (nestedMap != null && nestedMap.isNotEmpty) {
      for (var nestedFollowUpQuestionObject in nestedMap) {
        nestedFollowUpQuestionObject.updateKey(currentKey: "inputId", newKey: "questionId");
        nestedFollowUpQuestionObject.updateKey(currentKey: "inputText", newKey: "question");

        if (nestedFollowUpQuestionObject.containsKey("followup")) {
          nestedFollowUpQuestionObject.updateKey(currentKey: "followup", newKey: "inputs");
        }

        if (nestedFollowUpQuestionObject["inputs"] != null && nestedFollowUpQuestionObject["inputs"].isNotEmpty) {
          List<Map<String, dynamic>> nestedMap2 =
          (nestedFollowUpQuestionObject["inputs"] as List).map((e) => e as Map<String, dynamic>).toList();
          nestedFollowUpQuestionObject["inputs"] = generateFollowUpNestedJson(nestedMap: nestedMap2);
        }
        followUpNestedListMap.add(nestedFollowUpQuestionObject);
      }
    }
    return followUpNestedListMap;
  } catch (error) {
    return followUpNestedListMap;
  }
}