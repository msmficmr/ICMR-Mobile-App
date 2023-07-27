import 'package:flutter/material.dart';
import 'package:mhealth/views/questionnaire/widgets/single_choice_toggle_text_form_widget.dart';

class Delete extends StatelessWidget {
  static const String routerPath = "/delete";
  const Delete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete", style: TextStyle(color: Colors.black),),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SingleChoiceToggleTextForm()
          ],
        ),
      ),
    );
  }
}
