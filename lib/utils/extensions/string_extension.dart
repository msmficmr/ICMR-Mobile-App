import 'package:mhealth/utils/app_localization.dart';

extension StringExtension on String {
  String get toKey {
    return replaceAll(RegExp(r"\s+"), "").toLowerCase();
  }

  String get maskPhoneNumber {
    String lastFiveLetters = substring(length - 5);
    String maskedString = replaceAll(lastFiveLetters, 'x' * lastFiveLetters.length);
    return maskedString;
  }

  String translate(context) {
    return AppLocalizations.of(context).getTranslate(this) ?? "";
  }

  String get sectionTitleName {
    String titleName = replaceAll("community_risk_assessment_", "").replaceAll("_", " ");
    return titleName[0].toUpperCase() + titleName.substring(1);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String get questionText {
    String questionText = replaceAll(" ", "_");
    return questionText.toLowerCase();
  }

  String convertToCamelCase() {
    List<String> words = split('_');
    String result = '';
    for (String word in words) {
      if (word.isNotEmpty) {
        result += '${word[0].toUpperCase()}${word.substring(1)} ';
      }
    }
    return result.trim();
  }

  bool toBoolean() {
    return (toLowerCase() == "true") ? true : false;
  }
}