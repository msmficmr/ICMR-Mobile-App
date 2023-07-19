import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/views/screening/widget/upload_file_widget.dart';
import 'package:mhealth/widgets/attachment_widget.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import '../../utils/app_assets_path.dart';
import '../../utils/app_color_scheme.dart';
import '../../utils/app_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/space_widget.dart';

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
  //TITLE
  static const String APP_BAR_TITLE = "CRA";
  static const String TITLE_INFORMED_CONSENT = "Informed Consent";
  static const String TITLE_UPLOAD_CONSENT = "Upload Consent";
  static const String UPLOAD_FILE_BUTTON_TITLE = "Upload File";

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

  void selectAttachment() async {
    XFile? attachment = await CommonFunctions.chooseImage(context: context);
    if (attachment != null) {
      Uint8List bytes = await attachment.readAsBytes();
      AttachmentModel model = AttachmentModel(bytes: bytes, fileName: attachment.name);
      _selectedAttachment.value = model;
      _buttonEnabled.value = true;
    }
  }

  onFileSelect(file) async {
    if (file != null) {
      Uint8List bytes = await file.readAsBytes();
      AttachmentModel model = AttachmentModel(bytes: bytes, fileName: file.name);
      _selectedAttachment.value = model;
      _buttonEnabled.value = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _buttonEnabled = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        onLeadingClick: () {
          GoRouter.of(context).pop();
        },
        titleText: APP_BAR_TITLE,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.kAppPadding),
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
                  TITLE_INFORMED_CONSENT,
                  key: Key(KEY_INFORMED_CONSENT),
                  style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            ValueListenableBuilder<AttachmentModel?>(
                valueListenable: _selectedAttachment,
                builder: (context, _, __) {
                  return UploadFileWidget(
                    heading: TITLE_UPLOAD_CONSENT,
                    onFileSelected: onFileSelect,
                  );
                }),
            const SpaceWidget(
              height: 15,
            ),
            ValueListenableBuilder<AttachmentModel?>(
                valueListenable: _selectedAttachment,
                builder: (context, attachment, _) {
                  if (attachment != null) {
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
                    return SizedBox.shrink();
                  }
                }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ValueListenableBuilder<bool>(
                  valueListenable: _buttonEnabled,
                  builder: (context, isValid, _) {
                    return PrimaryFilledButton(
                      buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                      buttonTitle: UPLOAD_FILE_BUTTON_TITLE,
                      widgetKey: KEY_BUTTON_UPLOAD_FILE,
                      isLoading: false,
                      onPressed: !isValid ? null : () {},
                    );
                  }),
            ),
            const SpaceWidget(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
