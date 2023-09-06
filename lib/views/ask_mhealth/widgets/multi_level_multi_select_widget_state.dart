class MultiLevelMultiSelectWidgetState {
  static Map<String, bool> _questionResponseState = <String, bool>{};
  static bool isValidationOn = false;
  static bool isMandatoryQuestion = false;
  static String? validationMessage;

  static bool get getQuestionResponseStatus {
    var status = true;

    if (isMandatoryQuestion) {
      _questionResponseState.forEach((key, value) {
        status = status && value;
      });
    }

    return status;
  }

  static void setQuestionState(String questionId, bool status) {
    _questionResponseState[questionId] = status;
  }

  static void removeQuestionState(String questionId) {
    if (_questionResponseState.containsKey(questionId)) {
      _questionResponseState.remove(questionId);
    }
  }

  static void reset() {
    _questionResponseState.clear();
    isValidationOn = false;
    isMandatoryQuestion = false;
    validationMessage = '';
  }
}
