import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';

enum CRASTATUS {
  COMPLETED("Completed", AppColorScheme.kSuccessStatusColor),
  INCOMPLETE("Incomplete", AppColorScheme.errorTextColor);

  final String text;
  final Color color;
  const CRASTATUS(this.text, this.color);
}

class StatusWidget extends StatelessWidget {
  final CRASTATUS status;
  const StatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(color: status.color),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Text(
        status.text,
        style: AppStyles.bodySmall.copyWith(color: status.color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
