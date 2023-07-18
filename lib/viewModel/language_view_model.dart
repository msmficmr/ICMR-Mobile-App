import 'package:flutter/material.dart';

class LanguageViewModel extends ChangeNotifier {
  int _selectedIndex = -1;
  String _selectedLanguage = "";

  int get selectedIndex => _selectedIndex;
  String get selectedLanguage => _selectedLanguage;
  

  void setSelectedLanguage({required String selectedLanguage, required int selectedIndex}) {
    _selectedIndex = selectedIndex;
    _selectedLanguage = selectedLanguage;
    notifyListeners();
  }
}
