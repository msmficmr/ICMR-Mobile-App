import 'package:flutter/material.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';

Future<void> editConversation({
  required BuildContext context,
  required int index,
  required String currentLanguage,
}) async {
  final Questionnaires _questionariesRepository = Questionnaires();
  final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);

  final String _currentQuestionId = _questionariesRepository.conversation.elementAt(index).questionId;

  /// Edits Selected Question and will make suggestions unselected
  editCurrentQuestion(context: context, index: index);

  /// Delete all the selected questions from conversation
  for (int i = 0; i <= index - 1; i++) {
    _questionariesRepository.conversation.removeFirst();
    if (chatBotProvider.conversationToSend.isNotEmpty) {
      chatBotProvider.removeLastConversationToSend();
    }
  }

  _questionariesRepository.setPresentSectionEnded = false;

  chatBotProvider.setIsLastQuestion(false);

  passEditableValue(isEditButtonClicked: true, context: context);

  _questionariesRepository.setCurrentQuestionId = _currentQuestionId;

  String? nextQuestionId = _questionariesRepository.questionMapObject["fields"]
  [_questionariesRepository.currentQuestionId]["nextQuestionId"];

  if (nextQuestionId != null) {
    _questionariesRepository.setNextQuestionId = nextQuestionId;
  }

  chatBotProvider.scrollController.animateTo(
    0,
    duration: const Duration(milliseconds: 800),
    curve: Curves.ease,
  );

  chatBotProvider.notify();
}

void editCurrentQuestion({required BuildContext context, required int index}) {
  final _questionariesRepository = Questionnaires();
  final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);

  /// selectedOptionIndex setting to null, because the after clicking edit
  /// button the last question suggestions should show as unselected options.
  /// To restore the last question suggestions as unselected options, the selectedOptionIndex
  /// should be set to null after clicking the edit button. This ensures that no option is
  /// considered selected, allowing the user to make a new selection or leave the options unselected.
  try {
    _questionariesRepository.conversation.elementAt(index).selectedOptionIndex = null;
    _questionariesRepository.conversation.elementAt(index).followUpSubmitted = false;
    _questionariesRepository.conversation.elementAt(index).answer = null;

    if (_questionariesRepository.conversation.elementAt(index).chipType == "CHIP_WITH_SINGLE_SELECT_CHIP") {
      if (_questionariesRepository.conversation.elementAt(index).followupQuestions.containsKey("yes")) {
        _questionariesRepository.conversation.elementAt(index).followupQuestions["yes"][0].remove('answer');
        _questionariesRepository.conversation.elementAt(index).followupQuestions["yes"][0].remove('answerText');
        _questionariesRepository.conversation
            .elementAt(index)
            .followupQuestions["yes"][0]
            .remove('selectedOptionIndex');
      }
    } else if (_questionariesRepository.conversation.elementAt(index).chipType == "BMI") {
      _questionariesRepository.conversation.elementAt(index).followupQuestions[""][0].remove('answer');
      _questionariesRepository.conversation.elementAt(index).followupQuestions[""][1].remove('answer');
      _questionariesRepository.conversation.elementAt(index).followupQuestions[""].removeAt(2);
    } else if (_questionariesRepository.conversation.elementAt(index).chipType == "CHIP_WITH_MULTISELECT_TEXTFORM") {
      if (_questionariesRepository.conversation.elementAt(index).followupQuestions.containsKey("yes")) {
        _questionariesRepository.conversation.elementAt(index).followupQuestions["yes"][0]["selectedOptions"] = [];
        _questionariesRepository.conversation.elementAt(index).followupQuestions["yes"][0]["selectedOptionKeys"] = [];
        _questionariesRepository.conversation
            .elementAt(index)
            .followupQuestions["yes"][0]["inputs"]["other_cancer"][0]
            .remove("answer");
      }
      if (_questionariesRepository.conversation.elementAt(index).followupQuestions.containsKey("one")) {
        _questionariesRepository.conversation.elementAt(index).followupQuestions["one"][0]["selectedOptions"] = [];
        _questionariesRepository.conversation.elementAt(index).followupQuestions["one"][0]["selectedOptionKeys"] = [];
        _questionariesRepository.conversation
            .elementAt(index)
            .followupQuestions["one"][0]["inputs"]["other_cancer"][0]
            .remove("answer");
      }
      if (_questionariesRepository.conversation.elementAt(index).followupQuestions.containsKey("more_than_one")) {
        _questionariesRepository.conversation.elementAt(index).followupQuestions["more_than_one"][0]
        ["selectedOptions"] = [];
        _questionariesRepository.conversation.elementAt(index).followupQuestions["more_than_one"][0]
        ["selectedOptionKeys"] = [];
        _questionariesRepository.conversation
            .elementAt(index)
            .followupQuestions["more_than_one"][0]["inputs"]["other_cancer"][0]
            .remove("answer");
      }
    }

    if (chatBotProvider.serviceFlow != ServiceFlow.registration &&
        chatBotProvider.serviceFlow != ServiceFlow.loginIntent) {
      chatBotProvider.setCurrentQuestionNo(currentQuestionNo: chatBotProvider.currentQuestionNo - 1);
    } else {
      if (!chatBotProvider.isLastQuestion) {
        chatBotProvider.setCurrentQuestionNo(currentQuestionNo: chatBotProvider.currentQuestionNo - 1);
      }
    }
  } catch (error, stackTrace) {
    CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
  }
}

/// The passEditableValue() was called when ever User clicks on Suggestions (Answers)
/// to make [isEditable] variable true or false based on condition.
Future<void> passEditableValue({
  bool isEditButtonClicked = false,
  bool showEditOption = true,
  required BuildContext context,
}) async {
  final Questionnaires _questionariesRepository = Questionnaires();
  final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
  if (isEditButtonClicked) {
    if (_questionariesRepository.conversation.length > 1) {
      if (_questionariesRepository.conversation.elementAt(1).questionId != AppConstant.IN_BUILT_QUESTION) {
        _questionariesRepository.conversation.elementAt(0).isEditable = false;
        _questionariesRepository.conversation.elementAt(1).isEditable = true;
      } else {
        _questionariesRepository.conversation.elementAt(0).isEditable = false;
      }
    }
  } else {
    try {
      if (_questionariesRepository.conversation.length > 1) {
        _questionariesRepository.conversation.elementAt(0).isEditable = false;
        _questionariesRepository.conversation.elementAt(1).isEditable = showEditOption ? true : false;

        if (_questionariesRepository.conversation.elementAt(1).questionId == AppConstant.IN_BUILT_QUESTION) {
          _questionariesRepository.conversation.elementAt(1).isEditable = false;
        }
      }
    } catch (error, stackTrace) {
      CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
    }
  }

  /// After one section (Assessment) complete, all the answers will be not editable
  if (chatBotProvider.isAssessmentCompleted) {
    for (var conversation in _questionariesRepository.conversation) {
      conversation.isEditable = false;
    }
  }
}
