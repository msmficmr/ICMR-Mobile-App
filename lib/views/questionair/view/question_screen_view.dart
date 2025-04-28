// ignore_for_file: use_build_context_synchronously

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
import 'package:mhealth/viewModel/offline_data_view_model.dart';
import 'package:mhealth/viewModel/patient_list_view_model.dart';
import 'package:mhealth/views/questionair/widgets/create_questionnaire_widget.dart';
import 'package:mhealth/views/questionair/widgets/section_name_widget.dart';
import 'package:mhealth/views/questionair/viewmodel/question_view_model.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class QuestionScreenView extends StatefulWidget {
  static const String routerPath = "/QuestionScreenView";
  final String sectionId;
  final String patientId;
  final String caseId;
  const QuestionScreenView({super.key, required this.sectionId, required this.patientId, required this.caseId});

  @override
  State<QuestionScreenView> createState() => _QuestionScreenViewState();
}

class _QuestionScreenViewState extends State<QuestionScreenView> {
  late QuestionViewModel _questionViewModel;
  final String KEY_BUTTON_CONTINUE = "key_button_continue";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() async {
    await _questionViewModel.fetchEncounterDetails();
    await _questionViewModel.fetchPatientEhrDetails();
    _questionViewModel.fetchSectionQuestions();
  }

  onBackPress() {
    GoRouter.of(context).pop();
  }

  goToNextSection() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool isValid = true;
      for (var questionnaire in _questionViewModel.questionList) {
        if (!questionnaire.isValid()) {
          isValid = false;
        }
      }
      setState(() {});
      if (isValid) {
        bool isSaved = await _questionViewModel.saveToDB();
        if (isSaved) {
          //update patient list
          context.read<PatientListViewModel>().checkCraStatus(widget.patientId);
          await context.read<PatientListViewModel>().fetchCompletedCRA();

          /// If all sections are completed then [nextSectionId] will return null
          String? nextSectionId = _questionViewModel.nextSectionId;
          if (nextSectionId != null) {
            Map<String, dynamic> details = {
              "caseId": widget.caseId,
              "patientId": widget.patientId,
              "sectionId": nextSectionId,
            };
            if (mounted) {
              GoRouter.of(context).push(QuestionScreenView.routerPath, extra: details);
            }
          } else {
            if (mounted) {
              CommonFunctions.toastMessage(TranslationKeys.craSuccessMessage.translate(context));
              GoRouter.of(context).go(DashboardScreen.routerPath);
            }
          }
        }
      }
    }else{
       CommonFunctions.toastMessage(AppConstant.SELECT_FILE_BEFORE_SUBMITTING);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => QuestionViewModel(widget.sectionId, widget.patientId, widget.caseId),
      builder: (context, child) {
        _questionViewModel = Provider.of<QuestionViewModel>(context, listen: false);

        _questionViewModel.questionList.forEach((element) => print('good=${element.toJson()}'));
        return Scaffold(
          appBar: CustomAppBar(
            onLeadingClick: onBackPress,
            appBarTitleType: CustomAppBarTitleType.TEXT,
            titleText: AppConstant.RISK_ASSESSMENT,
          ),
          body: Selector<QuestionViewModel, Tuple2<ApiStatus, int>>(
            selector: (p0, p1) => Tuple2(p1.fetchQuestionsApiStatus, p1.templateList.length),
            builder: (context, value, child) {
              switch (_questionViewModel.fetchQuestionsApiStatus) {
                case ApiStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case ApiStatus.error:
                  return const Text("Something Went Wrong");
                case ApiStatus.success:
                  return Selector<QuestionViewModel, Tuple2<List<Questionnaire>, int>>(
                    selector: (p0, p1) => Tuple2(p1.questionList, p1.questionList.length),
                    builder: (context, value, child) {
                      if (_questionViewModel.questionList.isEmpty) {
                        return const SizedBox.shrink();
                      } else {
                        return SizedBox(
                          height: double.infinity,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: IntrinsicHeight(
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SectionNameWidget(sectionName: _questionViewModel.currentSection.name),
                                            ..._questionViewModel.questionList.map((question) {
                                              Function onClick = () => {setState(() {})};
                                              return getWidgetForQuestionnaireAndFollowupQuestionnaire(
                                                context,
                                                question,
                                                height,
                                                onClick,
                                                "",
                                              );
                                            }).toList(),
                                            const Spacer(),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              width: double.infinity,
                                              child: PrimaryFilledButton(
                                                onPressed: () {
                                                  goToNextSection();
                                                },
                                                buttonTitle:
                                                    widget.sectionId == QuestionViewModel.sectionList.last.id ? TranslationKeys.submit.capitalize() : TranslationKeys.continueText.capitalize(),
                                                widgetKey: KEY_BUTTON_CONTINUE,
                                              ),
                                            ),
                                            const SizedBox(height: 10)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  );
              }
            },
          ),
        );
      },
    );
  }
}
