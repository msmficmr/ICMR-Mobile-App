import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/isar_db_schema/attachment_db_schema.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/services/network_status_service.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/viewModel/offline_data_view_model.dart';
import 'package:mhealth/viewModel/patient_list_view_model.dart';
import 'package:mhealth/views/doctor/doctor_name_screen.dart';
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

  ValueNotifier<String?> docName = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _syncData = ValueNotifier<bool>(false);
    networkStatusService = Provider.of<NetworkStatusService>(context, listen: false);
    checkToSyncData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bindDocName();
    });
  }

  bindDocName() async {
    bool containDocName = await SharedPreferencesService.sharedPreferencesService.hasKey(AppConstant.SHREAD_PREF_DOC_KEY);
    if (containDocName) {
      String? strDocName = await SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.SHREAD_PREF_DOC_KEY);
      if (strDocName != null) {
        docName.value = strDocName;
      }
    }
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
  final String KEY_DOCTOR_CARD = "key_doctor_card";
  final String KEY_DATA_SYNC_CARD = "key_data_sync_card";
  final String KEY_LOGIN_EXPIRE = "key_login_expire_card";

  //Constant text
  final String VOLUNTEER_ID = "Volunteer ID";
  OfflineDataViewModel viewModel = OfflineDataViewModel();

  bool _syncing = false;
  bool _isClicked = false;

  late NetworkStatusService networkStatusService;

  late ValueNotifier<bool> _syncData;

  checkToSyncData() async {
    if (networkStatusService.networkStatus == NetworkStatus.online) {
      List<CRAOfflineData?> response = await IsarDbService.isarDbService.getListCRAOfflineData();

      response = response = response.where(
        (element) {
          String? patientId = element?.patientId;
          return context.read<PatientListViewModel>().registeredPatients.any(
                (element) => element.patientId == patientId,
              );
        },
      ).toList();

      List<PatientRegistration?> patientResponse = context
          .read<PatientListViewModel>()
          .registeredPatients
          .where(
            (element) => element.isSynced == false,
          )
          .toList();
      if (response.isNotEmpty || patientResponse.isNotEmpty) {
        _syncData.value = true;
      } else {
        _syncData.value = false;
      }
    } else {
      _syncData.value = false;
    }
  }

  Future<bool> onLogoutClick() async {
    if (networkStatusService.networkStatus == NetworkStatus.online) {
      final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

      final bool shouldLogout = await confirmLogout();
      if (shouldLogout) {
        await loginViewModel.logout();
      }

      return shouldLogout;
    } else {
      CommonFunctions.toastMessage("You are offline. Please connect to the internet and try again.");
      return false;
    }
  }

  Future<bool> confirmLogout() async {
    bool? result = await CommonFunctions.openDialog<bool?>(
      context: context,
      buttonCancelText: DIALOG_TEXT_CANCEL,
      buttonText: DIALOG_TEXT_LOGOUT,
      title: DIALOG_CLOSE_TITLE,
      subtitle: DIALOG_CLOSE_SUBTITLE,
      action: (context) {
        GoRouter.of(context).pop(true);
      },
      onCancelAction: (context) {
        GoRouter.of(context).pop(false);
      },
    );

    return result ?? false;
  }

  Future showDataSyncLoading(BuildContext context, {String? message}) {
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
                  message ?? 'Syncing data Please wait',
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
    NetworkStatus networkStatus = context.read<NetworkStatusService>().networkStatus;

    if (networkStatus == NetworkStatus.online) {
      List<CRAOfflineData?> response = await IsarDbService.isarDbService.getListCRAOfflineData();
      List<PatientRegistration> patientList = context.read<PatientListViewModel>().registeredPatients;

      if (response.isEmpty && patientList.isEmpty) {
        CommonFunctions.toastMessage(AppConstant.NO_DATA_TO_SYNC_COMPLETED);
      } else {
        showDataSyncLoading(context);
        //_syncing = true;

        for (int i = 0; i < response.length; i++) {
          String? patientId = response[i]?.patientId;
          int patientIndex = patientList.indexWhere(
            (element) => element.patientId == patientId,
          );
          if (patientIndex != -1) {
            PatientRegistration? resp = patientList[patientIndex];

            List<String> fileDeleteList = [];
            List<dynamic> payLoadObjList = [];
            Map<String, dynamic>? patientJson = resp.toJson();

            //Generating new patient id while uploading
            String newPatientId = patientJson["patientId"];

            Map<String, dynamic> patientData = {"patientData": patientJson};
            Map<String, dynamic> registrationObj = {"registrationObj": patientData};
            Map<String, dynamic>? craOfflineDataJson = response[i]?.toJson();
            //updating new patient id
            /*----------------- */
            registrationObj['registrationObj']['patientData']['patientId'] = newPatientId;
            /*----------------- */

            try {
              List<dynamic> pMap = registrationObj['registrationObj']['patientData']['consent'];
              registrationObj['registrationObj']['patientData']['consent'] = [];
              List<AttachmentDb> consentList = [];
              for (dynamic pat in pMap) {
                AttachmentDb fileName = pat;
                fileDeleteList.add(fileName.dataBytes!);
                List<int> content = await CommonFunctions().readFileInIsolate(fileName.dataBytes!);
                fileName.dataBytes = base64.encode(content);
                consentList.add(fileName);
              }
              registrationObj['registrationObj']['patientData']['consent'] = consentList;
            } catch (e) {}

            List<dynamic> craSectionModel = craOfflineDataJson?['craSectionModel'];

            craSectionModel.forEach((element) {
              element["extension"] = {"doctorDetails": craOfflineDataJson?["docDetails"]};
              //updating new patient id
              /*------------- */
              element["patientId"] = newPatientId;
              /*----------*/
            });

            for (int i = 0; i < craSectionModel.length; i++) {
              if (craSectionModel[i]['encounterEhrDiagnosisReports'] != null) {
                List<dynamic> questionList = craSectionModel[i]['encounterEhrDiagnosisReports']["questions"];
                for (int j = 0; j < questionList.length; j++) {
                  AttachmentDb fileName = questionList[j]['file'];
                  try {
                    fileDeleteList.add(fileName.dataBytes!);
                    List<int> content = await CommonFunctions().readFileInIsolate(fileName.dataBytes!);
                    fileName.dataBytes = base64.encode(content);
                    craSectionModel[i]['encounterEhrDiagnosisReports']["questions"][j]["file"] = fileName;
                  } catch (e) {}
                }
              }
            }

            Map<String, dynamic> cdrPostObj = {
              "cdrPostObj": [
                {response[i]?.caseId: craSectionModel}
              ]
            };
            List<Map<String, dynamic>> patientDataList = [registrationObj, cdrPostObj];
            payLoadObjList.add({newPatientId: patientDataList});
            Map<String, dynamic> payLoadObj = {
              "payloadObj": payLoadObjList,
              "appVersion": Environment.runningEnv.releaseVersion,
            };

            bool isPostSuccess = await viewModel.postOfflineData(
              caseId: response[i]?.caseId,
              primaryId: resp.primaryId,
              payLoadObj: payLoadObj,
              fileDeleteList: fileDeleteList,
            );
            if (isPostSuccess) {
              context.read<PatientListViewModel>().markPatientAsSynced(resp.primaryId, true);
            }
          }
        }

        response = await IsarDbService.isarDbService.getListCRAOfflineData();
        List<PatientRegistration> patientListResponse = context.read<PatientListViewModel>().registeredPatients;

        /// Taking only those patients which are not synced
        patientListResponse = patientListResponse
            .where(
              (element) => element.isSynced == false,
            )
            .toList();
        for (int i = 0; i < patientListResponse.length; i++) {
          List<String> fileDeleteList = [];
          List<dynamic> payLoadObjList = [];
          String? patientId = patientListResponse[i].patientId;

          if (!(response.map((e) => e?.patientId ?? "").contains(patientId))) {
            int patientIndex = patientListResponse.indexWhere(
              (element) => element.patientId == patientId,
            );

            PatientRegistration? resp = patientListResponse[patientIndex];
            Map<String, dynamic>? patientJson = resp?.toJson();

            //Generating new patient id while uploading
            String newPatientId = patientJson!["patientId"];

            Map<String, dynamic> patientData = {"patientData": patientJson};
            Map<String, dynamic> registrationObj = {"registrationObj": patientData};
            Map<String, dynamic> cdrPostObj = {"cdrPostObj": []};

            //updating new patient id
            /*----------------- */
            registrationObj['registrationObj']['patientData']['patientId'] = newPatientId;
            /*----------------- */

            try {
              List<dynamic> pMap = registrationObj['registrationObj']['patientData']['consent'];
              registrationObj['registrationObj']['patientData']['consent'] = [];
              List<AttachmentDb> consentList = [];
              for (dynamic pat in pMap) {
                AttachmentDb fileName = pat;
                fileDeleteList.add(fileName.dataBytes!);
                List<int> content = await CommonFunctions().readFileInIsolate(fileName.dataBytes!);
                fileName.dataBytes = base64.encode(content);
                consentList.add(fileName);
              }
              registrationObj['registrationObj']['patientData']['consent'] = consentList;
            } catch (e) {}

            List<Map<String, dynamic>> patientDataList = [registrationObj, cdrPostObj];
            payLoadObjList.add({newPatientId: patientDataList});
            Map<String, dynamic> payLoadObj = {
              "payloadObj": payLoadObjList,
              "appVersion": Environment.runningEnv.releaseVersion,
            };
            bool isPostSuccess = await viewModel.postOfflineData(caseId: null, primaryId: patientListResponse[i].primaryId, payLoadObj: payLoadObj, fileDeleteList: fileDeleteList);
            if (isPostSuccess) {
              context.read<PatientListViewModel>().markPatientAsSynced(patientListResponse[i].primaryId, false);
            }
          }
        }
        if (context.mounted) {
          Navigator.of(context, rootNavigator: true).pop();
        }

        CommonFunctions.toastMessage(AppConstant.SYNC_COMPLETED);
        if (context.mounted) {
          await context.read<PatientListViewModel>().fetchCompletedCRA();
          await context.read<PatientListViewModel>().updateCraStatus();
          GoRouter.of(context).go(DashboardScreen.routerPath);
        }
      }
    } else {
      CommonFunctions.toastMessage(AppConstant.NO_INTERNET_MESSAGE);
    }

    _isClicked = false;
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
    String? locationName = (loginViewModel?.userDetails?.locations != null && loginViewModel!.userDetails!.locations!.isNotEmpty) ? loginViewModel!.userDetails!.locations![0].locationName : "";

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
        body: SizedBox(
          height: double.infinity,
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
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
                                        onTap: () => CommonFunctions.copyToClipboard(volunteerId, context),
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
                                      Text('${gender.capitalize()} - $age | ', style: AppStyles.bodySmall),
                                      Text(emailId, style: AppStyles.bodySmall),
                                    ],
                                  ),
                                  const SpaceWidget(
                                    height: 10,
                                  ),
                                  Text('$location : $locationName', style: AppStyles.bodySmall),
                                  const SpaceWidget(
                                    height: 10,
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: docName,
                                    builder: (context, value, child) {
                                      if (value == null) return const SizedBox.shrink();
                                      return Text('Doctor Name : $value', style: AppStyles.bodySmall);
                                    },
                                  ),
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
                          onLogoutClick();
                        },
                        child: Builder(
                          builder: (context) {
                            int expireIn = loginViewModel!.checkLoginTimestamp();
                            String text = "";
                            if (expireIn == 0) {
                              text = "Login will expire today";
                            } else if (expireIn < 0) {
                              text = "Login is expired";
                            } else {
                              text = "Login will expire in ${expireIn} days";
                            }

                            return Visibility(
                              visible: (expireIn < 16) ? true : false,
                              child: AccountCard(
                                key: Key(KEY_LOGIN_EXPIRE),
                                cardTitleText: text,
                                textStyle: AppStyles.errorStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                trailingIconPath: AppAssetsPath.icChevronRight,
                                leadingIconPath: AppAssetsPath.icWarning,
                                iconColor: AppColorScheme.errorTextColor,
                              ),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          bool? result = await GoRouter.of(context).push(DoctorNameScreen.routerPath, extra: true);
                          if (result != null && result) {
                            bindDocName();
                          }
                        },
                        child: AccountCard(
                          key: Key(KEY_DOCTOR_CARD),
                          cardTitleText: TranslationKeys.changeDocName.translate(context),
                          trailingIconPath: AppAssetsPath.icChevronRight,
                          leadingIconPath: AppAssetsPath.icPerson,
                        ),
                      ),
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
                      ValueListenableBuilder(
                          valueListenable: _syncData,
                          builder: (context, syncData, _) {
                            if (syncData) {
                              return InkWell(
                                onTap: () async {
                                  final appVersion = await getAppVersion();
                                  if (appVersion.isEmpty) {
                                    CommonFunctions.toastMessage("Session expired! Login to Continue");
                                    await loginViewModel?.logout();
                                  } else {
                                    if (!_isClicked) {
                                      _isClicked = true;
                                      onSyncClick();
                                    }
                                  }
                                },
                                child: AccountCard(
                                  key: Key(KEY_DATA_SYNC_CARD),
                                  cardTitleText: TranslationKeys.dataSync.translate(context),
                                  trailingIconPath: AppAssetsPath.icChevronRight,
                                  leadingIconPath: AppAssetsPath.icSync,
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Checking if the token has been expired or not
  Future<String> getAppVersion() async {
    final response = await LoginViewModel.loginViewModel.getAppVersion();
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  }
}
