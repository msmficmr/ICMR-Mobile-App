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
  final Questionnaires questionariesRepository = Questionnaires();
  final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);

  final String currentQuestionId = questionariesRepository.conversation.elementAt(index).questionId;

  /// Edits Selected Question and will make suggestions unselected
  editCurrentQuestion(context: context, index: index);

  /// Delete all the selected questions from conversation
  for (int i = 0; i <= index - 1; i++) {
    questionariesRepository.conversation.removeFirst();
    if (chatBotProvider.conversationToSend.isNotEmpty) {
      chatBotProvider.removeLastConversationToSend();
    }
  }

  questionariesRepository.setPresentSectionEnded = false;

  chatBotProvider.setIsLastQuestion(false);

  passEditableValue(isEditButtonClicked: true, context: context);

  questionariesRepository.setCurrentQuestionId = currentQuestionId;

  String? nextQuestionId = questionariesRepository.questionMapObject["fields"][questionariesRepository.currentQuestionId]["nextQuestionId"];

  if (nextQuestionId != null) {
    questionariesRepository.setNextQuestionId = nextQuestionId;
  }

  chatBotProvider.scrollController.animateTo(
    0,
    duration: const Duration(milliseconds: 800),
    curve: Curves.ease,
  );

  chatBotProvider.notify();
}

void editCurrentQuestion({required BuildContext context, required int index}) {
  final questionariesRepository = Questionnaires();
  final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);

  /// selectedOptionIndex setting to null, because the after clicking edit
  /// button the last question suggestions should show as unselected options.
  /// To restore the last question suggestions as unselected options, the selectedOptionIndex
  /// should be set to null after clicking the edit button. This ensures that no option is
  /// considered selected, allowing the user to make a new selection or leave the options unselected.
  try {
    questionariesRepository.conversation.elementAt(index).selectedOptionIndex = null;
    questionariesRepository.conversation.elementAt(index).followUpSubmitted = false;
    questionariesRepository.conversation.elementAt(index).answer = null;

    if (questionariesRepository.conversation.elementAt(index).chipType == "CHIP_WITH_SINGLE_SELECT_CHIP") {
      if (questionariesRepository.conversation.elementAt(index).followupQuestions.containsKey("yes")) {
        questionariesRepository.conversation.elementAt(index).followupQuestions["yes"][0].remove('answer');
        questionariesRepository.conversation.elementAt(index).followupQuestions["yes"][0].remove('answerText');
        questionariesRepository.conversation.elementAt(index).followupQuestions["yes"][0].remove('selectedOptionIndex');
      }
    } else if (questionariesRepository.conversation.elementAt(index).chipType == "BMI") {
      questionariesRepository.conversation.elementAt(index).followupQuestions[""][0].remove('answer');
      questionariesRepository.conversation.elementAt(index).followupQuestions[""][1].remove('answer');
      questionariesRepository.conversation.elementAt(index).followupQuestions[""].removeAt(2);
    } else if (questionariesRepository.conversation.elementAt(index).chipType == "CHIP_WITH_MULTISELECT_TEXTFORM") {
      if (questionariesRepository.conversation.elementAt(index).followupQuestions.containsKey("yes")) {
        questionariesRepository.conversation.elementAt(index).followupQuestions["yes"][0]["selectedOptions"] = [];
        questionariesRepository.conversation.elementAt(index).followupQuestions["yes"][0]["selectedOptionKeys"] = [];
        questionariesRepository.conversation.elementAt(index).followupQuestions["yes"][0]["inputs"]["other_cancer"][0].remove("answer");
      }
      if (questionariesRepository.conversation.elementAt(index).followupQuestions.containsKey("one")) {
        questionariesRepository.conversation.elementAt(index).followupQuestions["one"][0]["selectedOptions"] = [];
        questionariesRepository.conversation.elementAt(index).followupQuestions["one"][0]["selectedOptionKeys"] = [];
        questionariesRepository.conversation.elementAt(index).followupQuestions["one"][0]["inputs"]["other_cancer"][0].remove("answer");
      }
      if (questionariesRepository.conversation.elementAt(index).followupQuestions.containsKey("more_than_one")) {
        questionariesRepository.conversation.elementAt(index).followupQuestions["more_than_one"][0]["selectedOptions"] = [];
        questionariesRepository.conversation.elementAt(index).followupQuestions["more_than_one"][0]["selectedOptionKeys"] = [];
        questionariesRepository.conversation.elementAt(index).followupQuestions["more_than_one"][0]["inputs"]["other_cancer"][0].remove("answer");
      }
    }
  } catch (error) {
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
  final Questionnaires questionariesRepository = Questionnaires();
  final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
  if (isEditButtonClicked) {
    if (questionariesRepository.conversation.length > 1) {
      if (questionariesRepository.conversation.elementAt(1).questionId != AppConstant.IN_BUILT_QUESTION) {
        questionariesRepository.conversation.elementAt(0).isEditable = false;
        questionariesRepository.conversation.elementAt(1).isEditable = true;
      } else {
        questionariesRepository.conversation.elementAt(0).isEditable = false;
      }
    }
  } else {
    try {
      if (questionariesRepository.conversation.length > 1) {
        questionariesRepository.conversation.elementAt(0).isEditable = false;
        questionariesRepository.conversation.elementAt(1).isEditable = showEditOption ? true : false;

        if (questionariesRepository.conversation.elementAt(1).questionId == AppConstant.IN_BUILT_QUESTION) {
          questionariesRepository.conversation.elementAt(1).isEditable = false;
        }
      }
    } catch (error) {
      CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
    }
  }

  /// After one section (Assessment) complete, all the answers will be not editable
  if (chatBotProvider.isOneAssessmentCompleted) {
    for (var conversation in questionariesRepository.conversation) {
      conversation.isEditable = false;
    }
  }
}
