import 'package:flutter/material.dart';
import 'package:mhealth/views/questionnaire/widgets/custom_chip_widget.dart';
import 'package:mhealth/views/questionnaire/widgets/question.dart';
import 'package:mhealth/views/questionnaire/widgets/send_widget.dart';

class SingleTextField extends StatefulWidget {
  const SingleTextField({Key? key}) : super(key: key);

  @override
  State<SingleTextField> createState() => _SingleTextFieldState();
}

class _SingleTextFieldState extends State<SingleTextField> {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 0),
            child: QuestionWidget(context: context, question: "question", time: DateTime.now()),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //TODO: If followup is submitted
              (1 > 2)
                  ? Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: CustomChip(
                        answer: "answer",
                        editable: true,
                      ),
                    )
                  : _displayTextBox(),
              //TODO: If followup is submitted
              if (1 == 1)
                SendWidget(onTap: (){}, bottom: 30,)
            ],
          )
        ],
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
