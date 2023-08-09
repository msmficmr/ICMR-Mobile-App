import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/widgets/avatar.dart';

class Question extends StatelessWidget {
  final String questionText;
  final DateTime questionTime;
  final double screenWidth;

  const Question({
    Key? key,
    required this.questionText,
    required this.questionTime,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            //TODO: Need to add a bot icon in the avatar
            child: avatar(AppAssetsPath.appIcon),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Bubble(
                radius: const Radius.circular(10),
                color: AppColorScheme.kPrimaryIconColor,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              alignment: Alignment.topLeft,
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.6,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      questionText,
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      style: AppStyles.titleSmall,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              alignment: Alignment.topRight,
                              margin: const EdgeInsets.only(top: 10),
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.6,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                      child: Stack(
                                    children: [
                                      Text(
                                        " ${DateFormat("hh:mm a").format(questionTime)}",
                                        textAlign: TextAlign.end,
                                        style: AppStyles.bodySmall.copyWith(color: AppColorScheme.kGrayColor.shade700),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10)
        ],
      ),
    );
  }
}
