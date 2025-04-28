import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/model/questionnaire_input_model.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/views/questionair/model/section_type_model.dart';
import 'package:mhealth/views/questionair/util/question_parse_util.dart';
import 'package:uuid/uuid.dart';

class QuestionViewModel extends ChangeNotifier {
  String sectionId;
  String patientId;
  String caseId;
  QuestionViewModel(this.sectionId, this.patientId, this.caseId);

  //MUST CALL BEFORE TAKING CRA
  static resetViewModel() {
    _patientEhrDetails = null;
    _templateList = [];
  }

  ///
  static List<SectionTypeModel> sectionList = [
    SectionTypeModel(id: "community_risk_assessment_details_of_habits", name: "Details of Habits", type: "JSON", version: "V1.0"),
    SectionTypeModel(id: "community_risk_assessment_baseline_signs_or_symptoms", name: "Baseline signs / symptoms", type: "JSON", version: "V1.0"),
    SectionTypeModel(id: "community_risk_assessment_periodontal_status", name: "Periodontal Status", type: "WIDGET", version: "V1.0"),
    SectionTypeModel(id: "community_risk_assessment_lesion_location", name: "Lesion Location (mark the site)", type: "WIDGET", version: "V1.0"),
    SectionTypeModel(id: "community_risk_assessment_clinical_examination", name: "Clinical Examination", type: "JSON", version: "V1.0"),
    SectionTypeModel(id: "community_risk_assessment_investigation", name: "Investigations", type: "JSON", version: "V1.0"),
    SectionTypeModel(id: "community_risk_assessment_verification_form", name: " Verification Form", type: "WIDGET", version: "V1.0"),
  ];

  static CRAOfflineData? _patientEhrDetails;
  static List<QuestionnairesModel> _templateList = [];
  ApiStatus _fetchQuestionsApiStatus = ApiStatus.success;
  ApiStatus _fetchEhrDetailsStatus = ApiStatus.success;
  List<Questionnaire> _questionList = [];

  ApiStatus get fetchEhrDetailsStatus => _fetchEhrDetailsStatus;
  ApiStatus get fetchQuestionsApiStatus => _fetchQuestionsApiStatus;
  SectionTypeModel get currentSection => sectionList.firstWhere((element) => element.id == sectionId);
  List<QuestionnairesModel> get templateList => _templateList;
  List<Questionnaire> get questionList => _questionList;

  String? get nextSectionId {
    int index = sectionList.indexWhere((element) => element.id == sectionId);
    if (index == sectionList.length - 1) return null;
    return sectionList[index + 1].id;
  }

  set fetchEhrDetailsStatus(ApiStatus status) {
    _fetchEhrDetailsStatus = status;
    notifyListeners();
  }

  set fetchQuestionsApiStatus(ApiStatus status) {
    _fetchQuestionsApiStatus = status;
    notifyListeners();
  }

  set questionList(List<Questionnaire> list) {
    _questionList = list;
    notifyListeners();
  }

  fetchEncounterDetails() async {
    if (_templateList.isNotEmpty) {
      return;
    }
    try {
      fetchQuestionsApiStatus = ApiStatus.loading;
      _templateList.clear();
      RiskAssessmentQuestionaire? raQuest = await IsarDbService.isarDbService.getTemplate(local: LanguageViewModel.languageViewModel.currentLanguage);

      if (raQuest != null) {
        for (QuestionnairesModel sectionQuestions in raQuest.sections ?? []) {
          bool include = sectionList.any((element) => element.id == sectionQuestions.uiTemplateId && element.version == sectionQuestions.versionNumber);
          if (include) {
            _templateList.add(sectionQuestions);
          }
        }
        fetchQuestionsApiStatus = ApiStatus.success;
      } else {
        fetchQuestionsApiStatus = ApiStatus.error;
      }
    } catch (e) {
      fetchQuestionsApiStatus = ApiStatus.error;
    }
  }

  fetchPatientEhrDetails({bool forceRefresh = false}) async {
    if (_patientEhrDetails != null && !forceRefresh) return; // don't load Details if already loaded

    try {
      if (!forceRefresh) fetchEhrDetailsStatus = ApiStatus.loading;
      _patientEhrDetails = await IsarDbService.isarDbService.getCRAByPatientAndCase(patientId, caseId);
      if (!forceRefresh) fetchEhrDetailsStatus = ApiStatus.success;
    } catch (e) {
      if (!forceRefresh) fetchEhrDetailsStatus = ApiStatus.error;
    }
  }

  fetchSectionQuestions() {
    switch (currentSection.type) {
      case "JSON":
        QuestionnairesModel sectionDetails = _templateList.firstWhere((element) => element.uiTemplateId == sectionId);
        questionList = [...QuestionParseUtil().fetchDBQuestions(sectionDetails.questionObj ?? [])];
        break;
      case "WIDGET":
        switch (currentSection.id) {
          case "community_risk_assessment_periodontal_status":
            questionList = [PeriodontalStatusQuestionnaire(currentSection.version)];
            break;
          case "community_risk_assessment_lesion_location":
            questionList = [LesionLocationQuestionnaire(currentSection.version)];
            break;
          case "community_risk_assessment_verification_form":
            questionList = [VerificationFormQuestionnaire(currentSection.version)];
            break;
        }
        break;
    }
    _bindAnswers();
  }

  _bindAnswers() {
    if (_patientEhrDetails != null) {
      int? ehrIndex = _patientEhrDetails?.craSectionData?.indexWhere((element) => element.encounterCategoryMapId == sectionId);
      if (ehrIndex != null && ehrIndex != -1) {
        EHRNotes? ehrNotes = _patientEhrDetails?.craSectionData?[ehrIndex].ehrNotes;
        EHRDiagnosisReports? diagnosisReports = _patientEhrDetails?.craSectionData?[ehrIndex].encounterEhrDiagnosisReports;
        if (ehrNotes != null) {
          switch (currentSection.type) {
            case "JSON":
              _populateEhrNotesByJson(ehrNotes);
              break;
            case "WIDGET":
              _populateEhrNotesByWidget(ehrNotes, diagnosisReports);
              break;
          }
          notifyListeners();
        }
      }
    }
  }

  void _populateEhrNotesByJson(EHRNotes ehrNotes) {
    questionList.forEach((element) {
      String questionId = element.getId();

      int? ehrAnswerIndex = ehrNotes.questions?.indexWhere((element) => element.questionId == questionId);
      if (ehrAnswerIndex != null && ehrAnswerIndex != -1) {
        CRAQuestionnaire? answerDetails = ehrNotes.questions?[ehrAnswerIndex];
        if (answerDetails != null) {
          /// THIS INPUTS IS FOR SELECTING MULTIPLE VALUES
          /// RIGHT NOW WE DON'T HAVE ANY SUCH QUESTIONS
          /// don't have provision in isar schema
          List<QuestionnaireInputModel> multipleAnswers = [];
          element.setSelected(answerDetails.value, multipleAnswers);

          /// populate follow up questions
          List<Inputs> inputs = (answerDetails.inputs ?? []);

          element.getFollowupQuestionnaires().forEach((element) {
            String followUpId = element.getId();

            int followUpIndex = inputs.indexWhere((element) => element.inputId == followUpId);

            if (followUpIndex != -1) {
              element.setSelected(inputs[followUpIndex].value, []);
            }
          });
        }
      }
    });
  }

  void _populateEhrNotesByWidget(EHRNotes ehrNotes, EHRDiagnosisReports? diagnosisReports) {
    ///WIDGET TYPE WILL ALWAYS HAVE ONLY ONE QUESTIONNAIRE
    questionList.first.populateByEhrNotes(ehrNotes, diagnosisReports);
  }

  Future<bool> saveToDB() async {
    CRAOfflineData? craDetails = await IsarDbService.isarDbService.getCRAByPatientAndCase(patientId, caseId);

    List<DoctorModel>? _doctorDetails = await _getDoctorDetails();

    //Preparing EhrNotes
    CRASectionModel craSectionModel = _buildEhrNotes();

    //Update Details
    if (craDetails != null) {
      await IsarDbService.isarDbService.updateCRA(caseId: caseId, craData: craSectionModel, docDetails: _doctorDetails ?? []);
    } else {
      CRAOfflineData craData = CRAOfflineData()
        ..caseId = caseId
        ..patientId = patientId
        ..craSectionData = [craSectionModel]
        ..docDetails = _doctorDetails
        ..languageCode = LanguageViewModel.languageViewModel.selectedLanguage;

      await IsarDbService.isarDbService.saveCRA(craData);
    }
    await fetchPatientEhrDetails(forceRefresh: true);
    return true;
  }

  CRASectionModel _buildEhrNotes() {
    List<CRAQuestionnaire> myQuestionsList = [];

    switch (currentSection.type) {
      case "JSON":
        myQuestionsList = _getEhrNotesOfJson();
        break;
      case "WIDGET":
        myQuestionsList = _getEhrNotesOfWidget();
        break;
    }

    EHRNotes ehrNotes = EHRNotes();
    ehrNotes.versionNumber = currentSection.version;
    ehrNotes.questions = myQuestionsList;


    CRASectionModel craSectionModel = CRASectionModel();
    craSectionModel.caseId = caseId;
    craSectionModel.encounterCategoryMapId = currentSection.id;
    craSectionModel.patientId = patientId;
    craSectionModel.locale = LanguageViewModel.languageViewModel.selectedLanguage;
    craSectionModel.ehrNotes = ehrNotes;
    craSectionModel.createdBy = LoginViewModel.loginViewModel.userDetails?.userId;
    craSectionModel.encounterEhrDiagnosisReports = _getEhrDiagnosisReport();

    return craSectionModel;
  }

  List<CRAQuestionnaire> _getEhrNotesOfJson() {
    List<CRAQuestionnaire> myQuestionsList = [];
    for (int i = 0; i < questionList.length; i++) {
      Questionnaire question = questionList[i];
      Map<String, dynamic> questionJson = question.toJson();

      List<Inputs> inputsData = [];

      if (questionJson.containsKey("inputs")) {
        String inputData = questionJson["inputs"];
        List<dynamic> inputList = jsonDecode(inputData);
        for (var input in inputList) {
          Inputs ip = Inputs()..fromJson(input);
          ip.timeAsked = DateTime.parse(questionJson["timeAsked"]);

          //SUBInput
          inputsData.add(ip);
        }
      }

      String questionId = questionJson['questionid'];
      String value = questionJson['value'];
      String loinc = questionJson['loinc'];
      String snomed = questionJson['snomed'];
      DateTime timeAsked = questionJson['timeAsked'] == null ? DateTime.now() : DateTime.parse(questionJson['timeAsked']);

      CRAQuestionnaire craQuestionnaire = CRAQuestionnaire()
        ..questionId = questionId
        ..value = value
        ..inputs = inputsData
        ..timeAsked = timeAsked
        ..lonic = loinc
        ..snomed = snomed;

      myQuestionsList.add(craQuestionnaire);
    }
    return myQuestionsList;
  }

  /// WIDGET TYPE WILL ALWAYS HAVE ONLY ONE QUESTIONNAIRE
  List<CRAQuestionnaire> _getEhrNotesOfWidget() => questionList.first.getEhrNotes();

  EHRDiagnosisReports? _getEhrDiagnosisReport() {
    switch (currentSection.type) {
      case "JSON":
        // JSON TYPE QUESTIONNAIRE WILL NOT HAVE EHRDiagnosisReports
        return null;
      case "WIDGET":
        return questionList.first.getEhrDiagnosisReports();
    }
    return null;
  }

  Future<List<DoctorModel>?> _getDoctorDetails() async {
    DoctorModel doctorModel = DoctorModel();
    String? docName;
    try {
      bool hasDoctor = await SharedPreferencesService.sharedPreferencesService.hasKey(AppConstant.SHREAD_PREF_DOC_KEY);
      if (hasDoctor) {
        docName = await SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.SHREAD_PREF_DOC_KEY);
        if (docName != null) {
          doctorModel.id = _stringToId(docName);
          doctorModel.name = docName;
        }
      }
    } catch (e) {}
    return docName == null ? null : [doctorModel];
  }

  String _stringToId(String input) {
    var uuid = Uuid();
    return uuid.v5(Uuid.NAMESPACE_URL, input);
  }
}
