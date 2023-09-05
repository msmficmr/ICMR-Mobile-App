import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/utils/app_assets_path.dart';
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

  //Widget Keys
  final String KEY_TEXTFIELD_SEARCH = "key_search_textfield";
  final String KEY_TITLE_SEARCH = "key_title_mobile";
  final String KEY_BUTTON_ADD = "key_button_add";
  final String KEY_PATIENT_NAME = "key_patient_name";
  final String KEY_PATIENT_ID = "key_patient_id";

  void onSearchFieldChanged(String? input) {}

  @override
  void initState() {
    super.initState();
    Provider.of<PatientListViewModel>(context, listen: false).loadRegisteredPatients();
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
              child: Selector<PatientListViewModel, List<PatientRegistration?>>(
                selector: (context, provider) => provider.registeredPatients,
                builder: (context, registeredPatients, child) {
                  return ListView.builder(
                    itemCount: registeredPatients.length,
                    itemBuilder: (context, index) {
                      final patient = registeredPatients[index];
                      final fullName = "${patient?.firstName} ${patient?.lastName}";
                      return CustomPatientCard(
                        patientName: fullName,
                        patientId: patient!.medicalId,
                        gender: (patient.gender == "m") ? "Male" : "Female",
                        dob: patient.age,
                        phoneNumber: patient.mobile,
                        patientNameKey: Key('KEY_PATIENT_NAME_$index'),
                        patientIdKey: Key('KEY_PATIENT_ID_$index'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
