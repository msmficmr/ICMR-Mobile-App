import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/utils/app_constant.dart';

class ChatBotViewModel extends ChangeNotifier {
  Map<String, String> _languageMap = {};

  Map<String, String> get languageMapObject => _languageMap;

  /// using global variable for using animations
  final GlobalKey<AnimatedListState> animationKey = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController();

  late CRAModel answeredCRAData;

  RiskAssessmentQuestionaire? isarDB;

  List<Questionnaire> questionnaireList = [];
  List<Questionnaire> answeredQuestionnaire = [];
  List<CRAModel> craSectionData = [];

  String? _sectionName;
  String? get sectionName => _sectionName;

  void setNextSectionData(String sectionName) {
    List<Questionnaire> answeredQuestions = [];
    answeredQuestions.addAll(questionnaireList);
    answeredCRAData = CRAModel(sectionName, answeredQuestions);
    craSectionData.add(answeredCRAData);
    if (sectionName == isarDB!.sections![questionnaireSections.length - 1].sectionName) {
      log("End of the questionnaire $craSectionData");
      submitForm(craData: craSectionData);
    } else {
      for (int i = 0; i < questionnaireSections.length; i++) {
        if (sectionName == questionnaireSections[i]) {
          questionnaireList = parseJsonForQuestionnaire(isarDB!.sections![i + 1].questionObj ?? []);
          _sectionName = isarDB!.sections![i+1].sectionName;
        }
      }
    }
    notifyListeners();
  }

  void setPreviousSectionData(String sectionName) {
    int previousIndex = questionnaireSections.indexOf(sectionName);
    if (craSectionData.isNotEmpty) {
      for (var section in craSectionData) {
        String? key = section.ehrCategoryMap;
        if (questionnaireSections[previousIndex - 1] == key) {
          _sectionName = key;
          questionnaireList = section.questionnaireList!;
        }
      }
    }
  }

  List<String> questionnaireSections = [];

  /// Forces provider to setstate on external command
  void notify() => notifyListeners();

  fetchQuestionnaireForRA(String language, String sectionName) async {
    isarDB = await IsarDbService.isarDbService.getRAQuestionaireByLocale(language);
    if (questionnaireSections.isEmpty) {
      if (isarDB!.sections != null) {
        for (var section in isarDB!.sections!) {
          questionnaireSections.add(section.sectionName.toString());
        }
      }
    }

    if (questionnaireList.isEmpty) {
      _sectionName = questionnaireSections[0];
      for (int i = 0; i < isarDB!.sections!.length; i++) {
        if (isarDB!.sections![i].sectionName == questionnaireSections[0]) {
          questionnaireList = parseJsonForQuestionnaire(isarDB!.sections![i].questionObj ?? []);
        }
      }
    }
    notifyListeners();
  }

  void submitForm({required List<CRAModel> craData}) {
    List<String> sectionNames = [];
    List<CRAQuestionnaire> craQuestionnaireData = [];
    CRAQuestionnaire? craQuestionnaire;
    for (int i = 0; i < craData.length; i++) {
      sectionNames.add(craData[i].ehrCategoryMap.toString());
      for(int j = 0; j < craData[i].questionnaireList!.length; j++) {
        List<Inputs>? inputs;
        late Inputs input;
        if (craData[i].questionnaireList![j].toJson()['inputs'] != []) {
          for (int k = 0; k < craData[i].questionnaireList![j].toJson()['inputs'].length; k++ ) {
            input = Inputs()
                ..inputId = craData[i].questionnaireList![j].toJson()['inputs'][k]['inputId']
                ..value = craData[i].questionnaireList![j].toJson()['inputs'][k]['value'];
          }
          inputs!.add(input);
        }
         craQuestionnaire = CRAQuestionnaire()
            ..questionId = craData[i].questionnaireList![j].toJson()['questionid']
            ..versionNumber = "1.0"
            ..value = craData[i].questionnaireList![j].toJson()['value']
            ..inputs = inputs ?? []
            ..timeAsked = craData[i].questionnaireList![j].toJson()['timeAsked']
            ..lonic = craData[i].questionnaireList![j].toJson()['loinc']
            ..snomed = craData[i].questionnaireList![j].toJson()['snomed'];
      }
      craQuestionnaireData.add(craQuestionnaire!);
    }
    CRASectionModel craModel = CRASectionModel()
    ..ehrCategoryMap = sectionNames[0]
    ..questionnaireList = craQuestionnaireData;
    List<CRASectionModel> craSectionModel = [];
    craSectionModel.add(craModel);
    for (var e in craSectionModel) {
      log(e.questionnaireList.toString());
    }
    try {
      IsarDbService.isarDbService.saveCRA(CRAOfflineData()
        ..id = 01
        ..patientId = "CRA15150"
        ..caseId = "515"
        ..versionNumber = "1.0"
        ..craSectionData = craSectionModel
      );
    } catch (e) {
      log(e.toString());
    }
  }

  List<Questionnaire> parseJsonForQuestionnaire(questionsList) {
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
      if (chipType == AppConstant.CHIP_WITH_MULTISELECT_TEXTFORM || chipType == AppConstant.CHIP_OPTIONS || chipType == AppConstant.CHIP_WITH_SINGLE_SELECT_CHIP) {
        return _parseSingleSelectionQuestionnaire(element);
      } else if (chipType == AppConstant.MULTI_SELECT_TEXTFORM || chipType == AppConstant.CHIP_OPTIONS_WITH_MULTI_SELECTION) {
        return _parseMultiSelectionSubQuestionnaire(element);
      } else if (chipType == AppConstant.SINGLE_MULTI_MULTI_CHIP_OPTIONS) {
        return _parseSingleMultiMultiSelectionQuestionnaire(element);
      }
    } else if (element.type == null) {
      return _parseTextFieldQuestionnaire(element);
    }
    return null;
  }

  SingleSelectionQuestionnaire _parseSingleSelectionQuestionnaire(element) {
    String questionId = element is QuestionObj ? element.questionId.toString() : element.inputId.toString();
    String question = element is QuestionObj ? element.questionText.toString() : element.inputText.toString();
    List<QuestionnaireOption> optionsList = [];
    List<Option> options = element.options ?? [];
    bool isRequired = false;
    String isRequiredField = element.requiredValue ?? "";
    if (isRequiredField.isNotEmpty) {
      isRequired = true;
    }
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
}

class CRAModel {
  String? ehrCategoryMap;
  List<Questionnaire>? questionnaireList;

  CRAModel(this.ehrCategoryMap, this.questionnaireList);

  Map<String, dynamic> toJson() => {'ehrCategoryMapId': ehrCategoryMap, 'ehrNotes': questionnaireList};
}