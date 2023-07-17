import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier {

  Locale _locale = new Locale("en", "IN");
  String _language = "English";

  Locale get locale => _locale;
  String get language => _language;

  Future<void> setLocale({required Locale locale, required String language}) async {
    if (language == "English") {

    }
  }

}