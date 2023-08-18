import 'package:flutter/material.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/views/ask_mhealth/widgets/multi_select_chips_widget.dart';
import 'package:mhealth/views/ask_mhealth/widgets/question.dart';
import 'package:provider/provider.dart';

class ChipWithMultiSelectTextForm extends StatefulWidget {
  const ChipWithMultiSelectTextForm({
    Key? key,
    required this.conversationModel,
    required this.screenWidth,
    required this.index,
  }) : super(key: key);

  final ConversationModel conversationModel;
  final double screenWidth;
  final int index;

  @override
  State<ChipWithMultiSelectTextForm> createState() => _ChipWithMultiSelectTextFormState();
}

class _ChipWithMultiSelectTextFormState extends State<ChipWithMultiSelectTextForm> {
  final Questionnaires _questionnairesRepository = Questionnaires();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: true);

    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Question(
            questionText: widget.conversationModel.question,
            questionTime: widget.conversationModel.timeAsked,
            screenWidth: CommonFunctions.getCardWidth(screenWidth: screenWidth),
          ),
          const SizedBox(height: 10),
          widget.conversationModel.selectedOptionIndex == null
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: chipOptionList(chatBotProvider: chatBotProvider),
                )
              : CustomChip(
                  index: widget.index,
                  answer: widget.conversationModel.options[widget.conversationModel.selectedOptionIndex!],
                  editable: widget.conversationModel.isEditable,
                ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            transitionBuilder: (child, animation) {
              return SizeTransition(
                sizeFactor: animation,
                axisAlignment: -1.0,
                axis: Axis.vertical,
                child: child,
              );
            },
            child: (widget.conversationModel.selectedOptionIndex != null &&
                    widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]] != null)
                ? Column(
                    children: [
                      ...[
                        if (widget.conversationModel.selectedOptionIndex != null &&
                            widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]] != null)
                          Question(
                            questionText: widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]][0]["question"],
                            questionTime: widget.conversationModel.timeAsked,
                            screenWidth: CommonFunctions.getCardWidth(screenWidth: screenWidth),
                          ),
                      ],
                      const SizedBox(height: 10),
                      ...[
                        if (widget.conversationModel.selectedOptionIndex != null &&
                            widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]] != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: MultiSelectChipsWidget(
                              conversationModel: widget.conversationModel,
                              followUpQuestion: widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex ?? 0]][0],
                              screenWidth: CommonFunctions.getCardWidth(screenWidth: screenWidth),
                            ),
                          )
                      ]
                    ],
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  List<Widget> chipOptionList({required ChatBotViewModel chatBotProvider}) {
    return List.generate(
      widget.conversationModel.options.length,
      (index) {
        return GestureDetector(
          onTap: () {
            if (chatBotProvider.isNextSuggestionClickable) {
              chatBotProvider.setIsOneAssessmentCompleted = false;
              _questionnairesRepository.conversation.first.selectedOptionIndex = index;
              _questionnairesRepository.conversation.first.answer = _questionnairesRepository.conversation.first.optionKeys[index];
              if ((widget.conversationModel.followupQuestions[widget.conversationModel.answer] == null && widget.conversationModel.followUpSubmitted == false)) {
                chatBotProvider.onUserSelectsOption(conversationModel: widget.conversationModel, context: context);
              }
              chatBotProvider.notify();
            }
          },
          child: Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColorScheme.kPrimaryColor.shade50,
              border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor.shade50),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Text(
              widget.conversationModel.options[index],
              softWrap: true,
              style: AppStyles.titleMedium,
            ),
          ),
        );
      },
    );
  }
}
