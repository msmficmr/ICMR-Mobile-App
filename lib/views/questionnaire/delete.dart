import 'package:flutter/material.dart';
import 'package:mhealth/views/questionnaire/widgets/question.dart';
import 'package:mhealth/views/questionnaire/widgets/single_choice_toggle_text_form_widget.dart';
import 'package:mhealth/views/questionnaire/widgets/single_text_field.dart';
import 'package:mhealth/views/questionnaire/widgets/text_widget.dart';

class Delete extends StatelessWidget {
  static const String routerPath = "/delete";
  const Delete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete", style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SingleChoiceToggleTextForm(),
            const SizedBox(height: 10),
            QuestionWidget(context: context, question: "question", time: DateTime.now()),
            const SizedBox(height: 10),
            const TextWidget(text: "text"),
            const SizedBox(height: 10),
            const SingleTextField()
          ],
        ),
      ),
    );
  }
}
