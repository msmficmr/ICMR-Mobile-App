import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';

class CustomChip extends StatelessWidget {
  final String answer;
  final bool userIcon;
  final bool editable;
  final MainAxisAlignment mainAxisAlignment;

  const CustomChip({
    Key? key,
    required this.answer,
    this.userIcon = true,
    this.editable = false,
    this.mainAxisAlignment = MainAxisAlignment.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.only(bottom: 30, left: 5, right: 5, top: 5),
                decoration: BoxDecoration(
                  color: AppColorScheme.kPrimaryColor,
                  border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
                      child: Text(
                        answer,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kPrimaryIconColor),
                      ),
                    ),
                    if (editable)
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          //TODO: Replace with SVG image
                          child: Icon(Icons.edit, color: AppColorScheme.kPrimaryIconColor),
                        ),
                      ),
                    if (userIcon)
                      Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                          backgroundColor: AppColorScheme.kPrimaryColor,
                          child: CircleAvatar(
                            backgroundColor: AppColorScheme.kPrimaryIconColor,
                            //TODO: Need to fetch the name from the shared preference
                            child: Text("U", style: AppStyles.titleMedium.copyWith(color: AppColorScheme.kPrimaryColor.shade500),),
                          ),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
