import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/model/static_questionnaire_model.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
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
  late ValueNotifier<bool> errorText;
  late ValueNotifier<bool> _buttonEnabled;
  late QuestionnaireViewModel provider;
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

  final Map<String, String> siteMaps = {
    "1": "Upper lip",
    "2": "Lower lip",
    "3": "Cheek",
    "4": "Tongue lateral",
    "5": "Tongue lateral",
    "6": "Dorsal",
    "7": "Ventral",
    "8": "Base of the tongue",
    "9": "Palate",
    "10": "Upper vestibule",
    "11": "Lower vestibule",
    "12": "Retromolar trigone (RMT)",
    "13": "Gingiva-upper",
    "14": "Gingiva-lower",
    "15": "Floor of the mouth"
  };

  final List<String> siteLocation = ['Left', 'Right'];
  List<StaticQuestionModel> staticQuestionnaires = [];

  //Titles
  static const String ATTACHMENT = "Attachment";
  final String SITE_TITLE = "Site";
  final String LOCATION_TITLE = "Location";
  final String CONSENT_TEXT = 'I have capture all the images of lesions';
  final String CAPTURE_IMAGE_TITLE = "Capture Image";

  @override
  void initState() {
    super.initState();
    provider = Provider.of<QuestionnaireViewModel>(context, listen: false);
    initializeField();
  }

  initializeField() {
    _site = ValueNotifier<String?>(null);
    _location = ValueNotifier<String?>(null);
    _hasConsent = ValueNotifier<bool>(false);
    errorText = ValueNotifier<bool>(false);
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
      provider.saveAttachment(model);
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
                          items: siteMaps.values.map((e) => e).toList(),
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
                    if (provider.attachmentList.isNotEmpty)
                      Text(
                        ATTACHMENT,
                        style: AppStyles.appBarStyle.copyWith(color: AppColorScheme.kBlack),
                      ),
                    Selector<QuestionnaireViewModel, int>(
                      selector: (_, provider) => provider.attachmentList.length,
                      builder: (context, value, child) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          provider.attachmentList.length,
                          (index) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder<AttachmentModel?>(
                                  valueListenable: _selectedAttachment,
                                  builder: (context, attachment, _) {
                                    return AttachmentWidget(
                                      title: provider.attachmentList[index]!.fileName,
                                      titleKey: Key(KEY_ATTACHMENT_TITLE),
                                      viewKey: Key(KEY_ATTACHMENT_VIEW_CARD),
                                      removeButtonKey: Key(KEY_REMOVE_BUTTON),
                                      onRemoveClick: () {
                                        provider.removeAttachment(index); // Remove the attachment from the list
                                        _selectedAttachment.value = null;
                                      },
                                      viewPictureClick: () {
                                        CommonFunctions.viewImage(context: context, bytes: provider.attachmentList[index]!.bytes);
                                      },
                                    );
                                  }),
                              const SpaceWidget(),
                            ],
                          ),
                        ),
                      ),
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
                        return ValueListenableBuilder(
                          valueListenable: errorText,
                          builder: (context, _, __) {
                            return QuestionnaireCheckBox(
                              onChanged: onConsentChanged,
                              checkboxStatus: _hasConsent.value,
                              widgetKey: KEY_CHECKBOX_CONSENT,
                              text: CONSENT_TEXT,
                              errorText: errorText.value,
                            );
                          },
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
                              if (_selectedAttachment.value != null && _hasConsent.value == false) {
                                errorText.value = true;
                              } else {
                                errorText.value = false;
                                await saveLesionLocationsData();
                                if (provider.attachmentList.isNotEmpty) {
                                  GoRouter.of(context).push(MeasurementLesionsScreen.routerPath);
                                } else {
                                  GoRouter.of(context).push(QuestionnaireScreen.routerPath, extra: "community_risk_assessment_investigation");
                                }
                              }
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

  saveLesionLocationsData() async {
    if (provider.attachmentList.isNotEmpty) saveLesionLocationData();
    await provider.setNextSectionData("community_risk_assessment_lesion_location", context, staticSectionsData: staticQuestionnaires);
  }

  saveLesionLocationData() {
    for (int i = 0; i < provider.attachmentList.length; i++) {
      final staticQuestion = StaticQuestionModel(provider.attachmentList[i]!.fileName.questionText, provider.attachmentList[i]!.bytes.toString(), null, null, DateTime.now(), null, null);
      staticQuestionnaires.add(staticQuestion);
    }
  }
}

class SiteModel {
  String id;
  String site;

  SiteModel(this.id, this.site);
}
