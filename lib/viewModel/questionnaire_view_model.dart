import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/model/cra_model.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:provider/provider.dart';

class QuestionnaireViewModel extends ChangeNotifier {

  RiskAssessmentQuestionaire? isarDB;

  List<Questionnaire> questionnaireList = [];
  List<CRAModel> craSectionData = [];
  List<String> questionnaireSections = [];

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

  Map<String, List<Questionnaire>> sectionsData = {};

  /// Updating the value of the [sectionsData] key
  /// Getting the next section index from [questionnaireSections] and adding the values for [_sectionName] & [questionnaireList]
  /// If all the sections are completed then submitting the form
  setNextSectionData(String sectionName, BuildContext context) async {
    _allSectionsCompleted = false;
    sectionsData[sectionName] = questionnaireList;
    craSectionData.add(CRAModel(sectionName, questionnaireList));
    int currentIndex = questionnaireSections.indexOf(sectionName);
    if (currentIndex == questionnaireSections.length - 1) {
       await submitForm(craData: craSectionData, context: context);
    } else {
      _sectionName = questionnaireSections[currentIndex + 1];
      questionnaireList = sectionsData[_sectionName]!;
    }
    notifyListeners();
  }

  /// From the [sectionName] received in the parameter, we are finding in which index that particular
  /// index is present in the [questionnaireSections] and saving the previous item as [_sectionName]
  /// From the [_sectionName] fetching the previous section data which was saved in the [sectionsData]
  setPreviousSectionData(String sectionName) {
    int currentIndex = questionnaireSections.indexOf(sectionName);
    _sectionName = questionnaireSections[currentIndex - 1];
    questionnaireList = sectionsData[_sectionName]!;
  }

  setVersionNumber(String version) => _versionNumber = version;

  /// Forces provider to setstate on external command
  void notify() => notifyListeners();

  /// Fetching the Questionnaire based upon the [language] and saving it in the [sectionsData] Map Object
  /// If the [_sectionName] is null|empty then adding the first section data saved in [sectionsData]
  fetchQuestionnaireForRA(String language) async {
    isarDB = await IsarDbService.isarDbService.getRAQuestionnaireByLocale("en_US");
    if (_sectionName == null) {
      for (int i = 0; i < isarDB!.sections!.length; i++) {
        questionnaireSections.add(isarDB!.sections![i].sectionName.toString());
        sectionsData[isarDB!.sections![i].sectionName.toString()] = fetchDBQuestions(isarDB!.sections![i].questionObj ?? []);
      }
      _sectionName = questionnaireSections[0];
      questionnaireList = sectionsData[_sectionName]!;
    }
    notifyListeners();
  }

  submitForm({required List<CRAModel> craData, required BuildContext context}) async {
    SubInput? subInput;
    late Inputs inputs;
    CRAQuestionnaire? craQuestionnaire;
    List<String> sectionNames = [];
    List<CRAQuestionnaire> craQuestion = [];
    List<CRASectionModel> craSectionModel = [];
    for (int i = 0; i < craData.length; i++) {
      sectionNames.add(craData[i].ehrCategoryMap.toString());
      if (craData[i].questionnaireList != []) {
        craQuestion.clear();
        List<Inputs> inputsData = [];
        List subInputsData = [];
        for (int j = 0; j < craData[i].questionnaireList!.length; j++) {
          inputsData = [];
          if (craData[i].questionnaireList![j].toJson()['inputs'] != "[]") {
            List inputsData1 = json.decode(craData[i].questionnaireList![j].toJson()['inputs']);
            subInputsData = [];
            for (int k = 0; k < inputsData1.length; k++) {
              subInputsData = [];
              if (inputsData1[k]['inputs'].runtimeType == String) {
                subInputsData = jsonDecode(inputsData1[k]['inputs']);
              } else if (inputsData1[k]['inputs'].runtimeType == List<dynamic>) {
                subInputsData = inputsData1[k]['inputs'];
              }
              if (subInputsData.isNotEmpty) {
                subInput = SubInput()
                    ..inputId = subInputsData[0]['inputid']
                    ..value = subInputsData[0]['value'];
              }
              inputs = Inputs()
                ..inputId = inputsData1[k]['inputid'] ?? inputsData1[k]['questionid']
                ..value = inputsData1[k]['value']
                ..subInput = subInput
                ..timeAsked = inputsData1[k]['timeAsked'] == null ? DateTime.now() : DateTime.parse(inputsData1[k]['timeAsked']);
              inputsData.add(inputs);
              subInput = null;
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
        ..caseId = CommonFunctions.randomNumber(5)
        ..versionNumber = versionNumber
        ..languageCode = languageViewModel.selectedLanguage
        ..craSectionData = craSectionModel);
      _allSectionsCompleted = true;
      resetAll();
    } catch (e) {
      log(e.toString());
    }
  }

  resetAll() {
    questionnaireSections = [];
    questionnaireList = [];
    craSectionData = [];
    _sectionName = null;
  }

  savePatientId(String randomId) => _patientId = randomId;

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
