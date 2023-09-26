import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/model/cra_model.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/model/static_questionnaire_model.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

class QuestionnaireViewModel extends ChangeNotifier {

  RiskAssessmentQuestionaire? isarDB;
  LoginViewModel? loginViewModel;

  List<CRAModel> craSectionData = [];
  List<StaticQuestionnaireModel> staticCraSectionData = [];
  List<String> questionnaireSections = [];
  List<AttachmentModel?> attachmentList = [];

  String? _caseId;
  String? _sectionName;
  String? _versionNumber;
  String? _languageCode;
  String? _patientId;
  bool _allSectionsCompleted = false;

  String? get caseId => _caseId;
  String? get sectionName => _sectionName;
  String? get versionNumber => _versionNumber;
  String? get languageCode => _languageCode;
  String? get patientId => _patientId;
  bool get allSectionsCompleted => _allSectionsCompleted;

  Map<String, List<Questionnaire>> sectionsData = {};

  /// Updating the value of the [sectionsData] key
  /// Getting the next section index from [questionnaireSections] and adding the values for [_sectionName] & [questionnaireList]
  /// If all the sections are completed then submitting the form
  setNextSectionData(String sectionName, BuildContext context, {List<StaticQuestionModel>? staticSectionsData}) async {
    _allSectionsCompleted = false;
    if (questionnaireSections.contains(sectionName)) {
      craSectionData.add(CRAModel(sectionName, sectionsData[sectionName]));
      int currentIndex = questionnaireSections.indexOf(sectionName);
      if (currentIndex == questionnaireSections.length - 1) {
        _sectionName = questionnaireSections[currentIndex];
      } else {
        _sectionName = questionnaireSections[currentIndex + 1];
      }
    } else {
      staticCraSectionData.add(StaticQuestionnaireModel(sectionName, staticSectionsData));
    }
    if (sectionName.sectionTitleName == AppConstant.WHITE_LISTED_SECTIONS[AppConstant.WHITE_LISTED_SECTIONS.length - 1]) {
      submitForm(craData: craSectionData, context: context, staticCraData: staticCraSectionData);
    }
  }

  /// From the [sectionName] received in the parameter, we are finding in which index that particular
  /// index is present in the [questionnaireSections] and saving the previous item as [_sectionName]
  /// From the [_sectionName] fetching the previous section data which was saved in the [sectionsData]
  setPreviousSectionData(String sectionName) {
    int currentIndex = questionnaireSections.indexOf(sectionName);
    _sectionName = questionnaireSections[currentIndex - 1];
  }

  setVersionNumber(String version) => _versionNumber = version;

  setCaseId() {
    _caseId = CommonFunctions.randomNumber(5);
  }

  /// Forces provider to setstate on external command
  void notify() => notifyListeners();

  /// Fetching the Questionnaire based upon the [language] and saving it in the [sectionsData] Map Object
  /// If the [_sectionName] is null|empty then adding the first section data saved in [sectionsData]
  fetchQuestionnaireForRA(String language) async {
    isarDB = await IsarDbService.isarDbService.getRAQuestionnaireByLocale("en_US");
    if (_sectionName == null) {
      for (int i = 0; i < isarDB!.sections!.length; i++) {
        if (caseId == null || caseId!.isEmpty) setCaseId();
        setVersionNumber(isarDB!.sections![i].versionNumber.toString());
        questionnaireSections.add(isarDB!.sections![i].sectionName.toString());
        sectionsData[isarDB!.sections![i].sectionName.toString()] = fetchDBQuestions(isarDB!.sections![i].questionObj ?? []);
      }
      _sectionName = questionnaireSections[0];
    }
    notifyListeners();
  }

  submitForm({required List<CRAModel> craData, required BuildContext context, required List<StaticQuestionnaireModel> staticCraData}) async {
    SubInput? subInput;
    late Inputs inputs;
    CRAQuestionnaire? craQuestionnaire;
    List<String> sectionNames = [];
    List<CRAQuestionnaire> craQuestion = [];
    List<StaticQuestionModel> staticCraQuestion = [];
    List<CRASectionModel> craSectionModel = [];
    final languageViewModel = Provider.of<LanguageViewModel>(context, listen: false);
    int sectionsLength = isarDB?.sections?.length ?? 0;
    for (int i = 0; i < sectionsLength; i++) {
      sectionNames.add(craData[i].ehrCategoryMap.toString());
      if (craData[i].questionnaireList != []) {
        craQuestion.clear();
        List<Inputs> inputsData = [];
        List subInputsData = [];
        for (int j = 0; j < craData[i].questionnaireList!.length; j++) {
          inputsData = [];
          if (craData[i].questionnaireList![j].toJson().containsKey("inputs") && craData[i].questionnaireList![j].toJson()['inputs'] != "[]") {
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
            ..value = craData[i].questionnaireList![j].toJson()['value']
            ..inputs = inputsData
            ..timeAsked = DateTime.now()
            ..lonic = craData[i].questionnaireList![j].toJson()['loinc']
            ..snomed = craData[i].questionnaireList![j].toJson()['snomed'];
          craQuestion.add(craQuestionnaire);
        }
      }
      List<CRAQuestionnaire> craQuestionnaireData = [];
      craQuestionnaireData.addAll(craQuestion);
      loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
      String userId = loginViewModel?.userDetails?.userId ?? "";
      EHRNotes ehrNotes = EHRNotes()
        ..versionNumber = versionNumber
        ..questions = craQuestionnaireData;
      CRASectionModel craModel = CRASectionModel()
        ..createdBy = userId
        ..locale = languageViewModel.selectedLanguage
        ..patientId = patientId
        ..caseId = caseId
        ..ehrCategoryMapId = craData[i].ehrCategoryMap
        ..ehrNotes = ehrNotes;
      craSectionModel.add(craModel);
    }


    for (int i = 0; i < staticCraData.length; i++) {
      sectionNames.add(staticCraData[i].ehrCategoryMap.toString());
      if (staticCraData[i].questionnaireList != []) {
        staticCraQuestion.clear();
        for (int j = 0; j < staticCraData[i].questionnaireList!.length; j++) {
          craQuestionnaire = CRAQuestionnaire()
            ..questionId = staticCraData[i].questionnaireList![j].toJson()['questionid']
            ..value = staticCraData[i].questionnaireList![j].toJson()['value']
            ..timeAsked = DateTime.now()
            ..lonic = staticCraData[i].questionnaireList![j].toJson()['loinc']
            ..snomed = staticCraData[i].questionnaireList![j].toJson()['snomed'];
          craQuestion.add(craQuestionnaire);
        }
      }
      List<CRAQuestionnaire> craQuestionnaireData = [];
      craQuestionnaireData.addAll(craQuestion);
      loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
      String userId = loginViewModel?.userDetails?.userId ?? "";
      EHRNotes ehrNotes = EHRNotes()
        ..versionNumber = versionNumber
        ..questions = staticCraData[i].questionnaireList.toString() == "[]" ? [] : craQuestionnaireData;
      CRASectionModel craModel = CRASectionModel()
        ..createdBy = userId
        ..locale = languageViewModel.selectedLanguage
        ..patientId = patientId
        ..caseId = caseId
        ..ehrCategoryMapId = staticCraData[i].ehrCategoryMap
        ..ehrNotes = ehrNotes;
      craSectionModel.add(craModel);
    }
    try {
      IsarDbService.isarDbService.saveCRA(CRAOfflineData()
        ..patientId = patientId
        ..caseId = _caseId
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
    craSectionData = [];
    _sectionName = null;
    _caseId = null;
    _versionNumber = null;
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
      } else if (chipType == AppConstant.TEXT_AREA) {
        return _parseTextFormFieldQuestionnaire(element);
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

  saveAttachment(AttachmentModel model) {
    bool fileExists = attachmentList.any((attachment) => attachment?.fileName == model.fileName);
    if (fileExists) {
      CommonFunctions.toastMessage("Image already exists for this ${model.fileName}");
    } else {
      attachmentList.add(model);
    }
    notifyListeners();
  }

  removeAttachment(int index) {
    attachmentList.removeAt(index);
    notifyListeners();
  }

  removeAllAttachment() {
    attachmentList.clear();
    notifyListeners();
  }
}
