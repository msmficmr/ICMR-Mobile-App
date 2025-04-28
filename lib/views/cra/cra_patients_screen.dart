import 'dart:async';
import 'dart:developer';

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
import 'package:mhealth/views/questionair/view/question_screen_view.dart';
import 'package:mhealth/views/questionair/viewmodel/question_view_model.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_floating_button.dart';
import 'package:mhealth/widgets/custom_patient_card.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CRAPatientScreen extends StatefulWidget {
  static const String routerPath = "/cra-patients";

  const CRAPatientScreen({Key? key}) : super(key: key);

  @override
  State<CRAPatientScreen> createState() => _CRAPatientScreenState();
}

class _CRAPatientScreenState extends State<CRAPatientScreen> {
  late PatientListViewModel patientListViewModel;

  //Widget Keys
  final String KEY_TEXTFIELD_SEARCH = "key_search_textfield";
  final String KEY_TITLE_SEARCH = "key_title_mobile";
  final String KEY_BUTTON_ADD = "key_button_add";
  final String KEY_PATIENT_CARD = "key_login_type";
  final String KEY_PATIENT_NAME = "key_patient_name";
  final String KEY_PATIENT_ID = "key_patient_id";

  Timer? _debounce;

  void onSearchFieldChanged(String input) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      patientListViewModel.searchPatient(input);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    patientListViewModel = Provider.of<PatientListViewModel>(context, listen: false);
    patientListViewModel.searchFieldController.text = "";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      patientListViewModel.bindPatientScreen();
    });
  }

  redirectToDashboard() {
    GoRouter.of(context).go(DashboardScreen.routerPath);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    patientListViewModel.updateCraStatus();
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
          onLeadingClick: redirectToDashboard,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
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
                controller: patientListViewModel.searchFieldController,
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
                      return Selector<PatientListViewModel, int>(
                        selector: (_, provider) => provider.filteredItems.length,
                        builder: (context, patientName, child) {
                          final items = patientListViewModel.filteredItems;
                          if (items.isNotEmpty) {
                            return ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final patient = items[index];
                                final fullName = "${patient.firstName} ${patient.lastName}";
                                return Selector<PatientListViewModel, Tuple3<bool, int, int>>(
                                    selector: (p0, p1) => Tuple3(patientListViewModel.filteredItems[index].isCompleted, patientListViewModel.filteredItems[index].totalCompletedSections,
                                        patientListViewModel.filteredItems[index].visitCount),
                                    builder: (context, statusData, __) {
                                      return CustomPatientCard(
                                        widgetKey: KEY_PATIENT_CARD,
                                        isCraCompleted: statusData.item1,
                                        totalCompletedSections: statusData.item2,
                                        visitCount: statusData.item3,
                                        patientName: fullName,
                                        patientId: patient.patientId,
                                        gender: CommonFunctions.getGender(patient.gender.toString()),
                                        age: patient.age,
                                        phoneNumber: patient.phoneNumber,
                                        patientNameKey: Key('KEY_PATIENT_NAME_$index'),
                                        patientIdKey: Key('KEY_PATIENT_ID_$index'),
                                        primaryId: patient.primaryId,
                                        primaryIdKey: Key('KEY_PRIMARY_ID_$index'),
                                        secondaryId: patient.secondaryId,
                                        secondaryIdKey: Key('KEY_SECONDARY_ID_$index'),
                                        onTap: () {
                                          CommonFunctions().onStartCRA(context: context, patientId: patient.patientId, isCraCompleted: statusData.item1, caseId: patient.caseId);
                                        },
                                      );
                                    });
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
}
