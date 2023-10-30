import 'dart:convert';

import 'package:flutter/material.dart';

class LanguageViewModel extends ChangeNotifier {

  static const defaultLanguage = "en_US";

  int _selectedIndex = -1;
  String _selectedLanguage = "";
  Locale _locale = const Locale(defaultLanguage, "IN");
  bool _isLoading = false;

  int get selectedIndex => _selectedIndex;
  String get selectedLanguage => _selectedLanguage;
  Locale get locale => _locale;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> setSelectedLanguage({required String selectedLanguage, required int selectedIndex, required Locale locale}) async {

    if (selectedLanguage == null) {
      _locale = const Locale(defaultLanguage, "IN");
      _selectedIndex = -1;
    }

    _locale = locale;
    _selectedIndex = selectedIndex;
    _selectedLanguage = selectedLanguage;
    notifyListeners();
  }

  clearLanguageViewModelData() {
    _selectedIndex = -1;
    _isLoading = false;
  }
}

class AttachmentModel {
  String fileName;
  List<int> bytes;
  String? baseImage;
  AttachmentModel({required this.fileName, required this.bytes}) {
    this.baseImage = base64.encode(this.bytes);
  }
  factory AttachmentModel.fromJson(Map<String, dynamic> json) => AttachmentModel(
        fileName: json["fileName"],
        bytes: List<int>.from(json["bytes"].map((e) => e)),
      );

  factory AttachmentModel.clone(AttachmentModel source) {
    return AttachmentModel(
      fileName: source.fileName,
      bytes: source.bytes,
    );
  }

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "bytes": List<dynamic>.from(bytes),
      };
}
