import 'dart:developer';

import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier {

  Locale _locale = const Locale("en", "IN");
  String _language = "English";

  Locale get locale => _locale;
  String get language => _language;

  Future<void> setLocale({required Locale locale, required String language}) async {
    _locale = locale;
    _language = language;
    notifyListeners();
  }

}