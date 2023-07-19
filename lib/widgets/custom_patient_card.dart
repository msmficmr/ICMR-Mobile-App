import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/widgets/space_widget.dart';

class CustomPatientCard extends StatelessWidget {
  final String patientName, patientId, gender, dob, phoneNumber;

  final Key patientNameKey, patientIdKey;

  final Color textTitleColor, textColor;

  const CustomPatientCard({
    Key? key,
    required this.patientName,
    required this.patientId,
    required this.gender,
    required this.dob,
    required this.phoneNumber,
    required this.patientNameKey,
    required this.patientIdKey,
    this.textTitleColor = const Color(0xFF2F43EE),
    this.textColor = const Color(0xFF616161),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: widthSize,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: AppValues.circularBorderRadius10,
          color: AppColorScheme.kGrayColor.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patientName, key: patientNameKey,
              style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.w700, color: textTitleColor),
            ),
            const SpaceWidget(height: 5),
            Text(
              "KHID: $patientId", key: patientIdKey,
              style: AppStyles.titleMedium.copyWith(color: textColor),
            ),
            const SpaceWidget(height: 5),
            SizedBox(
              width: widthSize * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RowTextWidget(image: gender == "Female" ? AppAssetsPath.icFemale : AppAssetsPath.icMale, text: gender),
                  RowTextWidget(image: AppAssetsPath.icGroup, text: dob),
                  RowTextWidget(image: AppAssetsPath.icPhone, text: phoneNumber.maskPhoneNumber),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RowTextWidget extends StatelessWidget {
  final String image, text;

  const RowTextWidget({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(image),
        const SpaceWidget(width: 5,),
        Text(
          text,
          style: AppStyles.titleMedium,
        ),
      ],
    );
  }
}
