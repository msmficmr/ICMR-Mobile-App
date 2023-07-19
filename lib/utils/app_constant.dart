import 'package:mhealth/widgets/custom_chip_widget.dart';

class AppConstant {
  AppConstant._();

  static const String APP_NAME_KEY = "APP_NAME";
  static const String BASE_URL_KEY = "BASE_URL";
  static const String ENV_KEY = "ENV";
  static const String FONT_FAMILY = "Montserrat";

  static const String EMAIL = "Email";

  //Hint Texts
  static const String HINT_TEXT_ENTER_HERE = "Enter here";
  static const String HINT_TEXT_DATE = "DD/MM/YYYY";
  static const String HINT_TEXT_SELECT = "Select";

  // BUTTON TITLES
  static const String CONTINUE_BUTTON_TITLE = "Continue";
  static const String TAKE_CRA_BUTTON_TITLE = "Take CRA";
  static const String CONSENT_BUTTON_TITLE = "Consent";

  //KEYS
  static const String KEY_BUTTON_CONTINUE = "key_continue_button";

  /// ERRORS
  // ERRORS
  static const String ERROR_SOMETHING_WENT_WRONG = "Something Went Wrong";

  /// Language Supported
  static const List<Map<String, String>> languages = [
    {"locale": "en_US", "name": "English", "englishText": "English"},
    {"locale": "hi", "name": "हिन्दी", "englishText": "Hindi"},
    {"locale": "mr", "name": "मराठी", "englishText": "Marathi"},
    {"locale": "te", "name": "తెలుగు", "englishText": "Telegu"},
    {"locale": "ru", "name": "മലയാളം", "englishText": "Malayalam"},
    {"locale": "kn", "name": "ಕನ್ನಡ", "englishText": "Kannada"},
    {"locale": "bn", "name": "বাংলা", "englishText": "Bengali"},
    {"locale": "ta", "name": "தமிழ்", "englishText": "Tamil"},
    {"locale": "or", "name": "ଓଡ଼ିଆ", "englishText": "Odia"},
  ];
  static const List<CustomChipItem<String>> GENDER_LIST = [
    CustomChipItem(data: "m", text: "Male"),
    CustomChipItem(data: "f", text: "Female"),
    CustomChipItem(data: "u", text: "Other"),
  ];

  static const List<CustomChipItem<String>> BINARY_LIST = [
    CustomChipItem(text: 'Yes', data: 'y'),
    CustomChipItem(text: 'No', data: 'n'),
  ];
}
