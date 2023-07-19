import 'package:mhealth/utils/app_localization.dart';
import 'package:mhealth/utils/translation_keys.dart';

extension StringExtension on String {
  String get toKey {
    return replaceAll(RegExp(r"\s+"), "").toLowerCase();
  }

  String get maskPhoneNumber {
    String lastFiveLetters = substring(length - 5);
    String maskedString = replaceAll(lastFiveLetters, 'x' * lastFiveLetters.length);
    return maskedString;
  }
}

extension TranslationExtension on String {
  String get _string => this;

  String translate(context) {
    return AppLocalizations.of(context).getTranslate(_string) ?? "";
  }
}