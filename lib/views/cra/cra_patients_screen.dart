import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/patient_list_view_model.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_floating_button.dart';
import 'package:mhealth/widgets/custom_patient_card.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class CRAPatientScreen extends StatefulWidget {
  static const String routerPath = "/cra-patients";

  const CRAPatientScreen({Key? key}) : super(key: key);

  @override
  State<CRAPatientScreen> createState() => _CRAPatientScreenState();
}

class _CRAPatientScreenState extends State<CRAPatientScreen> {
  final TextEditingController _searchFieldController = TextEditingController();
  late PatientListViewModel patientListViewModel;

  //Widget Keys
  final String KEY_TEXTFIELD_SEARCH = "key_search_textfield";
  final String KEY_TITLE_SEARCH = "key_title_mobile";
  final String KEY_BUTTON_ADD = "key_button_add";
  final String KEY_PATIENT_CARD = "key_login_type";
  final String KEY_PATIENT_NAME = "key_patient_name";
  final String KEY_PATIENT_ID = "key_patient_id";

  void onSearchFieldChanged(String input) {
    patientListViewModel.searchPatient(input);
  }

  @override
  void initState() {
    super.initState();
    patientListViewModel = Provider.of<PatientListViewModel>(context, listen: false);
    patientListViewModel.loadRegisteredPatients();
  }

  @override
  void dispose() {
    patientListViewModel.debounce?.cancel();
    super.dispose();
  }

  redirectToDashboard() {
    GoRouter.of(context).go(DashboardScreen.routerPath);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        redirectToDashboard();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          appBarTitleType: CustomAppBarTitleType.TEXT,
          titleText: TranslationKeys.craPatientList.translate(context),
          centerTitle: false,
          onLeadingClick: () => redirectToDashboard(),
        ),
        floatingActionButton: SizedBox(
          width: 50,
          height: 50,
          child: CustomFloatingButton(
            buttonAssetType: CustomFloatingAssetTypes.SVG,
            assetPath: AppAssetsPath.icAdd,
            buttonKey: Key(KEY_BUTTON_ADD),
            onPressed: () {
              GoRouter.of(context).push(RegistrationScreen.routerPath);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                widgetKey: Key(KEY_TEXTFIELD_SEARCH),
                controller: _searchFieldController,
                hintText: TranslationKeys.search.translate(context),
                headingKey: Key(KEY_TITLE_SEARCH),
                onChanged: onSearchFieldChanged,
                keyboardType: TextInputType.text,
                suffixType: TextFieldPrefixSuffixType.SVG_ASSET,
                hasSuffix: true,
                suffixData: AppAssetsPath.icSearch,
              ),
              Expanded(
                child: Selector<PatientListViewModel, bool>(
                  selector: (context, provider) => provider.isLoading,
                  builder: (context, isLoading, child) {
                    if (isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Consumer<PatientListViewModel>(
                        builder: (context, patientName, child) {
                          final items = _searchFieldController.text.isEmpty ? patientName.registeredPatients : patientName.filteredItems;
                          if (items.isNotEmpty) {
                            return ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final patient = items[index];
                                final fullName = "${patient?.firstName} ${patient?.lastName}";
                                return CustomPatientCard(
                                  widgetKey: KEY_PATIENT_CARD,
                                  patientName: fullName,
                                  patientId: patient!.patientId,
                                  gender: CommonFunctions.getGender(patient.gender.toString()),
                                  age: patient.age,
                                  phoneNumber: patient.phoneNumber,
                                  patientNameKey: Key('KEY_PATIENT_NAME_$index'),
                                  patientIdKey: Key('KEY_PATIENT_ID_$index'),
                                  onTap: () async {
                                    await redirectToQuestionnaire(patient.patientId);
                                  },
                                );
                              },
                            );
                          } else {
                            return const Center(child: Text(AppConstant.NO_RECORD_FOUND));
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  redirectToQuestionnaire(String patientID) async {
    CRAOfflineData? craData = await IsarDbService.isarDbService.getCRAData(patientID ?? "");
    if (craData != null) {
      await context.read<QuestionnaireViewModel>().setSelectedPatientId(patientID);
      await Provider.of<QuestionnaireViewModel>(context, listen: false).setCaseId(craData.caseId!);
      for (int i = 0; i < (craData.craSectionData?.length ?? 0); i++) {
        switch (craData.craSectionData![i].encounterCategoryMapId) {
          case "community_risk_assessment_details_of_habits":
            return GoRouter.of(context).push(QuestionnaireScreen.routerPath, extra: "community_risk_assessment_details_of_habits");
          case "community_risk_assessment_baseline_signs_or_symptoms":
            return GoRouter.of(context).push(PeriodontalScreen.routerPath);
          case "community_risk_assessment_periodontal_status" :
            return GoRouter.of(context).push(LesionLocationScreen.routerPath);
          case "community_risk_assessment_lesion_location":
            return GoRouter.of(context).push(MeasurementLesionsScreen.routerPath);
          case "community_risk_assessment_measurement_lesions":
            return GoRouter.of(context).push(QuestionnaireScreen.routerPath, extra: "community_risk_assessment_baseline_signs_or_symptoms");
          case "community_risk_assessment_investigation":
            return GoRouter.of(context).push(VerificationScreen.routerPath);
          default:
            return CommonFunctions.toastMessage("All sections completed");
        }
      }
    } else {
      return GoRouter.of(context).push(CriteriaScreen.routerPath);
    }
  }
}
