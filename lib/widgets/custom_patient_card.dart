import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:mhealth/widgets/status_widget.dart';

import '../config/theme/outlined_button_theme_style.dart';
import '../utils/translation_keys.dart';
import '../views/cra/registration_screen.dart';
import 'primary_outlined_button.dart';

class CustomPatientCard extends StatelessWidget {
  final String patientName, patientId, age, phoneNumber, widgetKey;
  final String? gender;

  final Key patientNameKey, patientIdKey;

  final Color textTitleColor, textColor;

  final Function()? onTap;
  final bool isCraCompleted;
  final String primaryId, secondaryId;
  final Key primaryIdKey, secondaryIdKey;
  final int totalCompletedSections;
  final int visitCount;

  const CustomPatientCard({
    Key? key,
    required this.visitCount,
    required this.totalCompletedSections,
    required this.isCraCompleted,
    required this.widgetKey,
    required this.patientName,
    required this.patientId,
    required this.gender,
    required this.age,
    required this.phoneNumber,
    required this.patientNameKey,
    required this.patientIdKey,
    required this.onTap,
    required this.primaryId,
    required this.secondaryId,
    required this.primaryIdKey,
    required this.secondaryIdKey,
    this.textTitleColor = AppColorScheme.kEnabledButtonTextColor,
    this.textColor = AppColorScheme.kTextGreyColor,
  }) : super(key: key);

  final String KEY_PATIENT_GENDER = "key_patient_gender";
  final String KEY_PATIENT_AGE = "key_patient_age";
  final String KEY_PATIENT_PHONE_NUMBER = "key_patient_phone_number";
  final String KEY_VIEW_DETAILS_BUTTON = "key_view_details_button";

  String getVisitText() {
    switch (visitCount) {
      case 1:
        return "1st visit done";
      case 2:
        return "2nd visit done";
      case 3:
        return "3rd Visit done";
      default:
        return "${visitCount}th visit done";
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return Padding(
      key: Key(widgetKey),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: widthSize,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: AppValues.circularBorderRadius10,
            color: AppColorScheme.kGrayColor.shade50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      patientName,
                      key: patientNameKey,
                      style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.w700, color: textTitleColor),
                    ),
                  ),
                  const SpaceWidget(width: 10),
                  
                  if (visitCount == 0) ...[
                    StatusWidget(status: isCraCompleted ? CRASTATUS.COMPLETED : CRASTATUS.INCOMPLETE)
                  ] else ...[
                    if (totalCompletedSections > 0 ) ...[
                      StatusWidget(status: isCraCompleted ? CRASTATUS.COMPLETED : CRASTATUS.INCOMPLETE)
                    ] else ...[
                      StatusTextWidget(
                        status: getVisitText(),
                      )
                    ]
                  ]
                ],
              ),
              const SpaceWidget(height: 5),
              Text(
                "ICMRID: $patientId",
                key: patientIdKey,
                style: AppStyles.titleMedium.copyWith(color: textColor),
              ),
              const SpaceWidget(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Primary ID: $primaryId",
                      key: primaryIdKey,
                      style: AppStyles.titleMedium.copyWith(color: textColor),
                    ),
                  ),
                  const SpaceWidget(width: 5),
                  InkWell(
                    onTap: () => CommonFunctions.copyToClipboard(primaryId, context),
                    child: SvgPicture.asset(AppAssetsPath.icCopy),
                  )
                ],
              ),
              const SpaceWidget(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Secondary ID: $secondaryId",
                      key: secondaryIdKey,
                      style: AppStyles.titleMedium.copyWith(color: textColor),
                    ),
                  ),
                  const SpaceWidget(width: 5),
                  InkWell(
                    onTap: () => CommonFunctions.copyToClipboard(secondaryId, context),
                    child: SvgPicture.asset(AppAssetsPath.icCopy),
                  )
                ],
              ),
              const SpaceWidget(height: 5),
              SizedBox(
                width: widthSize * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RowTextWidget(widgetKey: KEY_PATIENT_GENDER, image: CommonFunctions.getGenderImage(gender ?? ""), text: gender ?? ""),
                    RowTextWidget(widgetKey: KEY_PATIENT_AGE, image: AppAssetsPath.icGroup, text: age),
                    RowTextWidget(widgetKey: KEY_PATIENT_PHONE_NUMBER, image: AppAssetsPath.icPhone, text: phoneNumber.maskPhoneNumber),
                  ],
                ),
              ),
              const SpaceWidget(height: 10),
              PrimaryOutlinedButton(
                buttonThemeStyle:
                    OutlinedButtonThemeStyle(customTextStyle: AppStyles.buttonStyle, enabledTextColor: AppColorScheme.kGrayColor.shade600, enabledBorderColor: AppColorScheme.kGrayColor.shade600),
                buttonTitle: TranslationKeys.viewDetails.translate(context),
                widgetKey: KEY_VIEW_DETAILS_BUTTON,
                onPressed: () {
                  GoRouter.of(context).push(
                    RegistrationScreen.routerPath,
                    extra: patientId,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowTextWidget extends StatelessWidget {
  final String image, text, widgetKey;

  const RowTextWidget({
    Key? key,
    required this.widgetKey,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(image),
        const SpaceWidget(
          width: 5,
        ),
        Text(
          text,
          style: AppStyles.titleMedium,
        ),
      ],
    );
  }
}
