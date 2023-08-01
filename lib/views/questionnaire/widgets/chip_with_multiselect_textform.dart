import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/views/questionnaire/widgets/custom_chip_widget.dart';
import 'package:mhealth/views/questionnaire/widgets/multi_select_chips_widget.dart';
import 'package:mhealth/views/questionnaire/widgets/question.dart';

class ChipWithMultiSelectTextForm extends StatefulWidget {
  const ChipWithMultiSelectTextForm({Key? key}) : super(key: key);

  @override
  State<ChipWithMultiSelectTextForm> createState() => _ChipWithMultiSelectTextFormState();
}

class _ChipWithMultiSelectTextFormState extends State<ChipWithMultiSelectTextForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          QuestionWidget(context: context, question: "question", time: DateTime.now()),
          const SizedBox(height: 10),
          //TODO: If selectedOptionIndex == null
          1 > 2
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [...chipOptionList(), const SizedBox(height: 100)],
                )
              : CustomChip(
                  answer: "answer",
                  editable: true,
                ),
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
            //TODO: If selectedOptionIndex != null
            child: (1 > 2) ? Column(
              children: [
                ...[QuestionWidget(context: context, question: "question", time: DateTime.now())],
                const SizedBox(height: 10),
                ...[Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: MultiSelectChipsWidget(),
                )]
              ],
            ) : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  List<Widget> chipOptionList() {
    return List.generate(
      4,
      (index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColorScheme.kPrimaryColor.shade50,
              border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor.shade50),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Text(
              "",
              style: AppStyles.titleMedium,
            ),
          ),
        );
      },
    );
  }
}
