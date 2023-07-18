import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/app_assets_path.dart';
import '../../../utils/app_color_scheme.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/space_widget.dart';

class UploadFileWidget extends StatefulWidget {
  /// [heading] is label text
  /// if you don't pass heading it wont be visible
  final String? heading;

  final void Function(XFile?)? onFileSelected;
  const UploadFileWidget({
    super.key,
    this.heading,
    this.onFileSelected,
  });

  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  static const String TITLE_BUTTON_CAMERA = "Camera";
  static const String TITLE_BUTTON_BROWSE = "Browse";

  /// keys
  final Key KEY_TITLE_CAMERA = const Key("key_title_camera");
  final Key KEY_TITLE_BROWSE = const Key("key_title_browse");
  final Key KEY_TITLE_HEADING = const Key("key_title_heading");

  final Key KEY_BUTTON_CAMERA = const Key("key_button_camera");
  final Key KEY_BUTTON_BROWSE = const Key("key_button_browse");

  double outerPadding = 20.0;

  // Future<void> captureCameraImage() async {
  //   bool hasCameraPermission = await PermissionService.permissionService.checkCameraPermission(context);
  //   if (hasCameraPermission) {
  //     XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
  //     widget.onFileSelected(file);
  //   }
  // }

  // Future<void> chooseImage() async {
  //   XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   widget.onFileSelected(file);
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double spaceBetweenCard = 15;

    double cardWidth = width - (outerPadding * 2) - spaceBetweenCard;
    cardWidth = cardWidth / 2;

    cardWidth = cardWidth > 200 ? 200 : cardWidth;

    return Padding(
        padding: EdgeInsets.all(2),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (widget.heading != null) ...[
            const SpaceWidget(
              height: 15,
            ),
            Text(
              widget.heading ?? "",
              key: KEY_TITLE_HEADING,
              style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
          const SpaceWidget(
            height: 15,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox.square(
                  dimension: cardWidth,
                  child: SquareButton(
                    cardKey: KEY_BUTTON_CAMERA,
                    onCardClick: () {
                      // captureCameraImage();
                    },
                    title: TITLE_BUTTON_CAMERA,
                    titleKey: KEY_TITLE_CAMERA,
                    svgPath: AppAssetsPath.icEmail,
                  ),
                ),
                SpaceWidget(
                  width: spaceBetweenCard,
                ),
                SizedBox.square(
                  dimension: cardWidth,
                  child: SquareButton(
                    cardKey: KEY_BUTTON_BROWSE,
                    onCardClick: () {
                      //  chooseImage();
                    },
                    title: TITLE_BUTTON_BROWSE,
                    titleKey: KEY_TITLE_BROWSE,
                    svgPath: AppAssetsPath.icArrowBack,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}

class SquareButton extends StatelessWidget {
  final Key cardKey, titleKey;
  final VoidCallback onCardClick;
  final String title;
  final String svgPath;
  final Color iconColor;

  const SquareButton({
    super.key,
    required this.cardKey,
    required this.onCardClick,
    required this.title,
    required this.titleKey,
    required this.svgPath,
    this.iconColor = const Color(0xFF0F4391),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: cardKey,
      onTap: onCardClick,
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          border: Border.all(color: AppColorScheme.kGrayColor.shade300, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
            const SpaceWidget(
              height: 10,
            ),
            Text(
              title,
              key: titleKey,
              style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
