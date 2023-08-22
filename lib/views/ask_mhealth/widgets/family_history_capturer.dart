import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mhealth/isar_db_schema/risk_assessment_questionaire.dart';
import 'package:mhealth/views/ask_mhealth/widgets/multi_level_multi_select_widget_state.dart';

class FamilyHistoryCapturer extends StatefulWidget {
  final QuestionObj questionConfiguration;

  FamilyHistoryCapturer({required this.questionConfiguration, Key? key}) : super(key: key);

  @override
  State<FamilyHistoryCapturer> createState() => _FamilyHistoryCapturerState();
}

class _FamilyHistoryCapturerState extends State<FamilyHistoryCapturer> {

  static final Key _key = GlobalKey();
  Response? _familyHistoryResponse;
  static const String familyHistoryQuestionId = 'family_history_of_cancers_among_first_degree_relatives';
  Timer? _validationCheckTimer;
  Timer? _delayedCallbackTimer;

  bool validateQuestions = false;

  /// Sets the validation message to be displayed on validation error
  void _setValidationMessage() {
    setState(() {
      //set locale textfield, invalid message, blank text,
      MultiLevelMultiSelectWidgetState.validationMessage = "Please select an option";
    });
  }

  /// This method configure a callback to be called every 50 milleseconds until the validation is enabled
  /// once enabled, will set the status on the common component and cancels the frequent callback
  void _registerForValidationUpdate() {
    _validationCheckTimer =
    Timer.periodic(const Duration(milliseconds: 50), (Timer time) {
      if (validateQuestions) {
        MultiLevelMultiSelectWidgetState.isValidationOn = true;
        if (_validationCheckTimer != null) {
          _validationCheckTimer!.cancel();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
