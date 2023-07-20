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

class AttachmentModel {
  String fileName;
  List<int> bytes;
  AttachmentModel({required this.fileName, required this.bytes});
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
