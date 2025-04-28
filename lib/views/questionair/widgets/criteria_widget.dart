import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';

class CriteriaWidget extends StatelessWidget {
  String title;
  List<String> description;

  CriteriaWidget({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: const BoxDecoration(
        color: AppColorScheme.kEnabledButtonColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kEnabledButtonTextColor),
          ),
          ...description.map((e) => Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(e),
              )),
        ],
      ),
    );
  }
}
