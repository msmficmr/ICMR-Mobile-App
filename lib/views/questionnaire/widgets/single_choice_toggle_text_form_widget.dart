import 'package:flutter/material.dart';
import 'package:mhealth/views/questionnaire/widgets/custom_chip_widget.dart';

class SingleChoiceToggleTextForm extends StatefulWidget {
  const SingleChoiceToggleTextForm({Key? key}) : super(key: key);

  @override
  State<SingleChoiceToggleTextForm> createState() => _SingleChoiceToggleTextFormState();
}

class _SingleChoiceToggleTextFormState extends State<SingleChoiceToggleTextForm> {

  String? selectedChipId;
  List<TextEditingController> _textControllerList = [];

  @override
  void dispose() {
    for (TextEditingController element in _textControllerList) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomChip(answer: "answer")
        ],
      ),
    );
  }
}
