import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_color_scheme.dart';

avatar(imagePath) {
  return CircleAvatar(
    radius: 20,
    backgroundColor: AppColorScheme.kPrimaryColor.shade50,
    child: SvgPicture.asset(imagePath),
  );
}