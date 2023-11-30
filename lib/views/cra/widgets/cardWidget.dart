import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';

class CardWidget extends StatelessWidget {

  final Key? cardKey;

  ///[title] is title text for card
  final String title;

  ///[image] is used to show the card image
  final String image;

  final Function()? onTap;

  const CardWidget({super.key,
    this.onTap,
    this.cardKey,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: cardKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: InkWell(
          onTap: onTap,
          highlightColor: AppColorScheme.kWhite,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColorScheme.kLightBlue,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(image, fit: BoxFit.cover),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title, textAlign: TextAlign.center,
                      style: AppStyles.bodySmall.copyWith(color: AppColorScheme.kPrimaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

