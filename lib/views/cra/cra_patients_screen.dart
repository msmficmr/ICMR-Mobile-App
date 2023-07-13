import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_floating_button.dart';
import 'package:mhealth/widgets/custom_patient_card.dart';
import 'package:mhealth/widgets/custom_textfield.dart';

class CRAPatientScreen extends StatefulWidget {
  static const String routerPath =  "/cra-patients";
  const CRAPatientScreen({Key? key}) : super(key: key);

  @override
  State<CRAPatientScreen> createState() => _CRAPatientScreenState();
}

class _CRAPatientScreenState extends State<CRAPatientScreen> {
  final TextEditingController _searchFieldController = TextEditingController();

  // constant text
  final String SEARCH_FIELD_TITLE = "Search";

  //Widget Keys
  final String KEY_TEXTFIELD_SEARCH = "key_search_textfield";
  final String KEY_TITLE_SEARCH = "key_title_mobile";
  final String KEY_BUTTON_ADD = "key_button_add";

  void onSearchFieldChanged(String? input) {}

  redirectToPreviousPage() {
    GoRouter.of(context).go(DashboardScreen.routerPath);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        redirectToPreviousPage();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          appBarTitleType: CustomAppBarTitleType.TEXT,
          titleText: 'CRA Patient List',
          centerTitle: false,
          onLeadingClick: () => redirectToPreviousPage(),
        ),
        floatingActionButton: SizedBox(
          width: 50,
          height: 50,
          child: CustomFloatingButton(
            buttonAssetType: CustomFloatingAssetTypes.SVG,
            assetPath: AppAssetsPath.icAdd,
            buttonKey: Key(KEY_BUTTON_ADD),
            onPressed: () {
              GoRouter.of(context).go(RegistrationScreen.routerPath);
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
                hintText: SEARCH_FIELD_TITLE,
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
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    CustomPatientCard(
                      patientName: "Aparna Nair",
                      patientId: "KH88383839399",
                      gender: "Female",
                      dob: "45",
                      phoneNumber: "9741814444",
                    ),
                    CustomPatientCard(
                      patientName: "Sahil Lalani",
                      patientId: "KH88383839399",
                      gender: "Male",
                      dob: "45",
                      phoneNumber: "9741814444",
                    ),
                    CustomPatientCard(
                      patientName: "Aparna Nair",
                      patientId: "KH88383839399",
                      gender: "Female",
                      dob: "45",
                      phoneNumber: "9741814444",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
