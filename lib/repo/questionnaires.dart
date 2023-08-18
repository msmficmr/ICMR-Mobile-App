import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/model/questionnaires_model.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';
import 'package:mhealth/viewModel/chat_bot/create_follow_up_json.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/repo/questionnaires_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Questionnaires implements QuestionnaireService {
  static final Questionnaires _questionnaire = Questionnaires._();

  Questionnaires._();

  factory Questionnaires() {
    return _questionnaire;
  }

  /// The [_conversation] variable is a data structure that stores all the questions
  /// asked to the user, along with the user's corresponding answers.
  /// This information is used to keep track of the user's progress and to
  /// generate the final risk assessment report.
  ListQueue<ConversationModel> _conversation = ListQueue<ConversationModel>();

  ListQueue<ConversationModel> get conversation => _conversation;

  /// The variable [_questionMapObject] is a map object that contains a list of
  /// question objects obtained from the server.
  Map<String, dynamic> _questionMapObject = {};

  Map<String, dynamic> get questionMapObject => _questionMapObject;

  late ChatBotViewModel _chatBotProvider;
  late SharedPreferences _sharedPreferences;

  String _currentQuestionId = "";
  String _previousQuestionId = "";
  String _nextQuestionId = "";
  bool _presentSectionEnded = false;
  bool _isInBuiltQuestion = false;
  List<String> _allQuestionIds = []; // List of all Question Id's of a current section

  /// Getters
  String get previousQuestionId => _previousQuestionId;

  String get currentQuestionId => _currentQuestionId;

  String get nextQuestionId => _nextQuestionId;

  bool get presentSectionEnded => _presentSectionEnded;

  bool get isInBuiltQuestion => _isInBuiltQuestion;

  List<String> get allQuestionIds => _allQuestionIds;

  /// Setters
  set setChatBotProvider(context) => _chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);

  set setPreviousQuestionId(previousQuestionId) => _previousQuestionId = previousQuestionId;

  set setCurrentQuestionId(currentQuestionId) => _currentQuestionId = currentQuestionId;

  set setNextQuestionId(nextQuestionId) => _nextQuestionId = nextQuestionId;

  set setPresentSectionEnded(presentSectionEnded) => _presentSectionEnded = presentSectionEnded;

  set setIsInBuiltQuestion(isInBuiltQuestion) => _isInBuiltQuestion = isInBuiltQuestion;

  void removeFirstConversation() => _conversation.removeFirst();

  void removeConversationAtIndex(index) => _conversation.remove(index);

  /// Clears total conversation of Risk Assessment
  void clearConversation() => _conversation.clear();

  /// Clears all Current section Questionnaires
  void clearQuestionnaires() => _questionMapObject.clear();

  /// Clears all Current section Question Ids
  void clearAllQuestionIds() => _allQuestionIds.clear();

  int get getLength => _conversation.length;

  @override
  void addToConversation(
      {required String questionId,
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
        bool isEditable = false}) {
    _conversation.addFirst(ConversationModel(
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

    if (_chatBotProvider.animationKey.currentState != null) {
      int animationDuration = 800;
      if (selectedOptionIndex == null && chipType != AppConstant.SINGLE_TEXT_FIELD && chipType != AppConstant.CHIP_WITH_MULTISELECT_TEXTFORM) {
        animationDuration = 1200;
      }
      _chatBotProvider.animationKey.currentState!.insertItem(0, duration: Duration(milliseconds: animationDuration));
    }
    _chatBotProvider.notify();
  }

  /// The [fetchAllQuestionnaires] method fetches all questions for a specific section
  /// from the [Questionnaires] Singleton class.
  @override
  Future<Map<String, dynamic>> fetchAllQuestionnaires({String sectionName = ""}) async {
    log("fetchAllQuestionnaires");
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_questionMapObject.isEmpty) {
      try {
        // AppAssetsPath.personalHistoryQuestionnaire
        final String response = await rootBundle.loadString(sectionName);
        _questionMapObject.addAll(json.decode(response));

        _chatBotProvider.setCurrentVersionNumber(currentVersionNumber: _questionMapObject["versionNumber"]);
        List<String> allQuestionIds = [];
        Map<String, dynamic> questionsMapObject = _questionMapObject["fields"];
        questionsMapObject.forEach((key, value) {
          allQuestionIds.add(key);
        });
        _allQuestionIds = allQuestionIds;
        // log("Line 158 $_allQuestionIds");
      } on CustomException catch (error) {
        CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
      }
    }
    return _questionMapObject;
  }

  /// The [fetchNextQuestion] method has been implemented in the [Questionnaires] singleton class.
  /// It retrieves questions one by one from the questionnaires object by
  /// iterating over the Question objects in the [_questionMapObject] map.
  @override
  Future<void> fetchNextQuestion({
    required BuildContext context,
    required String questionId,
    required String encounterId,
    required String ehrCategoryId,
  }) async {
    try {
      Map<String, dynamic> questionObject = _questionMapObject["fields"][questionId];
      //  log("Line 173 $questionObject");
      _chatBotProvider.setIsNextSuggestionClickable(isNextSuggestionClickable: true);

      if (questionObject["lastQuestion"] != null) {
        log("Line 177");
        _presentSectionEnded = questionObject["lastQuestion"];
      }

      if (_presentSectionEnded) {
        log("Line 182");
        _chatBotProvider.setIsOneAssessmentCompleted = false;
      }

      Map<String, String> optionsData = {};

      final newQuestionObject = questionObject["questionObject"];
      if (questionObject["nextQuestionId"] != null) {
        log("Line 190");
        _nextQuestionId = questionObject["nextQuestionId"];
      }

      _currentQuestionId = questionId;

      if (questionObject["previousQuestionId"] != null) {
        log("Line 197");
        _previousQuestionId = questionObject["previousQuestionId"];
      }

      Field currentQuestionObject = Field.fromJson(newQuestionObject);

      Map<String, dynamic> followupMap = {};
      currentQuestionObject.followup?.forEach((element) {
        log("Line followup 198: ${element.toJson()}");
      });

      if (currentQuestionObject.followup != null && currentQuestionObject.followup!.isNotEmpty) {
        log("Line 206: ${currentQuestionObject.toJson()}");
        followupMap = generateFollowUpQuestionsMapObject(field: currentQuestionObject);
        log("Line 208 $followupMap");
      }
      try {
        if (currentQuestionObject.options != null && currentQuestionObject.options!.isNotEmpty) {
          log("Line 212");
          currentQuestionObject.options?.forEach((options) {
            optionsData[options.id ?? ""] = options.displayText ?? "";
          });
        }
      } catch (error, stackTrace) {
        CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
      }
      if (currentQuestionObject.type == AppConstant.TEXT_AREA) {
        ConversationModel qaModel = ConversationModel(
          questionId: currentQuestionObject.questionId ?? "",
          question: currentQuestionObject.questionText ?? "",
          chipType: currentQuestionObject.type ?? "",
          timeAsked: DateTime.now(),
          options: optionsData.values.toList(),
          optionKeys: optionsData.keys.toList(),
          hasOptions: optionsData.values.toList().isNotEmpty,
          followupQuestions: (currentQuestionObject.followup != null && currentQuestionObject.followup!.isNotEmpty) ? followupMap : {},
        );
        await _chatBotProvider.onUserSelectsOption(conversationModel: qaModel, context: context);
      } else {
        try {
          var dd = (currentQuestionObject.followup != null && currentQuestionObject.followup!.isNotEmpty) ? followupMap : {};
          addToConversation(
              questionId: currentQuestionObject.questionId ?? "",
              question: currentQuestionObject.questionText ?? "",
              chipType: currentQuestionObject.type ?? "",
              timeAsked: DateTime.now(),
              options: optionsData.values.toList(),
              optionKeys: optionsData.keys.toList(),
              hasOptions: optionsData.values.toList().isNotEmpty,
              hasFollowUp: (currentQuestionObject.followup != null && currentQuestionObject.followup!.isNotEmpty),
              followupQuestions: (currentQuestionObject.followup != null && currentQuestionObject.followup!.isNotEmpty) ? followupMap : {},
              isEditable: true);
        } catch (error, stackTrace) {
          log("Error is $error");
          CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
        }
      }
      _chatBotProvider.notify();
    } catch (error, stackTrace) {
      _chatBotProvider.setIsNextSuggestionClickable(isNextSuggestionClickable: true);
      CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
    }
  }
}
