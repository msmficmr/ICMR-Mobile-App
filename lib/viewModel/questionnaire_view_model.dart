import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/model/cra_model.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
  String? _versionNumber;
  String? _languageCode;
  String? _patientId;
  bool? _allSectionsCompleted;

  String? get sectionName => _sectionName;
  String? get versionNumber => _versionNumber;
  String? get languageCode => _languageCode;
  String? get patientId => _patientId;
  bool? get allSectionsCompleted => _allSectionsCompleted;

  setNextSectionData(String sectionName, BuildContext context) async {
    _allSectionsCompleted = false;
    List<Questionnaire> answeredQuestions = [];
    answeredQuestions.addAll(questionnaireList);
    answeredCRAData = CRAModel(sectionName, answeredQuestions);
    for (int i = 0; i < craSectionData.length; i++) {
      if (craSectionData[i].ehrCategoryMap! == answeredCRAData.ehrCategoryMap) {
        craSectionData.removeAt(i);
      }
    }
    craSectionData.add(answeredCRAData);
    if (sectionName == isarDB!.sections![questionnaireSections.length - 1].sectionName) {
      await submitForm(craData: craSectionData, context: context);
      craSectionData = [];
    } else {
      for (int i = 0; i < questionnaireSections.length; i++) {
        if (sectionName == questionnaireSections[i]) {
          questionnaireList = parseJsonForQuestionnaire(isarDB!.sections![i + 1].questionObj ?? []);
          _sectionName = isarDB!.sections![i + 1].sectionName;
        }
      }
    }
    notifyListeners();
  }

  setPreviousSectionData(String sectionName) {
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

  setVersionNumber(String version) => _versionNumber = version;

  List<String> questionnaireSections = [];

  /// Forces provider to setstate on external command
  void notify() => notifyListeners();

  fetchQuestionnaireForRA(String language, String sectionName) async {
    isarDB = await IsarDbService.isarDbService.getRAQuestionnaireByLocale(language);
    if (questionnaireSections.isEmpty) {
      if (isarDB!.sections != null) {
        for (var section in isarDB!.sections!) {
          questionnaireSections.add(section.sectionName.toString());
          if (versionNumber == null || versionNumber!.isEmpty) {
            _versionNumber = section.versionNumber;
          }
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

  submitForm({required List<CRAModel> craData, required BuildContext context}) async {
    List<String> sectionNames = [];
    List<CRASectionModel> craSectionModel = [];
    CRAQuestionnaire? craQuestionnaire;
    late Inputs inputs1;
    InputsBranch? inputs2;
    List<CRAQuestionnaire> craQuestion = [];
    for (int i = 0; i < craData.length; i++) {
      sectionNames.add(craData[i].ehrCategoryMap.toString());
      if (craData[i].questionnaireList != []) {
        craQuestion.clear();
        List<Inputs> inputsData = [];
        List inputsData2 = [];
        for (int j = 0; j < craData[i].questionnaireList!.length; j++) {
          inputsData = [];
          if (craData[i].questionnaireList![j].toJson()['inputs'] != "[]") {
            List inputsData1 = json.decode(craData[i].questionnaireList![j].toJson()['inputs']);
            inputsData2 = [];
            for (int k = 0; k < inputsData1.length; k++) {
              inputsData2 = [];
              if (inputsData1[k]['inputs'].runtimeType == String) {
                inputsData2 = jsonDecode(inputsData1[k]['inputs']);
              } else if (inputsData1[k]['inputs'].runtimeType == List<dynamic>) {
                inputsData2 = inputsData1[k]['inputs'];
              }
              if (inputsData2.isNotEmpty) {
                inputs2 = InputsBranch()
                    ..inputId = inputsData2[0]['inputid']
                    ..value = inputsData2[0]['value'];
              }
              inputs1 = Inputs()
                ..inputId = inputsData1[k]['inputid'] ?? inputsData1[k]['questionid']
                ..value = inputsData1[k]['value']
                ..inputsBranch = inputs2
                ..timeAsked = inputsData1[k]['timeAsked'] == null ? DateTime.now() : DateTime.parse(inputsData1[k]['timeAsked']);
              inputsData.add(inputs1);
              inputs2 = null;
            }
          }
          craQuestionnaire = CRAQuestionnaire()
            ..questionId = craData[i].questionnaireList![j].toJson()['questionid']
            ..versionNumber = versionNumber
            ..value = craData[i].questionnaireList![j].toJson()['value']
            ..inputs = inputsData
            ..timeAsked = DateTime.parse(craData[i].questionnaireList![j].toJson()['timeAsked'])
            ..lonic = craData[i].questionnaireList![j].toJson()['loinc']
            ..snomed = craData[i].questionnaireList![j].toJson()['snomed'];
          craQuestion.add(craQuestionnaire);
        }
      }
      List<CRAQuestionnaire> craQuestionnaireData = [];
      craQuestionnaireData.addAll(craQuestion);
      CRASectionModel craModel = CRASectionModel()
        ..ehrCategoryMapId = sectionNames[i]
        ..questionnaireList = craQuestionnaireData;
      craSectionModel.add(craModel);
    }
    try {
      final languageViewModel = Provider.of<LanguageViewModel>(context, listen: false);
      IsarDbService.isarDbService.saveCRA(CRAOfflineData()
        ..patientId = patientId
        ..caseId = randomCaseNumber()
        ..versionNumber = versionNumber
        ..languageCode = languageViewModel.selectedLanguage
        ..craSectionData = craSectionModel);
      _allSectionsCompleted = true;
      questionnaireList = [];
    } catch (e) {
      log(e.toString());
    }
  }

  String randomPatientNumber() {
    const uuid = Uuid();
    final sixDigitUuid = uuid.v4().toString().substring(0, 6);
    savePatientId(sixDigitUuid);
    return sixDigitUuid;
  }

  savePatientId(String randomId) => _patientId = randomId;

  String randomCaseNumber() {
    const uuid = Uuid();
    final sixDigitUuid = uuid.v4().toString().substring(0, 5);
    return sixDigitUuid;
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
