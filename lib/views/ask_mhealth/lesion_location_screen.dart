import 'package:flutter/material.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/views/ask_mhealth/widgets/verification_checkbox_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';

class LesionLocationScreen extends StatefulWidget {
  static const routerPath = "/lesionLocationScreen";

  const LesionLocationScreen({Key? key}) : super(key: key);

  @override
  State<LesionLocationScreen> createState() => _LesionLocationScreenState();
}

class _LesionLocationScreenState extends State<LesionLocationScreen> {

  late ValueNotifier<String?> _site;
  late ValueNotifier<String?> _location;
  late ValueNotifier<bool> _hasConsent;
  late ValueNotifier<bool> _buttonEnabled;

  //Widget Keys
  final String KEY_FIELD_SITE = "key_textfield_site";
  final String KEY_FIELD_LOCATION = "key_textfield_location";
  final String KEY_HEADING_SITE = "key_title_site";
  final String KEY_HEADING_LOCATION = "key_title_location";
  final String KEY_BUTTON_CAPTURE_IMAGE = "key_button_capture_image";
  final String KEY_CHECKBOX_CONSENT = "key_checkbox_consent";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  //Titles
  final String SITE_TITLE = "Site";
  final String LOCATION_TITLE = "Location";
  final String CONSENT_TEXT = 'I have capture  all the images of lesions';
  final String CAPTURE_IMAGE_TITLE = "Capture Image";

  @override
  void initState() {
    super.initState();
    initializeField();
  }

  initializeField() {
    _site = ValueNotifier<String?>(null);
    _location = ValueNotifier<String?>(null);
    _hasConsent = ValueNotifier<bool>(false);
    _buttonEnabled = ValueNotifier<bool>(true);
  }

  void onConsentChanged(bool? input) {
    _hasConsent.value = input ?? false;
  }

  @override
  Widget build(BuildContext context) {
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
                  const SpaceWidget(
                    height: 15,
                  ),
                  //SITE
                  ValueListenableBuilder<String?>(
                    valueListenable: _site,
                    builder: (context, _, __) {
                      return CustomDropdown<String>(
                        widgetKey: KEY_FIELD_SITE,
                        heading: SITE_TITLE,
                        headingKey: Key(KEY_HEADING_SITE),
                        hintText: TranslationKeys.select.translate(context),
                        onChanged: (val) {
                          _site.value = val;
                        },
                        selectedItem: _site.value,
                        items: [],
                      );
                    },
                  ),
                  const SpaceWidget(
                    height: 15,
                  ),
                  //LOCATION
                  ValueListenableBuilder<String?>(
                    valueListenable: _location,
                    builder: (context, _, __) {
                      return CustomDropdown<String>(
                        widgetKey: KEY_FIELD_LOCATION,
                        heading: LOCATION_TITLE,
                        headingKey: Key(KEY_HEADING_LOCATION),
                        hintText: TranslationKeys.select.translate(context),
                        onChanged: (val) {
                          _location.value = val;
                        },
                        selectedItem: _location.value,
                        items: [],
                      );
                    },
                  ),
                  const SpaceWidget(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryFilledButton(
                        onPressed: () {},
                        isLoading: false,
                        buttonThemeStyle: const FilledButtonThemeStyle(
                          enabledTextColor: AppColorScheme.kEnabledButtonTextColor,
                          enabledButtonColor: AppColorScheme.kEnabledButtonColor,
                        ),
                        buttonTitle: CAPTURE_IMAGE_TITLE,
                        widgetKey: KEY_BUTTON_CAPTURE_IMAGE),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _hasConsent,
                    builder: (context, _, __) {
                      return QuestionnaireCheckBox(
                        onChanged: onConsentChanged,
                        checkboxStatus: _hasConsent.value,
                        widgetKey: KEY_CHECKBOX_CONSENT,
                        text: CONSENT_TEXT,
                      );
                    },
                  ),
                  const SpaceWidget(height: 20,),
                  SizedBox(
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
