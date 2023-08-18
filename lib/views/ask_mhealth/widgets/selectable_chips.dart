import 'package:flutter/material.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'dart:developer';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';

class SelectableChips extends StatefulWidget {
  const SelectableChips({Key? key, required this.chipText, required this.chipTextId}) : super(key: key);

  final List<String> chipText;
  final List<String> chipTextId;

  @override
  _SelectableChipsState createState() => _SelectableChipsState();
}

class _SelectableChipsState extends State<SelectableChips> {
  final Questionnaires _questionariesRepository = Questionnaires();
  List<String> selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: true);
    return Container(
      child: Wrap(
        alignment: WrapAlignment.end,
        children: List.generate(widget.chipText.length, (index) {
          return Container(
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
              label: Text(
                widget.chipText[index],
                softWrap: true,
                style: TextStyle(
                    color: selectedChoices.contains(widget.chipText[index]) ? AppColorScheme.kPrimaryIconColor : AppColorScheme.kGrayColor.shade700,
                    textBaseline: TextBaseline.ideographic,
                    height: AppConstant.TEXT_HEIGHT,
                    fontSize: 14),
              ),
              selected: selectedChoices.contains(widget.chipText[index]),
              selectedColor: AppColorScheme.kPrimaryColor,
              backgroundColor: AppColorScheme.kPrimaryColor.shade50,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              onSelected: (selected) {
                /// If selectedChoices variable contains selected suggestion it will remove else it will add.
                if (selectedChoices.contains(widget.chipText[index])) {
                  selectedChoices.remove(widget.chipText[index]);
                  _questionariesRepository.conversation.first
                      .followupQuestions[_questionariesRepository.conversation.first.optionKeys[_questionariesRepository.conversation.first.selectedOptionIndex!]][0]["selectedOptions"]
                      .remove(widget.chipText[index]);
                  _questionariesRepository.conversation.first
                      .followupQuestions[_questionariesRepository.conversation.first.optionKeys[_questionariesRepository.conversation.first.selectedOptionIndex!]][0]["selectedOptionKeys"]
                      .remove(widget.chipTextId[index]);
                } else {
                  selectedChoices.add(widget.chipText[index]);
                  _questionariesRepository.conversation.first
                      .followupQuestions[_questionariesRepository.conversation.first.optionKeys[_questionariesRepository.conversation.first.selectedOptionIndex!]][0]["selectedOptions"]
                      .add(widget.chipText[index]);
                  _questionariesRepository.conversation.first
                      .followupQuestions[_questionariesRepository.conversation.first.optionKeys[_questionariesRepository.conversation.first.selectedOptionIndex!]][0]["selectedOptionKeys"]
                      .add(widget.chipTextId[index]);
                }
                log("selectedChoices: $selectedChoices");
                log(_questionariesRepository.conversation.first
                    .followupQuestions[_questionariesRepository.conversation.first.optionKeys[_questionariesRepository.conversation.first.selectedOptionIndex!]][0]["selectedOptions"]
                    .toString());
                log(_questionariesRepository.conversation.first
                    .followupQuestions[_questionariesRepository.conversation.first.optionKeys[_questionariesRepository.conversation.first.selectedOptionIndex!]][0]["selectedOptionKeys"]
                    .toString());

                chatBotProvider.notify();
              },
            ),
          );
        }),
      ),
    );
  }
}
