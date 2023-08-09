import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';
import 'package:mhealth/viewModel/chat_bot/edit_conversation.dart';
import 'package:mhealth/viewModel/chat_bot/get_encounters_all_data.dart';
import 'package:mhealth/viewModel/chat_bot/get_xml_widget.dart';
import 'package:mhealth/viewModel/chat_bot/intents/get_final_intent.dart';
import 'package:mhealth/viewModel/chat_bot/intents/intents.dart';
import 'package:mhealth/viewModel/chat_bot/prepare_response.dart';
import 'package:mhealth/viewModel/chat_bot/submit_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatBotViewModel extends ChangeNotifier {
  final Questionnaires _questionnairesRepository = Questionnaires();

  Map<String, String> _languageMap = {};

  Map<String, String> get languageMapObject => _languageMap;

  Map<String, String> _sections = { "personal_history" : "Personal History", "health_habit" : "Health Habit", "fagerstorm" : "Fagerstorm"};
  Map<String, String> get sections => _sections;

  /// using global variable for using animations
  final GlobalKey<AnimatedListState> animationKey = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController();

  late BuildContext _context;

  int initialSectionCount = 0; // to keep track of how many questions did the user started with
  String? encounterEhrId; // unique id based on caseId and sectionId
  String? _mobileNumber;
  String? _email;

  int _widgetIndex = 0;
  int _totalQuestions = 0;
  int _currentQuestionNo = 0; // current questionNo in this section
  bool _isLastQuestion = false;
  bool _isRegFlow = false;
  bool _hasCaseId = false;
  bool _isNextSuggestionClickable = true;
  bool _isPreviousChatButtonClickable = true;
  bool _caseSubmittedOnce = false;
  bool _isInsuranceDisabled = false;
  bool _isAssessmentCompleted = false;
  bool _isNewChatScreenMounted = false; // tracks if the newChat screen is mounted or not
  String _patientName = "";
  String _currentLanguage = "en_US";
  String? _currentSectionId;
  String? _currentEncounterId;
  String? _currentCaseId;
  String? _currentSectionName;
  String _currentVersionNumber = "";
  List _conversationToSend = [];
  Map<String, String> _sectionNameIdMap = {};
  Map<String, dynamic> _questionObj = {};
  Map<String, Map<String, dynamic>> _screeningSections = {};
  ServiceFlow _serviceFlow = ServiceFlow.riskAssessment;

  int get widgetIndex => _widgetIndex;

  int get totalQuestions => _totalQuestions;

  int get currentQuestionNo => _currentQuestionNo;

  bool get isLastQuestion => _isLastQuestion;

  bool get isRegFlow => _isRegFlow;

  bool get hasCaseId => _hasCaseId;

  bool get isNextSuggestionClickable => _isNextSuggestionClickable;

  bool get isPreviousChatButtonClickable => _isPreviousChatButtonClickable;

  bool get caseSubmittedOnce => _caseSubmittedOnce;

  bool get isInsuranceDisabled => _isInsuranceDisabled;

  bool get isAssessmentCompleted => _isAssessmentCompleted;

  bool get isNewChatScreenMounted => _isNewChatScreenMounted;

  String get patientName => _patientName;

  String get currentLanguage => _currentLanguage;

  String? get currentSectionId => _currentSectionId;

  String? get currentEncounterId => _currentEncounterId;

  String? get currentCaseId => _currentCaseId;

  String? get currentSectionName => _currentSectionName;

  String get currentVersionNumber => _currentVersionNumber;

  List get conversationToSend => _conversationToSend;

  Map<String, String> get sectionNameIdMap => _sectionNameIdMap;

  Map<String, dynamic> get questionObj => _questionObj;

  Map<String, Map<String, dynamic>> get screeningSections => _screeningSections;

  ServiceFlow get serviceFlow => _serviceFlow;

  PhaseStatus? _currentPhaseStatus;

  void setIndex({required int widgetIndex}) {
    _widgetIndex = widgetIndex;
    notifyListeners();
  }

  void setIsPreviousChatButtonClickable({required bool isPreviousChatButtonClickable}) {
    _isPreviousChatButtonClickable = isPreviousChatButtonClickable;
  }

  void setIsNextSuggestionClickable({required bool isNextSuggestionClickable}) {
    _isNextSuggestionClickable = isNextSuggestionClickable;
  }

  void setPatientName({required String patientName}) {
    _patientName = patientName;
  }

  void setIsLastQuestion(bool isLastQuestion) {
    _isLastQuestion = isLastQuestion;
  }

  void setBuildContext(BuildContext context) {
    _context = context;
  }

  void setTotalQuestions({required int totalQuestions}) {
    _totalQuestions = totalQuestions;
  }

  void setCaseSubmittedOnce({required bool caseSubmittedOnce}) {
    _caseSubmittedOnce = caseSubmittedOnce;
  }

  void setServiceFlow({required ServiceFlow newFlow}) {
    _serviceFlow = newFlow;
  }

  void changeServiceFlowTo({required ServiceFlow newServiceFlow}) {
    _serviceFlow = newServiceFlow;
    notifyListeners();
  }

  void setCurrentPhaseStatus({required PhaseStatus currentPhaseStatus}) {
    _currentPhaseStatus = currentPhaseStatus;
  }

  Future<void> setLanguage({String? languageCode}) async {
    _currentLanguage = languageCode ?? await CommonFunctions.getLanguageKey() ?? "en_US";
  }

  Future<void> setCurrentCaseId({String? caseId}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (caseId == null) {
      _currentCaseId = sharedPreferences.getString(AppConstant.CASE_ID);
    } else {
      sharedPreferences.setString(AppConstant.CASE_ID, caseId);
      _currentCaseId = caseId;
    }
  }

  setCurrentVersionNumber({required String currentVersionNumber}) {
    _currentVersionNumber = currentVersionNumber;
  }

  setLanguagesList({required Map<String, String> languageMap}) {
    _languageMap = languageMap;
  }

  setConversationToSend({required Map<String, dynamic> response}) {
    _conversationToSend.add(response);
  }

  setCurrentSectionId({String? currentSectionId}) {
    _currentSectionId = currentSectionId;
  }

  setCurrentSectionName({String? currentSectionName}) {
    _currentSectionName = currentSectionName;
  }

  setCurrentQuestionNo({required int currentQuestionNo}) {
    _currentQuestionNo = currentQuestionNo;
  }

  setIsInsuranceDisabled({required bool isInsuranceDisabled}) {
    _isInsuranceDisabled = isInsuranceDisabled;
  }

  setIsAssessmentCompleted({required bool isAssessmentCompleted}) {
    _isAssessmentCompleted = isAssessmentCompleted;
  }

  setQuestionObject({required Map<String, dynamic> questionObject}) {
    _questionObj = questionObject;
  }

  removeLastConversationToSend() {
    _conversationToSend.removeLast();
  }

  void setSectionNameIdMap({required String sectionName, required String sectionId}) {
    _sectionNameIdMap[sectionName] = sectionId;
  }

  void clearConversationToSendList() {
    _conversationToSend.clear();
  }

  void setNewChatScreenMount(bool isMounted) {
    _isNewChatScreenMounted = isMounted;
  }

  void setHasCaseId({required bool asCaseId}) {
    _hasCaseId = asCaseId;
  }

  /// Forces provider to setstate on external command
  void notify() {
    notifyListeners();
  }

  void addToConversation({
    required String questionId,
    required String question,
    required String chipType,
    required DateTime timeAsked,
    bool hasFollowUp = false,
    bool isFollowUp = false,
    Map<String, dynamic> followupQuestions = const {},
    bool hasOptions = true,
    List<String> options = const [],
    List<String> optionKeys = const [],
    int? selectedOptionIndex,
    String? answer,
    bool isEditable = false,
  }) {
    _questionnairesRepository.conversation.addFirst(ConversationModel(
      questionId: questionId,
      question: question,
      chipType: chipType,
      timeAsked: timeAsked,
      hasFollowUp: hasFollowUp,
      isFollowUp: isFollowUp,
      followupQuestions: followupQuestions,
      hasOptions: hasOptions,
      options: options,
      optionKeys: optionKeys,
      selectedOptionIndex: selectedOptionIndex,
      answer: answer,
      isEditable: false,
    ));
    if (animationKey.currentState != null) {
      int animationDuration = 800;
      if (selectedOptionIndex == null && chipType != AppConstant.SINGLE_TEXT_FIELD && chipType != AppConstant.CHIP_WITH_MULTISELECT_TEXTFORM) {
        animationDuration = 1200;
      }
      animationKey.currentState!.insertItem(0, duration: Duration(milliseconds: animationDuration));
    }
    notifyListeners();
  }

  Future<void> addScreeningSection({
    required String encounterId,
    required String sectionName,
    required Map<String, dynamic> value,
  }) async {
    try {
      if (_screeningSections.containsKey(encounterId)) {
        _screeningSections[encounterId]?[sectionName] = value;
      } else {
        _screeningSections[encounterId] = {};
        _screeningSections[encounterId]?[sectionName] = value;
      }
    } catch (error, stackTrace) {
      CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
    }
  }

  Future<void> clearScreeningData({required bool clearSharedPreferences}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (clearSharedPreferences) {
      sharedPreferences.clear();
    } else {
      sharedPreferences.remove(AppConstant.CASE_ID);
    }

    try {
      if (animationKey.currentState != null) {
        for (var i = 0; i < _questionnairesRepository.getLength; i++) {
          animationKey.currentState!.removeItem(0, (context, animation) => Container());
        }
      }
    } catch (error, stackTrace) {
      CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
    }

    _questionnairesRepository.clearConversation();
    _screeningSections.clear();
    _conversationToSend.clear();
    _currentEncounterId = null;
    _currentSectionId = null;
    _currentSectionName = null;
    _currentQuestionNo = 0;
    _screeningSections.clear();
    _caseSubmittedOnce = false;
    encounterEhrId = null;
    _currentCaseId = null;
    _isNewChatScreenMounted = false;
  }

  Future<void> cleaScreeningData2() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(AppConstant.CASE_ID);
    try {
      if (animationKey.currentState != null) {
        for (var i = 0; i < _questionnairesRepository.getLength; i++) {
          animationKey.currentState!.removeItem(0, (context, animation) => Container());
        }
      }
    } catch (error) {
      CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
    }
    _questionnairesRepository.clearConversation();
    _screeningSections.clear();
    _conversationToSend.clear();
    _currentEncounterId = null;
    _currentSectionId = null;
    _currentSectionName = null;
    _currentQuestionNo = 0;
    _screeningSections.clear();
    _caseSubmittedOnce = false;
    encounterEhrId = null;
    _currentCaseId = null;
    _isNewChatScreenMounted = false;
  }

  /// This method is implemented for Invoking Welcome intents for mHealth
  void getWelcomeIntent({required BuildContext context, bool userHasPreviousChat = false}) async {
    if (serviceFlow == ServiceFlow.languageIntent) {
      if (!userHasPreviousChat) {
        await Encounters().getEncountersData(context: context);
      }

      if (_patientName.isNotEmpty) {
        _questionnairesRepository.addToConversation(
            questionId: AppConstant.IN_BUILT_QUESTION,
            question: CommonFunctions.toLocale("welcome_back", currentLanguage, _patientName),
            chipType: AppConstant.CHIP_OPTIONS,
            timeAsked: DateTime.now(),
            hasOptions: false);
      }
      setServiceFlow(newFlow: ServiceFlow.languageIntent);
      if (_hasCaseId) {
        if (_currentPhaseStatus != null && _currentPhaseStatus == PhaseStatus.PAYMENT_SUCCESS) {
          Intents().getLanguageIntent(context: context, languageMap: _languageMap);
        } else {
          Intents().getPreviousChatButtonIntent(context: context);
        }
      } else {
        Intents().getLanguageIntent(context: context, languageMap: _languageMap);
      }
      _currentQuestionNo = 0;
    } else {
      List<String> dfIntents = [
        "KAREMITRA_SERVICES",
      ];
      if (_isNewChatScreenMounted) {
        for (String intent in dfIntents) {
          try {
            // final response = await EdgeService.getDFIntent(
            //   intentName: intent,
            //   locale: _currentLanguage,
            //   caseId: _currentCaseId,
            // );
            // _isNextSuggestionClickable = true;
            // final responseBody = jsonDecode(response.body);
            // // parsing the intent response
            // _questionObj = getXmlWidget(responseBody[AppConstant.QUESTIONS]);
            // // add to conversation stack
            // _questionnairesRepository.addToConversation(
            //   questionId: AppConstant.IN_BUILT_QUESTION,
            //   question: _questionObj["question"],
            //   chipType: _questionObj["type"],
            //   timeAsked: DateTime.now(),
            //   hasOptions: (_questionObj["suggestions"] as List<String>).isNotEmpty,
            //   options: _questionObj["suggestions"],
            //   optionKeys: _questionObj["optionKeys"],
            //   hasFollowUp: (_questionObj["inputs"] as Map<String, dynamic>).isNotEmpty,
            //   followupQuestions: _questionObj["inputs"],
            // );

          } on CustomException catch (error, stackTrace) {
            _isNextSuggestionClickable = true;
            Navigator.of(context).pop();
            CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
          } catch (error, stackTrace) {
            _isNextSuggestionClickable = true;
            CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
          }

          // Delay added for asthetics
          await Future.delayed(const Duration(seconds: 2), () {});
        }
      }
    }
  }

  //TODO :: add proper docs for methods and what they do
  Future<void> onUserInputOptions({required var conversationModel, required BuildContext context}) async {
    //TODO :: refactor the serviceFlow Variable name
    //checking what type of questions we are getting
    log("onUserInputOptions");
    if (serviceFlow == ServiceFlow.registration && !_isLastQuestion) {
      var questionsList;

      try {
        // final registrationResponseObj = await EdgeService().getRegistrationDialogFlow(_currentQuestionNo);
        // if (registrationResponseObj.body.isNotEmpty) {
        //   _isNextSuggestionClickable = true;
        //   questionsList = jsonDecode(registrationResponseObj.body);
        //   _questionObj = await getXmlWidget(questionsList[AppConstant.QUESTIONS]);
        //
        //   _questionnairesRepository.addToConversation(
        //     questionId: _questionObj["questionId"].toString(),
        //     question: _questionObj[AppConstant.QUESTION].toString(),
        //     chipType: _questionObj[AppConstant.TYPE],
        //     timeAsked: DateTime.now(),
        //     options: _questionObj["suggestions"],
        //     optionKeys: _questionObj["optionKeys"],
        //     hasOptions: (_questionObj["suggestions"] as List<String>).isNotEmpty,
        //     hasFollowUp: (_questionObj["inputs"] as Map<String, dynamic>).isNotEmpty,
        //     followupQuestions: _questionObj["inputs"],
        //     isEditable: true,
        //   );
        //   _isLastQuestion = questionsList["endFlag"];
        //   if (!_isLastQuestion) {
        //     _currentQuestionNo = _currentQuestionNo + 1;
        //   }
        // }
      } catch (error, stackTrace) {
        _isNextSuggestionClickable = true;
        CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
      }
      //TODO: remove unnecessary notifyListeners if variable are not updating
      notifyListeners();
    } else if (serviceFlow == ServiceFlow.loginIntent) {
      var questionsList;

      _currentQuestionNo = _currentQuestionNo + 1;

      /// [getLanguagesList()] is used to get language codes and names
      // await getLanguagesList(context: context);

      var registrationResponseObj;
      if (serviceFlow == ServiceFlow.registration) {
        try {
          // registrationResponseObj = await EdgeService().getRegistrationDialogFlow(_currentQuestionNo);
          _isNextSuggestionClickable = true;
        } catch (error, stackTrace) {
          _isNextSuggestionClickable = true;
          CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
        }
      } else if (serviceFlow == ServiceFlow.riskAssessment) {
        if (_patientName.length > 0) {
          _questionnairesRepository.addToConversation(
              questionId: AppConstant.IN_BUILT_QUESTION,
              question: CommonFunctions.toLocale("welcome_back", currentLanguage, _patientName),
              chipType: AppConstant.CHIP_OPTIONS,
              timeAsked: DateTime.now(),
              hasOptions: false);
        }
        setServiceFlow(newFlow: ServiceFlow.languageIntent);

        /// The [_hasCaseId] will be true if the user has at least one caseID
        /// If _currentPhaseStatus is PAYMENT_SUCCESS, it will show Language question
        /// else it will show Previous Chat button.

        if (_hasCaseId) {
          if (_currentPhaseStatus != null && _currentPhaseStatus == PhaseStatus.PAYMENT_SUCCESS) {
            Intents().getLanguageIntent(context: context, languageMap: _languageMap);
          } else {
            Intents().getPreviousChatButtonIntent(context: context);
          }
        } else {
          Intents().getLanguageIntent(context: context, languageMap: _languageMap);
        }
        _currentQuestionNo = 0;
      }
      if (registrationResponseObj != null) {
        questionsList = jsonDecode(registrationResponseObj.body);
        _questionObj = await getXmlWidget(questionsList[AppConstant.QUESTIONS]);

        _questionnairesRepository.addToConversation(
          questionId: _questionObj["questionId"].toString(),
          question: _questionObj[AppConstant.QUESTION].toString(),
          chipType: _questionObj[AppConstant.TYPE],
          timeAsked: DateTime.now(),
          options: _questionObj["suggestions"],
          optionKeys: _questionObj["optionKeys"],
          hasOptions: (_questionObj["suggestions"] as List<String>).isNotEmpty,
          hasFollowUp: (_questionObj["inputs"] as Map<String, dynamic>).isNotEmpty,
          followupQuestions: _questionObj["inputs"],
          isEditable: true,
        );
        _isLastQuestion = questionsList["endFlag"];
        if (!_isLastQuestion) {
          _currentQuestionNo = _currentQuestionNo + 1;
        }
      }
      notifyListeners();
    } else if (serviceFlow == ServiceFlow.registration && _isLastQuestion) {
      // await patientRegistration(context: _context);
      _isRegFlow = true;
      setServiceFlow(newFlow: ServiceFlow.languageIntent);
      Intents().getRiskAssessmentPaymentIntent(context: context, currentLanguage: _currentLanguage, patientName: _patientName, isRegFlow: _isRegFlow);
    } else if (serviceFlow == ServiceFlow.riskAssessment) {
      if (_questionnairesRepository.presentSectionEnded) {
        prepareResponse(conversationModel: conversationModel, currentVersionNumber: _currentVersionNumber, context: _context);
        await submitSection(context: context);
        _screeningSections[_currentEncounterId]!.remove(_currentSectionName);
        if (_screeningSections[_currentEncounterId]!.isEmpty) {
          _isLastQuestion = true;
          getFinalIntent(context: context);
        } else {
          _questionnairesRepository.addToConversation(
              questionId: AppConstant.IN_BUILT_QUESTION,
              question: CommonFunctions.getSectionQuestion(isRegFlow: _isRegFlow, currentLanguage: _currentLanguage),
              chipType: AppConstant.CHIP_OPTIONS,
              timeAsked: DateTime.now(),
              hasOptions: _screeningSections[_currentEncounterId]!.keys.toList().length > 0,
              options: _screeningSections[_currentEncounterId]!.keys.toList());
          _questionnairesRepository.setIsInBuiltQuestion = true;
          _questionnairesRepository.setPresentSectionEnded = true;
          _currentSectionId = null;
          _currentSectionName = null;
        }
      } else {
        if (_currentCaseId == null) {
          if (_patientName.isNotEmpty) {
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            // _questionnairesRepository.addToConversation(
            //     questionId: AppConstant.IN_BUILT_QUESTION,
            //     question: "Welcome back ${sharedPreferences.get(AppConstant.USER_FULLNAME_KEY)}, you are already registered with us, please proceed with the assessment.",
            //     chipType: AppConstant.CHIP_OPTIONS,
            //     timeAsked: DateTime.now(),
            //     hasOptions: false);
          }
          await getRiskAssessmentSections(CommonFunctions.getSectionQuestion(isRegFlow: _isRegFlow, currentLanguage: _currentLanguage));
          _currentQuestionNo = 0;
        } else {
          prepareResponse(conversationModel: conversationModel, currentVersionNumber: _currentVersionNumber, context: _context);
          await _questionnairesRepository.fetchNextQuestion(
            context: context,
            questionId: _questionnairesRepository.nextQuestionId,
            encounterId: _currentEncounterId!,
            ehrCategoryId: _currentSectionId!,
          );
          _currentQuestionNo += 1;
        }
      }
    }
    passEditableValue(context: context, showEditOption: _serviceFlow != ServiceFlow.registration);
  }

  getRiskAssessmentSections(String label) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? patientId = sharedPreferences.getString(AppConstant.PATIENT_ID_KEY);
    // if (_currentCaseId == null && patientId != null) {
    //   _serviceFlow = ServiceFlow.riskAssessment;
    //   _currentSectionName = EncounterIds.RISK_ASSESSMENT.name;
    //
    //   _currentEncounterId = EncounterIds.RISK_ASSESSMENT.name;
    //
    //   final sharedPreference = await SharedPreferences.getInstance();
    //   final String? caseIdValue = sharedPreference.getString(AppConstant.CASE_ID);
    //
    //   if (caseIdValue != null && caseIdValue.isNotEmpty) {
    //     intentData(lable: label);
    //     return;
    //   } else {
    //     try {
    //       final resObj = await createCase(map: {"encounterId": EncounterIds.RISK_ASSESSMENT.name});
    //       if (resObj != null) {
    //         intentData(lable: label);
    //         return;
    //       } else {
    //         CommonFunctions.toastMessage("Try Again...");
    //       }
    //     } catch (error, stackTrace) {
    //       CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
    //     }
    //   }
    // } else {
    //   _serviceFlow = ServiceFlow.riskAssessment;
    //   _currentSectionName = EncounterIds.RISK_ASSESSMENT.name;
    //   _currentEncounterId = EncounterIds.RISK_ASSESSMENT.name;
    //   return;
    // }
  }

  intentData({required String label}) async {
    await setCurrentCaseId();
    _questionnairesRepository.addToConversation(
        questionId: AppConstant.IN_BUILT_QUESTION,
        question: label,
        chipType: AppConstant.CHIP_OPTIONS,
        timeAsked: DateTime.now(),
        hasOptions: true,
        optionKeys: _screeningSections[_currentEncounterId]!.keys.toList(),
        options: _screeningSections[_currentEncounterId]!.keys.toList());
    initialSectionCount = _screeningSections[_currentEncounterId]!.keys.toList().length;
    _questionnairesRepository.setIsInBuiltQuestion = true;
    _questionnairesRepository.setPresentSectionEnded = true;
    notifyListeners();
  }

  Future<void> onUserSelectsOption({required var conversationModel, required BuildContext context}) async {
    String selectedOption = conversationModel.options[conversationModel.selectedOptionIndex!];
    log("onUserSelectsOption $selectedOption $serviceFlow");
    if (serviceFlow == ServiceFlow.none) {
      log("ServiceFlow.none");
      await _questionnairesRepository.fetchAllQuestionnaires();
      await _questionnairesRepository.fetchNextQuestion(context: context,  questionId: _questionnairesRepository.nextQuestionId,
        encounterId: _currentEncounterId ?? "",
        ehrCategoryId: _currentSectionId ?? "");
    } else if (serviceFlow == ServiceFlow.languageIntent) {
      String selectedLocale = _languageMap[selectedOption] ?? "en_US";
      await setLanguage(languageCode: selectedLocale);
      await Encounters().getEncountersData(context: _context);
      setServiceFlow(newFlow: ServiceFlow.riskAssessment);
      await getRiskAssessmentSections(CommonFunctions.getSectionQuestion(isRegFlow: _isRegFlow, currentLanguage: _currentLanguage));
      _isRegFlow = false;
    } else if (serviceFlow == ServiceFlow.riskAssessment) {
      log("Line 652");
      if (!_questionnairesRepository.presentSectionEnded) {
        try {
          prepareResponse(
              conversationModel: conversationModel, currentVersionNumber: _currentVersionNumber, context: _context);
        } catch (error, stackTrace) {
          CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
        }

        log("658 $conversationModel");

        await _questionnairesRepository.fetchAllQuestionnaires();
        await _questionnairesRepository.fetchNextQuestion(
          context: context,
          questionId: _questionnairesRepository.nextQuestionId,
          encounterId: _currentEncounterId ?? "",
          ehrCategoryId: _currentSectionId ?? "",
        );

        // _currentQuestionNo += 1;
      } else {
        if (_questionnairesRepository.isInBuiltQuestion) {
          _questionnairesRepository.setPresentSectionEnded = false;

          /// figuring out what section was chosen
          _currentSectionId = _screeningSections[_currentEncounterId]![selectedOption]["ehrCategoryId"];
          _currentSectionName = selectedOption;

          await _questionnairesRepository.fetchAllQuestionnaires();

          final String firstQuestionId = _questionnairesRepository.questionMapObject["firstQuestionId"];
          await _questionnairesRepository.fetchNextQuestion(
            context: context,
            questionId: firstQuestionId,
            encounterId: _currentEncounterId ?? "",
            ehrCategoryId: _currentSectionId ?? "",
          );
          _questionnairesRepository.setIsInBuiltQuestion = false;
          // _currentQuestionNo = 1;
        } else {
          prepareResponse(
              conversationModel: conversationModel, currentVersionNumber: _currentVersionNumber, context: _context);
          await submitSection(context: context);
          _screeningSections[_currentEncounterId]!.remove(_currentSectionName);

          if (_screeningSections[_currentEncounterId]!.isEmpty) {
            getFinalIntent(context: _context);
          } else {
            _questionnairesRepository.addToConversation(
                questionId: AppConstant.IN_BUILT_QUESTION,
                question: CommonFunctions.getSectionQuestion(isRegFlow: _isRegFlow, currentLanguage: _currentLanguage),
                chipType: AppConstant.CHIP_OPTIONS,
                timeAsked: DateTime.now(),
                hasOptions: _screeningSections[_currentEncounterId]!.keys.toList().isNotEmpty,
                options: _screeningSections[_currentEncounterId]!.keys.toList());
            _questionnairesRepository.setIsInBuiltQuestion = true;
            _questionnairesRepository.setPresentSectionEnded = true;
            _currentSectionId = null;
            _currentSectionName = null;
          }
        }
      }
    } else if (serviceFlow == ServiceFlow.registration) {
      var questionsList;

      if (!_isLastQuestion) {
        try {
          // final registrationResponseObj = await EdgeService().getRegistrationDialogFlow(_currentQuestionNo);
          // if (registrationResponseObj.body.isNotEmpty) {
          //   _isNextSuggestionClickable = true;
          //   questionsList = jsonDecode(registrationResponseObj.body);
          //   _questionObj = await getXmlWidget(questionsList[AppConstant.QUESTIONS]);
          //   _questionnairesRepository.addToConversation(
          //     questionId: _questionObj["questionId"].toString(),
          //     question: _questionObj[AppConstant.QUESTION].toString(),
          //     chipType: _questionObj[AppConstant.TYPE],
          //     timeAsked: DateTime.now(),
          //     options: _questionObj["suggestions"],
          //     optionKeys: _questionObj["optionKeys"],
          //     hasOptions: (_questionObj["suggestions"] as List<String>).isNotEmpty,
          //     hasFollowUp: (_questionObj["inputs"] as Map<String, dynamic>).isNotEmpty,
          //     followupQuestions: _questionObj["inputs"],
          //     isEditable: true,
          //   );
          //   _isLastQuestion = questionsList["endFlag"];
          // }
        } catch (error, stackTrace) {
          _isNextSuggestionClickable = true;
          CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
        }
      } else {
        // patientRegistration(context: _context);
      }

      notifyListeners();
    } else if (serviceFlow == ServiceFlow.loginIntent) {
      _currentQuestionNo = _currentQuestionNo + 1;
      if (!_isLastQuestion) {
        if ((_mobileNumber == null) || _email == null) {
          _currentQuestionNo = 0;

          // if (_questionnairesRepository.conversation.first.answer == AppConstant.MOBILE_NUMBER) {
          //   _isMobileNumberLogin = true;
          //   Intents().getMobileNumberIntent(context: context);
          // } else if (_questionnairesRepository.conversation.first.answer == AppConstant.EMAIL) {
          //   _isMobileNumberLogin = false;
          //   Intents().getEmailIntent(context: context);
          // } else {
          //   /// This else block executes only when user re-enter the OTP,
          //   /// when first OPT fails.
          //   if (_questionnairesRepository.conversation.first.answer == AppConstant.RESEND_OTP) {
          //     callingAPI(
          //       context: context,
          //       mobileNumber: _mobileNumber,
          //       email: _email,
          //     );
          //   }
          //   Intents().getVerifyOtpIntent(context: context);
          // }
        } else {
          // callingAPI(
          //   context: context,
          //   mobileNumber: _mobileNumber,
          //   email: _email,
          // );
          // Intents().getVerifyOtpIntent(context: context);
          _currentQuestionNo = 0;
        }
      }
      notifyListeners();
    }
    passEditableValue(context: _context, showEditOption: _serviceFlow != ServiceFlow.registration);
  }

  void setValuesForContinuingChat({required String caseId, required String encounterId, required bool caseSubmittedOnce}) {
    setCurrentCaseId(caseId: caseId);
    _currentEncounterId = encounterId;
    _questionnairesRepository.setIsInBuiltQuestion = true;
    _currentQuestionNo = 0;
    _questionnairesRepository.addToConversation(
        questionId: AppConstant.IN_BUILT_QUESTION,
        question: CommonFunctions.getSectionQuestion(currentLanguage: currentLanguage, isRegFlow: false),
        // "Please select a section from options below",
        chipType: AppConstant.CHIP_OPTIONS,
        timeAsked: DateTime.now(),
        hasOptions: _screeningSections[_currentEncounterId]!.keys.toList().length > 0,
        options: _screeningSections[_currentEncounterId]!.keys.toList());
    _questionnairesRepository.setPresentSectionEnded = true;
    _caseSubmittedOnce = caseSubmittedOnce;
    notifyListeners();
  }
}
