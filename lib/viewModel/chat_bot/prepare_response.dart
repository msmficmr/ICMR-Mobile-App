import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';

void prepareResponse(
    {required ConversationModel conversationModel,
      required String currentVersionNumber,
      required BuildContext context}) {
  final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
  if (conversationModel.chipType == AppConstant.TEXT_AREA) {
    return;
  }

  if (conversationModel.chipType == AppConstant.SINGLE_MULTI_MULTI_CHIP_OPTIONS) {
    Map<String, dynamic> value = {};
    String mainSelectedKey = conversationModel.optionKeys[conversationModel.selectedOptionIndex!];
    value["answer"] = mainSelectedKey;

    Map<String, dynamic> furtherInformation = {};

    if (conversationModel.followupQuestions.containsKey(mainSelectedKey)) {
      var subMap = conversationModel.followupQuestions[mainSelectedKey][0];
      for (String key in subMap["selectedOptionKeys"]) {
        var tempMap = subMap["inputs"][key][0];
        List<Map<String, dynamic>> inputs = [];

        for (int i = 0; i < tempMap["selectedOptionKeys"].length; i++) {
          String selectedOptionKey = tempMap["selectedOptionKeys"][i];

          Map<String, dynamic> inputMap = {};
          inputMap["value"] = tempMap["selectedOptionKeys"][i];

          if (tempMap["inputs"].containsKey(selectedOptionKey)) {
            List<Map<String, dynamic>> subInputArray = [];
            for (var subInput in tempMap["inputs"][selectedOptionKey]) {
              subInputArray.add({"questionid": subInput["questionId"], "value": subInput["answer"]});
            }
            inputMap["additionalInfo"] = subInputArray;
          } else {
            inputMap["additionalInfo"] = [];
          }
          inputs.add(inputMap);
        }
        furtherInformation[key] = {"inputs": inputs};
      }
    }

    value["furtherInformation"] = furtherInformation;

    var response = {
      "versionNumber": currentVersionNumber,
      "questionid": conversationModel.questionId,
      "value": value,
      "snomed": "",
      "inputs": "[]",
      "loinc": "",
      "timeAsked": conversationModel.timeAsked.toString(),
    };
    chatBotProvider.setConversationToSend(response: response);
    return;
  }

  List<dynamic> followupData = [];
  if (conversationModel.hasFollowUp) {
    if (conversationModel.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_WITH_AUTOSUGGEST ||
        conversationModel.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_WITH_MULTI_INPUT ||
        conversationModel.chipType == AppConstant.CHIP_OPTIONS_WITH_TEXTFORM ||
        conversationModel.chipType == AppConstant.CHIP_OPTIONS_WITH_AUTOSUGGEST ||
        conversationModel.chipType == AppConstant.CHIP_OPTIONS_WITH_MULTI_INPUT) {
      conversationModel.followupQuestions.forEach((optionKey, value) {
        for (dynamic questionData in value) {
          var followupQuestionData = {
            "inputid": questionData["questionId"],
            "value": questionData["answer"],
            "snomed": "",
            "loinc": ""
          };
          followupData.add(followupQuestionData);
        }
      });
    } else if (conversationModel.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_TEXTFORM) {
      conversationModel.followupQuestions.forEach((optionKey, value) {
        final List<String> options = conversationModel.optionKeys;
        final String ans = options[conversationModel.selectedOptionIndex!];
        if (optionKey == ans) {
          for (dynamic questionData in value) {
            var followupQuestionData = {
              "inputid": questionData["questionId"],
              "value": questionData["answer"],
              "snomed": "",
              "loinc": ""
            };
            followupData.add(followupQuestionData);
          }
        }
      });
    } else if (conversationModel.chipType == AppConstant.CHIP_WITH_MULTISELECT_TEXTFORM) {
      if (conversationModel.followUpSubmitted) {
        conversationModel.followupQuestions.forEach((optionKey, value) {
          final List<String> options = conversationModel.optionKeys;
          final String ans = options[conversationModel.selectedOptionIndex!];
          if (optionKey == ans) {
            for (dynamic questionData in value) {
              var followupQuestionData = {
                "inputid": questionData["questionId"],
                "value": (questionData["selectedOptionKeys"] as List).join(","),
                "inputs": [
                  {
                    "inputid": questionData["inputs"]["other_cancer"][0]["questionId"],
                    "value": questionData["inputs"]["other_cancer"][0]["answer"],
                  }
                ],
              };
              followupData.add(followupQuestionData);
            }
          }
        });
      }
    } else if (conversationModel.chipType == AppConstant.CHIP_WITH_SINGLE_SELECT_CHIP) {
      if (conversationModel.followUpSubmitted) {
        conversationModel.followupQuestions.forEach((optionKey, value) {
          if (optionKey == conversationModel.answer) {
            for (dynamic questionData in value) {
              var followupQuestionData = {
                "inputid": questionData["questionId"],
                "value": questionData["answer"],
              };
              followupData.add(followupQuestionData);
            }
          }
        });
      }
    }
  }

  if (chatBotProvider.serviceFlow == ServiceFlow.riskAssessment) {
    Map<String, dynamic> response = {};
    if (conversationModel.chipType == AppConstant.SINGLE_TEXT_FIELD) {
      response = {
        "versionNumber": currentVersionNumber,
        "questionid": conversationModel.questionId,
        "value": conversationModel.answer,
        "snomed": "",
        "loinc": "",
        "inputs": jsonEncode(followupData).toString(),
        "timeAsked": conversationModel.timeAsked.toString(),
      };
    } else {
      response = {
        "versionNumber": currentVersionNumber,
        "questionid": conversationModel.questionId,
        "value": conversationModel.optionKeys[conversationModel.selectedOptionIndex!],
        "snomed": "",
        "loinc": "",
        "inputs": jsonEncode(followupData).toString(),
        "timeAsked": conversationModel.timeAsked.toString(),
      };
    }
    chatBotProvider.setConversationToSend(response: response);
  }
}
