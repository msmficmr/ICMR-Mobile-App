import 'package:flutter/material.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';

class Intents {
  final Questionnaires _questionnaires = Questionnaires();

  void getLanguageIntent({required BuildContext context, required Map<String, String> languageMap}) async {
    final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 800));
    _questionnaires.addToConversation(
      questionId: AppConstant.IN_BUILT_QUESTION,
      question: AppConstant.PLEASE_SELECT_PREFERRED_LANGUAGE,
      chipType: AppConstant.CHIP_OPTIONS,
      timeAsked: DateTime.now(),
      hasOptions: true,
      optionKeys: languageMap.values.toList(),
      options: languageMap.keys.toList(),
    );
    _questionnaires.setIsInBuiltQuestion = true;
    chatBotProvider.notify();
  }

  void getPreviousChatButtonIntent({required BuildContext context}) async {
    final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 800));
    _questionnaires.addToConversation(
        questionId: AppConstant.IN_BUILT_QUESTION,
        question: "",
        chipType: AppConstant.BUTTON_TYPE,
        timeAsked: DateTime.now(),
        hasOptions: false);
    _questionnaires.setIsInBuiltQuestion = true;
    chatBotProvider.notify();
  }

  void getRiskAssessmentPaymentIntent(
      {required BuildContext context,
        required String currentLanguage,
        required String patientName,
        required bool isRegFlow}) {
    if (isRegFlow) {
      _questionnaires.addToConversation(
        questionId: AppConstant.IN_BUILT_QUESTION,
        question: AppConstant.THANKS_FOR_ENTERING_YOUR_DETAILS,
        chipType: AppConstant.CHIP_OPTIONS,
        timeAsked: DateTime.now(),
        hasOptions: false,
      );
    } else {
      if (patientName.isNotEmpty) {
        _questionnaires.addToConversation(
            questionId: AppConstant.IN_BUILT_QUESTION,
            question: CommonFunctions.toLocale("welcome_back", currentLanguage, patientName),
            chipType: AppConstant.CHIP_OPTIONS,
            timeAsked: DateTime.now(),
            hasOptions: false);
      }
    }
  }
}