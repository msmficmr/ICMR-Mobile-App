import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/views/screening/widget/upload_file_widget.dart';
import 'package:mhealth/widgets/attachment_widget.dart';
import '../../utils/app_color_scheme.dart';
import '../../utils/app_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/space_widget.dart';

class ConsentScreeningScreen extends StatefulWidget {
  static const String routerPath = "/consentScreening";

  /// [heading] is label text
  /// if you don't pass heading it wont be visible
  // final String? heading;

  // final void Function(XFile?) onFileSelected;
  const ConsentScreeningScreen({
    super.key,
    // this.heading,
    // required this.onFileSelected,
  });

  @override
  State<ConsentScreeningScreen> createState() => _ConsentScreeningScreenState();
}

class _ConsentScreeningScreenState extends State<ConsentScreeningScreen> {
  //TITLE
  static const String APP_BAR_TITLE = "CRA";
  static const String TITLE_BUTTON_CAMERA = "Camera";
  static const String TITLE_BUTTON_BROWSE = "Browse";
  static const String TITLE_INFORMED_CONSENT = "Informed Consent";

  /// keys
  final String KEY_INFORMED_CONSENT = "key_informed_consent";
  final Key KEY_TITLE_CAMERA = const Key("key_title_camera");
  final Key KEY_TITLE_BROWSE = const Key("key_title_browse");
  final Key KEY_TITLE_HEADING = const Key("key_title_heading");
  final Key KEY_BUTTON_CAMERA = const Key("key_button_camera");
  final Key KEY_BUTTON_BROWSE = const Key("key_button_browse");

  // double outerPadding = 20.0;

  // Future<void> captureCameraImage() async {
  //   // bool hasCameraPermission = await PermissionService.permissionService.checkCameraPermission(context);
  //   // if (hasCameraPermission) {
  //   //   XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
  //   //   widget.onFileSelected(file);
  //   // }
  // }

  // Future<void> chooseImage() async {
  //   XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   widget.onFileSelected(file);
  // }

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
                Text(
                  TITLE_INFORMED_CONSENT,
                  key: Key(KEY_INFORMED_CONSENT),
                  style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.w600),
                ),
                UploadFileWidget(
                  heading: "Upload",
                  onFileSelected: (file) {
                    GoRouter.of(context).pop(file);
                  },
                ),
                 const SpaceWidget(
                  height: 10,
                ),
                AttachmentWidget(
                    title: "ttt",
                                    titleKey: const Key("KEY_TITLE"),
                                    viewKey: const Key("KEY_CARD"),
                                    removeButtonKey: const Key("KEY_REMOVE_BUTTON"),
                                    onRemoveClick: () {
                                      // provider.removeAttachment(index);
                                    },
                                    viewPictureClick: () {
                                     // CommonFunctions.viewImage(context: context, bytes: provider.localPatientHistoryScreenModel.attachmentList[index].bytes);
                                    },
                )
              ],
            )));
  }
}
