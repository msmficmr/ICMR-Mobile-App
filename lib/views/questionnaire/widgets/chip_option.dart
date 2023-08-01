import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';

class ChipOption extends StatelessWidget {
  const ChipOption({Key? key}) : super(key: key);


  final int chipOptionsLength = 4;

  @override
  Widget build(BuildContext context) {

    //TODO: Add the options length
    return Container(
      // If the chipOptions Length is greater than 3
      // we should show in grid view
      child: chipOptionsLength > 4 ? Wrap(
        runSpacing: 1,
        spacing: 1,
        alignment: WrapAlignment.end,
        children: chipOptionList(),
      )
          : Column(
        mainAxisSize: MainAxisSize.max,
        children: chipOptionList(),
      ),
    );
  }

  List<Widget> chipOptionList() {
    return List<Widget>.generate(chipOptionsLength, (index) {
      return InkWell(
        onTap: (){},
        child: Container(
          alignment: chipOptionsLength > 4 ? null : Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: AppColorScheme.kPrimaryColor.shade50,
              border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor.shade50),
              borderRadius: const BorderRadius.all(Radius.circular(30.0))
            ),
            child: Text("",style: AppStyles.titleMedium,),
          ),
        ),
      );
    });
  }
}
