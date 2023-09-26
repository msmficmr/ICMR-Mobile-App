import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/patient_list_view_model.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.TEXT,
        titleText: TranslationKeys.craPatientList.translate(context),
        centerTitle: false,
        onLeadingClick: () => Navigator.pop(context),
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
              keyboardType: TextInputType.emailAddress,
              suffixType: TextFieldPrefixSuffixType.SVG_ASSET,
              hasSuffix: true,
              suffixData: AppAssetsPath.icSearch,
              inputFormatters: [
                AppValues.stringInputFormatter,
              ],
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
                                patientName: fullName,
                                patientId: patient!.patientId!,
                                gender: (patient.gender == "m") ? "Male" : "Female",
                                age: patient.age,
                                phoneNumber: patient.phoneNumber,
                                patientNameKey: Key('KEY_PATIENT_NAME_$index'),
                                patientIdKey: Key('KEY_PATIENT_ID_$index'),
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
    );
  }
}
