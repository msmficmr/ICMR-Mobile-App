import 'package:flutter/material.dart';
import 'package:mhealth/model/conversation_model.dart';
import 'package:mhealth/repo/questionnaires.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/views/ask_mhealth/widgets/question.dart';
import 'package:mhealth/views/ask_mhealth/widgets/send_widget.dart';
import 'package:provider/provider.dart';

class SingleTextField extends StatefulWidget {
  final ConversationModel conversationModel;
  final double screenWidth;
  final int index;

  const SingleTextField({
    Key? key,
    required this.conversationModel,
    required this.screenWidth,
    required this.index,
  }) : super(key: key);

  @override
  State<SingleTextField> createState() => _SingleTextFieldState();
}

class _SingleTextFieldState extends State<SingleTextField> {
  final Questionnaires _questionnairesRepository = Questionnaires();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ChatBotViewModel chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: true);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 0),
              child: Question(
                screenWidth: widget.screenWidth,
                questionText: widget.conversationModel.question,
                questionTime: widget.conversationModel.timeAsked,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.conversationModel.followUpSubmitted)
                    ? Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: CustomChip(
                          index: widget.index,
                          answer: widget.conversationModel.answer!,
                          editable: widget.conversationModel.isEditable,
                        ),
                      )
                    : _displayTextBox(),
                if (!widget.conversationModel.followUpSubmitted)
                  SendWidget(
                    onTap: () {
                      if (chatBotProvider.isNextSuggestionClickable) {
                        chatBotProvider.setIsOneAssessmentCompleted = false;
                        if (_questionnairesRepository.conversation.first.questionId == "middle_name") {
                          _questionnairesRepository.conversation.first.answer = _textEditingController.text;
                          _textEditingController.clear();
                          _questionnairesRepository.conversation.first.followUpSubmitted = true;
                          chatBotProvider.notify();
                          chatBotProvider.onUserSelectsOption(conversationModel: widget.conversationModel, context: context);
                        } else {
                          if (formKey.currentState!.validate() && _textEditingController.text.isNotEmpty) {
                            _questionnairesRepository.conversation.first.answer = _textEditingController.text;
                            _textEditingController.clear();
                            _questionnairesRepository.conversation.first.followUpSubmitted = true;
                            chatBotProvider.notify();
                            chatBotProvider.onUserSelectsOption(conversationModel: widget.conversationModel, context: context);
                          } else {}
                        }
                      }
                    },
                    bottom: 30,
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _displayTextBox() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        controller: _textEditingController,
        decoration: const InputDecoration(
          errorBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
        onSubmitted: (value) {},
      ),
    );
  }
}
