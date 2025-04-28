import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mhealth/utils/app_constant.dart';

class AppLocalizations {
  late final Locale appLocale;

  AppLocalizations(this.appLocale);

  Map<String, String> _localizedStrings = {};

  static AppLocalizations of(BuildContext context) => Localizations.of(context, AppLocalizations);

  /// Loading the JSON file from the "language" folder
  Future<bool> loadLanguageJson({Locale? appLocale}) async {
    String languageCode = appLocale?.languageCode ?? "en";
    String jsonString = await rootBundle.loadString('assets/language/$languageCode.json');
    Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);
    _localizedStrings = jsonLanguageMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  /// Called from every widget which needs a localized text
  String? getTranslate(String jsonKey) {
    return _localizedStrings[jsonKey];
  }

  static const supportedLocales = AppConstant.appLocales;

  /// This method checks for the supported locales & the locale for the phone language,
  /// If the phone language is supported by the app it will return the language
  /// else it will return english language
  static Locale?
  localeResolutionCallBack(Locale? locale, Iterable<Locale>? supportedLocales) {
    if (supportedLocales != null && locale != null) {
      return supportedLocales.firstWhere((element) => element.languageCode == locale.languageCode, orElse: () => supportedLocales.first);
    }
  }

  static const LocalizationsDelegate<AppLocalizations> _delegate = _ApplicationLocalizationsDelegate();

  static const localizationsDelegates = [
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    _delegate,
  ];
}

class _ApplicationLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _ApplicationLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppConstant.appLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.loadLanguageJson(appLocale: locale);
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => true;
}
