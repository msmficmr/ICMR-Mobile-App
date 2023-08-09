import 'package:flutter/cupertino.dart';

abstract class QuestionnaireService {
  Future<void> fetchAllQuestionnaires();

  Future<void> fetchNextQuestion({
    required BuildContext context,
    required String questionId,
    required String encounterId,
    required String ehrCategoryId,
  });

  void addToConversation({
    required String questionId,
    required String question,
    required String chipType,
    required DateTime timeAsked,
    bool hasFollowUp = false,
    bool isFollowUp = false,
    Map<String, dynamic> followupQuestions = const {},
    bool hasOptions = true,
    List<String> options = const [],
    List<String> optionKeys = const [],
    int? selectedOptionIndex,
    String? answer,
    bool isEditable = false,
  });
}
