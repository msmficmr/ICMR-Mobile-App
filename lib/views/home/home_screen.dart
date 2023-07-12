import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_patient_card.dart';
import 'package:mhealth/widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  static const String routerPath = "/dashboard";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _searchFieldController = TextEditingController();

  // constant text
  final String SEARCH_FIELD_TITLE = "Search";

  //Widget Keys
  final String KEY_TEXTFIELD_SEARCH = "key_search_textfield";
  final String KEY_TITLE_SEARCH = "key_title_mobile";

  void onSearchFieldChanged(String? input) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.TEXT,
        titleText: 'CRA Patient List',
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go(RegistrationScreen.routerPath);
        },
        child: SvgPicture.asset(AppAssetsPath.icAdd),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              widgetKey: Key(KEY_TEXTFIELD_SEARCH),
              controller: _searchFieldController,
              hasPrefix: true,
              prefixType: TextFieldPrefixSuffixType.SVG_ASSET,
              prefixData: AppAssetsPath.icEmail,
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
    );
  }
}
