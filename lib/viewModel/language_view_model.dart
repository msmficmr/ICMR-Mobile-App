import 'package:flutter/material.dart';

class LanguageViewModel extends ChangeNotifier {

  int _selectedIndex = -1;
  String _selectedLanguage = "";
  Locale _locale = const Locale("en", "IN");

  int get selectedIndex => _selectedIndex;
  String get selectedLanguage => _selectedLanguage;
  Locale get locale => _locale;

  Future<void> setSelectedLanguage({required String selectedLanguage, required int selectedIndex, required Locale locale}) async {
    _locale = locale;
    _selectedIndex = selectedIndex;
    _selectedLanguage = selectedLanguage;
    notifyListeners();
  }
}
