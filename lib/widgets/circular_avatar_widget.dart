import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/enums.dart';

class CircularAvatar extends StatelessWidget {
  /// [backgroundColor] is being used to show in the background of the circle avatar widget
  /// [textColor] is used to show the color of the text/letters
  /// [borderColor] is used to show the color of the border of the circle
  final Color backgroundColor, textColor, borderColor;

  /// [radius] is being used to give the size of the circle
  /// [borderWidth] is being used to give the size of the border of the circle
  final double radius, borderWidth;

  /// we are supporting 3 types of child declared in this enum [CircularAvatarFieldChildType]
  /// 1. if you want to set Text as child then pass [childType] as [CircularAvatarFieldChildType.TEXT]
  /// 2. if you want to set SvgAsset as child then pass [childType] as [CircularAvatarFieldChildType.SVG_ASSET]
  /// 3. if you want to set Image Asset as child then pass [childType] as [CircularAvatarFieldChildType.IMAGE_ASSET]
  final CircularAvatarFieldChildType childType;

  /// if [childType] is set as [CircularAvatarFieldChildType.TEXT] then pass text of prefix
  /// if [childType] is set as [CircularAvatarFieldChildType.SVG_ASSET] or [CircularAvatarFieldChildType.IMAGE_ASSET] then pass asset path of icon
  final String childData;

  const CircularAvatar({
    super.key,
    required this.childType,
    required this.childData,
    this.backgroundColor = AppColorScheme.kPrimaryColor,
    this.textColor = Colors.white,
    this.radius = 40.0,
    this.borderWidth = 2.0,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: radius,
      child: Stack(
        children: [
          Center(
            child: Builder(
              builder: (context) {
                switch (childType) {
                  case CircularAvatarFieldChildType.TEXT:
                    return Text(childData, style: AppStyles.bodyMedium.copyWith(color: textColor));
                  case CircularAvatarFieldChildType.SVG_ASSET:
                    return SvgPicture.asset(
                      childData,
                      
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    );
                  case CircularAvatarFieldChildType.IMAGE_ASSET:
                    return Image.asset(childData);
                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: borderWidth,
                  color: borderColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
