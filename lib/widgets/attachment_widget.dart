import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../utils/app_assets_path.dart';

class AttachmentWidget extends StatelessWidget {
  /// Name of the attachment
  final String title;

  /// Callback for View attachment Click
  final VoidCallback? viewPictureClick;

  /// Callback for delete
  final VoidCallback? onRemoveClick;

  //TextStyle of the [title]
  final TextStyle? textStyle;

  /// Keys that can be used for automation
  /// [titleKey] assigned to text
  /// [viewKey] is assigned to viewButton
  final Key titleKey, viewKey;

  /// [removeButtonKey] assigned to remove button
  final Key? removeButtonKey;

  /// [isLoading] is used to show shimmer effect on card default value is set to `false`
  final bool isLoading;

  const AttachmentWidget({
    super.key,
    this.viewPictureClick,
    this.onRemoveClick,
    this.textStyle,
    this.removeButtonKey,
    required this.title,
    required this.titleKey,
    required this.viewKey,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(children: [
            Expanded(
              child: Skeletonizer(
                enabled: isLoading,
                child: Text(
                  key: titleKey,
                  title,
                  style: textStyle ?? AppStyles.titleMedium.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SpaceWidget(
              width: 10,
            ),
            InkWell(
              key: removeButtonKey,
              onTap: isLoading ? null : onRemoveClick,
              borderRadius: BorderRadius.circular(40),
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssetsPath.icClose,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  )),
            ),
            const SpaceWidget(
              width: 10,
            ),
            InkWell(
              key: viewKey,
              onTap: isLoading ? null : viewPictureClick,
              borderRadius: BorderRadius.circular(40),
              child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: SvgPicture.asset(
                      AppAssetsPath.icFile,
                      height: 24,
                      width: 24,
                    ),
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
