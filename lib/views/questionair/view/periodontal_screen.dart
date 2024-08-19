import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/model/static_questionnaire_model.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/views/questionair/widgets/section_name_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class PeriodontalScreen extends StatefulWidget {
  PeriodontalStatusQuestionnaire questioner;
  PeriodontalScreen({Key? key, required this.questioner}) : super(key: key);

  @override
  State<PeriodontalScreen> createState() => _PeriodontalScreenState();
}

class _PeriodontalScreenState extends State<PeriodontalScreen> {
  //Titles
  final String UPPER_RIGHT_THRID_MOLAR_DROPDOWN = "17/16";
  final String UPPER_RIGHT_CENTRAL_INCISOR_DROPDOWN = "11";
  final String UPPER_LEFT_THIRD_MOLAR_DROPDOWN = "26/27";
  final String LOWER_RIGHT_THIRD_MOLAR_DROPDOWN = "47/46";
  final String LOWER_LEFT_FIRST_MOLAR_DROPDOWN = "31";
  final String LOWER_LEFT_THIRD_MOLAR_DROPDOWN = "36/37";

  //Widget Keys
  final String KEY_HEADING_UPPER_RIGHT_THRID_MOLAR = "key_heading_upper_right_third_molar";
  final String KEY_HEADING_UPPER_RIGHT_CENTRAL_INCISOR = "key_heading_upper_right_central_incisor";
  final String KEY_HEADING_UPPER_LEFT_THIRD_MOLAR = "key_heading_upper_left_third_molar";
  final String KEY_HEADING_LOWER_RIGHT_THIRD_MOLAR = "key_heading_lower_right_third_molar";
  final String KEY_HEADING_LOWER_LEFT_FIRST_MOLAR = "key_heading_lower_left_first_molar";
  final String KEY_HEADING_LOWER_LEFT_THIRD_MOLAR = "key_heading_lower_left_third_molar";
  final String KEY_FIELD_UPPER_RIGHT_THRID_MOLAR = "key_textfield_upper_right_third_molar";
  final String KEY_FIELD_UPPER_RIGHT_CENTRAL_INCISOR = "key_textfield_upper_right_central_incisor";
  final String KEY_FIELD_UPPER_LEFT_THIRD_MOLAR = "key_textfield_upper_left_third_molar";
  final String KEY_FIELD_LOWER_RIGHT_THIRD_MOLAR = "key_textfield_lower_right_third_molar";
  final String KEY_FIELD_LOWER_LEFT_FIRST_MOLAR = "key_textfield_lower_left_first_molar";
  final String KEY_FIELD_LOWER_LEFT_THIRD_MOLAR = "key_textfield_lower_left_third_molar";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  List<String> items = ["0", "1", "2", "3", "4", "x"];
  List<String> codesDescription = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCPITNCodes();
  }

  /// Used to fetch all the CPITN code description from the json
  getCPITNCodes() {
    String codes = TranslationKeys.cpitnCodesDescription.translate(context);
    codesDescription = CommonFunctions.convertStringToList(codes);
  }

  redirectToQuestionnaire() async {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: ExpansionTile(
              initiallyExpanded: true,
              tilePadding: const EdgeInsets.symmetric(horizontal: 14),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: Border.all(color: Colors.transparent),
              backgroundColor: AppColorScheme.kEnabledButtonColor,
              collapsedBackgroundColor: AppColorScheme.kEnabledButtonColor,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.topLeft,
              title: Text(TranslationKeys.cpitnCodes.translate(context)),
              children: List.generate(
                codesDescription.length,
                (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(codesDescription[index]),
                      const SpaceWidget(height: 5),
                    ],
                  );
                },
              )),
        ),
        const SpaceWidget(
          height: 20,
        ),
        Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: ValueListenableBuilder<String?>(
                      valueListenable: widget.questioner.quest1716.selectedOption,
                      builder: (context, _, __) {
                        return CustomDropdown(
                          hintText: TranslationKeys.select.translate(context),
                          heading: UPPER_RIGHT_THRID_MOLAR_DROPDOWN,
                          headingKey: Key(KEY_HEADING_UPPER_RIGHT_THRID_MOLAR),
                          widgetKey: KEY_FIELD_UPPER_RIGHT_THRID_MOLAR,
                          items: items,
                          selectedItem: widget.questioner.quest1716.selectedOption.value,
                          onChanged: (val) {
                            widget.questioner.quest1716.selectedOption.value = val;
                          },
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        );
                      }),
                ),
                const SpaceWidget(
                  width: 10,
                ),
                Flexible(
                  child: ValueListenableBuilder<String?>(
                      valueListenable: widget.questioner.quest11.selectedOption,
                      builder: (context, _, __) {
                        return CustomDropdown(
                          hintText: TranslationKeys.select.translate(context),
                          heading: UPPER_RIGHT_CENTRAL_INCISOR_DROPDOWN,
                          headingKey: Key(KEY_HEADING_UPPER_RIGHT_CENTRAL_INCISOR),
                          widgetKey: KEY_FIELD_UPPER_RIGHT_CENTRAL_INCISOR,
                          items: items,
                          selectedItem: widget.questioner.quest11.selectedOption.value,
                          onChanged: (val) {
                            widget.questioner.quest11.selectedOption.value = val;
                          },
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        );
                      }),
                ),
                const SpaceWidget(
                  width: 10,
                ),
                Flexible(
                  child: ValueListenableBuilder<String?>(
                      valueListenable: widget.questioner.quest2676.selectedOption,
                      builder: (context, _, __) {
                        return CustomDropdown(
                          hintText: TranslationKeys.select.translate(context),
                          heading: UPPER_LEFT_THIRD_MOLAR_DROPDOWN,
                          headingKey: Key(KEY_HEADING_UPPER_LEFT_THIRD_MOLAR),
                          widgetKey: KEY_FIELD_UPPER_LEFT_THIRD_MOLAR,
                          items: items,
                          selectedItem: widget.questioner.quest2676.selectedOption.value,
                          onChanged: (val) {
                            widget.questioner.quest2676.selectedOption.value = val;
                          },
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        );
                      }),
                ),
              ],
            ),
            const SpaceWidget(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: ValueListenableBuilder<String?>(
                      valueListenable: widget.questioner.quest4746.selectedOption,
                      builder: (context, _, __) {
                        return CustomDropdown(
                          hintText: TranslationKeys.select.translate(context),
                          heading: LOWER_RIGHT_THIRD_MOLAR_DROPDOWN,
                          headingKey: Key(KEY_HEADING_LOWER_RIGHT_THIRD_MOLAR),
                          widgetKey: KEY_FIELD_LOWER_RIGHT_THIRD_MOLAR,
                          items: items,
                          selectedItem: widget.questioner.quest4746.selectedOption.value,
                          onChanged: (val) {
                            widget.questioner.quest4746.selectedOption.value = val;
                          },
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        );
                      }),
                ),
                const SpaceWidget(
                  width: 10,
                ),
                Flexible(
                  child: ValueListenableBuilder<String?>(
                      valueListenable: widget.questioner.quest31.selectedOption,
                      builder: (context, _, __) {
                        return CustomDropdown(
                          hintText: TranslationKeys.select.translate(context),
                          heading: LOWER_LEFT_FIRST_MOLAR_DROPDOWN,
                          headingKey: Key(KEY_HEADING_LOWER_LEFT_FIRST_MOLAR),
                          widgetKey: KEY_FIELD_LOWER_LEFT_FIRST_MOLAR,
                          items: items,
                          selectedItem: widget.questioner.quest31.selectedOption.value,
                          onChanged: (val) {
                            widget.questioner.quest31.selectedOption.value = val;
                          },
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        );
                      }),
                ),
                const SpaceWidget(
                  width: 10,
                ),
                Flexible(
                  child: ValueListenableBuilder<String?>(
                      valueListenable: widget.questioner.quest3637.selectedOption,
                      builder: (context, _, __) {
                        return CustomDropdown(
                          hintText: TranslationKeys.select.translate(context),
                          heading: LOWER_LEFT_THIRD_MOLAR_DROPDOWN,
                          headingKey: Key(KEY_HEADING_LOWER_LEFT_THIRD_MOLAR),
                          widgetKey: KEY_FIELD_LOWER_LEFT_THIRD_MOLAR,
                          items: items,
                          selectedItem: widget.questioner.quest3637.selectedOption.value,
                          onChanged: (val) {
                            widget.questioner.quest3637.selectedOption.value = val;
                          },
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
