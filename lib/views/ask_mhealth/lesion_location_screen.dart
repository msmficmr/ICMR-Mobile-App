import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/model/static_questionnaire_model.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/views/ask_mhealth/measurement_lesions_screen.dart';
import 'package:mhealth/views/ask_mhealth/widgets/section_name_widget.dart';
import 'package:mhealth/views/ask_mhealth/widgets/verification_checkbox_widget.dart';
import 'package:mhealth/widgets/attachment_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<AttachmentModel?> _selectedAttachment = ValueNotifier<AttachmentModel?>(null);

  //Widget Keys
  final String KEY_FIELD_SITE = "key_textfield_site";
  final String KEY_FIELD_LOCATION = "key_textfield_location";
  final String KEY_HEADING_SITE = "key_title_site";
  final String KEY_HEADING_LOCATION = "key_title_location";
  final String KEY_BUTTON_CAPTURE_IMAGE = "key_button_capture_image";
  final String KEY_ATTACHMENT_TITLE = "key_attachment_title";
  final String KEY_ATTACHMENT_VIEW_CARD = "key_attachment_view_card";
  final String KEY_REMOVE_BUTTON = "key_remove_button";
  final String KEY_CHECKBOX_CONSENT = "key_checkbox_consent";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  final List<String> sites = [
    'Upper lip',
    'Lower lip',
    'Cheek',
    'Tongue lateral',
    'Dorsal',
    'Ventral',
    'Base of the tongue',
    'Palate',
    'Upper vestibule',
    'Lower vestibule',
    'Retromolar trigone (RMT)',
    'Gingiva -upper',
    'Gingiva-lower',
    'Floor of the mouth'
  ];
  final List<String> siteLocation = ['Left', 'Right'];
  List<StaticQuestionModel> staticQuestionnaires = [];

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

  fetchImage(ImageSource source) async {
    XFile? file = await CommonFunctions.getImage(context: context, imageSource: source);
    if (file != null) {
      Uint8List bytes = await file.readAsBytes();
      AttachmentModel model = AttachmentModel(bytes: bytes, fileName: "${_location.value} ${_site.value}");
      _selectedAttachment.value = model;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeadingClick: () => GoRouter.of(context).pop(),
        appBarTitleType: CustomAppBarTitleType.TEXT,
        titleText: AppConstant.RISK_ASSESSMENT,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(AppValues.kAppPadding),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionNameWidget(sectionName: "Lesion Location (mark the site)"),
                    const SpaceWidget(
                      height: 15,
                    ),
                    ValueListenableBuilder<String?>(
                      valueListenable: _site,
                      builder: (context, _, __) {
                        return CustomDropdown<String>(
                          widgetKey: KEY_FIELD_SITE,
                          heading: SITE_TITLE,
                          headingKey: Key(KEY_HEADING_SITE),
                          validator: AppValidators.requiredField,
                          hintText: TranslationKeys.select.translate(context),
                          onChanged: (val) {
                            _site.value = val;
                          },
                          selectedItem: _site.value,
                          items: sites,
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
                          validator: AppValidators.requiredField,
                          headingKey: Key(KEY_HEADING_LOCATION),
                          hintText: TranslationKeys.select.translate(context),
                          onChanged: (val) {
                            _location.value = val;
                          },
                          selectedItem: _location.value,
                          items: siteLocation,
                        );
                      },
                    ),
                    const SpaceWidget(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryFilledButton(
                          onPressed: () {
                            fetchImage(ImageSource.camera);
                          },
                          isLoading: false,
                          buttonThemeStyle: const FilledButtonThemeStyle(
                            enabledTextColor: AppColorScheme.kEnabledButtonTextColor,
                            enabledButtonColor: AppColorScheme.kEnabledButtonColor,
                          ),
                          buttonTitle: CAPTURE_IMAGE_TITLE,
                          widgetKey: KEY_BUTTON_CAPTURE_IMAGE),
                    ),
                    const SpaceWidget(
                      height: 15,
                    ),
                    ValueListenableBuilder<AttachmentModel?>(
                        valueListenable: _selectedAttachment,
                        builder: (context, attachment, _) {
                          if (attachment != null) {
                            saveLesionLocationData(_site.value!, _location.value!, attachment.bytes);
                            return AttachmentWidget(
                              title: attachment.fileName,
                              titleKey: Key(KEY_ATTACHMENT_TITLE),
                              viewKey: Key(KEY_ATTACHMENT_VIEW_CARD),
                              removeButtonKey: Key(KEY_REMOVE_BUTTON),
                              onRemoveClick: () {
                                _buttonEnabled.value = false;
                                _selectedAttachment.value = null;
                              },
                              viewPictureClick: () {
                                CommonFunctions.viewImage(context: context, bytes: _selectedAttachment.value!.bytes);
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
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
                    const SpaceWidget(
                      height: 20,
                    ),
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
                            onPressed: () async {
                              await saveLesionLocationsData();
                              GoRouter.of(context).push(MeasurementLesionsScreen.routerPath);
                            },
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
      ),
    );
  }

  saveLesionLocationData(String site, String location, List<int> image) {
    final staticQuestion = StaticQuestionModel("${site}_$location", image.toString(), null, null, DateTime.now(), null, null);
    staticQuestionnaires.add(staticQuestion);
  }


  saveLesionLocationsData() async {
    final questionnaireViewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    await questionnaireViewModel.setNextSectionData("community_risk_assessment_lesion_location", context, staticSectionsData: staticQuestionnaires);
  }
}
