import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/views/ask_mhealth/widgets/question.dart';
import 'package:mhealth/views/ask_mhealth/widgets/send_widget.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class SingleChoiceToggleTextForm extends StatefulWidget {
  const SingleChoiceToggleTextForm({
    Key? key,
    required this.conversationModel,
    required this.maxWidth,
    required this.index,
  }) : super(key: key);

  final ConversationModel conversationModel;
  final double maxWidth;
  final int index;

  @override
  State<SingleChoiceToggleTextForm> createState() => _SingleChoiceToggleTextFormState();
}

class _SingleChoiceToggleTextFormState extends State<SingleChoiceToggleTextForm> {
  final Questionnaires _questionnairesRepository = Questionnaires();
  String? selectedChipId;
  List<TextEditingController> _textControllerList = [];

  @override
  void initState() {
    super.initState();
    selectedChipId = widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!];
    for (int i = 0; i < (widget.conversationModel.followupQuestions[selectedChipId]?.length ?? 0); i++) {
      _textControllerList.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (TextEditingController element in _textControllerList) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int noOfFollowUpQuestions = widget.conversationModel.followupQuestions[selectedChipId]?.length ?? 0;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomChip(
          index: widget.index,
          answer: widget.conversationModel.answer!,
          editable: widget.conversationModel.isEditable,
        ),
        if (selectedChipId != null)
          for (int i = 0; i < noOfFollowUpQuestions; i++) _displayFollowUpQA(conversationModel: widget.conversationModel, noOfFollowUpQuestions: noOfFollowUpQuestions, followUpQuestionIndex: i),
      ],
    );
  }

  Widget _displayFollowUpQA({required ConversationModel conversationModel, required int noOfFollowUpQuestions, required int followUpQuestionIndex}) {
    if (conversationModel.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_TEXTFORM ||
        conversationModel.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_WITH_MULTI_INPUT ||
        conversationModel.chipType == AppConstant.SINGLE_CHOICE_TOGGLE_WITH_AUTOSUGGEST) {
      return Consumer<ChatBotViewModel>(builder: (context, chatBotProvider, child) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SpaceWidget(
              height: 10,
            ),
            Question(
              questionText: conversationModel.followupQuestions[selectedChipId][followUpQuestionIndex]["question"],
              questionTime: conversationModel.timeAsked,
              screenWidth: widget.maxWidth,
            ),
            const SpaceWidget(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                (conversationModel.followUpSubmitted)
                    ? CustomChip(
                        index: widget.index,
                        answer: conversationModel.followupQuestions[selectedChipId][followUpQuestionIndex]["answer"],
                        editable: false,
                      )
                    : _displayTextBox(conversationModel: conversationModel, followUpQuestionIndex: followUpQuestionIndex),
                if (!widget.conversationModel.followUpSubmitted && noOfFollowUpQuestions > 0)
                  InkWell(
                    onTap: () {
                      if (chatBotProvider.isNextSuggestionClickable) {
                        chatBotProvider.setIsNextSuggestionClickable(isNextSuggestionClickable: false);
                        for (int i = 0; i < noOfFollowUpQuestions; i++) {
                          _questionnairesRepository.conversation.first.followupQuestions[selectedChipId][i]["answer"] = _textControllerList[i].text;
                        }

                        _questionnairesRepository.conversation.first.followUpSubmitted = true;
                        chatBotProvider.notify();
                        chatBotProvider.onUserSelectsOption(conversationModel: widget.conversationModel, context: context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: AppColorScheme.kPrimaryColor,
                        border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      });
    } else {
      return const Text(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    }
  }

  Widget _displayTextBox({required ConversationModel conversationModel, required int followUpQuestionIndex}) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        controller: _textControllerList[followUpQuestionIndex],
        cursorColor: AppColorScheme.kPrimaryColor,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]'),
          ),
        ],
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(color: AppColorScheme.kLightRed, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(color: AppColorScheme.kPrimaryColor, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(color: AppColorScheme.kPrimaryColor, width: 1),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
