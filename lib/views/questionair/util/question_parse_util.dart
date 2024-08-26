import 'dart:developer';

import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';

class QuestionParseUtil {
  List<Questionnaire> fetchDBQuestions(questionsList) {
    List<Questionnaire> questionnaires = [];

    for (var element in questionsList) {
      Questionnaire? questionnaire = _parseQuestionnaire(element);
      if (questionnaire != null) {
        questionnaires.add(questionnaire);
      }
    }
    return questionnaires;
  }

  Questionnaire? _parseQuestionnaire(element) {
    String chipType = element.type ?? "";
    if (chipType.isNotEmpty) {
      switch (chipType) {
        case AppConstant.CHIP_WITH_MULTISELECT_TEXTFORM:
        case AppConstant.CHIP_OPTIONS:
        case AppConstant.CHIP_WITH_SINGLE_SELECT_CHIP:
          return _parseSingleSelectionQuestionnaire(element);
        case AppConstant.MULTI_SELECT_TEXTFORM:
        case AppConstant.CHIP_OPTIONS_WITH_MULTI_SELECTION:
          return _parseMultiSelectionSubQuestionnaire(element);
        case AppConstant.SINGLE_MULTI_MULTI_CHIP_OPTIONS:
          return _parseSingleMultiMultiSelectionQuestionnaire(element);
        case AppConstant.TEXT_AREA:
          return _parseTextFormFieldQuestionnaire(element);
        case AppConstant.CHECKBOX:
          return _parseCheckBoxQuestionnaire(element);
      }
    } else if (element.type == null) {
      return _parseTextFieldQuestionnaire(element);
    }
    return null;
  }

  CheckboxQuestionnaire _parseCheckBoxQuestionnaire(QuestionObj element) {
    String questionId = element.questionId.toString();
    String question = element.questionText.toString();
    List<QuestionnaireOption> optionsList = [];
    List<Option> options = element.options ?? [];
    var inputField;
    List<Followup> followUps = element.followup ?? [];
    if (followUps.isNotEmpty) {
      for (var follow in followUps) {
        if (follow.inputId != null) {
          inputField = follow;
        }
      }
    }
    for (var option in options) {
      QuestionnaireOption questionnaireOption = _parseOptions(option, inputField);
      optionsList.add(questionnaireOption);
    }
    bool isRequired = false;
    String isRequiredField = element.requiredValue ?? "";
    if (isRequiredField.isNotEmpty && isRequiredField == "true") {
      isRequired = true;
    }

    CheckboxQuestionnaire checkBoxSubQuestionnaire = CheckboxQuestionnaire(
      selectedOptions: [],
      questionId: questionId,
      questionText: question,
      optionsList: optionsList,
      isRequired: isRequired,
      shouldShowError: false,
      versionNumber: "",
      timeAsked: DateTime.now().toString(),
    );
    return checkBoxSubQuestionnaire;
  }

  MultiSelectionSubQuestionnaire _parseMultiSelectionSubQuestionnaire(Followup element) {
    String questionId = element.inputId.toString();
    String question = element.inputText.toString();
    List<QuestionnaireOption> optionsList = [];
    List<Option> options = element.options ?? [];
    var inputField;
    List<Followup> followUps = element.followup ?? [];
    if (followUps.isNotEmpty) {
      for (var follow in followUps) {
        if (follow.inputId != null) {
          inputField = follow;
        }
      }
    }
    for (var option in options) {
      QuestionnaireOption questionnaireOption = _parseOptions(option, inputField);
      optionsList.add(questionnaireOption);
    }
    bool isRequired = false;
    String isRequiredField = element.requiredValue ?? "";
    if (isRequiredField.isNotEmpty) {
      isRequired = true;
    }

    MultiSelectionSubQuestionnaire multiSelectionSubQuestionnaire = MultiSelectionSubQuestionnaire(
      selectedOptions: [],
      questionId: questionId,
      questionText: question,
      optionsList: optionsList,
      isRequired: isRequired,
      shouldShowError: false,
      versionNumber: "",
      timeAsked: DateTime.now().toString(),
    );
    return multiSelectionSubQuestionnaire;
  }

  SingleSelectionQuestionnaire _parseSingleSelectionQuestionnaire(element) {
    String questionId = element is QuestionObj ? element.questionId.toString() : element.inputId.toString();
    String question = element is QuestionObj ? element.questionText.toString() : element.inputText.toString();
    List<QuestionnaireOption> optionsList = [];
    List<Option> options = element.options ?? [];
    bool isRequired = element.requiredValue.toString().isNotEmpty ? element.requiredValue.toString().toBoolean() : false;
    List<Followup> followUps = element.followup ?? [];

    if (options != []) {
      for (var option in options) {
        QuestionnaireOption questionnaireOption = _parseOptions(option, followUps);
        optionsList.add(questionnaireOption);
      }
    }

    SingleSelectionQuestionnaire singleSelectionQuestionnaire = SingleSelectionQuestionnaire(
      DateTime.now(),
      null,
      versionNumber: "",
      questionId: questionId,
      questionText: question,
      optionsList: optionsList,
      isRequired: isRequired,
      shouldShowError: false,
    );

    return singleSelectionQuestionnaire;
  }

  SingleMultiMultiSelectionQuestionnaire _parseSingleMultiMultiSelectionQuestionnaire(QuestionObj element) {
    String questionId = element.questionId.toString();
    String question = element.questionText.toString();
    List<QuestionnaireOption> optionsList = [];
    List<Option> options = element.options ?? [];
    bool isRequired = false;
    String isRequiredField = element.requiredValue ?? "";
    if (isRequiredField.isNotEmpty) {
      isRequired = true;
    }
    var inputField;
    List<Followup> followUps = element.followup ?? [];
    if (followUps.isNotEmpty) {
      for (var follow in followUps) {
        if (follow.inputId != null) {
          inputField = follow;
        }
      }
    }
    for (var option in options) {
      QuestionnaireOption questionnaireOption = _parseOptions(option, inputField);
      optionsList.add(questionnaireOption);
    }

    SingleMultiMultiSelectionQuestionnaire singleMultiMultiSelectionQuestionnaire = SingleMultiMultiSelectionQuestionnaire(
      element,
    );

    return singleMultiMultiSelectionQuestionnaire;
  }

  QuestionnaireOption _parseOptions(option, followupList1) {
    List followupList = followupList1 is List<Followup> ? followupList1 : [followupList1];
    String? optionId = option.id;
    List<Questionnaire> questionnaireList = [];
    for (var followup in followupList) {
      if (followup != null) {
        if (followup.forOptionKey == optionId) {
          var questionnaire = _parseQuestionnaire(followup);
          if (questionnaire != null) {
            questionnaireList.add(questionnaire);
          }
        }
      }
    }
    QuestionnaireOption questionnaireOption = QuestionnaireOption(questionnaireList, optionId: optionId!, optionText: option.displayText.toString());
    return questionnaireOption;
  }

  TextFieldQuestionnaire _parseTextFieldQuestionnaire(element) {
    String id = element.inputId.toString();
    String label = element.inputText.toString();
    String? regex = element.regex.toString();
    bool isRequired = false;

    var isRequiredField = element.requiredValue.toString();
    if (isRequiredField.isNotEmpty) {
      isRequired = isRequiredField == "true";
    }

    TextFieldQuestionnaire textFieldQuestionnaire = TextFieldQuestionnaire(
      null,
      id: id,
      label: label,
      regex: regex,
      isRequired: isRequired,
      shouldShowError: false,
    );
    return textFieldQuestionnaire;
  }

  TextFieldQuestionnaire _parseTextFormFieldQuestionnaire(QuestionObj element) {
    String id = element.questionId.toString();
    String label = element.questionText.toString();
    String? regex = element.regex.toString();
    bool isRequired = false;

    var isRequiredField = element.requiredValue.toString();
    if (isRequiredField.isNotEmpty) {
      isRequired = isRequiredField == "true";
    }

    TextFieldQuestionnaire textFieldQuestionnaire = TextFieldQuestionnaire(
      null,
      id: id,
      label: label,
      regex: regex,
      isRequired: isRequired,
      shouldShowError: false,
    );
    return textFieldQuestionnaire;
  }
}
