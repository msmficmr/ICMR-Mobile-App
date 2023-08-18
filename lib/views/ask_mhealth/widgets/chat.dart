import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/chat_annimation.dart';
import 'package:mhealth/views/ask_mhealth/widgets/chip_option.dart';
import 'package:mhealth/views/ask_mhealth/widgets/chip_with_multiselect_textform.dart';
import 'package:mhealth/views/ask_mhealth/widgets/chip_with_single_select_chip.dart';
import 'package:mhealth/views/ask_mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/views/ask_mhealth/widgets/multiselect_chip_with_submit.dart';
import 'package:mhealth/views/ask_mhealth/widgets/question.dart';
import 'package:mhealth/views/ask_mhealth/widgets/single_choice_toggle_text_form_widget.dart';
import 'package:mhealth/views/ask_mhealth/widgets/single_text_field.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class AnimatedChatWidget extends StatefulWidget {
  final int index;
  final Animation<double>? animation;
  final bool? reverseAnimation;
  final double? maxWidth;

  const AnimatedChatWidget({Key? key, required this.index, this.animation, this.reverseAnimation = false, this.maxWidth}) : super(key: key);

  @override
  State<AnimatedChatWidget> createState() => _AnimatedChatWidgetState();
}

class _AnimatedChatWidgetState extends State<AnimatedChatWidget> {
  late int index;
  late double maxWidth;

  List<String> chipType = [
    AppConstant.CHIP_OPTIONS,
    AppConstant.SINGLE_CHOICE_TOGGLE,
    AppConstant.SINGLE_CHOICE_TOGGLE_TEXTFORM,
    AppConstant.SINGLE_CHOICE_TOGGLE_WITH_AUTOSUGGEST,
    AppConstant.SINGLE_CHOICE_TOGGLE_WITH_MULTI_INPUT
  ];

  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    maxWidth = CommonFunctions.getCardWidth(screenWidth: screenWidth);
    ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
    ServiceFlow serviceFlow = chatBotProvider.serviceFlow;
    ListQueue conversationStack = Questionnaires().conversation;

    /// if the messages is new and untapped, then only the loader
    /// should show for it
    /// To show loading Animation only for the last received question, that's why we keep
    /// condition "index == 0", the last received question always comes at index 0.
    return (index == 0 &&
            conversationStack.elementAt(index).selectedOptionIndex == null &&
            conversationStack.elementAt(index).chipType != AppConstant.SINGLE_TEXT_FIELD &&
            (conversationStack.elementAt(index).chipType != AppConstant.CHIP_WITH_MULTISELECT_TEXTFORM) &&
            conversationStack.elementAt(index).chipType != AppConstant.SINGLE_MULTI_MULTI_CHIP_OPTIONS &&
            conversationStack.elementAt(index).chipType != AppConstant.BUTTON_TYPE)
        ? AnimatedBuilder(
            animation: widget.animation!,
            builder: (context, child) {
              return (!widget.reverseAnimation!)
                  ? widget.animation!.value < 0.5
                      ? Container(margin: EdgeInsets.only(bottom: index == 0 ? 100 : 0), child: ChatAnimation())
                      : SizeTransition(
                          sizeFactor: widget.animation!,
                          axisAlignment: -1.0,
                          axis: Axis.vertical,
                          child: child,
                        )
                  : SizeTransition(
                      sizeFactor: widget.animation!,
                      axisAlignment: -1.0,
                      axis: Axis.vertical,
                      child: child,
                    );
            },
            child: SizeTransition(
              sizeFactor: widget.animation!,
              axisAlignment: -1.0,
              axis: Axis.vertical,
              child: Column(
                children: [
                  if (conversationStack.elementAt(index).questionId == "NO")
                    Container(
                      margin: EdgeInsets.only(bottom: index == 0 ? 100 : 0),
                      child: Column(
                        children: [
                          chat(index: index, screenWidth: maxWidth, context: context, serviceFlow: serviceFlow, conversationModel: conversationStack.elementAt(index)),
                          const SpaceWidget(height: 20),
                          // Return to HOME button after thankyou intent
                          PrimaryFilledButton(
                            onPressed: () {
                              chatBotProvider.clearScreeningData(clearSharedPreferences: true);
                              chatBotProvider.setNewChatScreenMount(false);
                              GoRouter.of(context).go(DashboardScreen.routerPath);
                            },
                            buttonTitle: AppConstant.RETURN_TO_HOME,
                            widgetKey: '',
                          ),
                        ],
                      ),
                    ),
                  if (chipType.contains(conversationStack.elementAt(index).chipType))
                    Container(
                      margin: EdgeInsets.only(bottom: index == 0 ? 100 : 0),
                      child: chat(index: index, screenWidth: maxWidth, context: context, serviceFlow: serviceFlow, conversationModel: conversationStack.elementAt(index)),
                    ),
                  if (conversationStack.elementAt(index).chipType == AppConstant.CHIP_WITH_SINGLE_SELECT_CHIP)
                    ChipWithSingleSelectChip(
                      index: index,
                      screenWidth: maxWidth,
                      conversationModel: conversationStack.elementAt(index),
                    ),
                ],
              ),
            ),
          )
        : SizeTransition(
            sizeFactor: widget.animation!,
            axisAlignment: -1.0,
            axis: Axis.vertical,
            child: Column(
              children: [
                if (chipType.contains(conversationStack.elementAt(index).chipType))
                  Container(
                    margin: EdgeInsets.only(bottom: index == 0 ? 100 : 0),
                    child: chat(
                      index: index,
                      screenWidth: maxWidth,
                      context: context,
                      serviceFlow: serviceFlow,
                      conversationModel: conversationStack.elementAt(index),
                    ),
                  ),
                if (conversationStack.elementAt(index).chipType == AppConstant.CHIP_WITH_SINGLE_SELECT_CHIP)
                  ChipWithSingleSelectChip(
                    index: index,
                    screenWidth: maxWidth,
                    conversationModel: conversationStack.elementAt(index),
                  ),
                if (conversationStack.elementAt(index).chipType == AppConstant.SINGLE_TEXT_FIELD)
                  SingleTextField(
                    index: index,
                    screenWidth: maxWidth,
                    conversationModel: conversationStack.elementAt(index),
                  ),
                if (conversationStack.elementAt(index).chipType == AppConstant.SINGLE_MULTI_MULTI_CHIP_OPTIONS)
                  Selector<ChatBotViewModel, int>(
                      selector: (_, provider) => provider.widgetIndex,
                      shouldRebuild: (previous, next) => next == chatBotProvider.widgetIndex,
                      builder: (context, value, child) {
                        return MultiMultiChipWidget(
                          conversationModel: conversationStack.elementAt(index),
                        );
                      }),
                if (conversationStack.elementAt(index).chipType == AppConstant.CHIP_WITH_MULTISELECT_TEXTFORM)
                  ChipWithMultiSelectTextForm(
                    index: index,
                    screenWidth: maxWidth,
                    conversationModel: conversationStack.elementAt(index),
                  ),
              ],
            ),
          );
  }
}

Widget chat({
  required BuildContext context,
  required ServiceFlow serviceFlow,
  required var conversationModel,
  required double screenWidth,
  required int index,
}) {
  return Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(
      right: 20,
      top: 10,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Question(
          screenWidth: screenWidth,
          questionText: conversationModel.question,
          questionTime: conversationModel.timeAsked,
        ),
        const SpaceWidget(height: 10),
        (conversationModel.selectedOptionIndex != null)
            ? displayAnswers(index: index, conversationModel: conversationModel, maxWidth: screenWidth)
            // an answer can be options or user input, or options + userInput
            : displayOptions(conversationModel: conversationModel),
      ],
    ),
  );
}

/// Returns chips based on the [ChatResponseModel.chipType]
/// currently only single type of chip is supported:
/// [ChipOption] : List of chips with single selectable option
/// [SINGLE_CHOICE_TOGGLE] : same as [ChipOption]
/// [MultilineTextInput] : text box that spans multiple lines and lets user submit text
Widget displayOptions({required var conversationModel}) {
  switch (conversationModel.chipType) {
    case AppConstant.CHIP_OPTIONS:
      return ChipOption(conversationModel: conversationModel);
    case AppConstant.SINGLE_CHOICE_TOGGLE:
      return ChipOption(conversationModel: conversationModel);
    case AppConstant.SINGLE_CHOICE_TOGGLE_TEXTFORM:
      return ChipOption(conversationModel: conversationModel);
    case AppConstant.SINGLE_CHOICE_TOGGLE_WITH_AUTOSUGGEST:
      return ChipOption(conversationModel: conversationModel);
    case AppConstant.SINGLE_CHOICE_TOGGLE_WITH_MULTI_INPUT:
      return ChipOption(conversationModel: conversationModel);
    case AppConstant.TEXT_AREA:
      // TODO: add code to bypass text area
      return Container();
    default:
      return Container();
  }
}

/// Returns chip
Widget displayAnswers({required var conversationModel, required double maxWidth, required int index}) {
  if ((conversationModel.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_TEXTFORM ||
          conversationModel.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_WITH_MULTI_INPUT ||
          conversationModel.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_WITH_AUTOSUGGEST) &&
      (conversationModel as ConversationModel).followupQuestions[conversationModel.optionKeys[conversationModel.selectedOptionIndex!]] != null) {
    return SingleChoiceToggleTextForm(index: index, conversationModel: conversationModel, maxWidth: maxWidth);
  } else {
    return CustomChip(index: index, answer: conversationModel.options[conversationModel.selectedOptionIndex], editable: (conversationModel as ConversationModel).isEditable);
  }
}
