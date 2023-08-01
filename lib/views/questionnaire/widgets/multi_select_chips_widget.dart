import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/views/questionnaire/widgets/custom_field_text.dart';
import 'package:mhealth/views/questionnaire/widgets/selectable_chips.dart';
import 'package:mhealth/widgets/space_widget.dart';

class MultiSelectChipsWidget extends StatefulWidget {
  const MultiSelectChipsWidget({Key? key}) : super(key: key);

  @override
  State<MultiSelectChipsWidget> createState() => _MultiSelectChipsWidgetState();
}

class _MultiSelectChipsWidgetState extends State<MultiSelectChipsWidget> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TODO: If followupQuestions[widget.conversationModel.answer] != null
        1 > 2
            ? SelectableChips(
                chipText: [],
                chipTextId: [],
              )
            : 1 > 2 //TODO: If selectedOptionIndex != null
                ? Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 1,
                    spacing: 1,
                    children: List.generate(
                      4,
                      (index) {
                        return CustomChipWOMargin(
                          answer: "",
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
        //TODO: If selectedOptionIndex != null
        if (1 > 2) ...[
          //TODO: If selectedOptionKeys contains other_cancer && !followUpSubmitted
          if (2 > 1)
            CustomFieldText(
              onSubmit: () {},
              textEditingController: textEditingController,
              showSubmit: false,
            ),
          //TODO: If selectedOptionKeys contains other_cancer, other_cancer"][0]["answer] != null && !followUpSubmitted
          if (1 > 2) CustomChipWOMargin(answer: "answer"),
          // submit button will only show when follow-ups are not submitted
          //TODO: If followupQuestions != null && followUpSubmitted
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: AppColorScheme.kPrimaryColor,
                  border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  //TODO: change the select to SUBMIT in respective language
                  CommonFunctions.getText(
                    language: "en_US",
                    engText: TranslationKeys.select.translate(context),
                    hindiText: TranslationKeys.select.translate(context),
                  ),
                ),
              ),
            ),
          ),
          //TODO: If followupQuestions != null && followUpSubmitted
          if (1 > 2) const SpaceWidget(height: 100)
        ]
      ],
    );
  }
}

class CustomChipWOMargin extends StatelessWidget {
  final String answer;

  const CustomChipWOMargin({Key? key, required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
