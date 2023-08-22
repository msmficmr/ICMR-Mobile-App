import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/chat_bot/edit_conversation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatBotViewModel extends ChangeNotifier {
  final Questionnaires _questionnairesRepository = Questionnaires();

  Map<String, String> _languageMap = {};

  Map<String, String> get languageMapObject => _languageMap;

  /// using global variable for using animations
  final GlobalKey<AnimatedListState> animationKey = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController();

  late BuildContext _context;

  int _widgetIndex = 0;
  int _totalQuestions = 0;
  bool _isLastQuestion = false;
  bool _isNextSuggestionClickable = true;

  bool _isOneAssessmentCompleted = false;

  /// [_isNewChatScreenMounted] tracks if the newChat screen is mounted or not
  bool _isNewChatScreenMounted = false;

  String _currentLanguage = "en_US";
  String? _currentSectionId;
  String? _currentEncounterId;

  String? _currentSectionName;
  String _currentVersionNumber = "";
  final List _conversationToSend = [];
  Map<String, String> _sectionNameIdMap = {};
  Map<String, dynamic> _questionObj = {};
  Map<String, Map<String, dynamic>> _screeningSections = {};
  ServiceFlow _serviceFlow = ServiceFlow.riskAssessment;

  List<Questionnaire> questionnaireList = [];

  int screenNumber = 0;

  void setNextScreenNumber() {
    screenNumber++;
  }

  void setPreviousScreenNumber() {
    screenNumber--;
  }

  List<String> questionnaireSections = [];

  /// The variable [_questionMapObject] is a map object that contains a list of
  /// question objects obtained from the server.
  Map<String, dynamic> _questionMapObject = {};

  Map<String, dynamic> get questionMapObject => _questionMapObject;

  int get widgetIndex => _widgetIndex;

  int get totalQuestions => _totalQuestions;

  bool get isLastQuestion => _isLastQuestion;

  bool get isNextSuggestionClickable => _isNextSuggestionClickable;

  bool get isOneAssessmentCompleted => _isOneAssessmentCompleted;

  bool get isNewChatScreenMounted => _isNewChatScreenMounted;

  String get currentLanguage => _currentLanguage;

  String? get currentSectionId => _currentSectionId;

  String? get currentEncounterId => _currentEncounterId;

  String? get currentSectionName => _currentSectionName;

  String get currentVersionNumber => _currentVersionNumber;

  List get conversationToSend => _conversationToSend;

  Map<String, String> get sectionNameIdMap => _sectionNameIdMap;

  Map<String, dynamic> get questionObj => _questionObj;

  Map<String, Map<String, dynamic>> get screeningSections => _screeningSections;

  ServiceFlow get serviceFlow => _serviceFlow;

  Future<void> setLanguage({String? languageCode}) async {
    _currentLanguage = languageCode ?? await CommonFunctions.getLanguageKey() ?? "en_US";
  }

  void setIsNextSuggestionClickable({required bool isNextSuggestionClickable}) {
    _isNextSuggestionClickable = isNextSuggestionClickable;
  }

  void setIsLastQuestion(bool isLastQuestion) {
    _isLastQuestion = isLastQuestion;
  }

  void setBuildContext(BuildContext context) {
    _context = context;
  }

  void setServiceFlow({required ServiceFlow newFlow}) {
    _serviceFlow = newFlow;
  }

  setCurrentVersionNumber({required String currentVersionNumber}) {
    _currentVersionNumber = currentVersionNumber;
  }

  void setIndex({required int widgetIndex}) {
    _widgetIndex = widgetIndex;
    notifyListeners();
  }

  set setIsOneAssessmentCompleted(bool isOneAssessmentCompleted) {
    _isOneAssessmentCompleted = isOneAssessmentCompleted;
  }

  removeLastConversationToSend() => _conversationToSend.removeLast();

  void setNewChatScreenMount(bool isMounted) {
    _isNewChatScreenMounted = isMounted;
  }

  /// Forces provider to setstate on external command
  void notify() => notifyListeners();

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
    _screeningSections.clear();
    _isNewChatScreenMounted = false;
  }

  Future<void> onUserSelectsOption({required ConversationModel conversationModel, required BuildContext context}) async {
    try {
      if (!_questionnairesRepository.presentSectionEnded) {
        // await _questionnairesRepository.fetchAllQuestionnaires(sectionName: AppAssetsPath.personalHistoryQuestionnaire);
        await _questionnairesRepository.fetchNextQuestion(
          context: context,
          questionId: _questionnairesRepository.nextQuestionId,
          encounterId: _currentEncounterId ?? "",
          ehrCategoryId: _currentSectionId ?? "",
        );
        passEditableValue(context: _context, showEditOption: _serviceFlow != ServiceFlow.registration);
      } else {
        _questionnairesRepository.clearQuestionnaires();
        // await _questionnairesRepository.fetchAllQuestionnaires(sectionName: AppAssetsPath.healthHabitQuestionnaire);
        _questionnairesRepository.fetchNextQuestion(
          context: context,
          questionId: "do_you_smoke_cigarette",
          encounterId: "HEALTH_HABIT",
          ehrCategoryId: "RISK_ASSESSMENT_RISK_ASSESSMENT_HEALTH_HABIT",
        );
      }
    } catch (error, stackTrace) {
      log("onUserSelectsOption error: $error");
      log("onUserSelectsOption stackTrace: $stackTrace");
    }
  }

  fetchQuestionnaireForRA() async {
    RiskAssessmentQuestionaire? isarDB = await IsarDbService.isarDbService.getRiskAssessmentQuestionnaireById();
    if (isarDB!.sections != null) {
      for (var section in isarDB.sections!) {
        questionnaireSections.add(section.sectionName.toString());
      }
    }
    for (int i = 0; i < isarDB.sections!.length; i++) {
      if (isarDB.sections![i].sectionName == questionnaireSections[screenNumber]) {
        questionnaireList = parseJsonForQuestionnaire(isarDB.sections![i].questionObj ?? []);
      }
    }
    notifyListeners();
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

  TextFieldQuestionnaire _parseTextAreaFieldQuestionnaire(element) {
    String id = element.inputId.toString();
    String label = element.inputText.toString() ?? "";

    // String? regex = element.findElements("inputs").firstOrNull?.findElements("input").firstOrNull?.findElements("validation").firstOrNull?.findElements("regex").firstOrNull?.text;

    bool isRequired = true;
    // var isRequiredField = element.findElements("inputs").firstOrNull?.findElements("input").firstOrNull?.findElements("required");
    //
    // if (isRequiredField != null) {
    //   isRequired = isRequiredField.firstOrNull?.text == "true";
    // }

    TextFieldQuestionnaire textFieldQuestionnaire = TextFieldQuestionnaire(
      "",
      id: id,
      label: label,
      regex: "",
      isRequired: isRequired,
      shouldShowError: false,
    );
    return textFieldQuestionnaire;
  }

  TextFieldQuestionnaire _parseTextFieldQuestionnaire(element) {
    String id = element.inputId.toString();
    String label = element.inputText.toString();
    String? regex = element.regex.toString();
    bool isRequired = false;

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
