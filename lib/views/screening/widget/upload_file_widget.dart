import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:mhealth/widgets/square_button_widget.dart';

class UploadFileWidget extends StatefulWidget {
  /// [heading] is label text
  /// if you don't pass heading it wont be visible
  final String? heading;

  final void Function(XFile?) onFileSelected;

  const UploadFileWidget({
    super.key,
    this.heading,
    required this.onFileSelected,
  });

  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  /// keys
  final Key KEY_TITLE_CAMERA = const Key("key_title_camera");
  final Key KEY_TITLE_BROWSE = const Key("key_title_browse");
  final Key KEY_TITLE_HEADING = const Key("key_title_heading");

  final Key KEY_BUTTON_CAMERA = const Key("key_button_camera");
  final Key KEY_BUTTON_BROWSE = const Key("key_button_browse");

  double outerPadding = 20.0;

  fetchImage(ImageSource source) async {
    XFile? file = await CommonFunctions.getImage(context: context, imageSource: source);
    if (file != null) {
      widget.onFileSelected(file);
    }
  }

  fetchAttachment()async{
    XFile? file = await CommonFunctions.getAttachment(context: context,extensions: ["jpg", "jpeg", "png", "JPG", "pdf", "JPEG", "PNG", "PDF"] );
    if (file != null) {
      widget.onFileSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double spaceBetweenCard = 15;

    double cardWidth = width - (outerPadding * 2) - spaceBetweenCard;
    cardWidth = cardWidth / 3;

    cardWidth = cardWidth > 200 ? 200 : cardWidth;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          dashPattern: const [6, 5],
          color: AppColorScheme.kGrayColor.shade600.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox.square(
                    dimension: cardWidth,
                    child: SquareButtonWidget(
                      cardKey: KEY_BUTTON_CAMERA,
                      onCardClick: () {
                        fetchImage(ImageSource.camera);
                      },
                      title: TranslationKeys.camera.translate(context),
                      titleKey: KEY_TITLE_CAMERA,
                      svgPath: AppAssetsPath.icCamera,
                    ),
                  ),
                ),
                SpaceWidget(
                  width: spaceBetweenCard,
                ),
                Expanded(
                  child: SizedBox.square(
                    dimension: cardWidth,
                    child: SquareButtonWidget(
                      cardKey: KEY_BUTTON_BROWSE,
                      onCardClick: () {
                        fetchAttachment();
                      },
                      title: TranslationKeys.browse.translate(context),
                      titleKey: KEY_TITLE_BROWSE,
                      svgPath: AppAssetsPath.icUpload,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
