import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/views/questionair/view/lesion_location_questionair_screen.dart';
import 'package:mhealth/views/questionair/view/periodontal_screen.dart';
import 'package:mhealth/views/questionair/view/verification_questionair_screen.dart';
import 'package:mhealth/widgets/custom_check_box.dart';

Widget _getWidgetForQuestionnaire(
  BuildContext context,
  Questionnaire questionnaire,
  double height,
  Function globalOnClick,
  String patientId,
) {
  switch (questionnaire.runtimeType) {
    case SingleSelectionQuestionnaire:
      return _getWidgetForSingleSelectionQuestionnaire(context, questionnaire as SingleSelectionQuestionnaire, height, globalOnClick);
    case SingleSelectionSubQuestionnaire:
      return _getWidgetForSingleSelectionSubQuestionnaire(context, questionnaire as SingleSelectionSubQuestionnaire, height, globalOnClick);
    case MultiSelectionSubQuestionnaire:
      return _getWidgetForMultiSelectionSubQuestionnaire(context, questionnaire as MultiSelectionSubQuestionnaire, height, globalOnClick);
    case TextFieldQuestionnaire:
      return _getWidgetForTextFieldQuestionnaire(context, questionnaire as TextFieldQuestionnaire, height);
    case CheckboxQuestionnaire:
      return _getWidgetForCheckBoxQuestionnaire(context, questionnaire as CheckboxQuestionnaire, height, globalOnClick);
    case PeriodontalStatusQuestionnaire:
      return PeriodontalScreen(questioner: questionnaire as PeriodontalStatusQuestionnaire);
    case LesionLocationQuestionnaire:
      return LesionLocationQuestionnaireScreen(questioner: questionnaire as LesionLocationQuestionnaire);
    case VerificationFormQuestionnaire:
      return VerificationQuestionnaireScreen(questioner: questionnaire as VerificationFormQuestionnaire);
    default:
      log("${questionnaire.runtimeType}");
      return Container(
        color: AppColorScheme.errorTextColor,
        padding: const EdgeInsets.all(10),
        child: const Text(
          "Not implemented yet",
          style: TextStyle(
            color: AppColorScheme.kGrayColor,
          ),
        ),
      );
  }
}

Widget _getWidgetForSingleSelectionQuestionnaire(BuildContext context, SingleSelectionQuestionnaire singleSelectionQuestionnaire, double height, Function globalOnClick) {
  Function onClick = (QuestionnaireOption questionnaireOption) {
    singleSelectionQuestionnaire.timeAsked = DateTime.now();
    singleSelectionQuestionnaire.selectedOption = questionnaireOption;
    singleSelectionQuestionnaire.shouldShowError = false;
    globalOnClick();
    singleSelectionQuestionnaire.clear();
  };
  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          singleSelectionQuestionnaire.questionText,
          style: AppStyles.titleMedium,
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Wrap(
          direction: Axis.horizontal,
          runSpacing: 5,
          spacing: 5,
          children: List.generate(
            singleSelectionQuestionnaire.optionsList.length,
            (optionIndex) => _getWidgetForQuestionnaireOption(
              singleSelectionQuestionnaire.optionsList[optionIndex],
              singleSelectionQuestionnaire.optionsList[optionIndex].optionId == singleSelectionQuestionnaire.selectedOption?.optionId,
              onClick,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Visibility(
          visible: singleSelectionQuestionnaire.shouldShowError,
          child: Text(
            TranslationKeys.thisFieldIsMandatory.translate(context),
            style: AppStyles.bodySmall.copyWith(color: AppColorScheme.errorTextColor),
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
      ],
    ),
  );
}

Widget _getWidgetForSingleSelectionSubQuestionnaire(BuildContext context, SingleSelectionSubQuestionnaire singleSelectionSubQuestionnaire, double height, Function globalOnClick) {
  Function onClick = (QuestionnaireOption questionnaireOption) {
    singleSelectionSubQuestionnaire.selectedOption = questionnaireOption;
    singleSelectionSubQuestionnaire.shouldShowError = false;
    globalOnClick();
  };
  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          singleSelectionSubQuestionnaire.questionText,
          style: AppStyles.titleMedium,
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Wrap(
          direction: Axis.horizontal,
          runSpacing: 5,
          spacing: 5,
          children: List.generate(
              singleSelectionSubQuestionnaire.optionsList.length,
              (optionIndex) => _getWidgetForQuestionnaireOption(singleSelectionSubQuestionnaire.optionsList[optionIndex],
                  singleSelectionSubQuestionnaire.optionsList[optionIndex].optionId == singleSelectionSubQuestionnaire.selectedOption?.optionId, onClick)),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Visibility(
          visible: singleSelectionSubQuestionnaire.shouldShowError,
          child: Text(
            TranslationKeys.thisFieldIsMandatory.translate(context),
            style: AppStyles.bodySmall.copyWith(color: AppColorScheme.errorTextColor),
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
      ],
    ),
  );
}

Widget _getWidgetForCheckBoxQuestionnaire(BuildContext context, CheckboxQuestionnaire checkboxSubQuestionnaire, double height, Function globalOnClick) {
  Function onClick = (QuestionnaireOption questionnaireOption) {
    int selectedOptionIndex = checkboxSubQuestionnaire.selectedOptions.indexWhere((element) => element.optionId == questionnaireOption.optionId);
    if (selectedOptionIndex < 0) {
      checkboxSubQuestionnaire.selectedOptions.add(questionnaireOption);
      checkboxSubQuestionnaire.shouldShowError = false;
    } else {
      checkboxSubQuestionnaire.selectedOptions.removeAt(selectedOptionIndex);
    }
    globalOnClick();
  };
  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          checkboxSubQuestionnaire.questionText,
          style: AppStyles.bodyMedium,
        ),
        SizedBox(
          height: 10,
        ),
        ...List.generate(
          checkboxSubQuestionnaire.optionsList.length,
          (optionIndex) => CustomCheckBox(
            widgetKey: UniqueKey(),
            onChanged: (p0) {
              onClick(checkboxSubQuestionnaire.optionsList[optionIndex]);
            },
            value: checkboxSubQuestionnaire.selectedOptions.indexWhere(( // ignore: unrelated_type_equality_checks
                        element) =>
                    // ignore: unrelated_type_equality_checks
                    element.optionId == checkboxSubQuestionnaire.optionsList[optionIndex].optionId) >=
                0,
            children: [
              TextSpan(
                text: checkboxSubQuestionnaire.optionsList[optionIndex].optionText,
                style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kGrayColor),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: checkboxSubQuestionnaire.shouldShowError,
          child: Text(
            TranslationKeys.thisFieldIsMandatory.translate(context),
            style: AppStyles.bodySmall.copyWith(color: AppColorScheme.errorTextColor),
          ),
        ),
      ],
    ),
  );
}

Widget _getWidgetForMultiSelectionSubQuestionnaire(BuildContext context, MultiSelectionSubQuestionnaire multiSelectionSubQuestionnaire, double height, Function globalOnClick) {
  Function onClick = (QuestionnaireOption questionnaireOption) {
    int selectedOptionIndex = multiSelectionSubQuestionnaire.selectedOptions.indexWhere((element) => element.optionId == questionnaireOption.optionId);
    if (selectedOptionIndex < 0) {
      multiSelectionSubQuestionnaire.selectedOptions.add(questionnaireOption);
      multiSelectionSubQuestionnaire.shouldShowError = false;
    } else {
      multiSelectionSubQuestionnaire.selectedOptions.removeAt(selectedOptionIndex);
    }
    globalOnClick();
  };
  return SizedBox(
    width: height * 0.5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          multiSelectionSubQuestionnaire.questionText,
          style: AppStyles.bodyMedium,
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Wrap(
          direction: Axis.horizontal,
          runSpacing: 5,
          spacing: 5,
          children: List.generate(
              multiSelectionSubQuestionnaire.optionsList.length,
              (optionIndex) => _getWidgetForQuestionnaireOption(
                  multiSelectionSubQuestionnaire.optionsList[optionIndex],
                  multiSelectionSubQuestionnaire.selectedOptions.indexWhere(( // ignore: unrelated_type_equality_checks
                              element) =>
                          // ignore: unrelated_type_equality_checks
                          element.optionId == multiSelectionSubQuestionnaire.optionsList[optionIndex].optionId) >=
                      0,
                  onClick)),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Visibility(
          visible: multiSelectionSubQuestionnaire.shouldShowError,
          child: Text(
            TranslationKeys.thisFieldIsMandatory.translate(context),
            style: AppStyles.bodySmall.copyWith(color: AppColorScheme.errorTextColor),
          ),
        ),
      ],
    ),
  );
}

Widget _getWidgetForTextFieldQuestionnaire(BuildContext context, TextFieldQuestionnaire textFieldQuestionnaire, double height) {
  return Padding(
    padding: const EdgeInsets.only(right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          textFieldQuestionnaire.label,
          style: AppStyles.titleMedium,
        ),
        SizedBox(
          height: height * 0.01,
        ),
        TextFormField(
          controller: TextEditingController(text: textFieldQuestionnaire.userEnteredInput ?? ""),
          onChanged: (text) {
            textFieldQuestionnaire.userEnteredInput = text;
            textFieldQuestionnaire.shouldShowError = false;
          },
          cursorColor: AppColorScheme.kPrimaryColor,
          decoration: const InputDecoration(
            errorBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Visibility(
          visible: textFieldQuestionnaire.shouldShowError,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              TranslationKeys.thisFieldIsMandatory.translate(context),
              style: AppStyles.bodySmall.copyWith(color: AppColorScheme.errorTextColor),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    ),
  );
}

Widget _getWidgetForQuestionnaireOption(QuestionnaireOption questionnaireOption, bool isSelected, Function onClick) {
  return InkWell(
    onTap: () {
      onClick(questionnaireOption);
    },
    splashColor: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: isSelected ? AppColorScheme.kPrimaryColor : AppColorScheme.kPrimaryIconColor,
        border: Border.all(width: 1, color: isSelected ? AppColorScheme.kPrimaryColor : AppColorScheme.kGrayColor.shade400),
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Text(
        questionnaireOption.optionText,
        style: AppStyles.bodyMedium.copyWith(color: isSelected ? AppColorScheme.kPrimaryIconColor : AppColorScheme.kGrayColor),
      ),
    ),
  );
}

Widget getWidgetForQuestionnaireAndFollowupQuestionnaire(
  BuildContext context,
  Questionnaire questionnaire,
  double height,
  Function globalOnClick,
  String patientId,
) {
  List<Widget> widgetList = _getQuestionnaireWidgetList(context, [], questionnaire, height, globalOnClick, patientId);

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgetList,
  );
}

List<Widget> _getQuestionnaireWidgetList(
  BuildContext context,
  List<Widget> widgetList,
  Questionnaire questionnaire,
  double height,
  Function globalOnClick,
  String patientId,
) {
  widgetList.add(_getWidgetForQuestionnaire(
    context,
    questionnaire,
    height,
    globalOnClick,
    patientId,
  ));

  questionnaire.getFollowupQuestionnaires().forEach((element) {
    _getQuestionnaireWidgetList(
      context,
      widgetList,
      element,
      height,
      globalOnClick,
      patientId,
    );
  });
  return widgetList;
}
