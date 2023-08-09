import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/question.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class MultiMultiChipWidget extends StatefulWidget {
  ConversationModel conversationModel;

  MultiMultiChipWidget({Key? key, required this.conversationModel}) : super(key: key);

  @override
  State<MultiMultiChipWidget> createState() => _MultiMultiChipWidgetState();
}

class _MultiMultiChipWidgetState extends State<MultiMultiChipWidget> {
  final Questionnaires _questionnairesRepository = Questionnaires();
  String selectedOptionKey = "";
  ConversationModel? followUpQuestion;

  List<String> _selectedChoices = [];
  List<String> submittedKeys = [];
  List<String> submittedSubQuestions = [];

  late ChatBotViewModel chatBotProvider;

  final GlobalKey<AnimatedListState> animationKey = GlobalKey<AnimatedListState>();

  void renderFollowUpQuestion() {
    selectedOptionKey = widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!];
    if (widget.conversationModel.followupQuestions.containsKey(selectedOptionKey)) {
    } else {
      widget.conversationModel = _questionnairesRepository.conversation.first;
      chatBotProvider.onUserInputOptions(conversationModel: widget.conversationModel, context: context);

      ///Follow up question not found for [selectedOptionKey] so load next question
    }
  }

  void displayQuestion() {
    List<String> remainingKeys = followUpQuestion!.selectedOptionKeys.where((element) => !submittedKeys.contains(element)).toList();
    if (remainingKeys.isNotEmpty) {
      animationKey.currentState!.insertItem(submittedKeys.length, duration: const Duration(milliseconds: 800));
      submittedKeys.add(remainingKeys.first);
    } else {
      //Submitted all options
      widget.conversationModel.followupQuestions[selectedOptionKey][0]["inputs"][submittedKeys.last][0]["isSubmitted"] = true;
      _questionnairesRepository.conversation.first.followupQuestions[selectedOptionKey][0]["inputs"][submittedKeys.last][0]["isSubmitted"] = true;
      widget.conversationModel = _questionnairesRepository.conversation.first;
      chatBotProvider.onUserInputOptions(conversationModel: widget.conversationModel, context: context);
    }
  }

  bool displayBottomMargin() {
    if (widget.conversationModel.followupQuestions.containsKey(selectedOptionKey)) {
      ConversationModel model = ConversationModel.fromJson(widget.conversationModel.followupQuestions[selectedOptionKey][0]);
      List<String> stepSelectedKeys = followUpQuestion?.selectedOptionKeys ?? [];
      int count = 0;
      for (String subKey in stepSelectedKeys) {
        bool isSubmitted = followUpQuestion!.followupQuestions[subKey][0]["isSubmitted"];
        if (isSubmitted) {
          count++;
        }
      }
      if (stepSelectedKeys.isEmpty) {
        return true;
      }
      if (count == stepSelectedKeys.length) {
        return false;
      }
      return true;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
    if (widget.conversationModel.selectedOptionIndex != null) {
      selectedOptionKey = widget.conversationModel.optionKeys[widget.conversationModel.selectedOptionIndex!];

      if (widget.conversationModel.followupQuestions.containsKey(selectedOptionKey)) {
        followUpQuestion = ConversationModel.fromJson(widget.conversationModel.followupQuestions[selectedOptionKey][0]);

        _selectedChoices = followUpQuestion?.selectedOptionKeys ?? [];
        List<String> stepSelectedKeys = followUpQuestion?.selectedOptionKeys ?? [];
        for (String subKey in stepSelectedKeys) {
          bool isSubmitted = followUpQuestion!.followupQuestions[subKey][0]["isSubmitted"];
          if (isSubmitted) {
            if (!submittedKeys.contains(subKey)) {
              submittedKeys.add(subKey);
              submittedSubQuestions.add(subKey);
            }
          }
        }
      }
    }

    return Container(
      margin: EdgeInsets.only(right: 20, bottom: displayBottomMargin() ? 100 : 10),
      child: Column(
        children: [
          Question(
            questionText: widget.conversationModel.question,
            questionTime: widget.conversationModel.timeAsked,
            screenWidth: CommonFunctions.getCardWidth(screenWidth: screenWidth),
          ),
          const SpaceWidget(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              runSpacing: 1,
              spacing: 1,
              alignment: WrapAlignment.end,
              children: List.generate(
                widget.conversationModel.options.length,
                (index) {
                  String optionText = widget.conversationModel.options[index];
                  bool isSelected = widget.conversationModel.selectedOptionIndex == index;
                  return (widget.conversationModel.selectedOptionIndex == null || isSelected)
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                          child: ChoiceChip(
                            label: Text(
                              optionText,
                              maxLines: 5,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: AppConstant.TEXT_HEIGHT,
                                fontSize: 14,
                                color: isSelected ? AppColorScheme.kPrimaryIconColor : AppColorScheme.kGrayColor,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: AppColorScheme.kPrimaryColor,
                            backgroundColor: AppColorScheme.kPrimaryColor.shade50,
                            onSelected: widget.conversationModel.selectedOptionIndex == null
                                ? (selected) {
                                    widget.conversationModel.selectedOptionIndex = index;
                                    widget.conversationModel.answer = optionText;
                                    renderFollowUpQuestion();
                                    chatBotProvider.notify();
                                  }
                                : (_) {},
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ),
          ...[
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
              child: (selectedOptionKey != "" && widget.conversationModel.followupQuestions.containsKey(selectedOptionKey))
                  ? Column(
                      children: [
                        Question(
                          questionText: followUpQuestion?.question ?? "",
                          questionTime: DateTime.now(),
                          screenWidth: CommonFunctions.getCardWidth(screenWidth: screenWidth),
                        ),
                        SizedBox(height: 10),
                        widget.conversationModel.followUpSubmitted
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Wrap(
                                  runSpacing: 1,
                                  spacing: 1,
                                  alignment: WrapAlignment.end,
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  runAlignment: WrapAlignment.end,
                                  children: List.generate(
                                    _selectedChoices.length,
                                    (index) => Container(
                                      margin: const EdgeInsets.all(4.0),
                                      child: ChoiceChip(
                                        onSelected: (value) {},
                                        label: Text(
                                          followUpQuestion!.selectedOptions[index],
                                          maxLines: 5,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14, height: AppConstant.TEXT_HEIGHT, color: AppColorScheme.kPrimaryIconColor),
                                        ),
                                        padding: const EdgeInsets.all(10.0),
                                        selected: true,
                                        selectedColor: AppColorScheme.kPrimaryColor,
                                        backgroundColor: AppColorScheme.kPrimaryColor.shade50,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Wrap(
                                runSpacing: 1,
                                spacing: 1,
                                alignment: WrapAlignment.end,
                                children: List.generate(followUpQuestion!.options.length, (index) {
                                  String optionText = followUpQuestion!.options[index];
                                  String optionKey = followUpQuestion!.optionKeys[index];

                                  return Container(
                                    margin: const EdgeInsets.all(4.0),
                                    child: ChoiceChip(
                                      label: Text(
                                        optionText,
                                        maxLines: 5,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14, height: AppConstant.TEXT_HEIGHT, color: _selectedChoices.contains(optionKey) ? AppColorScheme.kPrimaryIconColor : AppColorScheme.kGrayColor),
                                      ),
                                      selected: _selectedChoices.contains(optionKey),
                                      selectedColor: AppColorScheme.kPrimaryColor,
                                      backgroundColor: AppColorScheme.kPrimaryColor.shade50,
                                      padding: const EdgeInsets.all(10.0),
                                      onSelected: (selected) {
                                        if (_selectedChoices.contains(optionKey)) {
                                          int storedIndex = _questionnairesRepository.conversation.first.followupQuestions[selectedOptionKey][0]["selectedOptions"].indexOf(optionText);
                                          if (storedIndex != -1) {
                                            _questionnairesRepository.conversation.first.followupQuestions[selectedOptionKey][0]["selectedOptions"].removeAt(storedIndex);
                                            _questionnairesRepository.conversation.first.followupQuestions[selectedOptionKey][0]["selectedOptionKeys"].removeAt(storedIndex);
                                            _selectedChoices.remove(optionKey);
                                          }
                                        } else {
                                          _selectedChoices.add(optionKey);
                                          _questionnairesRepository.conversation.first.followupQuestions[selectedOptionKey][0]["selectedOptions"].add(optionText);
                                          _questionnairesRepository.conversation.first.followupQuestions[selectedOptionKey][0]["selectedOptionKeys"].add(optionKey);
                                        }

                                        chatBotProvider.notify();
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                        const SpaceWidget(height: 10),
                        if (!widget.conversationModel.followUpSubmitted)
                          GestureDetector(
                            onTap: () {
                              if (followUpQuestion!.selectedOptionKeys.isNotEmpty) {
                                widget.conversationModel.followUpSubmitted = true;
                                chatBotProvider.notify();
                                displayQuestion();
                              }
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColorScheme.kPrimaryColor,
                                  border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  TranslationKeys.submit.translate(context),
                                  style: TextStyle(fontSize: 14, height: AppConstant.TEXT_HEIGHT, color: AppColorScheme.kPrimaryIconColor),
                                ),
                              ),
                            ),
                          ),
                        AnimatedList(
                          key: animationKey,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          initialItemCount: submittedSubQuestions.length,
                          itemBuilder: (context, index, animation) {
                            return SizeTransition(
                              sizeFactor: animation,
                              axisAlignment: -1.0,
                              axis: Axis.vertical,
                              child: _FollowUpQuestion(
                                conversationModel: widget.conversationModel,
                                onSubmit: () {
                                  submittedSubQuestions.add(submittedKeys[index]);
                                  _questionnairesRepository.conversation.first.followupQuestions[selectedOptionKey][0]["inputs"][submittedKeys[index]][0]["isSubmitted"] = true;
                                  displayQuestion();
                                },
                                isSubmitted: false,
                                optionKey: submittedKeys[index],
                                submittedOptionKey: selectedOptionKey,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            )
          ]
        ],
      ),
    );
  }
}

class _FollowUpQuestion extends StatelessWidget {
  final VoidCallback onSubmit;
  final String optionKey;
  bool isSubmitted;
  final String submittedOptionKey;
  final ConversationModel conversationModel;

  _FollowUpQuestion({Key? key, required this.conversationModel, required this.onSubmit, required this.optionKey, required this.isSubmitted, required this.submittedOptionKey}) : super(key: key);

  final TextEditingController otherTypeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
    var obj = conversationModel.followupQuestions[submittedOptionKey][0]["inputs"];

    var subQuestionMap = obj[optionKey][0];
    isSubmitted = subQuestionMap["isSubmitted"];

    if ((conversationModel.followupQuestions[submittedOptionKey][0]["inputs"][optionKey][0]["inputs"]["other_cancer"][0]).containsKey("answer")) {
      otherTypeEditingController.text = conversationModel.followupQuestions[submittedOptionKey][0]["inputs"][optionKey][0]["inputs"]["other_cancer"][0]["answer"];
      otherTypeEditingController.selection = TextSelection.fromPosition(TextPosition(offset: otherTypeEditingController.text.length));
    }

    return Column(
      children: [
        Question(
          questionText: "${subQuestionMap["question"]}",
          questionTime: DateTime.now(),
          screenWidth: CommonFunctions.getCardWidth(screenWidth: screenWidth),
        ),
        const SpaceWidget(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Wrap(
            direction: Axis.horizontal,
            runSpacing: 1,
            spacing: 1,
            crossAxisAlignment: WrapCrossAlignment.end,
            runAlignment: WrapAlignment.end,
            alignment: WrapAlignment.end,
            children: isSubmitted
                ? List.generate(subQuestionMap["selectedOptionKeys"].length, (index) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      child: ChoiceChip(
                        selected: true,
                        onSelected: (value) {},
                        selectedColor: AppColorScheme.kPrimaryColor,
                        backgroundColor: AppColorScheme.kPrimaryColor.shade50,
                        padding: const EdgeInsets.all(10.0),
                        label: Text(
                          "${subQuestionMap["selectedOptions"][index]}",
                          maxLines: 5,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, height: AppConstant.TEXT_HEIGHT, color: AppColorScheme.kPrimaryIconColor),
                        ),
                      ),
                    );
                  })
                : List.generate(subQuestionMap["suggestions"].length, (index) {
                    String subOptionText = subQuestionMap["suggestions"][index];
                    String subOptionKey = subQuestionMap["optionKeys"][index];
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      child: ChoiceChip(
                        label: Text(
                          subOptionText,
                          maxLines: 5,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              height: AppConstant.TEXT_HEIGHT,
                              color: subQuestionMap["selectedOptionKeys"].contains(subOptionKey) ? AppColorScheme.kPrimaryIconColor : AppColorScheme.kGrayColor),
                        ),
                        selected: subQuestionMap["selectedOptionKeys"].contains(subOptionKey),
                        selectedColor: AppColorScheme.kPrimaryColor,
                        backgroundColor: AppColorScheme.kPrimaryColor.shade50,
                        padding: const EdgeInsets.all(10.0),
                        onSelected: (selected) {
                          if (subQuestionMap["selectedOptionKeys"].contains(subOptionKey)) {
                            subQuestionMap["selectedOptionKeys"].remove(subOptionKey);
                            subQuestionMap["selectedOptions"].remove(subOptionText);

                            if (subOptionKey == 'other_cancer') {
                              conversationModel.followupQuestions[submittedOptionKey][0]["inputs"][optionKey][0]["inputs"]["other_cancer"][0].remove("answer");
                            }
                          } else {
                            subQuestionMap["selectedOptionKeys"].add(subOptionKey);
                            subQuestionMap["selectedOptions"].add(subOptionText);
                          }
                          chatBotProvider.notify();
                        },
                      ),
                    );
                  }),
          ),
        ),
        if (subQuestionMap["optionKeys"].contains("other_cancer") && subQuestionMap["selectedOptionKeys"].contains("other_cancer") && !isSubmitted)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextFormField(
                cursorColor: AppColorScheme.kPrimaryColor,
                controller: otherTypeEditingController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z,. ]'),
                  ),
                ],
                decoration: const InputDecoration(
                  errorBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
                onChanged: (string) {
                  subQuestionMap["inputs"]["other_cancer"][0]["answer"] = otherTypeEditingController.text;
                },
              ),
            ),
          ),
        if (subQuestionMap["selectedOptionKeys"].contains("other_cancer") &&
            (conversationModel.followupQuestions[submittedOptionKey][0]["inputs"][optionKey][0]["inputs"]["other_cancer"][0]).containsKey("answer") &&
            isSubmitted)
          Align(
            alignment: Alignment.centerRight,
            child: ChoiceChip(
              selected: true,
              onSelected: (value) {},
              selectedColor: AppColorScheme.kPrimaryColor,
              backgroundColor: AppColorScheme.kPrimaryColor.shade50,
              padding: const EdgeInsets.all(10.0),
              label: Text(
                "${subQuestionMap["inputs"]["other_cancer"][0]["answer"]}",
                maxLines: 5,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: AppConstant.TEXT_HEIGHT,
                  fontSize: 14,
                  color: AppColorScheme.kPrimaryIconColor,
                ),
              ),
            ),
          ),
        if (!isSubmitted)
          GestureDetector(
            onTap: () {
              if (subQuestionMap["selectedOptionKeys"].isNotEmpty) {
                if (subQuestionMap["selectedOptionKeys"].contains("other_cancer")) {
                  subQuestionMap["inputs"]["other_cancer"][0]["answer"] = otherTypeEditingController.text;
                } else {
                  subQuestionMap["inputs"]["other_cancer"][0].remove("answer");
                }
                chatBotProvider.notify();
                onSubmit();
              }
            },
            child: Container(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColorScheme.kPrimaryColor,
                  border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Text(
                  TranslationKeys.submit.translate(context),
                  style: TextStyle(fontSize: 14, height: AppConstant.TEXT_HEIGHT, color: AppColorScheme.kPrimaryIconColor),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
