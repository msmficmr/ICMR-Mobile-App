import 'dart:convert';

import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/model/questionnaire_input_model.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/views/ask_mhealth/widgets/multi_level_multi_select_widget_state.dart';

abstract class Questionnaire {
  List<Questionnaire> getFollowupQuestionnaires();

  Map<String, dynamic> toJson();

  String getId();

  setSelected(String? value, List<QuestionnaireInputModel> inputs);

  bool isValid();
}

class SingleMultiMultiSelectionQuestionnaire extends Questionnaire {
  QuestionObj questionObj;

  SingleMultiMultiSelectionQuestionnaire(this.questionObj);

  @override
  List<Questionnaire> getFollowupQuestionnaires() {
    return [];
  }

  @override
  String getId() {
    // Not required, because its outside package.
    return "";
  }

  @override
  setSelected(String? value, List<QuestionnaireInputModel> inputs) {
    // Not required, because its outside package.
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  bool isValid() {
    MultiLevelMultiSelectWidgetState.isValidationOn = true;
    return MultiLevelMultiSelectWidgetState.getQuestionResponseStatus;
  }
}

class SingleSelectionQuestionnaire extends Questionnaire {
  String versionNumber;
  String questionId;
  String questionText;
  List<QuestionnaireOption> optionsList;
  QuestionnaireOption? selectedOption;
  DateTime? timeAsked;
  bool isRequired;
  bool shouldShowError;

  SingleSelectionQuestionnaire(
    this.timeAsked,
    this.selectedOption, {
    required this.versionNumber,
    required this.questionId,
    required this.questionText,
    required this.optionsList,
    required this.isRequired,
    required this.shouldShowError,
  });

  @override
  String getId() {
    return questionId;
  }

  @override
  setSelected(String? value, List<QuestionnaireInputModel> inputs) {
    if (value != null && value.trim().isNotEmpty) {
      selectedOption = optionsList.firstWhere((element) => element.optionId == value);
    }
    for (var input in inputs) {
      for (var option in selectedOption!.onClick) {
        if (input.id == option.getId()) {
          option.setSelected(input.value, []);
        }
      }
    }
  }

  @override
  List<Questionnaire> getFollowupQuestionnaires() {
    QuestionnaireOption? followupQuestionnaireOption = selectedOption;
    if (followupQuestionnaireOption != null) {
      return followupQuestionnaireOption.onClick;
    } else {
      return [];
    }
  }

  @override
  Map<String, dynamic> toJson() {
    var selectedOption = this.selectedOption;
    List<Map<String, dynamic>> inputs = [];
    if (selectedOption != null) {
      for (var element in selectedOption.onClick) {
        inputs.add(element.toJson());
      }
    }
    return {
      "questionid": questionId,
      "value": this.selectedOption?.optionId ?? "",
      "inputs": json.encode(inputs),
      "versionNumber": versionNumber,
      "timeAsked": timeAsked?.toString() ?? "",
      "snomed": "",
      "loinc": "",
    };
  }

  @override
  bool isValid() {
    bool isValid;
    if (selectedOption == null) {
      isValid = !isRequired;
    } else {
      isValid = selectedOption!.isValid();
    }

    shouldShowError = !isValid;
    return isValid;
  }
}

class MultiSelectionSubQuestionnaire extends Questionnaire {
  String questionId;
  String questionText;
  List<QuestionnaireOption> optionsList;
  List<QuestionnaireOption> selectedOptions;
  bool isRequired;
  bool shouldShowError;
  String versionNumber;
  String timeAsked;

  MultiSelectionSubQuestionnaire({
    required this.selectedOptions,
    required this.questionId,
    required this.questionText,
    required this.optionsList,
    required this.isRequired,
    required this.shouldShowError,
    required this.versionNumber,
    required this.timeAsked,
  });

  @override
  String getId() {
    return questionId;
  }

  @override
  setSelected(String? value, List<QuestionnaireInputModel> inputs) {
    if (value != null && value.trim().isNotEmpty) {
      List<String> values = value.split(",");
      for (var valueElement in values) {
        QuestionnaireOption selectedOption = optionsList.firstWhere((element) => element.optionId == valueElement);
        for (var input in inputs) {
          for (var option in selectedOption.onClick) {
            if (input.id == option.getId()) {
              option.setSelected(input.value, []);
            }
          }
        }
        selectedOptions.add(selectedOption);
      }
    }
  }

  @override
  List<Questionnaire> getFollowupQuestionnaires() {
    List<Questionnaire> followupQuestionnaires = [];
    for (var option in selectedOptions) {
      followupQuestionnaires.addAll(option.onClick);
    }
    return followupQuestionnaires;
  }

  @override
  Map<String, dynamic> toJson() {
    List<String> values = [];
    List<Map<String, dynamic>> inputs = [];
    for (var element in selectedOptions) {
      values.add(element.optionId);
      var onClick = element.onClick;
      for (var onClickElement in onClick) {
        inputs.add(onClickElement.toJson());
      }
    }

    /// Dont Change payload keys. For CRA and SCREENING we are using same payload.
    /// if keys changed then it will affect on RISK SCORE as well as it will not populate in CROSS Apps.
    return {
      "inputid": questionId,
      "value": values.join(","),
      "inputs": inputs,
      "versionNumber": versionNumber,
      "timeAsked": timeAsked,
      "snomed": "",
      "loinc": "",
    };
  }

  @override
  bool isValid() {
    bool isValid;
    if (selectedOptions.isEmpty) {
      isValid = !isRequired;
    } else {
      bool isOptionsValid = true;
      for (var option in selectedOptions) {
        if (!option.isValid()) {
          isOptionsValid = false;
        }
      }
      isValid = isOptionsValid;
    }
    shouldShowError = !isValid;
    return isValid;
  }
}

class SingleSelectionSubQuestionnaire extends Questionnaire {
  String questionId;
  String questionText;
  List<QuestionnaireOption> optionsList;
  QuestionnaireOption? selectedOption;
  bool isRequired;
  bool shouldShowError;
  String questionType;
  String versionNumber;
  String timeAsked;

  SingleSelectionSubQuestionnaire(
    this.selectedOption, {
    required this.questionId,
    required this.questionText,
    required this.optionsList,
    required this.isRequired,
    required this.shouldShowError,
    required this.questionType,
    required this.versionNumber,
    required this.timeAsked,
  });

  @override
  String getId() {
    return questionId;
  }

  @override
  setSelected(String? value, List<QuestionnaireInputModel> inputs) {
    if (value != null && value.trim().isNotEmpty) {
      selectedOption = optionsList.firstWhere((element) => element.optionId == value);
    }
    for (var input in inputs) {
      for (var option in selectedOption!.onClick) {
        if (input.id == option.getId()) {
          option.setSelected(input.value, []);
        }
      }
    }
  }

  @override
  List<Questionnaire> getFollowupQuestionnaires() {
    QuestionnaireOption? followupQuestionnaireOption = selectedOption;
    if (followupQuestionnaireOption != null) {
      return followupQuestionnaireOption.onClick;
    } else {
      return [];
    }
  }

  @override
  Map<String, dynamic> toJson() {
    var selectedOption = this.selectedOption;
    List<Map<String, dynamic>> inputs = [];
    if (selectedOption != null) {
      for (var element in selectedOption.onClick) {
        inputs.add(element.toJson());
      }
    }
    QuestionType singleType = QuestionType.SINGLE_SELECT_CHIP;
    if (questionType == singleType.toString()) {
      return {
        "inputid": questionId,
        "value": this.selectedOption?.optionId ?? "",
        "inputs": inputs,
        "snomed": "",
        "loinc": "",
      };
    }
    return {
      "questionid": questionId,
      "value": this.selectedOption?.optionId ?? "",
      "inputs": json.encode(inputs),
      "versionNumber": versionNumber,
      "timeAsked": timeAsked,
      "snomed": "",
      "loinc": "",
    };
  }

  @override
  bool isValid() {
    bool isValid;
    if (selectedOption == null) {
      isValid = !isRequired;
    } else {
      isValid = selectedOption!.isValid();
    }

    shouldShowError = !isValid;
    return isValid;
  }
}

class TextFieldQuestionnaire extends Questionnaire {
  String id;
  String label;
  String? regex;
  String? userEnteredInput;
  bool isRequired;
  bool shouldShowError;

  TextFieldQuestionnaire(
    this.userEnteredInput, {
    required this.id,
    required this.label,
    required this.regex,
    required this.isRequired,
    required this.shouldShowError,
  });

  @override
  String getId() {
    return id;
  }

  @override
  setSelected(String? value, List<QuestionnaireInputModel> inputs) {
    userEnteredInput = value;
  }

  @override
  List<Questionnaire> getFollowupQuestionnaires() {
    return [];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "questionid": id,
      "value": userEnteredInput == null || userEnteredInput.toString().isEmpty ? "" : userEnteredInput,
      "snomed": "",
      "loinc": "",
    };
  }

  @override
  bool isValid() {
    bool isValid;
    if (userEnteredInput == null || userEnteredInput!.isEmpty) {
      isValid = !isRequired; //getting dynamic required tag bool value from xml for validating height and weight are mandatory in BMI field.
    } else {
      isValid = true;
    }
    shouldShowError = !isValid;
    return isValid;
  }
}

class QuestionnaireOption {
  String optionId;
  String optionText;
  List<Questionnaire> onClick;

  QuestionnaireOption(
    this.onClick, {
    required this.optionId,
    required this.optionText,
  });

  bool isValid() {
    if (onClick.isEmpty) {
      return true;
    } else {
      bool isValid = true;
      for (var element in onClick) {
        if (!element.isValid()) {
          isValid = false;
        }
      }
      return isValid;
    }
  }
}
