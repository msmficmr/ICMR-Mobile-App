import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/views/questionnaire/widgets/chip_with_single_select_chip.dart';
import 'package:mhealth/views/questionnaire/widgets/custom_chip_widget.dart';
import 'package:mhealth/widgets/avatar.dart';
import 'package:mhealth/widgets/space_widget.dart';

class AnimatedChatWidget extends StatefulWidget {
  int? index;
  Animation<double>? animation;
  bool? reverseAnimation;

  AnimatedChatWidget({Key? key, this.index, this.animation, this.reverseAnimation = false}) : super(key: key);

  @override
  State<AnimatedChatWidget> createState() => _AnimatedChatWidgetState();
}

class _AnimatedChatWidgetState extends State<AnimatedChatWidget> {
  late int index;

  @override
  Widget build(BuildContext context) {
    index = widget.index ?? 0;
    return const Placeholder();
  }
}

Widget chat({required BuildContext context, required var conversationModel}) {
  if (conversationModel == AppConstant.CHIP_WITH_SINGLE_SELECT_CHIP) {
    return ChipWithSingleSelectChip();
  }
  return Container(
    alignment: Alignment.topCenter,
    color: AppColorScheme.kPrimaryIconColor,
    padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        displayQuestion(context: context, questionText: "question", questionTime: DateTime.now()),
        const SpaceWidget(height: 10),
        //TODO: selectedOptionIndex != null
        1 > 2
            ? displayAnswers()
            // an answer can be options or user input, or options + userInput
            : displayOptions()
      ],
    ),
  );
}

/// input: Question
/// output: A bubble with question text inside
Widget displayQuestion({required BuildContext context, required String questionText, required DateTime questionTime}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      //TODO: Bot icon in avatar
      avatar(""),
      const SpaceWidget(width: 10.0),
      Column(
        children: [
          Bubble(
            radius: const Radius.circular(10),
            color: AppColorScheme.kPrimaryIconColor,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment.topLeft,
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  questionText,
                                  softWrap: true,
                                  textAlign: TextAlign.start,
                                  style: AppStyles.titleMedium,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(top: 10),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Stack(
                                  children: [
                                    Text(
                                      " ${DateFormat("hh:mm a").format(questionTime)}",
                                      textAlign: TextAlign.end,
                                      style: AppStyles.bodySmall,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )
    ],
  );
}

/// Returns chips based on the [ChatResponseModel.chipType]
/// currently only single type of chip is supported:
/// [ChipOption] : List of chips with single selectable option
/// [SINGLE_CHOICE_TOGGLE] : same as [ChipOption]
/// [MultilineTextInput] : text box that spans multiple lines and lets user submit text
Widget displayOptions() {
  return Container();
}

Widget displayAnswers() {
  return CustomChip(answer: "answer");
}
