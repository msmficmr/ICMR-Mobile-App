import 'dart:convert';

import 'package:mhealth/utils/app_constant.dart';

class ConversationModel {
  String questionId; // questionId
  String question; // question text
  bool hasFollowUp; // if the question has followup questions
  bool isFollowUp; // if this question is a follow up question instead of main question
  Map<String, dynamic> followupQuestions; // list of followup questions
  bool hasOptions; // if the question has options, true for chip type renders and false for input type renders
  List<String> options; // list of options
  List<String> optionKeys; //tracks keys of the options
  int? selectedOptionIndex; // index of the answer
  String? answer; // answer selected by user
  String chipType; // type of the chip
  DateTime timeAsked; // time at which question was asked to the user
  bool followUpSubmitted; //tracks if the follow up questions are submitted or not
  bool isEditable;

  List<String> selectedOptionKeys = [];
  List<String> selectedOptions = [];

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
      questionId: json["questionId"],
      question: json["question"],
      chipType: json["type"],
      options: List<String>.from(json["suggestions"].map((x) => x)),
      optionKeys: List<String>.from(json["optionKeys"].map((x) => x)),
      hasFollowUp: json["hasFollowUp"],
      timeAsked: DateTime.now(),
      followupQuestions: json["inputs"],
      followUpSubmitted: json["isSubmitted"] ?? false)
    ..selectedOptionKeys = List<String>.from(json["selectedOptionKeys"].map((x) => x))
    ..selectedOptions = List<String>.from(json["selectedOptions"].map((x) => x));

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "question": question,
    "hasFollowUp": hasFollowUp,
    "isFollowUp": isFollowUp,
    "followupQuestions": followupQuestions,
    "hasOptions": hasOptions,
    "options": options,
    "optionKeys": optionKeys,
    "selectedOptionIndex": selectedOptionIndex,
    "answer": answer,
    "chipType": chipType,
    "timeAsked": timeAsked.toString(),
    "followUpSubmitted": followUpSubmitted,
    "isEditable": isEditable,
    "selectedOptionKeys": selectedOptionKeys,
    "selectedOptions": selectedOptions
  };

  @override
  toString() {
    return json.encode(toJson());
  }

  ConversationModel({
    required this.questionId,
    required this.question,
    required this.chipType,
    required this.timeAsked,
    this.hasFollowUp = false,
    this.isFollowUp = false,
    this.followupQuestions = const {},
    this.hasOptions = true,
    this.options = const [],
    this.optionKeys = const [],
    this.selectedOptionIndex,
    this.followUpSubmitted = false,
    this.answer,
    this.isEditable = false,
  })  :
        assert((hasOptions == true && options.isNotEmpty) || (hasOptions == false && options.isEmpty), AppConstant.YOU_HAVE_SET_HAS_OPTIONS_AS_TRUE);
}
