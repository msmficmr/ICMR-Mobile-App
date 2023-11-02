import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/questionnaire_view_model.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/create_questionnaire_widget.dart';
import 'package:mhealth/views/ask_mhealth/widgets/section_name_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class QuestionnaireScreen extends StatefulWidget {
  static const routerPath = "/questionnaireScreen";
  String? sectionName;

  QuestionnaireScreen({Key? key, required this.sectionName}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final String KEY_BUTTON_CONTINUE = "key_button_continue";
  late QuestionnaireViewModel questionnaireViewModel;

  @override
  void initState() {
    super.initState();
    questionnaireViewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    fetchQuestions();
  }

  fetchQuestions() async {
    final languageViewModel = Provider.of<LanguageViewModel>(context, listen: false);
    String? locale = languageViewModel.currentLanguage;
    if (questionnaireViewModel.questionnaireSections.isEmpty) {
      await questionnaireViewModel.setQuestionnaireSections(locale);
    }

    if (widget.sectionName == null) {
      await questionnaireViewModel.fetchQuestionnaireForRA(locale);
    } else {
      await questionnaireViewModel.setNextSectionData(sectionName: widget.sectionName ?? "", context: context);
    }
  }

  goToPreviousScreen() {
    if (questionnaireViewModel.questionnaireSections[0] == questionnaireViewModel.sectionName) {
      GoRouter.of(context).go(DashboardScreen.routerPath);
      questionnaireViewModel.craSectionData = [];
    } else if (questionnaireViewModel.questionnaireSections[1] == questionnaireViewModel.sectionName) {
      questionnaireViewModel.setPreviousSectionData(questionnaireViewModel.sectionName!);
      GoRouter.of(context).push(QuestionnaireScreen.routerPath, extra: questionnaireViewModel.questionnaireSections[0]);
    } else {
      GoRouter.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        goToPreviousScreen();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          onLeadingClick: () => goToPreviousScreen(),
          appBarTitleType: CustomAppBarTitleType.TEXT,
          titleText: AppConstant.RISK_ASSESSMENT,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Selector<QuestionnaireViewModel, List<Questionnaire>>(
              selector: (_, provider) => provider.sectionsData[questionnaireViewModel.sectionName] ?? [],
              builder: (context, questionnaireList, child) {
                if (questionnaireList.isEmpty) {
                  return SizedBox(
                      height: height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ));
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionNameWidget(sectionName: questionnaireViewModel.sectionName!.sectionTitleName),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: questionnaireList.length,
                        itemBuilder: (context, questionIndex) {
                          Function onClick = () => {setState(() {})};
                          return getWidgetForQuestionnaireAndFollowupQuestionnaire(
                            context,
                            questionnaireList[questionIndex],
                            height,
                            onClick,
                            "",
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: height * 0.01,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryFilledButton(
                          onPressed: () async {
                            bool isValid = true;
                            for (var questionnaire in questionnaireList) {
                              if (!questionnaire.isValid()) {
                                isValid = false;
                              }
                            }
                            if (isValid) {
                              if (questionnaireViewModel.sectionName == questionnaireViewModel.questionnaireSections[questionnaireViewModel.questionnaireSections.length - 2]) {
                                questionnaireViewModel.setNextSectionData(sectionName: questionnaireViewModel.sectionName!,context: context);
                                GoRouter.of(context).push(PeriodontalScreen.routerPath);
                              } else if (questionnaireViewModel.sectionName == questionnaireViewModel.questionnaireSections[questionnaireViewModel.questionnaireSections.length - 1]) {
                                questionnaireViewModel.setNextSectionData(sectionName: questionnaireViewModel.sectionName!,context: context);
                                GoRouter.of(context).push(VerificationScreen.routerPath);
                              } else {
                                GoRouter.of(context).push(QuestionnaireScreen.routerPath, extra: questionnaireViewModel.sectionName);
                              }
                            } else {
                              CommonFunctions.toastMessage(AppConstant.ERROR_FILL_REQUIRED_FIELDS);
                              setState(() {});
                            }
                          },
                          buttonTitle: TranslationKeys.continueText.capitalize(),
                          widgetKey: KEY_BUTTON_CONTINUE,
                        ),
                      ),
                      const SpaceWidget(
                        height: 20,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
