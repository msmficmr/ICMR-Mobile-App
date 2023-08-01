import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';

class SelectableChips extends StatefulWidget {
  final List<String> chipText;
  final List<String> chipTextId;

  const SelectableChips({Key? key, required this.chipText, required this.chipTextId}) : super(key: key);

  @override
  State<SelectableChips> createState() => _SelectableChipsState();
}

class _SelectableChipsState extends State<SelectableChips> {
  List<String> selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: List.generate(
        //TODO: Make the length as widget.chipText.length
        4,
        (index) {
          return Container(
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
                label: Text(
                  widget.chipText[index],
                  style: AppStyles.titleMedium.copyWith(color: selectedChoices.contains(widget.chipText[index])
                      ? AppColorScheme.kPrimaryIconColor
                      : AppColorScheme.kGrayColor.shade700),
                ),
                selected: selectedChoices.contains(widget.chipText[index]),
                selectedColor: AppColorScheme.kPrimaryColor,
              backgroundColor: AppColorScheme.kPrimaryColor.shade50,
              padding: const EdgeInsets.all(10),
              onSelected: (selected) {},
            ),
          );
        },
      ),
    );
  }
}
