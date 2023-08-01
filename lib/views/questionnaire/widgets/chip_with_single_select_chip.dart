import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/views/questionnaire/widgets/custom_chip_widget.dart';
import 'package:mhealth/views/questionnaire/widgets/question.dart';
import 'package:mhealth/widgets/space_widget.dart';

class ChipWithSingleSelectChip extends StatefulWidget {
  const ChipWithSingleSelectChip({Key? key}) : super(key: key);

  @override
  State<ChipWithSingleSelectChip> createState() => _ChipWithSingleSelectChipState();
}

class _ChipWithSingleSelectChipState extends State<ChipWithSingleSelectChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          QuestionWidget(context: context, question: "question", time: DateTime.now()),
          const SpaceWidget(height: 10),
          //TODO: If selectedOptionIndex == null
          1 > 2
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(4, (index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      ),
                    );
                  }),
                )
              : CustomChip(answer: "answer", editable: false),
          // follow-up question
          //TODO: If answer != null
          if (1 > 2) QuestionWidget(context: context, question: "question", time: DateTime.now()),
          const SpaceWidget(height: 10),
          // follow-up answer
          //TODO: If answer != null
          if (1 > 2)
            Column(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                  ),
                );
              }),
            ),
          //TODO : If selectedOptionIndex != null
          if (1 > 2)
            CustomChip(answer: "answer", editable: false,)
        ],
      ),
    );
  }
}
