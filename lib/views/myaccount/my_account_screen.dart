import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/views/myaccount/widgets/card_component_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/config/environment/environment.dart';

class MyAccountScreen extends StatefulWidget {
  static const String routerPath = "/myAccountScreen";
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  //To be replaced with Dynamic data
  static const String patientName = "Indira J Mcintyre";
  final String image = "";
  final String patientID = 'KH00000000';
  final String gender = "Female";
  final String age = '23';
  final String phone = '+91 9898989898';
  final String patientRelation = 'Myself';
  final String appVersion = Environment.runningEnv.releaseVersion;

  //KEY
  final String KEY_PATIENT_TEXT = "key_patient_text";
  final String KEY_PATIENT_ID = "key_patient_id";
  final String KEY_PATIENT_NAME = "key_patient_name";

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: patientID));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Patient ID copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;
    final bool isImagePresent = image != "" && image.isNotEmpty;

    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        onLeadingClick: () {
          GoRouter.of(context).pop();
        },
        backgroundColor: AppColorScheme.kGrayColor.shade50,
        trailingType: CustomAppBarTrailingType.SINGLE,
        trailingWidget: SvgPicture.asset(
          AppAssetsPath.icLogout,
        ),
        titleText: "My Account",
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Column(children: [
          const SizedBox(
            height: 80,
          ),
          Card(
            // color: Colors.grey.shade50,
            color: AppColorScheme.kGrayColor.shade50,
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 45, // Adjust the size as needed
                          height: 45, // Adjust the size as needed
                          color: isImagePresent ? Colors.transparent : AppColorScheme.kPrimaryColor.shade900, // Set a background color for the container without the image
                          child: isImagePresent
                              ? SvgPicture.asset(
                                  image,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Text(
                                    patientName.isNotEmpty == true ? patientName![0] : 'A',
                                    key: Key(KEY_PATIENT_TEXT),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 12 : 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              width: 47,
                              height: 18,
                              decoration: BoxDecoration(
                                color: AppColorScheme.kPrimaryColor.shade900,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: FittedBox(
                                child: Text(
                                  patientRelation,
                                  style: TextStyle(color: Colors.white, fontSize: 8),
                                ),
                              ),
                            ),
                            Text(
                              patientName,
                              key: Key(KEY_PATIENT_NAME),
                              style: AppStyles.hintStyle.copyWith(color: AppColorScheme.kGrayColor.shade700, fontWeight: FontWeight.w600, fontFamily: AppConstant.FONT_FAMILY),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child:
                      // Third Column with Patient ID
                      Container(
                    height: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Patient ID:', style: AppStyles.bodySmall),
                        const SpaceWidget(width: 2),
                        Text(
                          patientID,
                          key: Key(KEY_PATIENT_ID),
                          style: AppStyles.bodySmall,
                        ),
                        InkWell(
                          onTap: () => _copyToClipboard(context),
                          child: SvgPicture.asset(AppAssetsPath.icCopy),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child:
                      // Fourth Column with Gender and Mobile Number
                      Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$gender - $age |', style: AppStyles.bodySmall),
                      // SizedBox(width: 16, height: 6),
                      Text(phone, style: AppStyles.bodySmall),
                    ],
                  ),
                ),
                const SpaceWidget(
                  height: 15,
                ),
              ],
            ),
          ),
          const SpaceWidget(height: 20),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: AccountCard(
                height: 54,
                leftIcon: SvgPicture.asset(
                  AppAssetsPath.icLanguage,
                  height: isSmallScreen ? 30 : 40,
                  width: isSmallScreen ? 30 : 40,
                ),
                text: 'Language',
                rightIcon: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  GoRouter.of(context).push(LanguageSelectionScreen.routerPath);
                  // Handle profile card tap
                },
                textStyle: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kGrayColor.shade700, fontWeight: FontWeight.w500, fontFamily: AppConstant.FONT_FAMILY),
                cardColor: AppColorScheme.kWhite,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                iconSize: 24.0,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(3),
              child: AccountCard(
                leftIcon: SvgPicture.asset(
                  AppAssetsPath.icSync,
                  height: isSmallScreen ? 30 : 40,
                  width: isSmallScreen ? 30 : 40,
                ),
                text: 'Data Sync',
                rightIcon: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Handle profile card tap
                },
                textStyle: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kGrayColor.shade700, fontWeight: FontWeight.w500, fontFamily: AppConstant.FONT_FAMILY),
                cardColor: AppColorScheme.kWhite,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                iconSize: 24.0,
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 25.0),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Center(
          child: Column(children: [
            SvgPicture.asset(AppAssetsPath.appHorizontalIcon),
            Text(
              "Version: $appVersion",
              style: AppStyles.bodySmall,
            )
          ]),
        ),
      ),
    );
  }
}
