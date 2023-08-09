import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/chat_bot/edit_conversation.dart';
import 'package:mhealth/viewModel/chat_bot/get_xml_widget.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> getFinalIntent({required BuildContext context}) async {
  final Questionnaires _questionnairesRepository = Questionnaires();
  final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
  final sharedPreference = await SharedPreferences.getInstance();
  final String caseId = sharedPreference.getString(AppConstant.CASE_ID)!;
  // await updateCase(caseId: caseId, caseStatus: CaseStatus.FINAL.name, phaseStatus: PhaseStatus.RISK_SCORE_CALCULATED.name);
  chatBotProvider.setIsAssessmentCompleted(isAssessmentCompleted: true);
  passEditableValue(context: context, showEditOption: chatBotProvider.serviceFlow != ServiceFlow.registration);

  try {
    // final response = await EdgeService.getThankYouIntentAPI(caseId: caseId);
    // final responseBody = jsonDecode(response.body);
    // // parsing the intent response
    // Map<String, dynamic> questionObj = await getXmlWidget(responseBody[AppConstant.QUESTIONS]);
    // chatBotProvider.setQuestionObject(questionObject: questionObj);
    //
    // // add to conversation stack
    // _questionnairesRepository.addToConversation(
    //   questionId: AppConstant.IN_BUILT_QUESTION,
    //   question: questionObj["question"],
    //   chipType: questionObj["type"],
    //   timeAsked: DateTime.now(),
    //   hasOptions: (questionObj["suggestions"] as List<String>).isNotEmpty,
    //   options: questionObj["suggestions"],
    //   optionKeys: questionObj["optionKeys"],
    //   hasFollowUp: (questionObj["inputs"] as Map<String, dynamic>).isNotEmpty,
    //   followupQuestions: questionObj["inputs"],
    //   isEditable: true,
    // );
  } catch (error, stackTrace) {
    CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
  }

  /// Before calling [EdgeService.getThankYou2IntentAPI] API has
  /// to wait 2 seconds, Thank you messages should one after another
  await Future.delayed(const Duration(seconds: 2));

  try {
    // final response = await EdgeService.getThankYou2IntentAPI(caseId: caseId);
    // final responseBody = jsonDecode(response.body);
    // // parsing the intent response
    // Map<String, dynamic> questionObj = await getXmlWidget(responseBody[AppConstant.QUESTIONS]);
    // chatBotProvider.setQuestionObject(questionObject: questionObj);
    //
    // // add to conversation stack
    // _questionnairesRepository.addToConversation(
    //   questionId: AppConstant.IN_BUILT_QUESTION,
    //   question: questionObj["question"],
    //   chipType: questionObj["type"],
    //   timeAsked: DateTime.now(),
    //   hasOptions: (questionObj["suggestions"] as List<String>).isNotEmpty,
    //   options: questionObj["suggestions"],
    //   optionKeys: questionObj["optionKeys"],
    //   hasFollowUp: (questionObj["inputs"] as Map<String, dynamic>).isNotEmpty,
    //   followupQuestions: questionObj["inputs"],
    //   isEditable: true,
    // );
  } catch (error, stackTrace) {
    CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
  }

  try {
    // await sendReport(sentReportToMobile: chatBotProvider.isMobileNumberLogin);
  } catch (error, stackTrace) {
    CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
  }

  /// track and send mixPanel analytics that user completed whole session
  _questionnairesRepository.setIsInBuiltQuestion = true;
  _questionnairesRepository.setPresentSectionEnded = true;
  chatBotProvider.setCurrentSectionId(currentSectionId: null);
  chatBotProvider.setCurrentSectionName(currentSectionName: null);
}