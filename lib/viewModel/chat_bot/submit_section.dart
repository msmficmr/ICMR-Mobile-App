import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [submitSection()] function is Submitting each assessment
Future<void> submitSection({required BuildContext context}) async {
  final Questionnaires _questionnairesRepository = Questionnaires();
  final chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);

  Map<String, dynamic> requestObj = {
    'version': chatBotProvider.currentVersionNumber,
    'questions': chatBotProvider.conversationToSend,
  };

  bool isAllQuestionAvailable = true;
  bool isDuplicateQuestionAvailable = false;

  /// Checking all question id's are available or not
  for (var element in chatBotProvider.conversationToSend) {
    if (!_questionnairesRepository.allQuestionIds.contains(element["questionid"])) {
      isAllQuestionAvailable = false;
    }
  }

  if (isAllQuestionAvailable) {
    List<String> questions = [];

    /// Checking duplicate question id's
    chatBotProvider.conversationToSend.forEach((element) {
      if (questions.contains(element["questionid"])) {
        isDuplicateQuestionAvailable = true;
      } else {
        questions.add(element["questionid"]);
      }
    });

    if (isDuplicateQuestionAvailable) {
      return;
    }
  } else {
    return;
  }

  try {
    //TODO :: ! will be deprecated
    String encounterCategoryMapId = chatBotProvider.screeningSections[chatBotProvider.currentEncounterId]![
    chatBotProvider.currentSectionName]!["encounterCategoryMapId"];
    // Response? response = await CdrService().saveEncounterEhrData(chatBotProvider.currentVersionNumber, requestObj,
    //     chatBotProvider.encounterEhrId, encounterCategoryMapId, false, true);
    //
    // if (response?.statusCode == 201 && response!.body.isNotEmpty) {
    //   chatBotProvider.setIsAssessmentCompleted(isAssessmentCompleted: true);
    //   chatBotProvider.setIsNextSuggestionClickable(isNextSuggestionClickable: true);
    //
    //   final sharedPreference = await SharedPreferences.getInstance();
    //   final String caseId = sharedPreference.getString(AppConstant.CASE_ID)!;
    //
    //   /// makes sure that the case is submitted only once as FINAL
    //   if (!chatBotProvider.caseSubmittedOnce) {
    //     Response? updateCaseResponse = await updateCase(caseId: caseId, caseStatus: CaseStatus.FINAL.name, phaseStatus: PhaseStatus.INPROGRESS.name);
    //
    //     /// Updating stateId of current caseId
    //     if (updateCaseResponse?.statusCode == 201 && updateCaseResponse!.body.isNotEmpty) {
    //       chatBotProvider.setCaseSubmittedOnce(caseSubmittedOnce: true);
    //       if (json.decode(updateCaseResponse.body)["phaseStatus"] != PhaseStatus.RISK_SCORE_CALCULATED.name) {
    //         try {
    //           await updateCaseStateId(caseId: caseId, stateId: EncounterTypes.ENCOUNTER_TYPE_RISK_ASSESSMENT_IN_PROGRESS.name);
    //         } catch (error) {
    //           CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
    //         }
    //       }
    //     }
    //   }
    //
    //   // final String sectionNameValue = Encounters().localizedSectionNamesMapObject[chatBotProvider.currentSectionName];
    //   // final String sectionName = sectionNameValue.replaceAll(" ", "_").toLowerCase();
    //
    //   /// clearing [_conversationToSend] stack to make space for new section data
    //   chatBotProvider.clearConversationToSendList();
    //
    //   /// clearing Questionaries list to make space for new section Questionaries
    //   _questionnairesRepository.clearQuestionnaires();
    //   chatBotProvider.setCurrentQuestionNo(currentQuestionNo: 0);
    //   _questionnairesRepository.clearAllQuestionIds();
    // }
  } catch (error, stackTrace) {
    chatBotProvider.setIsNextSuggestionClickable(isNextSuggestionClickable: true);
    CommonFunctions.toastMessage("Unable to submit ${chatBotProvider.currentSectionName} Section data, Please try again");
    rethrow;
  }
}