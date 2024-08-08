import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_constant.dart';

class LanguageViewModel extends ChangeNotifier {
  static LanguageViewModel languageViewModel = LanguageViewModel._();
  LanguageViewModel._();

  factory LanguageViewModel() {
    return languageViewModel;
  }

  resetProvider() {
    _isLoading = false;
    _selectedLanguage = currentLanguage;
    int index = AppConstant.languages.indexWhere((element) => element["locale"] == selectedLanguage);
    if (index == -1) {
      _selectedIndex = -1;
    } else {
      _selectedIndex = index;
    }
  }

  String currentLanguage = "";

  static const String defaultLanguageCode = "en_US";

  int _selectedIndex = -1;
  String _selectedLanguage = "";
  Locale _locale = const Locale(defaultLanguageCode, "IN");
  bool _isLoading = false;

  int get selectedIndex => _selectedIndex;
  String get selectedLanguage => _selectedLanguage;
  Locale get locale => _locale;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> setAppLanguage(String languageCode) async {
    currentLanguage = languageCode;
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> setSelectedLanguage({required String? selectedLanguage}) async {
    if (selectedLanguage == null) {
      _selectedIndex = -1;
    } else {
      int index = AppConstant.languages.indexWhere((element) => element["locale"] == selectedLanguage);
      if (index == -1) {
        _selectedIndex = -1;
      } else {
        _selectedIndex = index;
      }
    }

    _selectedLanguage = selectedLanguage ?? defaultLanguageCode;
    notifyListeners();
  }
}

class AttachmentModel {
  String fileName;
  String filePath;
  AttachmentModel({required this.fileName, required this.filePath});
  factory AttachmentModel.fromJson(Map<String, dynamic> json) => AttachmentModel(
        fileName: json["fileName"],
        filePath: json["filePath"],
      );

  factory AttachmentModel.clone(AttachmentModel source) {
    return AttachmentModel(fileName: source.fileName, filePath: source.filePath);
  }

  /*  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "bytes": List<dynamic>.from(bytes),
      }; */
}
