import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';

avatar(imagePath) {
  return CircleAvatar(
    radius: 20,
    backgroundImage: AssetImage(imagePath),
    backgroundColor: AppColorScheme.kPrimaryColor.shade50,
  );
}