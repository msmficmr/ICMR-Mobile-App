import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/viewModel/offline_data_view_model.dart';
import 'package:mhealth/views/myaccount/widgets/card_component_widget.dart';
import 'package:mhealth/widgets/circular_avatar_widget.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatefulWidget {
  static const String routerPath = "/myAccountScreen";

  MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  LoginViewModel? loginViewModel;

  @override
  void initState() {
    super.initState();
  }

  //To be replaced with Dynamic data
  final String image = "";
  final String location = 'Location';
  final String patientRelation = 'Myself';
  final String appVersion = Environment.runningEnv.releaseVersion;
  final String DIALOG_CLOSE_TITLE = "Confirm";
  final String DIALOG_CLOSE_SUBTITLE = "Are you sure you want to Logout?";
  final String DIALOG_TEXT_CANCEL = "Cancel";
  final String DIALOG_TEXT_LOGOUT = "Logout";

  //KEY
  final String KEY_MY_ACCOUNT_APPBAR = "key_my_account_appbar";
  final String KEY_PATIENT_TEXT = "key_patient_text";
  final String KEY_VOLUNTEER_ID = "key_volunteer_id";
  final String KEY_PATIENT_NAME = "key_patient_name";
  final String KEY_LANGUAGE_CARD = "key_language_card";
  final String KEY_DATA_SYNC_CARD = "key_data_sync_card";

  //Constant text
  final String VOLUNTEER_ID = "Volunteer ID";
  OfflineDataViewModel viewModel = OfflineDataViewModel();

  bool _syncing = false;

  void _copyToClipboard(String volunteerId) {
    Clipboard.setData(ClipboardData(text: volunteerId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Volunteer ID copied to clipboard')),
    );
  }

  Future<bool> onLogoutClick() async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

    final bool shouldLogout = await confirmLogout();
    if (shouldLogout) {
      await loginViewModel.logout();
    }

    return shouldLogout;
  }

  Future<bool> confirmLogout() async {
    bool? result = await CommonFunctions.openDialog<bool?>(
      context: context,
      buttonCancelText: DIALOG_TEXT_CANCEL,
      buttonText: DIALOG_TEXT_LOGOUT,
      title: DIALOG_CLOSE_TITLE,
      subtitle: DIALOG_CLOSE_SUBTITLE,
      action: (context) {
        Navigator.of(context).pop(true);
      },
      onCancelAction: (context) {
        Navigator.pop(context, false);
      },
    );

    return result ?? false;
  }

  Future showDataSyncLoading(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SpaceWidget(height: 10),
                const CircularProgressIndicator(),
                const SpaceWidget(height: 10),
                Text(
                  'Syncing data Please wait',
                  style: AppStyles.titleSmall.copyWith(fontSize: 10, color: AppColorScheme.kPrimaryColor),
                ),
                const SpaceWidget(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSyncClick() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      List<CRAOfflineData?> response = await IsarDbService.isarDbService.getListCRAOfflineData();
      List<PatientRegistration> patientListResponse = await IsarDbService.isarDbService.getPatientsList();
      if (response.isEmpty && patientListResponse.isEmpty) {
        CommonFunctions.toastMessage(AppConstant.NO_DATA_TO_SYNC_COMPLETED);
      } else {
        showDataSyncLoading(context);
        _syncing = true;
        for (int i = 0; i < response.length; i++) {
          List<dynamic> payLoadObjList = [];
          String? patienId = response[i]?.patientId;
          PatientRegistration? resp = await IsarDbService.isarDbService.getPatientDetails(patienId ?? "");
          Map<String, dynamic>? patientJson = resp?.toJson();
          Map<String, dynamic> patientData = {"patientData": patientJson};
          Map<String, dynamic> registrationObj = {"registrationObj": patientData};
          Map<String, dynamic>? craOfflineDataJson = response[i]?.toJson();
          List<dynamic> craSectionModel = craOfflineDataJson?['craSectionModel'];
          Map<String, dynamic> cdrPostObj = {
            "cdrPostObj": [
              {response[i]?.caseId: craSectionModel}
            ]
          };
          List<Map<String, dynamic>> patientDataList = [registrationObj, cdrPostObj];
          payLoadObjList.add({response[i]?.patientId: patientDataList});
          Map<String, dynamic> payLoadObj = {
            "payloadObj": payLoadObjList,
            "appVersion": Environment.runningEnv.releaseVersion,
          };
          await viewModel.postOfflineData(caseId: response[i]?.caseId, patientId: response[i]?.patientId, payLoadObj: payLoadObj);
        }

        for (int i = 0; i < patientListResponse.length; i++) {
          List<dynamic> payLoadObjList = [];
          String? patientId = patientListResponse[i].patientId;
          PatientRegistration? resp = await IsarDbService.isarDbService.getPatientDetails(patientId ?? "");
          Map<String, dynamic>? patientJson = resp?.toJson();
          Map<String, dynamic> patientData = {"patientData": patientJson};
          Map<String, dynamic> registrationObj = {"registrationObj": patientData};
          Map<String, dynamic> cdrPostObj = {"cdrPostObj": []};
          List<Map<String, dynamic>> patientDataList = [registrationObj, cdrPostObj];
          payLoadObjList.add({patientListResponse[i].patientId: patientDataList});
          Map<String, dynamic> payLoadObj = {
            "payloadObj": payLoadObjList,
            "appVersion": "45",
          };
          await viewModel.postOfflineData(caseId: null, patientId: patientListResponse[i].patientId, payLoadObj: payLoadObj);
        }
        Navigator.of(context, rootNavigator: true).pop();
        CommonFunctions.toastMessage(AppConstant.SYNC_COMPLETED);
        GoRouter.of(context).go(DashboardScreen.routerPath);
      }
    } else {
      CommonFunctions.toastMessage(AppConstant.NO_INTERNET_MESSAGE);
    }
  }

  @override
  Widget build(BuildContext context) {
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    String firstName = loginViewModel?.userDetails?.firstName ?? "";
    String lastName = loginViewModel?.userDetails?.lastName ?? "";
    String gender = loginViewModel?.userDetails?.gender ?? "";
    String emailId = loginViewModel?.userDetails?.email ?? "";
    String volunteerId = loginViewModel?.userDetails?.userId ?? "";
    String age = loginViewModel?.userDetails?.age ?? "";
    String locatioName = loginViewModel?.userDetails?.locations?[0].locationName ?? "";
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    return WillPopScope(
      onWillPop: () async {
        if (_syncing) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          key: Key(KEY_MY_ACCOUNT_APPBAR),
          centerTitle: false,
          onLeadingClick: () {
            GoRouter.of(context).pop();
          },
          backgroundColor: AppColorScheme.kGrayColor.shade50,
          trailingType: CustomAppBarTrailingType.SINGLE,
          trailingWidget: InkWell(
            onTap: () {
              onLogoutClick();
            },
            child: SvgPicture.asset(
              AppAssetsPath.icLogout,
            ),
          ),
          titleText: TranslationKeys.myAccount.translate(context),
        ),
        body: Column(
          children: [
            Container(
              color: AppColorScheme.kGrayColor.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircularAvatar(childType: CircularAvatarFieldChildType.TEXT, childData: "${firstName.substring(0, 1)} ${lastName.substring(0, 1)}", radius: 30),
                        SpaceWidget(width: isSmallScreen ? 12 : 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColorScheme.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  patientRelation,
                                  style: AppStyles.titleSmall.copyWith(fontSize: 10, color: AppColorScheme.kPrimaryIconColor),
                                ),
                              ),
                              const SpaceWidget(
                                height: 5,
                              ),
                              Text(
                                "$firstName $lastName",
                                key: Key(KEY_PATIENT_NAME),
                                style: AppStyles.hintStyle.copyWith(color: AppColorScheme.kGrayColor.shade700, fontWeight: FontWeight.w600, fontFamily: AppConstant.FONT_FAMILY),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$VOLUNTEER_ID :', style: AppStyles.bodySmall),
                            const SpaceWidget(width: 2),
                            Text(
                              volunteerId,
                              key: Key(KEY_VOLUNTEER_ID),
                              style: AppStyles.bodySmall,
                            ),
                            const SpaceWidget(width: 5),
                            InkWell(
                              onTap: () => _copyToClipboard(volunteerId),
                              child: SvgPicture.asset(AppAssetsPath.icCopy),
                            )
                          ],
                        ),
                        const SpaceWidget(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$gender- $age | ', style: AppStyles.bodySmall),
                            Text('$emailId', style: AppStyles.bodySmall),
                          ],
                        ),
                        const SpaceWidget(
                          height: 10,
                        ),
                        Text('$location- $locatioName', style: AppStyles.bodySmall),
                      ],
                    ),
                  ),
                  const SpaceWidget(height: 20),
                ],
              ),
            ),
            const SpaceWidget(height: 20),
            InkWell(
              onTap: () {
                GoRouter.of(context).push(LanguageSelectionScreen.routerPath, extra: true);
              },
              child: AccountCard(
                key: Key(KEY_LANGUAGE_CARD),
                cardTitleText: TranslationKeys.language.translate(context),
                trailingIconPath: AppAssetsPath.icChevronRight,
                leadingIconPath: AppAssetsPath.icLanguage,
              ),
            ),
            InkWell(
              onTap: () {
                onSyncClick();
              },
              child: AccountCard(
                key: Key(KEY_DATA_SYNC_CARD),
                cardTitleText: TranslationKeys.dataSync.translate(context),
                trailingIconPath: AppAssetsPath.icChevronRight,
                leadingIconPath: AppAssetsPath.icSync,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 25.0),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Center(
            child: Column(children: [
              SvgPicture.asset(AppAssetsPath.appHorizontalIcon),
              Text(
                "${TranslationKeys.version.translate(context)}: $appVersion",
                style: AppStyles.bodySmall,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
