import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:xml/xml.dart';

/// Parsing incoming xml into a questionObj that can be further used to
/// decide what kind of widget we're going to display
getXmlWidget(questionsList) {
  Map<String, dynamic> questionObj = {};
  for (var element in questionsList) {
    List<String> optionList = [];

    List<dynamic> score = [];
    List<String> details = [];
    List<String> optionKeys = [];
    final xmlDocument = XmlDocument.parse(element[AppConstant.VALUE]);
    var field = xmlDocument.findAllElements(AppConstant.FIELD);

    if (field.first.findElements(AppConstant.TYPE).single.text == AppConstant.SINGLE_MULTI_MULTI_CHIP_OPTIONS) {
      return singleMultiMultiChipOptionMapObject(field.first);
    }

    for (var element in field) {
      questionObj.addAll({
        "questionId":
        element.findElements("questionid").single.text.toString().trim()
      });
      questionObj.addAll({
        AppConstant.QUESTION: element.findElements(AppConstant.QUESTION).single.text.toString().trim()
      });
      questionObj.addAll(
          {AppConstant.TYPE: element.findElements(AppConstant.TYPE).single.text.toString().trim()});

      element.findElements(AppConstant.OPTIONS).forEach((item) {
        item.findElements(AppConstant.OPTION).forEach((element) {
          optionList.add(element.text);
          score.add(element.attributes[0].value);
          optionKeys.add(element.attributes[0].value);
        });
      });
      questionObj.addAll({AppConstant.SUGGESTIONS: optionList});
      questionObj.addAll({AppConstant.DETAILS: details});
      questionObj.addAll({AppConstant.SCORE: score});
      questionObj.addAll({"optionKeys": optionKeys});
      Map<String, dynamic> inputs = {};


      //******************* CHIP_WITH_MULTISELECT_TEXTFORM FOLLOWUP PARSING */
      if (questionObj[AppConstant.TYPE] == AppConstant.CHIP_WITH_MULTISELECT_TEXTFORM ||
          questionObj[AppConstant.TYPE] == AppConstant.CHIP_WITH_SINGLE_SELECT_CHIP) {
        // main question will have only one `inputs`
        // so its safe to use first
        element.findElements("inputs").first.children.forEach((inputNode) {
          String forOptionKey =
              inputNode.findElements("for_option_key").first.text;
          if (inputs[forOptionKey] == null) inputs[forOptionKey] = [];

          List<String> optionList = [];
          List<String> optionKeys = [];

          // parsing follow-up options
          inputNode.findElements(AppConstant.OPTIONS).forEach((options) {
            options.findElements(AppConstant.OPTION).forEach((element) {
              optionList.add(element.text);
              optionKeys.add(element.attributes.first.value);
            });
          });

          // check if follow-up has more follow-ups
          // NOTE: only Single text input type follow-ups are supported
          Map<String, dynamic> inputsMap = {};
          inputNode.findElements(AppConstant.INPUTS).forEach((followUpInputNode) {
            followUpInputNode.findElements(AppConstant.INPUT).forEach((element) {
              String forOptionKey =
                  element.findElements("for_option_key").first.text;
              if (inputsMap[forOptionKey] == null) inputsMap[forOptionKey] = [];

              inputsMap[forOptionKey].add({
                "questionId": element.attributes.first.value,
                "question": element.findElements("label").first.text,
              });
            });
          });

          // Adding follow-up objects
          inputs[forOptionKey].add({
            "questionId": inputNode.attributes.first.value,
            "question": inputNode.findElements("question").first.text,
            "type": inputNode.findElements("type").first.text,
            "suggestions": optionList,
            "optionKeys": optionKeys,
            "inputs": inputsMap,
            "selectedOptionKeys": [],
            "selectedOptions": [],
            "hasFollowUp": inputsMap.isNotEmpty,
          });
        });
        questionObj.addAll({"inputs": inputs});
      } else if (element.findElements(AppConstant.TYPE).single.text.toString().trim() != AppConstant.SINGLE_TEXT_FIELD) {

        if (element.findElements("inputs").isNotEmpty) {
          final followUpElements =
          element.findElements("inputs").first.findAllElements("input");
          followUpElements.forEach((element) {
            String forAnswerKey =
                element.findElements('for_option_key').first.text;
            if (!inputs.containsKey(forAnswerKey)) {
              inputs[forAnswerKey] = [];
            }
            inputs[forAnswerKey].add({
              "questionId": element.attributes.first.value,
              "question": element.findElements('label').first.text,
              "chipType": questionObj["type"],
              "forAnswerKey": forAnswerKey,
            });
          });
        }
        questionObj.addAll({"inputs": inputs});
      } else {
        questionObj.addAll({"inputs": inputs});
      }
    }
  }
  return questionObj;
}

Future<Map<String, dynamic>> singleMultiMultiChipOptionMapObject(
    XmlElement elements) async {
  Map<String, dynamic> obj = {};
  try {
    if (elements.findElements("type").isNotEmpty) {
      obj["questionId"] =
          elements.findElements("questionid").single.text.toString().trim();
      obj[AppConstant.QUESTION] = elements.findElements(AppConstant.QUESTION).single.text.toString().trim();
      obj[AppConstant.TYPE] = elements.findElements(AppConstant.TYPE).single.text.toString().trim();

      List<String> optionList = [];
      List<dynamic> score = [];
      List<String> details = [];
      List<String> optionKeys = [];

      elements.findElements(AppConstant.OPTIONS).forEach((item) {
        item.findElements(AppConstant.OPTION).forEach((element) {
          optionList.add(element.text);
          score.add(element.attributes[0].value);
          optionKeys.add(element.attributes[0].value);
        });
      });

      obj.addAll({AppConstant.SUGGESTIONS: optionList});
      obj.addAll({AppConstant.DETAILS: details});
      obj.addAll({AppConstant.SCORE: score});
      obj.addAll({"optionKeys": optionKeys});

      Map<String, dynamic> inputs = {};
      if (elements.findElements("inputs").isNotEmpty) {
        String inputKey = "";
        List<Map<String, dynamic>> inputMap = [];
        for (var input
        in elements.findElements("inputs").first.findElements('input')) {
          inputKey = input.findElements("for_option_key").first.text;

          Map<String, dynamic> innerResponse =
          await singleMultiMultiChipOptionMapObject(input);
          inputMap.add({inputKey: innerResponse});
        }

        Map<String, dynamic> temp = {};
        for (int i = 0; i < inputMap.length; i++) {
          Map<String, dynamic> imap = inputMap[i];
          if (temp.containsKey(imap.keys.first)) {
            temp[imap.keys.first].add(imap.values.first);
          } else {
            temp[imap.keys.first] = [imap.values.first];
          }
        }
        inputs = temp;
      }
      obj["inputs"] = inputs;
      obj["selectedOptionKeys"] = [];
      obj["selectedOptions"] = [];
      obj["hasFollowUp"] = inputs.isNotEmpty;
      obj["isSubmitted"] = false;
    } else {
      obj[AppConstant.QUESTION] = elements.findElements("label").first.text;
      obj["questionId"] = elements.attributes.first.value;
    }
  } catch (error, stackTrace) {
    CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
  }

  return obj;
}