// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
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

  const QuestionScreenView({
    super.key,
    required this.sectionId,
    required this.patientId,
    required this.caseId,
  });

  @override
  State<QuestionScreenView> createState() => _QuestionScreenViewState();
}

class _QuestionScreenViewState extends State<QuestionScreenView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  void onBackPress() {
    GoRouter.of(context).pop();
  }

  // Future<void> goToNextSection(QuestionViewModel vm) async {
  //   if (!(_formKey.currentState?.validate() ?? false)) {
  //     CommonFunctions.toastMessage(AppConstant.SELECT_FILE_BEFORE_SUBMITTING);
  //     return;
  //   }

  //   bool isValid = true;
  //   for (var questionnaire in vm.questionList) {
  //     if (!questionnaire.isValid()) {
  //       isValid = false;
  //     }
  //   }

  //   if (!isValid) return;

  //   final isSaved = await vm.saveToDB();
  //   if (!isSaved) return;

  //   // Update patient list
  //   final patientVm = context.read<PatientListViewModel>();
  //   patientVm.checkCraStatus(widget.patientId);
  //   await patientVm.fetchCompletedCRA();

  //   final nextSectionId = vm.nextSectionId;
  //   if (nextSectionId != null) {
  //     GoRouter.of(context).push(
  //       QuestionScreenView.routerPath,
  //       extra: {
  //         "caseId": widget.caseId,
  //         "patientId": widget.patientId,
  //         "sectionId": nextSectionId,
  //       },
  //     );
  //   } else {
  //     CommonFunctions.toastMessage(
  //       TranslationKeys.craSuccessMessage.translate(context),
  //     );
  //     GoRouter.of(context).go(DashboardScreen.routerPath);
  //   }
  // }

  
  Future<void> goToNextSection(QuestionViewModel questionViewModel) async {
    if (_formKey.currentState?.validate() ?? false) {
      bool isValid = true;
      for (var questionnaire in questionViewModel.questionList) {
        if (!questionnaire.isValid()) {
          isValid = false;
        }
      }
      setState(() {});
      if (isValid) {
        bool isSaved = await questionViewModel.saveToDB();
        if (isSaved) {
          //update patient list
          context.read<PatientListViewModel>().checkCraStatus(widget.patientId);
          await context.read<PatientListViewModel>().fetchCompletedCRA();

          /// If all sections are completed then [nextSectionId] will return null
          String? nextSectionId = questionViewModel.nextSectionId;
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
    final height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<QuestionViewModel>(
      create: (context) {
        final vm = QuestionViewModel(
          widget.sectionId,
          widget.patientId,
          widget.caseId,
        );

        /// ✅ SAFE INIT — Provider is created here
        vm.fetchEncounterDetails().then((_) async {
          await vm.fetchPatientEhrDetails();
          await vm.fetchSectionQuestions();
        });

        return vm;
      },
      child: Consumer<QuestionViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: CustomAppBar(
              onLeadingClick: onBackPress,
              appBarTitleType: CustomAppBarTitleType.TEXT,
              titleText: AppConstant.RISK_ASSESSMENT,
            ),
            body: Selector<QuestionViewModel, ApiStatus>(
              selector: (_, p) => p.fetchQuestionsApiStatus,
              builder: (context, status, _) {
                switch (status) {
                  case ApiStatus.loading:
                    return const Center(child: CircularProgressIndicator());

                  case ApiStatus.error:
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Something Went Wrong"),
                          const SizedBox(height: 12),
                          PrimaryFilledButton(
                            buttonTitle: "Retry",
                            onPressed: () {
                              vm.fetchEncounterDetails().then((_) async {
                                await vm.fetchPatientEhrDetails();
                                await vm.fetchSectionQuestions();
                              });
                            }, widgetKey: 'retry',
                          ),
                        ],
                      ),
                    );

                  case ApiStatus.success:
                    return Selector<QuestionViewModel, List<Questionnaire>>(
                      selector: (_, p) => p.questionList,
                      builder: (context, questions, _) {
                        if (questions.isEmpty) {
                          return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Something Went Wrong"),
                          const SizedBox(height: 12),
                          PrimaryFilledButton(
                            buttonTitle: "Retry",
                            onPressed: () {
                              vm.fetchEncounterDetails().then((_) async {
                                await vm.fetchPatientEhrDetails();
                                await vm.fetchSectionQuestions();
                              });
                            }, widgetKey: 'retry',
                          ),
                        ],
                      ),
                    );
                        }

                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SectionNameWidget(
                                    sectionName: vm.currentSection.name,
                                  ),
                                  ...questions.map((question) {
                                    return getWidgetForQuestionnaireAndFollowupQuestionnaire(
                                      context,
                                      question,
                                      height,
                                      () => setState(() {}),
                                      "",
                                    );
                                  }).toList(),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: PrimaryFilledButton(
                                      widgetKey: KEY_BUTTON_CONTINUE,
                                      onPressed: () =>
                                          goToNextSection(vm),
                                      buttonTitle: widget.sectionId ==
                                              QuestionViewModel
                                                  .sectionList.last.id
                                          ? TranslationKeys.submit.capitalize()
                                          : TranslationKeys.continueText
                                              .capitalize(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
