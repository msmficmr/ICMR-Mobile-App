import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/views/questionair/widgets/criteria_widget.dart';
import 'package:mhealth/views/questionair/widgets/section_name_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';

class CriteriaScreen extends StatelessWidget {
  static const routerPath = "/criteriaScreen";
  final String theCaseId;
  final String thePatientId;
  const CriteriaScreen({Key? key, required this.theCaseId, required this.thePatientId}) : super(key: key);

  //Widget Keys
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  redirectToRegistrationSuccess(BuildContext context) {
    GoRouter.of(context).pop();
  }

  List<String> getDescription({required String criteria, required BuildContext context}) {
    String description;
    if (criteria == TranslationKeys.inclusionCriteria) {
      description = TranslationKeys.inclusionCriteriaDescription.translate(context);
    } else {
      description = TranslationKeys.exclusionCriteriaDescription.translate(context);
    }
    List<String> criteriaDescription = CommonFunctions.convertStringToList(description);
    return criteriaDescription;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        redirectToRegistrationSuccess(context);
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          onLeadingClick: () {
            redirectToRegistrationSuccess(context);
          },
          appBarTitleType: CustomAppBarTitleType.TEXT,
          titleText: AppConstant.RISK_ASSESSMENT,
        ),
        body: SizedBox(
          height: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SectionNameWidget(sectionName: TranslationKeys.criteriaSection.translate(context)),
                          CriteriaWidget(title: TranslationKeys.inclusionCriteria.translate(context), description: getDescription(criteria: TranslationKeys.inclusionCriteria, context: context)),
                          const SpaceWidget(height: 20),
                          CriteriaWidget(title: TranslationKeys.exclusionCriteria.translate(context), description: getDescription(criteria: TranslationKeys.exclusionCriteria, context: context)),
                          const SizedBox(height: 10),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryFilledButton(
                              buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                              buttonTitle: TranslationKeys.continueText.translate(context),
                              widgetKey: KEY_BUTTON_CONTINUE,
                              isLoading: false,
                              onPressed: () {
                                CommonFunctions().onStartCRA(
                                  context: context,
                                  patientId: thePatientId,
                                  isCraCompleted: false,
                                  caseId: theCaseId,
                                  withReplace: true
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
