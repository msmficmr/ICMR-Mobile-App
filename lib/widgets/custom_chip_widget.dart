import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/widgets/space_widget.dart';

class CustomChipWidget<T> extends StatelessWidget {
  /// If we pass this variable as true then it will translate the text into local language
  final bool shouldTranslate;

  //sets selected item for chips list
  final T? selectedItem;

  // list of element for chip
  final List<CustomChipItem<T>> chipList;

  /// [headingKey] is assigned to label of TextFormField i.e Text Widget so that it can used for automation
  final Key? headingKey;

  /// [heading] is label text for the TextFormField
  /// if you don't pass heading it wont be visible
  final String? heading;

  /// Callback to get selected chip value
  final ValueChanged<T?>? onChanged;

  /// background color for selected chips
  final Color selectedBackgroundColor;

  /// Text Color for selected chip
  final Color selectedTextColor;

  /// border color for selected chip
  final Color selectedBorderColor;

  /// background color for unSelected chips
  final Color unSelectedBackgroundColor;

  /// Text Color for unSelected chip
  final Color unSelectedTextColor;

  /// border color for unSelected chip
  final Color unSelectedBorderColor;

  ///Padding for chip
  final EdgeInsetsGeometry chipPadding;

  /// [fieldKey] is required if we are passing validator
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();

  /// validator for the CustomChipWidget
  final String? Function(T?)? validator;

  static _getHeadingAssert(String? heading, Key? widgetKey) {
    if (heading != null && widgetKey == null) {
      throw Exception("you have set heading text for the CustomChipWidget so headingKey is mandatory. pass headingKey:Key(\"key_heading\") to the widget");
    }

    return true;
  }

  /// *EXAMPLE:
  ///  CustomChipWidget<String>(
  ///   chipList: [
  ///     CustomChipItem(data: "Female", text: "Female"),
  ///     CustomChipItem(data: "Male", text: "Male"),
  ///     CustomChipItem(data: "Transgender", text: "Other"),
  ///   ],
  ///   onChanged: (value) {},
  ///   heading: "Gender*",
  /// ),

  CustomChipWidget({
    super.key,
    required this.chipList,
    this.selectedItem,
    this.headingKey,
    this.onChanged,
    this.heading,
    this.validator,
    this.chipPadding = const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    this.shouldTranslate = false,
    this.selectedBackgroundColor = const Color(0xFF4454EF),
    this.selectedBorderColor = const Color(0xFF4454EF),
    this.selectedTextColor = const Color(0xFFFFFFFF),
    this.unSelectedBackgroundColor = Colors.transparent,
    this.unSelectedBorderColor = const Color(0xFFE0E0E0),
    this.unSelectedTextColor = const Color(0xFF9E9E9E),
  })  : assert(
          chipList.isEmpty ||
              selectedItem == null ||
              chipList.where((CustomChipItem<T> item) {
                    return item.data == selectedItem;
                  }).length ==
                  1,
          "There should be exactly one item with [CustomChipItem]'s value: "
          '$selectedItem. \n'
          'Either zero or 2 or more [CustomChipItem]s were detected '
          'with the same value',
        ),
        assert(_getHeadingAssert(heading, headingKey));

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null) ...[
          Text(
            heading!,
            key: headingKey,
            style: AppStyles.titleMedium,
          ),
          const SpaceWidget(),
        ],
        FormField<T?>(
          key: _fieldKey,
          validator: validator,
          initialValue: selectedItem,
          builder: (field) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 10,
                  spacing: 10,
                  children: List.generate(
                    chipList.length,
                    (index) {
                      bool isItemSelected = (selectedItem == null || selectedItem != chipList[index].data);

                      return Material(
                        color: isItemSelected ? unSelectedBackgroundColor : selectedBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: isItemSelected ? unSelectedBorderColor : selectedBorderColor,
                          ),
                        ),
                        child: InkWell(
                          key: Key("key_choice_${chipList[index].text.toKey}"),
                          onTap: onChanged == null
                              ? null
                              : () {
                                  _fieldKey.currentState!.didChange(chipList[index].data);
                                  onChanged!(chipList[index].data);
                                },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: chipPadding,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: unSelectedBorderColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              shouldTranslate ? chipList[index].text.translate(context) : chipList[index].text,
                              style: AppStyles.titleMedium.copyWith(
                                fontWeight: isItemSelected ? FontWeight.normal : FontWeight.w600,
                                color: isItemSelected ? unSelectedTextColor : selectedTextColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (field.hasError) ...[
                  const SpaceWidget(),
                  Text(
                    field.errorText ?? "",
                    style: AppStyles.errorStyle,
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class CustomChipItem<T> {
  /// Class used to pass list item to [CustomChipWidget]
  /// *[text] will be displayed on Text
  final String text;

  /// *[data] will be used to return T type data when onChange callback is called
  final T? data;

  const CustomChipItem({required this.text, required this.data});
}
