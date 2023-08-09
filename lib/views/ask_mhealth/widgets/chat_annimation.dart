import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';

Widget ChatAnimation() {
  return Container(
    color: AppColorScheme.kPrimaryIconColor,
    padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Lottie.asset(
            AppAssetsPath.loader,
            fit: BoxFit.fill,
            reverse: false,
            animate: true,
            repeat: true,
            height: 50,
            width: 50,
          ),
        )
      ],
    ),
  );
}
