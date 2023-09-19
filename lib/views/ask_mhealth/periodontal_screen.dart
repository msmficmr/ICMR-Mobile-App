import 'package:flutter/material.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';

class PeriodontalScreen extends StatefulWidget {
  static const routerPath = "/periodontalScreen";

  PeriodontalScreen({Key? key}) : super(key: key);

  @override
  State<PeriodontalScreen> createState() => _PeriodontalScreenState();
}

class _PeriodontalScreenState extends State<PeriodontalScreen> {
  late ValueNotifier<bool> _buttonEnabled;

  //Widget Keys
  final String KEY_HEADING_DROPDOWN = "key_heading_dropdown_1";
  final String KEY_FIELD_DROPDOWN1 = "key_textfield_dropdown_1";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  List<String> items = ["0", "1", "2", "3", "4"];

  @override
  void initState() {
    super.initState();
    _buttonEnabled = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        onLeadingClick: () {},
        appBarTitleType: CustomAppBarTitleType.TEXT,
        titleText: AppConstant.RISK_ASSESSMENT,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppValues.kAppPadding),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppAssetsPath.periodontalStatusImage,
                    width: width,
                  ),
                  const SpaceWidget(
                    height: 20,
                  ),
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
                      title: const Text('CPITN Codes'),
                      children: const <Widget>[
                        Text('0 = Healthy'),
                        SpaceWidget(
                          height: 5,
                        ),
                        Text('1 = Bleeding on probing'),
                        SpaceWidget(
                          height: 5,
                        ),
                        Text('2 = Calculus or plaque retention factor'),
                        SpaceWidget(
                          height: 5,
                        ),
                        Text('3 = Shallow pocket 4 or 5mm'),
                        SpaceWidget(
                          height: 5,
                        ),
                        Text('4 = Deep pocket 6mm or more'),
                      ],
                    ),
                  ),
                  const SpaceWidget(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: CustomDropdown(
                              hintText: "Select",
                              heading: "17/16",
                              headingKey: Key(KEY_HEADING_DROPDOWN),
                              widgetKey: KEY_FIELD_DROPDOWN1,
                              items: items,
                              onChanged: (val) {},
                              showSearchBox: false,
                            ),
                          ),
                          const SpaceWidget(
                            width: 20,
                          ),
                          Flexible(
                            child: CustomDropdown(
                              hintText: "Select",
                              heading: "11",
                              headingKey: Key(KEY_HEADING_DROPDOWN),
                              widgetKey: KEY_FIELD_DROPDOWN1,
                              items: items,
                              onChanged: (val) {},
                              showSearchBox: false,
                            ),
                          ),
                          const SpaceWidget(
                            width: 20,
                          ),
                          Flexible(
                            child: CustomDropdown(
                              hintText: "Select",
                              heading: "26/27",
                              headingKey: Key(KEY_HEADING_DROPDOWN),
                              widgetKey: KEY_FIELD_DROPDOWN1,
                              items: items,
                              onChanged: (val) {},
                              showSearchBox: false,
                            ),
                          ),
                        ],
                      ),
                      const SpaceWidget(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: CustomDropdown(
                              hintText: "Select",
                              heading: "47/46",
                              headingKey: Key(KEY_HEADING_DROPDOWN),
                              widgetKey: KEY_FIELD_DROPDOWN1,
                              items: items,
                              onChanged: (val) {},
                              showSearchBox: false,
                            ),
                          ),
                          const SpaceWidget(
                            width: 20,
                          ),
                          Flexible(
                            child: CustomDropdown(
                              hintText: "Select",
                              heading: "31",
                              headingKey: Key(KEY_HEADING_DROPDOWN),
                              widgetKey: KEY_FIELD_DROPDOWN1,
                              items: items,
                              onChanged: (val) {},
                              showSearchBox: false,
                            ),
                          ),
                          const SpaceWidget(
                            width: 20,
                          ),
                          Flexible(
                            child: CustomDropdown(
                              hintText: "Select",
                              heading: "36/37",
                              headingKey: Key(KEY_HEADING_DROPDOWN),
                              widgetKey: KEY_FIELD_DROPDOWN1,
                              items: items,
                              onChanged: (val) {},
                              showSearchBox: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SpaceWidget(
                    height: 20,
                  ),
                ],
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _buttonEnabled,
                    builder: (context, isValid, _) {
                      return PrimaryFilledButton(
                        buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                        buttonTitle: TranslationKeys.continueText.translate(context),
                        widgetKey: KEY_BUTTON_CONTINUE,
                        isLoading: false,
                        onPressed: () {},
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
