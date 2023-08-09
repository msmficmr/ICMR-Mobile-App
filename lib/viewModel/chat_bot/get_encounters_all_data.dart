import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mhealth/model/encounters_model.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/chat_bot_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Encounters {
  late ChatBotViewModel chatBotProvider;
  late SharedPreferences sharedPreferences;
  List<String> _uiTemplatesList = [];
  Map<String, dynamic> _encounterCategoryMapIdForScreening = {};
  String? localeKey;

  List<EncounterDetailModel> _encounterModelList = [];

  List<EncounterDetailModel> get encounterModelList => _encounterModelList;

  /// The [_localizedSectionNamesMapObject] map object contains section names,
  /// The key will be section name in Multi Language and
  /// value will be section name in only English
  /// Ex: {"వ్యక్తిగత చరిత్ర": "Personal History"}
  Map<String, dynamic> _localizedSectionNamesMapObject = {};
  Map<String, dynamic> get localizedSectionNamesMapObject =>
      _localizedSectionNamesMapObject;

  static Encounters _encounters = Encounters._();

  Encounters._();

  factory Encounters() {
    return _encounters;
  }

  clearEncounters() => _encounterModelList.clear();

  /// The purpose of the [getEncountersData] method is to retrieve comprehensive
  /// information on all encounters that have occurred. This includes details on
  /// various sections such as Risk Assessment and TeleConsultation, etc.
  /// By calling this method, users can obtain a complete overview of all encounters that
  /// have taken place, allowing them to review and analyze the data as needed.

  Future<void> getEncountersData(
      {required BuildContext context, List<String>? sectionsAttempted}) async {
    chatBotProvider = Provider.of<ChatBotViewModel>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    localeKey = await CommonFunctions.getLanguageKey();
    final int age =
    CommonFunctions.getAgeFromDob(sharedPreferences.getString(AppConstant.PATIENT_DOB_KEY) ?? "");
    final String gender = sharedPreferences.getString(AppConstant.PATIENT_GENDER_KEY) ?? "";
    final String location = sharedPreferences.getString(AppConstant.LOCATION_ID_KEY) ?? "";

    if (_encounterModelList.isEmpty) {
      try {
        /*Response response = await EdgeService().getEncountersDataAPI(
          sourceAppName: RISK_ASSESSMENT_MOBILE_WEBAPP,
          age: age,
          locale: chatBotProvider.currentLanguage,
          gender: gender,
          location: location,
        );

        if (response.statusCode == 200 && response.body.isNotEmpty) {
          _encounterModelList = getEncounterModelFromJson(response.body);
          getScreeningSection(sectionsAttempted: sectionsAttempted);
        }*/
      } catch (error, stackTrace) {
        CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
      }
    } else {
      getScreeningSection(sectionsAttempted: sectionsAttempted);
    }
  }

  /// The [getScreeningSection] method serves the purpose of extracting data from
  /// the [_encounterModelList] (Model Class), which is a List consisting of encounterModel objects.
  /// Specifically, this method is designed to retrieve the ehrCategory name,
  /// ehrCategory ID, and encounterCategoryMapId associated with the screening section.
  /// By calling this method, users can easily access and retrieve this important data,
  /// allowing for further analysis and manipulation as necessary. Essentially,
  /// the [getScreeningSection] method is a tool for extracting specific data points
  /// related to the screening section from the larger [_encounterModelList].

  getScreeningSection({List<String>? sectionsAttempted}) {
    try {
      for (var sections in _encounterModelList) {
        if (sections.id == EncounterIds.RISK_ASSESSMENT.name) {
          List<Section>? sectionsList = sections.sections;
          sectionsList?.forEach((element) {
            if ((element.ehrCategory?.name) != null &&
                element.ehrCategory?.name != AppConstant.PAYMENT) {
              if ((sectionsAttempted == null) ||
                  (sectionsAttempted.contains(element.ehrCategory?.name))) {
                addScreeningSection(
                    sectionId: sections.id ?? "",
                    ehrCategoryId: element.ehrCategory?.ehrCategoryId ?? "",
                    ehrCategoryName: element.ehrCategory?.name ?? "",
                    sectionName: element.ehrCategory?.description ?? "",
                    encounterServiceName: element.encounterServiceName ?? "",
                    encounterCategoryMapId:
                    element.encounterCategoryMapId ?? "");
                _encounterCategoryMapIdForScreening[
                element.encounterCategoryMapId ?? ""] =
                    element.ehrCategory?.name;
              }
            }
          });
        }

        sharedPreferences.setString(AppConstant.ENCOUNTER_CATEGORY_MAP_IDS_KEY, json.encode(_encounterCategoryMapIdForScreening));
      }
    } catch (error) {
      CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
    }
  }

  /// The [addScreeningSection] method is designed to facilitate the addition of
  /// data to the chatBotProvider class in a specific JSON format. This method
  /// allows users to add various data points such as sectionId, ehrCategoryId
  /// and ehrCategoryName to the chatBotProvider class, streamlining the process
  /// of organizing and managing screening section data. By calling this method and passing the
  /// necessary parameters, users can easily and efficiently add the desired data
  /// to the chatBotProvider class in the specified format. Essentially,
  /// the [addScreeningSection] method serves as a tool for simplifying the
  /// process of adding data to the chatBotProvider class in a standardized manner.

  void addScreeningSection({
    required String sectionId,
    required String ehrCategoryId,
    required String ehrCategoryName,
    required String sectionName,
    required String encounterServiceName,
    required String encounterCategoryMapId,
  }) async {
    try {
      if (chatBotProvider.isInsuranceDisabled &&
          ehrCategoryName == AppConstant.INSURANCE_SECTION_NAME) {
        return;
      }

      String uiTemplate = sectionId + "_" + ehrCategoryId;
      _uiTemplatesList.add(uiTemplate);
      _localizedSectionNamesMapObject[ehrCategoryName] = sectionName;
      chatBotProvider.addScreeningSection(
          encounterId: sectionId,
          sectionName: ehrCategoryName,
          value: {
            'ehrCategoryName': ehrCategoryName,
            'ehrCategoryId': ehrCategoryId,
            'encounterServiceName': encounterServiceName,
            'encounterCategoryMapId': encounterCategoryMapId
          });
    } catch (error) {
      CommonFunctions.toastMessage(AppConstant.AN_UNKNOWN_ERROR);
    }
  }
}
