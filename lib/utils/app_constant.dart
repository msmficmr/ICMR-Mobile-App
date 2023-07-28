import 'dart:ui';

import 'package:mhealth/widgets/custom_chip_widget.dart';

class AppConstant {
  AppConstant._();

  static const String APP_NAME_KEY = "APP_NAME";
  static const String BASE_URL_KEY = "BASE_URL";
  static const String ENV_KEY = "ENV";
  static const String FONT_FAMILY = "Montserrat";

  static const String EMAIL = "Email";

  //Languages
  static const List<Locale> appLocales = [
    Locale('en', 'IN'),
    Locale('hi', 'IN'),
  ];
  static const List<String> appLanguages = ['en', 'hi'];

  //Hint Texts
  static const String HINT_TEXT_DATE = "DD/MM/YYYY";

  // BUTTON TITLES
  static const String CONTINUE_BUTTON_TITLE = "Continue";

  //KEYS
  static const String KEY_BUTTON_CONTINUE = "key_continue_button";

  // ERRORS
  static const String ERROR_SOMETHING_WENT_WRONG = "Something Went Wrong";
  static const String ERROR_FILL_REQUIRED_FIELDS = "Fill Required fields";
  static const String FIELD_REQUIRED = "This field is required";

  // Shared Preferences keys
  static const String LANGUAGE_KEY = "LANGUAGE";

  //Gender List
  static const List<CustomChipItem<String>> GENDER_LIST = [
    CustomChipItem(data: "m", text: "male"),
    CustomChipItem(data: "f", text: "female"),
    CustomChipItem(data: "o", text: "others"),
  ];

  /// Language Supported
  static const List<Map<String, String>> languages = [
    {"locale": "en_US", "name": "English", "englishText": "English"},
    {"locale": "hi", "name": "हिन्दी", "englishText": "Hindi"},
    {"locale": "mr", "name": "मराठी", "englishText": "Marathi"},
    {"locale": "te", "name": "తెలుగు", "englishText": "Telugu"},
    {"locale": "ru", "name": "മലയാളം", "englishText": "Malayalam"},
    {"locale": "kn", "name": "ಕನ್ನಡ", "englishText": "Kannada"},
    {"locale": "bn", "name": "বাংলা", "englishText": "Bengali"},
    {"locale": "ta", "name": "தமிழ்", "englishText": "Tamil"},
    {"locale": "or", "name": "ଓଡ଼ିଆ", "englishText": "Odia"},
  ];

  static const List<CustomChipItem<String>> BINARY_LIST = [
    CustomChipItem(text: 'yes', data: 'y'),
    CustomChipItem(text: 'no', data: 'n'),
  ];
}
