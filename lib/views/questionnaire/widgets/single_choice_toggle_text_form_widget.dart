import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/views/questionnaire/widgets/custom_chip_widget.dart';
import 'package:mhealth/views/questionnaire/widgets/question.dart';
import 'package:mhealth/views/questionnaire/widgets/send_widget.dart';

class SingleChoiceToggleTextForm extends StatefulWidget {
  const SingleChoiceToggleTextForm({Key? key}) : super(key: key);

  @override
  State<SingleChoiceToggleTextForm> createState() => _SingleChoiceToggleTextFormState();
}

class _SingleChoiceToggleTextFormState extends State<SingleChoiceToggleTextForm> {
  String? selectedChipId;
  List<TextEditingController> _textControllerList = [TextEditingController()];

  @override
  void dispose() {
    for (TextEditingController element in _textControllerList) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomChip(answer: "answer", editable: true),
        _displayFollowUpQA(),
      ],
    );
  }

  Widget _displayFollowUpQA() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        QuestionWidget(context: context, question: "Question widget", time: DateTime.now()),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //TODO: Conditional check if the followup is submitted
            (1 > 2) ? CustomChip(answer: "answer") : _displayTextBox(followUpQuestionIndex: 0),
            SendWidget(onTap: (){})
          ],
        )
      ],
    );
  }

  Widget _displayTextBox({required int followUpQuestionIndex}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        controller: _textControllerList[followUpQuestionIndex],
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          errorBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}
