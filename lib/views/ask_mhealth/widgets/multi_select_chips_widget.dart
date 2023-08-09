import 'package:flutter/material.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/custom_field_text.dart';
import 'package:mhealth/views/ask_mhealth/widgets/selectable_chips.dart';
import 'package:provider/provider.dart';

class MultiSelectChipsWidget extends StatefulWidget {
  final Map<String, dynamic> followUpQuestion;
  final ConversationModel conversationModel;
  final double screenWidth;

  const MultiSelectChipsWidget({
    Key? key,
    required this.conversationModel,
    required this.followUpQuestion,
    required this.screenWidth,
  }) : super(key: key);

  @override
  State<MultiSelectChipsWidget> createState() => _MultiSelectChipsWidgetState();
}

class _MultiSelectChipsWidgetState extends State<MultiSelectChipsWidget> {
  final Questionnaires _questionnairesRepository = Questionnaires();
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context);

    return Column(
      children: [
        widget.conversationModel.followupQuestions[widget.conversationModel.answer] != null && !widget.conversationModel.followUpSubmitted
            ? SelectableChips(chipText: widget.followUpQuestion["suggestions"], chipTextId: widget.followUpQuestion["optionKeys"])
            : Wrap(
                direction: Axis.horizontal,
                runSpacing: 1,
                spacing: 1,
                children: widget.conversationModel.selectedOptionIndex != null
                    ? List.generate(widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]][0]["selectedOptions"].length,
                        (index) {
                        return CustomChipWOMargin(
                          answer: widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]][0]["selectedOptions"][index],
                        );
                      })
                    : [Container()],
              ),
        if (widget.conversationModel.selectedOptionIndex != null) ...[
          if (widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]][0]["selectedOptionKeys"].contains("other_cancer") &&
              !widget.conversationModel.followUpSubmitted)
            CustomFieldText(
              screenWidth: widget.screenWidth,
              onSubmit: () {}, //submit is disabled in this field, we'll control it via submit button below
              textEditingController: textEditingController,
              showSubmit: false,
            ),
          if (widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]][0]["selectedOptionKeys"].contains("other_cancer") &&
              widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]][0]["inputs"]["other_cancer"][0]["answer"] != null &&
              widget.conversationModel.followUpSubmitted)
            CustomChipWOMargin(
                answer: widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]][0]["inputs"]["other_cancer"][0]["answer"]),
          // submit button will only show when follow-ups are not submitted
          if (widget.conversationModel.followupQuestions[widget.conversationModel.answer] != null && !widget.conversationModel.followUpSubmitted)
            GestureDetector(
              onTap: () {
                if (chatBotProvider.isNextSuggestionClickable) {
                  chatBotProvider.setIsAssessmentCompleted(isAssessmentCompleted: false);
                  if (widget.conversationModel.followupQuestions[widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!]][0]["selectedOptions"].length > 0) {
                    _questionnairesRepository.conversation.first.followUpSubmitted = true;
                    if (textEditingController.text.isNotEmpty) {
                      _questionnairesRepository.conversation.first.followupQuestions[_questionnairesRepository.conversation.first.answer][0]["inputs"]["other_cancer"][0]["answer"] =
                          textEditingController.text;
                    }
                    chatBotProvider.notify();
                    chatBotProvider.onUserSelectsOption(conversationModel: widget.conversationModel, context: context);
                  }
                }
              },
              child: Container(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: AppColorScheme.kPrimaryColor,
                    border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Text(
                    TranslationKeys.submit.translate(context),
                  ),
                ),
              ),
            ),
        ]
      ],
    );
  }
}

class CustomChipWOMargin extends StatelessWidget {
  final String answer;

  const CustomChipWOMargin({Key? key, required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: AppColorScheme.kPrimaryColor,
              border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Text(
              answer,
              softWrap: true,
              style: TextStyle(
                fontSize: 14,
                textBaseline: TextBaseline.ideographic,
                height: AppConstant.TEXT_HEIGHT,
                color: AppColorScheme.kPrimaryIconColor,
              ),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.only(left: 5, top: 5),
            child: CircleAvatar(
              radius: 27,
              backgroundColor: AppColorScheme.kPrimaryColor,
              child: CircleAvatar(
                backgroundColor: AppColorScheme.kPrimaryIconColor,
                radius: 25,
                child: Text(
                  "U",
                  style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kPrimaryColor.shade50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
