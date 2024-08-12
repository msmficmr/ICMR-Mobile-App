import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/views/screening/widget/upload_file_widget.dart';
import 'package:mhealth/widgets/attachment_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class ConsentScreeningScreen extends StatefulWidget {
  static const String routerPath = "/consentScreening";

  const ConsentScreeningScreen({
    super.key,
  });

  @override
  State<ConsentScreeningScreen> createState() => _ConsentScreeningScreenState();
}

class _ConsentScreeningScreenState extends State<ConsentScreeningScreen> {
  late ValueNotifier<bool> _buttonEnabled;
  final ValueNotifier<AttachmentModel?> _selectedAttachment = ValueNotifier<AttachmentModel?>(null);

  /// keys
  final String KEY_INFORMED_CONSENT = "key_informed_consent";
  final Key KEY_TITLE_CAMERA = const Key("key_title_camera");
  final Key KEY_TITLE_BROWSE = const Key("key_title_browse");
  final Key KEY_TITLE_HEADING = const Key("key_title_heading");
  final Key KEY_BUTTON_CAMERA = const Key("key_button_camera");
  final Key KEY_BUTTON_BROWSE = const Key("key_button_browse");
  final String KEY_ATTACHMENT_TITLE = "key_attachment_title";
  final String KEY_ATTACHMENT_VIEW_CARD = "key_attachment_view_card";
  final String KEY_BUTTON_UPLOAD_FILE = "key_button_upload_file";
  final String KEY_REMOVE_BUTTON = "key_remove_button";

  onFileSelect(file) async {
    if (file != null) {
      Uint8List bytes = await file.readAsBytes();
      AttachmentModel model = AttachmentModel(fileName: file.name, filePath: file.path);
      //provider.saveConsent(model);
      _selectedAttachment.value = model;
      _buttonEnabled.value = true;
    }
  }

  @override
  void initState() {
    super.initState();
    //provider = Provider.of<QuestionnaireViewModel>(context, listen: false);
    //provider.clearConsetList();
    _buttonEnabled = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        onLeadingClick: () {
          Navigator.of(context).pop();
        },
        titleText: TranslationKeys.riskAssessment.translate(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.kAppPadding),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpaceWidget(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssetsPath.dottedIcon,
                      ),
                      const SpaceWidget(
                        width: 5,
                      ),
                      Text(
                        TranslationKeys.informedConsent.translate(context),
                        key: Key(KEY_INFORMED_CONSENT),
                        style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  ValueListenableBuilder<AttachmentModel?>(
                      valueListenable: _selectedAttachment,
                      builder: (context, _, __) {
                        return UploadFileWidget(
                          heading: TranslationKeys.uploadConsent.translate(context),
                          onFileSelected: onFileSelect,
                        );
                      }),
                  const SpaceWidget(height: 10),
                  /* Selector<QuestionnaireViewModel, int>(
                    selector: (_, provider) => provider.consentList.length,
                    builder: (_, value, child) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            value,
                            (index) => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ValueListenableBuilder<AttachmentModel?>(
                                  valueListenable: _selectedAttachment,
                                  builder: (_, attachment, __) {
                                    return AttachmentWidget(
                                      title: provider.consentList[index]!.fileName,
                                      titleKey: Key(KEY_ATTACHMENT_TITLE),
                                      viewKey: Key(KEY_ATTACHMENT_VIEW_CARD),
                                      removeButtonKey: Key(KEY_REMOVE_BUTTON),
                                      onRemoveClick: () {
                                        provider.removeConsent(index);
                                        if (provider.consentList == [] || provider.consentList.isEmpty) {
                                          _selectedAttachment.value = null;
                                        }
                                      },
                                      viewPictureClick: () {
                                        CommonFunctions.viewImage(context: context, model: provider.consentList[index]!);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), */
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _buttonEnabled,
                  builder: (context, isValid, _) {
                    return PrimaryFilledButton(
                      buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                      buttonTitle: TranslationKeys.uploadFile.translate(context),
                      widgetKey: KEY_BUTTON_UPLOAD_FILE,
                      isLoading: false,
                      onPressed: !isValid
                          ? null
                          : () {
                              Navigator.pop(context, _selectedAttachment.value);
                            },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
