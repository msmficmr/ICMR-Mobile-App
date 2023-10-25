import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:mhealth/isar_db_schema/attachment_db_schema.dart';
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
  List<AttachmentModel?> consentList = [];

  String? _caseId;
  String? _sectionName;
  String? _versionNumber;
  String? _languageCode;
  String? _patientId;
  String? _selectedPatientId;
  bool _isPreviousScreen = false;
  bool _allSectionsCompleted = false;

  String? get caseId => _caseId;

  String? get sectionName => _sectionName;

  String? get versionNumber => _versionNumber;

  String? get languageCode => _languageCode;

  String? get patientId => _patientId;

  String? get selectedPatientId => _selectedPatientId;

  bool get isPreviousScreen => _isPreviousScreen;

  bool get allSectionsCompleted => _allSectionsCompleted;

  Map<String, List<Questionnaire>> sectionsData = {};

  /// Updating the value of the [sectionsData] key
  /// Getting the next section index from [questionnaireSections] and adding the values for [_sectionName] & [questionnaireList]
  /// If all the sections are completed then submitting the form

  setNextSectionData(String sectionName, BuildContext context, {List<StaticQuestionModel>? staticSectionsData}) async {
    _allSectionsCompleted = false;
    if (questionnaireSections.contains(sectionName)) {
      int currentIndex = questionnaireSections.indexOf(sectionName);
      if (sectionsData[sectionName] == null) {
        _sectionName = sectionName;
      } else if (currentIndex == questionnaireSections.length - 1) {
        _sectionName = questionnaireSections[currentIndex];
      } else {
        if (!_isPreviousScreen) _sectionName = questionnaireSections[currentIndex + 1];
      }
      if (sectionsData[sectionName] == null) {
        int? index;
        for (int i = 0; i < isarDB!.sections!.length; i++) {
          if (isarDB!.sections![i].uiTemplateId == sectionName) {
            index = i;
          }
        }
        sectionsData[sectionName] = fetchDBQuestions(isarDB!.sections![index!].questionObj ?? []);
      }
      craSectionData.add(CRAModel(sectionName, sectionsData[sectionName]));
      int index = craSectionData.indexWhere((element) => element.ehrCategoryMap == sectionName);
      craSectionData.removeAt(index);
      craSectionData.add(CRAModel(sectionName, sectionsData[sectionName]));
      if (sectionsData[sectionName] != null && _caseId != null) {
        addToDB(craData: CRAModel(sectionName, sectionsData[sectionName]), context: context);
      }
      _isPreviousScreen = false;
    } else {
      int index = staticCraSectionData.indexWhere((element) => element.ehrCategoryMap == sectionName);
      if (index >= 0) staticCraSectionData.removeAt(index);
      staticCraSectionData.add(StaticQuestionnaireModel(sectionName, staticSectionsData));
      if (sectionName == "community_risk_assessment_lesion_location") {
        await addLesionLocationImagesToDB(staticCraData: StaticQuestionnaireModel(sectionName, staticSectionsData), context: context);
      } else {
        await addToDB(staticCraData: StaticQuestionnaireModel(sectionName, staticSectionsData), context: context);
      }
    }
  }

  setSelectedPatientId(String selectedId) => _selectedPatientId = selectedId;

  setCaseId(String caseId) => _caseId = caseId;

  /// From the [sectionName] received in the parameter, we are finding in which index that particular
  /// index is present in the [questionnaireSections] and saving the previous item as [_sectionName]
  /// From the [_sectionName] fetching the previous section data which was saved in the [sectionsData]
  setPreviousSectionData(String sectionName) {
    _isPreviousScreen = true;
    int currentIndex = questionnaireSections.indexOf(sectionName);
    _sectionName = questionnaireSections[currentIndex - 1];
  }

  setVersionNumber(String version) => _versionNumber = version;

  createCaseID() {
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
        if (caseId == null || caseId!.isEmpty) createCaseID();
        setVersionNumber(isarDB!.sections![i].versionNumber.toString());
        questionnaireSections.add(isarDB!.sections![i].sectionName.toString());
        sectionsData[isarDB!.sections![i].sectionName.toString()] = fetchDBQuestions(isarDB!.sections![i].questionObj ?? []);
      }
      _sectionName = questionnaireSections[0];
    }
    notifyListeners();
  }

  setQuestionnaireSections(String language) async {
    isarDB = await IsarDbService.isarDbService.getRAQuestionnaireByLocale("en_US");
    for (int i = 0; i < isarDB!.sections!.length; i++) {
      questionnaireSections.add(isarDB!.sections![i].sectionName.toString());
    }
    notifyListeners();
  }

  addLesionLocationImagesToDB({required StaticQuestionnaireModel staticCraData, required BuildContext context}) async {
    Report? ehrDiagnosisReport;
    List<Report> ehrDiagnosisReports = [];
    List<CRASectionModel> craSectionModel = [];
    final languageViewModel = Provider.of<LanguageViewModel>(context, listen: false);
    try {
      for (int i = 0; i < staticCraData.questionnaireList!.length; i++) {
        AttachmentDb attachment = AttachmentDb()
          ..fileName = staticCraData.questionnaireList![i].toJson()['value']
          ..dataBytes = staticCraData.questionnaireList![i].toJson()['value'];
        ehrDiagnosisReport = Report()
          ..questionId = staticCraData.questionnaireList![i].toJson()['questionid']
          ..snomed = staticCraData.questionnaireList![i].toJson()['snomed']
          ..loinc = staticCraData.questionnaireList![i].toJson()['loinc']
          ..file = attachment
          ..value = staticCraData.questionnaireList![i].toJson()['questionid'].toString().convertToCamelCase();
        ehrDiagnosisReports.add(ehrDiagnosisReport);
        List<Report> craQuestionnaireData = [];
        craQuestionnaireData.addAll(ehrDiagnosisReports);
        loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
        String userId = loginViewModel?.userDetails?.userId ?? "";
        EHRDiagnosisReports diagnosisReports = EHRDiagnosisReports()..questions = ehrDiagnosisReports;
        CRASectionModel craModel = CRASectionModel()
          ..createdBy = userId
          ..locale = languageViewModel.selectedLanguage
          ..patientId = patientId
          ..caseId = caseId
          ..encounterCategoryMapId = staticCraData.ehrCategoryMap
          ..encounterEhrDiagnosisReports = diagnosisReports;
        craSectionModel.add(craModel);
        await IsarDbService.isarDbService.updateCRA(caseId!, craSectionModel[i]);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  addToDB({CRAModel? craData, StaticQuestionnaireModel? staticCraData, required BuildContext context}) async {
    SubInput? subInput;
    late Inputs inputs;
    CRAQuestionnaire? craQuestionnaire;
    List<CRAQuestionnaire> craQuestionnaires = [];
    List<CRASectionModel> craSectionModel = [];
    final languageViewModel = Provider.of<LanguageViewModel>(context, listen: false);

    if (craData != null) {
      List<Inputs> inputsData = [];
      List subInputsData = [];
      for (int i = 0; i < craData.questionnaireList!.length; i++) {
        inputsData = [];
        if (craData.questionnaireList![i].toJson().containsKey("inputs") && craData.questionnaireList![i].toJson()['inputs'] != "[]") {
          List inputsData1 = json.decode(craData.questionnaireList![i].toJson()['inputs']);
          subInputsData = [];
          for (int j = 0; j < inputsData1.length; j++) {
            subInputsData = [];
            if (inputsData1[j]['inputs'].runtimeType == String) {
              subInputsData = jsonDecode(inputsData1[j]['inputs']);
            } else if (inputsData1[j]['inputs'].runtimeType == List<dynamic>) {
              subInputsData = inputsData1[j]['inputs'];
            }
            if (subInputsData.isNotEmpty) {
              subInput = SubInput()
                ..inputId = subInputsData[0]['inputid']
                ..value = subInputsData[0]['value'];
            }
            inputs = Inputs()
              ..inputId = inputsData1[j]['inputid'] ?? inputsData1[j]['questionid']
              ..value = inputsData1[j]['value']
              ..subInput = subInput
              ..timeAsked = inputsData1[j]['timeAsked'] == null ? DateTime.now() : DateTime.parse(inputsData1[j]['timeAsked']);
            inputsData.add(inputs);
            subInput = null;
          }
        }
        craQuestionnaire = CRAQuestionnaire()
          ..questionId = craData.questionnaireList![i].toJson()['questionid']
          ..value = craData.questionnaireList![i].toJson()['value']
          ..inputs = inputsData
          ..timeAsked = DateTime.now()
          ..lonic = craData.questionnaireList![i].toJson()['loinc']
          ..snomed = craData.questionnaireList![i].toJson()['snomed'];
        craQuestionnaires.add(craQuestionnaire);
      }
    }

    try {
      if (staticCraData != null) {
        for (int i = 0; i < staticCraData.questionnaireList!.length; i++) {
          craQuestionnaire = CRAQuestionnaire()
            ..questionId = staticCraData.questionnaireList![i].toJson()['questionid']
            ..value = staticCraData.questionnaireList![i].toJson()['value']
            ..timeAsked = DateTime.now()
            ..lonic = staticCraData.questionnaireList![i].toJson()['loinc']
            ..snomed = staticCraData.questionnaireList![i].toJson()['snomed'];
          craQuestionnaires.add(craQuestionnaire);
        }
      }
    }  catch (e) {
      log(e.toString());
    }

    List<CRAQuestionnaire> craQuestionnaireData = [];
    craQuestionnaireData.addAll(craQuestionnaires);
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
      ..encounterCategoryMapId = craData?.ehrCategoryMap ?? staticCraData?.ehrCategoryMap
      ..ehrNotes = ehrNotes;
    craSectionModel.add(craModel);
    log("Line 261 ${(craData?.ehrCategoryMap)} ${isarDB!.sections!.map((e) => e.sectionName)}");
      if (craData?.ehrCategoryMap != isarDB!.sections![0].sectionName) {
        await IsarDbService.isarDbService.updateCRA(_caseId!, craSectionModel[0]);
      } else {
        bool craDataAvailable = await IsarDbService.isarDbService.checkIfCRADataPresent(_caseId!);
        if (!craDataAvailable) {
          IsarDbService.isarDbService.saveCRA(CRAOfflineData()
            ..patientId = patientId
            ..caseId = _caseId
            ..languageCode = languageViewModel.selectedLanguage
            ..craSectionData = craSectionModel);
        } else {
          await IsarDbService.isarDbService.removeDuplicateInQuestionnaire(_caseId!, craSectionModel[0]);
        }
      }

      if ((craData?.ehrCategoryMap ?? staticCraData?.ehrCategoryMap) == "community_risk_assessment_verification_form") {
        resetAll();
      }
  }

  resetAll() {
    questionnaireSections = [];
    craSectionData = [];
    staticCraSectionData = [];
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

  saveConsent(AttachmentModel model) {
    bool fileExists = consentList.any((consent) => consent?.fileName == model.fileName);
    if (fileExists) {
      CommonFunctions.toastMessage("Image already exists for this ${model.fileName}");
    } else {
      consentList.add(model);
    }
    notifyListeners();
  }

  removeConsent(int index) {
    consentList.removeAt(index);
    notifyListeners();
  }

  removeAllConsents() {
    consentList.clear();
    notifyListeners();
  }
}
