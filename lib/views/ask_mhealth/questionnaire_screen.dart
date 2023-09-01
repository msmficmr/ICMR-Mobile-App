import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/views/ask_mhealth/widgets/create_questionnaire_widget.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';

class QuestionnaireScreen extends StatefulWidget {
  static const routerPath = "/questionnaireScreen";
  String sectionName;

  QuestionnaireScreen({Key? key, required this.sectionName}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {

  final String KEY_BUTTON_CONTINUE = "key_button_continue";
  late ChatBotViewModel chatBotViewModel;

  @override
  void initState() {
    super.initState();
    chatBotViewModel = Provider.of<ChatBotViewModel>(context, listen: false);
    fetchQuestions();
  }

  fetchQuestions() async {
    if (chatBotViewModel.questionnaireList.isEmpty) {
      final languageViewModel = Provider.of<LanguageViewModel>(context, listen: false);
      String? locale = languageViewModel.selectedLanguage;
      await chatBotViewModel.fetchQuestionnaireForRA("en_US", "");
    }
  }

  goToPreviousScreen() {
    if (chatBotViewModel.questionnaireSections[0] == chatBotViewModel.sectionName) {
      GoRouter.of(context).push(DashboardScreen.routerPath);
    } else {
      chatBotViewModel.setPreviousSectionData(chatBotViewModel.sectionName!);
      GoRouter.of(context).push(QuestionnaireScreen.routerPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        goToPreviousScreen();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          onLeadingClick: () => goToPreviousScreen(),
          appBarTitleType: CustomAppBarTitleType.TEXT,
          titleText: "RISK ASSESSMENT",
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Selector<ChatBotViewModel, List<Questionnaire>> (
              selector: (_, provider) => provider.questionnaireList,
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
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssetsPath.dottedIcon,
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Expanded(
                            child: Text(
                              chatBotViewModel.sectionName!.sectionTitleName,
                              style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kPrimaryColor),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
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
                            onPressed: () {
                              bool isValid = true;
                              for (var questionnaire in questionnaireList) {
                                if (!questionnaire.isValid()) {
                                  isValid = false;
                                }
                              }
                              if (isValid) {
                                chatBotViewModel.setNextSectionData(chatBotViewModel.sectionName!);
                                GoRouter.of(context).push(QuestionnaireScreen.routerPath);
                              } else {
                                setState(() {});
                              }
                            },
                            buttonTitle: TranslationKeys.continueText.capitalize(), widgetKey: KEY_BUTTON_CONTINUE),
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
