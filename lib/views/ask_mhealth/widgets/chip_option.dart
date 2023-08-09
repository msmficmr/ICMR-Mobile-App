import 'package:flutter/material.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';

class ChipOption extends StatelessWidget {
  final conversationModel;
  final Questionnaires _questionnairesRepository = Questionnaires();

  ChipOption({Key? key, required this.conversationModel}) : super(key: key);

  final int chipOptionsLength = 4;

  @override
  Widget build(BuildContext context) {
    ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: true);
    final int chipOptionsLength = conversationModel.options.length;
    return Container(
      // If the chipOptions Length is greater than 3
      // we should show in grid view
      child: chipOptionsLength > 4
          ? Wrap(
              runSpacing: 1,
              spacing: 1,
              alignment: WrapAlignment.end,
              children: chipOptionList(chatBotProvider, context),
            )
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: chipOptionList(chatBotProvider, context),
            ),
    );
  }

  List<Widget> chipOptionList(ChatBotViewModel chatBotProvider, BuildContext context) {
    final int chipOptionsLength = conversationModel.options.length;
    final ServiceFlow serviceFlow = chatBotProvider.serviceFlow;

    return List<Widget>.generate(chipOptionsLength, (index) {
      return InkWell(
        onTap: () {
          if (chatBotProvider.isNextSuggestionClickable) {
            chatBotProvider.setIsAssessmentCompleted(isAssessmentCompleted: false);
            if (serviceFlow == ServiceFlow.riskAssessment ||
                serviceFlow == ServiceFlow.registration ||
                serviceFlow == ServiceFlow.loginIntent ||
                serviceFlow == ServiceFlow.languageIntent) {
              // updating the answer for the question
              _questionnairesRepository.conversation.first.selectedOptionIndex = index;
              _questionnairesRepository.conversation.first.answer =
              _questionnairesRepository.conversation.first.options[index];
              // force screen to rebuild so that the tapped option shows up
              chatBotProvider.notify();
              if (_questionnairesRepository.conversation.first.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_TEXTFORM ||
                  _questionnairesRepository.conversation.first.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_WITH_MULTI_INPUT ||
                  _questionnairesRepository.conversation.first.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_WITH_AUTOSUGGEST ||
                  _questionnairesRepository.conversation.first.chipType == AppConstant.CHIP_OPTIONS_WITH_CONDITIONAL) {
                // if the selected option doesn't have any follow up questions
                // then we want to drive the program to the next question
                if (_questionnairesRepository.conversation.first
                    .followupQuestions[_questionnairesRepository.conversation.first.optionKeys[index]] ==
                    null) {
                  chatBotProvider.onUserSelectsOption(
                      conversationModel: _questionnairesRepository.conversation.first, context: context);
                }
              } else {
                // fetching more questions
                chatBotProvider.onUserSelectsOption(
                    conversationModel: _questionnairesRepository.conversation.first, context: context);
              }
            }
          }
        },
        child: Container(
          alignment: chipOptionsLength > 4 ? null : Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColorScheme.kPrimaryColor.shade50,
              border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor.shade50),
              borderRadius: const BorderRadius.all(Radius.circular(30),),
            ),
            child: Text(
              conversationModel.options[index],
              softWrap: true,
              style: const TextStyle(
                  fontSize: 14,
                  textBaseline: TextBaseline.ideographic,
                  height: AppConstant.TEXT_HEIGHT,
                  color: AppColorScheme.kGrayColor),
            ),
          ),
        ),
      );
    });
  }
}
