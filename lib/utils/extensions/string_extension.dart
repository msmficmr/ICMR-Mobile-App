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

  String get sectionName {
    String section = replaceAll(" ", "_").toLowerCase();
    return section;
  }

  String get sectionTitleName {
    List<String> words = split('_');
    words = words.map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).toList();
    return words.join(' ');
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}