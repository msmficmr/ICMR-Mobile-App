import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/widgets/space_widget.dart';

@immutable
class CustomDropdown<T> extends StatelessWidget {
  /// Widget key for testing
  final String widgetKey;

  /// [hintText] hint Text for dropdown field
  /// [searchFieldHintText] hint text for search field
  final String? hintText, searchFieldHintText;

  /// Items for dropdown
  final List<T> items;

  /// callback for on changed
  final void Function(T?)? onChanged;

  /// selected item for dropdown
  final T? selectedItem;

  /// validator for dropdown
  final String? Function(T?)? validator;

  /// filter function for dropdown search items
  final bool Function(T, String)? filterFn;
  bool Function(T, T)? compareFn;

  /// [showSearchBox] enable or disable search field for dropdown items. default value is `true`
  final bool? showSearchBox;

  /// [headingKey] is assigned to label of Dropdown i.e Text Widget so that it can used for automation
  final Key? headingKey;

  /// [heading] is label text for the Dropdown
  /// if you don't pass heading it wont be visible
  final String? heading;

  static _getHeadingAssert(String? heading, Key? widgetKey) {
    if (heading != null && widgetKey == null) {
      throw Exception("you have set heading text for the CustomDropdown so headingKey is mandatory. pass headingKey:Key(\"key_heading\") to the widget");
    }

    return true;
  }

  EdgeInsetsGeometry? contentPadding;
  FocusNode? focusNode;
  final bool isEnabled;

  CustomDropdown({
    super.key,
    this.hintText,
    this.heading,
    this.headingKey,
    this.searchFieldHintText,
    this.selectedItem,
    this.validator,
    this.filterFn,
    this.showSearchBox,
    this.compareFn,
    required this.widgetKey,
    required this.items,
    required this.onChanged,
    this.contentPadding,
    this.focusNode,
    this.isEnabled = true,
  }) : assert(_getHeadingAssert(heading, headingKey));

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
        DropdownSearch<T>(
           enabled: isEnabled,
          key: Key(widgetKey),
          items: items,
          onChanged: (value) {
            FocusManager.instance.primaryFocus?.unfocus();
            onChanged?.call(value);
          },
          dropdownButtonProps: DropdownButtonProps(
            padding: const EdgeInsets.symmetric(vertical: 0),
            focusNode: focusNode,
            icon: const Icon(
              Icons.expand_more,
              size: 20,
            ),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: AppStyles.bodyMedium,
            dropdownSearchDecoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppStyles.hintStyle,
              errorStyle: AppStyles.errorStyle,
              contentPadding: contentPadding,
            ),
          ),
          selectedItem: selectedItem,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          filterFn: filterFn,
          compareFn: compareFn,
          popupProps: PopupProps.menu(
            showSearchBox: (items.length >= 10) ? true : false,
            fit: FlexFit.loose,
            showSelectedItems: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: searchFieldHintText,
                hintStyle: AppStyles.hintStyle,
                errorStyle: AppStyles.errorStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
