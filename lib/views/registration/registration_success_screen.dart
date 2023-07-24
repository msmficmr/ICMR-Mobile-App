import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/space_widget.dart';

import '../cra/registration_screen.dart';

class RegistrationSuccessFullScreen extends StatefulWidget {
  static const routeName = "/registrationSuccessFullScreen";

  const RegistrationSuccessFullScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationSuccessFullScreen> createState() => _RegistrationSuccessFullScreenState();
}

class _RegistrationSuccessFullScreenState extends State<RegistrationSuccessFullScreen> {
  List<Widget> cards = [];
  final String patientName = "Aparna"; // to be picked dynamically later
  final String titleText = "Registration";
  double horizontalSpacing = 10;

  @override
  void initState() {
    super.initState();

    cards.insert(0, cardWidget(context, 'Take\nCRA', AppAssetsPath.icCra));
    cards.insert(cards.length, cardWidget(context, 'New\nregistration', AppAssetsPath.icAdd));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColorScheme.selectedBackgroundColor,
      appBar: CustomAppBar(
        centerTitle: false,
        onLeadingClick: () {
          GoRouter.of(context).pop();
        },
        titleText: titleText,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColorScheme.kLightBlue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                height: height * 0.4,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssetsPath.icRegistrationOk, width: 100, height: 100),
                    const SpaceWidget(
                      height: 10,
                    ),
                    Text(
                      'Registration Successful',
                      style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kPrimaryColor.shade500, fontWeight: FontWeight.w700, fontFamily: AppConstant.FONT_FAMILY),
                      // style: bold_blue_16,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Thank you, $patientName \n You are successfully registered\nwith karkinos",
                      textAlign: TextAlign.center,
                      style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kGrayColor.shade500, fontWeight: FontWeight.w400, fontFamily: AppConstant.FONT_FAMILY),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Next Step',
                  style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kDarkGrayColor, fontWeight: FontWeight.w600, fontFamily: AppConstant.FONT_FAMILY),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: horizontalSpacing,
                  children: List.generate(cards.length, (index) {
                    return SizedBox(
                      // height: 100, // Set the desired height here
                      child: cards[index],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget cardWidget(
  BuildContext context,
  String text,
  String image,
  // Map patientDetailsMap,
) {
  return InkWell(
    onTap: () {
      if (Text == "registration") {
        GoRouter.of(context).push(RegistrationScreen.routerPath);
      }
    },
    child: Container(
      width: 100,
      decoration: const BoxDecoration(
        // color: LIGHT_BLUE,
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
              style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kPrimaryColor.shade600, fontSize: 12, fontWeight: FontWeight.w400, fontFamily: AppConstant.FONT_FAMILY),
            ),
          ],
        ),
      ),
    ),
  );
}
