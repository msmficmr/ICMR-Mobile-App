import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/utils/enums.dart';

import '../../../utils/app_color_scheme.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_styles.dart';
import '../../cra/registration_screen.dart';

class CardWidget extends StatelessWidget {
  final String text;
  final String image;
  final ScreenNames screenNames;
  const CardWidget({required this.text, required this.image, required this.screenNames});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (screenNames == ScreenNames.REGISTRATION_SCREEN) {
          GoRouter.of(context).push(RegistrationScreen.routerPath);
        }
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: AppColorScheme.kLightBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(image, fit: BoxFit.cover),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColorScheme.kPrimaryColor.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppConstant.FONT_FAMILY,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
