import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';
import 'package:mhealth/viewModel/chat_bot/edit_conversation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatBotViewModel extends ChangeNotifier {
  final Questionnaires _questionnairesRepository = Questionnaires();

  Map<String, String> _languageMap = {};

  Map<String, String> get languageMapObject => _languageMap;

  final Map<String, String> _sections = {"personal_history": "Personal History", "health_habit": "Health Habit", "fagerstorm": "Fagerstorm"};
  Map<String, String> get sections => _sections;

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
        await _questionnairesRepository.fetchAllQuestionnaires(sectionName: AppAssetsPath.personalHistoryQuestionnaire);
        await _questionnairesRepository.fetchNextQuestion(
          context: context,
          questionId: _questionnairesRepository.nextQuestionId,
          encounterId: _currentEncounterId ?? "",
          ehrCategoryId: _currentSectionId ?? "",
        );
        passEditableValue(context: _context, showEditOption: _serviceFlow != ServiceFlow.registration);
      } else {
        _questionnairesRepository.clearQuestionnaires();
        await _questionnairesRepository.fetchAllQuestionnaires(sectionName: AppAssetsPath.healthHabitQuestionnaire);
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

  Future<Map<String, dynamic>> fetchQuestionnaire({required String sectionName}) async {
      try {
        final String response = await rootBundle.loadString(sectionName);
        _questionMapObject.addAll(json.decode(response));
        List<String> allQuestionIds = [];
        Map<String, dynamic> questionsMapObject = _questionMapObject["fields"];
        questionsMapObject.forEach((key, value) {
          allQuestionIds.add(key);
        });
        log("line 193 ${_questionMapObject["fields"]}");
        return _questionMapObject["fields"];
      } on CustomException catch (error) {
        CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
        rethrow;
      } finally {
        notifyListeners();
      }
  }
}
