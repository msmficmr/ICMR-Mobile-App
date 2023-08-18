import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/views/ask_mhealth/widgets/question.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class ChipWithSingleSelectChip extends StatefulWidget {
  final ConversationModel conversationModel;
  final double screenWidth;
  final int index;

  const ChipWithSingleSelectChip({
    Key? key,
    required this.conversationModel,
    required this.screenWidth,
    required this.index,
  }) : super(key: key);

  @override
  State<ChipWithSingleSelectChip> createState() => _ChipWithSingleSelectChipState();
}

class _ChipWithSingleSelectChipState extends State<ChipWithSingleSelectChip> {
  @override
  Widget build(BuildContext context) {
    ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: true);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Question(screenWidth: widget.screenWidth, questionText: widget.conversationModel.question, questionTime: widget.conversationModel.timeAsked),
          const SpaceWidget(height: 10),
          widget.conversationModel.selectedOptionIndex == null
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(widget.conversationModel.options.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        if (chatBotProvider.isNextSuggestionClickable) {
                          chatBotProvider.setIsOneAssessmentCompleted = false;
                          widget.conversationModel.selectedOptionIndex = index;
                          widget.conversationModel.answer = widget.conversationModel.optionKeys[index];
                          chatBotProvider.notify();

                          if (widget.conversationModel.followupQuestions[widget.conversationModel.answer] == null) {
                            chatBotProvider.onUserSelectsOption(context: context, conversationModel: widget.conversationModel);
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColorScheme.kPrimaryColor.shade50,
                            border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor.shade50),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Text(
                            widget.conversationModel.options[index],
                            style: AppStyles.titleMedium,
                          ),
                        ),
                      ),
                    );
                  }),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CustomChip(index: widget.index, answer: widget.conversationModel.options[widget.conversationModel.selectedOptionIndex!], editable: widget.conversationModel.isEditable),
                ),
          // follow-up question
          if (widget.conversationModel.answer != null && widget.conversationModel.followupQuestions[widget.conversationModel.answer] != null)
            Question(
                screenWidth: widget.screenWidth,
                questionText: widget.conversationModel.followupQuestions[widget.conversationModel.answer][0]["question"],
                questionTime: widget.conversationModel.timeAsked),
          const SpaceWidget(height: 10),
          // follow-up answer
          if (widget.conversationModel.answer != null && widget.conversationModel.followupQuestions[widget.conversationModel.answer] != null && !widget.conversationModel.followUpSubmitted)
            Column(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(widget.conversationModel.followupQuestions[widget.conversationModel.answer][0]["suggestions"].length, (followUpIndex) {
                return GestureDetector(
                  onTap: () {
                    if (chatBotProvider.isNextSuggestionClickable) {
                      chatBotProvider.setIsOneAssessmentCompleted = false;
                      try {
                        widget.conversationModel.followUpSubmitted = true;
                        widget.conversationModel.followupQuestions[widget.conversationModel.answer][0]["selectedOptionIndex"] = followUpIndex;
                        widget.conversationModel.followupQuestions[widget.conversationModel.answer][0]["answer"] =
                            widget.conversationModel.followupQuestions[widget.conversationModel.answer][0]["optionKeys"][followUpIndex];
                        widget.conversationModel.followupQuestions[widget.conversationModel.answer][0]["answerText"] =
                            widget.conversationModel.followupQuestions[widget.conversationModel.answer][0]["suggestions"][followUpIndex];

                        chatBotProvider.notify();
                        chatBotProvider.onUserSelectsOption(context: context, conversationModel: widget.conversationModel);
                      } catch (error, stacktrace) {
                        log("Single ship select error: $error");
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColorScheme.kPrimaryColor.shade50,
                        border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor.shade50),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Text(
                        widget.conversationModel.followupQuestions[widget.conversationModel.answer][0]["suggestions"][followUpIndex],
                        style: AppStyles.titleMedium,
                      ),
                    ),
                  ),
                );
              }),
            ),

          if (widget.conversationModel.selectedOptionIndex != null && widget.conversationModel.followUpSubmitted)
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CustomChip(
                index: widget.index,
                answer: widget.conversationModel.followupQuestions[widget.conversationModel.answer][0]["answerText"],
                editable: false,
              ),
            ),
        ],
      ),
    );
  }
}
