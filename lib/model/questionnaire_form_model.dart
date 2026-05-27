import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mhealth/isar_db_schema/attachment_db_schema.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/model/id_text_model.dart';
import 'package:mhealth/model/questionnaire_input_model.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/views/questionair/widgets/multi_level_multi_select_widget_state.dart';

abstract class Questionnaire {
  List<Questionnaire> getFollowupQuestionnaires();

  Map<String, dynamic> toJson();

  String getId();

  setSelected(
    String? value,
    List<QuestionnaireInputModel> inputs,
  );

  bool isValid();

  clear();

  /// Override this method for widgets only
  List<CRAQuestionnaire> getEhrNotes();
  EHRDiagnosisReports? getEhrDiagnosisReports();
  void populateByEhrNotes(EHRNotes notes, EHRDiagnosisReports? diagnosisReports);
}

class VerificationFormQuestionnaire extends Questionnaire {
  String versionNumber;
  final String _sampleCollectedByQuestionId = "sample_collected_by";
  final String _signQuestionId = "patient_signature";
  TextEditingController sampleCollectedByController = TextEditingController();
  ValueNotifier<AttachmentModel?> signature = ValueNotifier<AttachmentModel?>(null);

  VerificationFormQuestionnaire(this.versionNumber);
  @override
  List<Questionnaire> getFollowupQuestionnaires() => [];

  @override
  String getId() => "";

  @override
  bool isValid() => true;

  @override
  setSelected(String? value, List<QuestionnaireInputModel> inputs) {
    return false;
  }

  @override
  Map<String, dynamic> toJson() => {};

  @override
  clear() {}

  @override
  List<CRAQuestionnaire> getEhrNotes() => [
        CRAQuestionnaire()
          ..questionId = _sampleCollectedByQuestionId
          ..value = sampleCollectedByController.text.trim()
          ..timeAsked = DateTime.now()
          ..inputs = []
          ..snomed = ""
          ..lonic = ""
      ];

  @override
  void populateByEhrNotes(EHRNotes notes, EHRDiagnosisReports? diagnosisReports) {
    List<CRAQuestionnaire> ehrQuestions = notes.questions ?? [];
    if (ehrQuestions.isNotEmpty) {
      for (CRAQuestionnaire quest in ehrQuestions) {
        String questionId = quest.questionId ?? "";
        if (questionId == _sampleCollectedByQuestionId) {
          sampleCollectedByController.text = quest.value ?? "";
        }
      }
    }

    if (diagnosisReports != null) {
      List<Report> reports = diagnosisReports.questions ?? [];
      for (Report report in reports) {
        if (report.questionId == _signQuestionId) {
          signature.value = AttachmentModel(fileName: report.file?.fileName ?? "", filePath: report.file?.dataBytes ?? "");
        }
      }
    }
  }

  @override
  EHRDiagnosisReports? getEhrDiagnosisReports() {
    EHRDiagnosisReports diagnosisReport = EHRDiagnosisReports();

    Report report = Report();
    report.questionId = _signQuestionId;
    report.value = signature.value?.fileName;
    report.file = AttachmentDb()
      ..fileName = signature.value?.fileName
      ..dataBytes = signature.value?.filePath;
    report.timeAsked = DateTime.now();

    List<Report> reports = [report];

    diagnosisReport.questions = reports;

    return diagnosisReport;
  }
}

class LesionLocationQuestionnaire extends Questionnaire {
  String versionNumber;
  LesionLocationQuestionnaire(this.versionNumber);

  @override
  List<Questionnaire> getFollowupQuestionnaires() => [];

  @override
  String getId() => "";

  @override
  bool isValid() => true;

  @override
  setSelected(String? value, List<QuestionnaireInputModel> inputs) {
    return false;
  }

  @override
  Map<String, dynamic> toJson() => {};

  @override
  clear() {}

  ValueNotifier<List<LesionLocationQuestion>> questionsList = ValueNotifier<List<LesionLocationQuestion>>([]);

  addNewQuestion(LesionLocationQuestion question, AttachmentModel attachment) {
    int index = questionsList.value.indexWhere((element) => element.questionId == question.questionId);
    if (index != -1) {
      questionsList.value[index].attachments.value = [
        ...questionsList.value[index].attachments.value,
        attachment,
      ];
    } else {
      question.attachments = ValueNotifier<List<AttachmentModel>>([attachment]);
      questionsList.value = [...questionsList.value, question];
    }
  }

  @override
  List<CRAQuestionnaire> getEhrNotes() {
    List<CRAQuestionnaire> notes = [];
    for (LesionLocationQuestion question in questionsList.value) {
      // Site
      Inputs siteInput = Inputs()
        ..inputId = "site"
        ..value = question.siteId
        ..loinc = ""
        ..snomed = ""
        ..timeAsked = question.timeAsked;

      //Location
      Inputs locationInput = Inputs()
        ..inputId = "location"
        ..value = question.locationId
        ..loinc = ""
        ..snomed = ""
        ..timeAsked = question.timeAsked;

      //Length
      Inputs lengthInput = Inputs()
        ..inputId = "length"
        ..value = question.lengthController.text.trim()
        ..loinc = ""
        ..snomed = ""
        ..timeAsked = question.timeAsked;

      //Breadth
      Inputs breadthInput = Inputs()
        ..inputId = "breadth"
        ..value = question.breadthController.text.trim()
        ..loinc = ""
        ..snomed = ""
        ..timeAsked = question.timeAsked;

      //Breadth
      Inputs diagnosisInput = Inputs()
        ..inputId = "diagnosis"
        ..value = question.diagnosys.value
        ..loinc = ""
        ..snomed = ""
        ..timeAsked = question.timeAsked;
      if (question.diagnosys.value == "other") {
        SubInput subInput = SubInput()
          ..inputId = "other"
          ..value = question.diagnosysController.text.trim()
          ..loinc = ""
          ..snomed = "";
        diagnosisInput.subInput = subInput;
      }

      List<Inputs> inputList = [siteInput, locationInput, lengthInput, breadthInput, diagnosisInput];

      CRAQuestionnaire questionnaire = CRAQuestionnaire();
      questionnaire.questionId = question.questionId;
      questionnaire.timeAsked = question.timeAsked;
      questionnaire.value = "";
      questionnaire.lonic = "";
      questionnaire.snomed = "";
      questionnaire.inputs = inputList;

      notes.add(questionnaire);
    }

    return notes;
  }

  @override
  void populateByEhrNotes(EHRNotes notes, EHRDiagnosisReports? diagnosisReports) {
    List<CRAQuestionnaire> ehrQuestions = notes.questions ?? [];
    List<LesionLocationQuestion> ques = [];

    for (CRAQuestionnaire ehrQuestion in ehrQuestions) {
      String questionId = ehrQuestion.questionId ?? "";

      LesionLocationQuestion lesionLocationQuestion = LesionLocationQuestion(
        versionNumber: notes.versionNumber ?? "",
        questionId: questionId,
        timeAsked: ehrQuestion.timeAsked,
      );

      lesionLocationQuestion.attachments.value = (diagnosisReports?.questions ?? [])
          .where((element) => element.questionId == questionId)
          .toList()
          .map((e) => AttachmentModel(fileName: e.file?.fileName ?? "", filePath: e.file?.dataBytes ?? ""))
          .toList();

      List<Inputs> inputList = ehrQuestion.inputs ?? [];
      for (var input in inputList) {
        switch (input.inputId) {
          case "site":
            lesionLocationQuestion.siteId = input.value;
            break;
          case "location":
            lesionLocationQuestion.locationId = input.value;
            break;
          case "length":
            lesionLocationQuestion.lengthController.text = input.value ?? "";
            break;
          case "breadth":
            lesionLocationQuestion.breadthController.text = input.value ?? "";
            break;
          case "diagnosis":
            lesionLocationQuestion.diagnosys.value = input.value;
            if (lesionLocationQuestion.diagnosys.value != null && lesionLocationQuestion.diagnosys.value == "other") {
              lesionLocationQuestion.diagnosysController.text = input.subInput?.value ?? "";
            }
            break;
        }
      }
      ques.add(lesionLocationQuestion);
    }

    questionsList.value = ques;
  }

  void removeQuestion(String questionId) {
    questionsList.value.removeWhere((element) => element.questionId == questionId);
    questionsList.value = [...questionsList.value];
  }

  void removeAttachmentImage(String questionId, String fileName) {
    int index = questionsList.value.indexWhere((element) => element.questionId == questionId);
    if (index != -1) {
      List<AttachmentModel> attachmentList = [...questionsList.value[index].attachments.value];
      attachmentList.removeWhere((element) => element.fileName == fileName);
      if (attachmentList.isEmpty) {
        questionsList.value.removeAt(index);
        questionsList.value = [...questionsList.value];
      } else {
        questionsList.value[index].attachments.value = [...attachmentList];
      }
    }
  }

  @override
  EHRDiagnosisReports? getEhrDiagnosisReports() {
    EHRDiagnosisReports diagnosisReports = EHRDiagnosisReports();
    List<Report> reports = [];
    for (LesionLocationQuestion question in questionsList.value) {
      String questionId = question.questionId;
      for (int i = 0; i < question.attachments.value.length; i++) {
        AttachmentModel attachmentModel = question.attachments.value[i];

        Report report = Report();
        report.timeAsked = question.timeAsked;
        report.questionId = questionId;
        report.value = questionId;
        report.file = AttachmentDb()
          ..fileName = attachmentModel.fileName
          ..dataBytes = attachmentModel.filePath;

        reports.add(report);
      }
    }

    diagnosisReports.questions = reports;
    return diagnosisReports;
  }
}

class PeriodontalStatusQuestionnaire extends Questionnaire {
  late WidgetQuestion quest1716, quest11, quest2676, quest4746, quest31, quest3637;

  final String _id1716 = "17_16";
  final String _id11 = "11";
  final String _id2676 = "26_76";
  final String _id4746 = "47_46";
  final String _id31 = "31";
  final String _id3637 = "36_37";

  PeriodontalStatusQuestionnaire(String versionNumber) {
    quest1716 = WidgetQuestion(questionId: _id1716, versionNumber: versionNumber);
    quest11 = WidgetQuestion(questionId: _id11, versionNumber: versionNumber);
    quest2676 = WidgetQuestion(questionId: _id2676, versionNumber: versionNumber);
    quest4746 = WidgetQuestion(questionId: _id4746, versionNumber: versionNumber);
    quest31 = WidgetQuestion(questionId: _id31, versionNumber: versionNumber);
    quest3637 = WidgetQuestion(questionId: _id3637, versionNumber: versionNumber);
  }

  DateTime? timeAsked;

  @override
  List<Questionnaire> getFollowupQuestionnaires() => [];

  @override
  String getId() => "";

  @override
  bool isValid() => true;

  @override
  setSelected(String? value, List<QuestionnaireInputModel> inputs) {
    return false;
  }

  @override
  Map<String, dynamic> toJson() => {};

  @override
  clear() {}

  @override
  List<CRAQuestionnaire> getEhrNotes() {
    return [
      quest1716.toCraQuestionnaire(),
      quest11.toCraQuestionnaire(),
      quest2676.toCraQuestionnaire(),
      quest4746.toCraQuestionnaire(),
      quest31.toCraQuestionnaire(),
      quest3637.toCraQuestionnaire(),
    ];
  }

  @override
  void populateByEhrNotes(EHRNotes notes, EHRDiagnosisReports? diagnosisReports) {
    List<CRAQuestionnaire> questionList = notes.questions ?? [];
    for (CRAQuestionnaire question in questionList) {
      String questionId = question.questionId ?? "";
      if (questionId == _id1716) {
        quest1716.selectedOption = ValueNotifier<String?>(question.value);
        quest1716.timeAsked = question.timeAsked ?? DateTime.now();
      }
      if (questionId == _id11) {
        quest11.selectedOption = ValueNotifier<String?>(question.value);
        quest11.timeAsked = question.timeAsked ?? DateTime.now();
      }
      if (questionId == _id2676) {
        quest2676.selectedOption = ValueNotifier<String?>(question.value);
        quest2676.timeAsked = question.timeAsked ?? DateTime.now();
      }
      if (questionId == _id4746) {
        quest4746.selectedOption = ValueNotifier<String?>(question.value);
        quest4746.timeAsked = question.timeAsked ?? DateTime.now();
      }
      if (questionId == _id31) {
        quest31.selectedOption = ValueNotifier<String?>(question.value);
        quest31.timeAsked = question.timeAsked ?? DateTime.now();
      }
      if (questionId == _id3637) {
        quest3637.selectedOption = ValueNotifier<String?>(question.value);
        quest3637.timeAsked = question.timeAsked ?? DateTime.now();
      }
    }
  }

  @override
  EHRDiagnosisReports? getEhrDiagnosisReports() => null;
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

  @override
  clear() {}

  @override
  List<CRAQuestionnaire> getEhrNotes() => [];

  @override
  void populateByEhrNotes(EHRNotes notes, EHRDiagnosisReports? diagnosisReports) {}

  @override
  EHRDiagnosisReports? getEhrDiagnosisReports() => null;
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

  @override
  clear() {
    getFollowupQuestionnaires().forEach((element) {
      element.clear();
    });
  }

  @override
  List<CRAQuestionnaire> getEhrNotes() => [];

  @override
  void populateByEhrNotes(EHRNotes notes, EHRDiagnosisReports? diagnosisReports) {
    // TODO: implement populateByEhrNotes
  }

  @override
  EHRDiagnosisReports? getEhrDiagnosisReports() => null;
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

  @override
  clear() {
    getFollowupQuestionnaires().forEach((element) {
      element.clear();
    });
  }

  @override
  List<CRAQuestionnaire> getEhrNotes() => [];

  @override
  void populateByEhrNotes(EHRNotes notes, EHRDiagnosisReports? diagnosisReports) {}

  @override
  EHRDiagnosisReports? getEhrDiagnosisReports() => null;
}

class CheckboxQuestionnaire extends Questionnaire {
  String questionId;
  String questionText;
  List<QuestionnaireOption> optionsList;
  List<QuestionnaireOption> selectedOptions;
  bool isRequired;
  bool shouldShowError;
  String versionNumber;
  String timeAsked;

  CheckboxQuestionnaire({
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
      "questionid": questionId,
      "value": values.join(","),
      "inputs": jsonEncode(inputs),
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

  @override
  clear() {
    getFollowupQuestionnaires().forEach((element) {
      element.clear();
    });
  }

  @override
  List<CRAQuestionnaire> getEhrNotes() => [];

  @override
  void populateByEhrNotes(EHRNotes notes, EHRDiagnosisReports? diagnosisReports) {}

  @override
  EHRDiagnosisReports? getEhrDiagnosisReports() => null;
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

  @override
  clear() {
    getFollowupQuestionnaires().forEach((element) {
      element.clear();
    });
  }

  @override
  List<CRAQuestionnaire> getEhrNotes() => [];

  @override
  void populateByEhrNotes(EHRNotes notes, EHRDiagnosisReports? diagnosisReports) {}
  @override
  EHRDiagnosisReports? getEhrDiagnosisReports() => null;
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

  @override
  clear() {
    userEnteredInput = "";
  }

  @override
  List<CRAQuestionnaire> getEhrNotes() => [];

  @override
  void populateByEhrNotes(EHRNotes notes, EHRDiagnosisReports? diagnosisReports) {}
  @override
  EHRDiagnosisReports? getEhrDiagnosisReports() => null;
}

class QuestionnaireOption {
  String optionId;
  String optionText;
  List<Questionnaire> onClick;
  bool isVisible; // New property to control visibility

  QuestionnaireOption(
    this.onClick, {
    required this.optionId,
    required this.optionText,
    this.isVisible = true, // Default to true

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

class WidgetQuestion {
  String questionId;
  DateTime timeAsked = DateTime.now();
  String versionNumber;
  ValueNotifier<String?> selectedOption = ValueNotifier<String?>(null);
  ValueNotifier<List<String>?> optionList = ValueNotifier<List<String>?>(null);
  WidgetQuestion({required this.questionId, required this.versionNumber});

  CRAQuestionnaire toCraQuestionnaire() {
    CRAQuestionnaire obj = CRAQuestionnaire();
    obj.inputs = [];
    obj.lonic = "";
    obj.questionId = questionId;
    obj.snomed = "";
    obj.timeAsked = timeAsked;
    obj.value = selectedOption.value;

    return obj;
  }

  Map<String, dynamic> toJson() {
    return {
      "questionid": questionId,
      "value": selectedOption.value,
      "inputs": json.encode([]),
      "versionNumber": versionNumber,
      "timeAsked": timeAsked.toString(),
      "snomed": "",
      "loinc": "",
    };
  }
}

class LesionLocationQuestion {
  String questionId;
  String versionNumber;
  String? siteId;
  String? locationId;

  TextEditingController lengthController = TextEditingController();
  TextEditingController breadthController = TextEditingController();
  ValueNotifier<String?> diagnosys = ValueNotifier<String?>(null);
  TextEditingController diagnosysController = TextEditingController();

  DateTime? timeAsked = DateTime.now();
  ExpansionTileController expansionTileController = ExpansionTileController();
  ValueNotifier<bool> expansionTileState = ValueNotifier<bool>(false);

  ValueNotifier<List<AttachmentModel>> attachments = ValueNotifier<List<AttachmentModel>>([]);

  LesionLocationQuestion({required this.questionId, required this.versionNumber, this.timeAsked});
}
