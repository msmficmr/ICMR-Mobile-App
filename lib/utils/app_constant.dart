import 'dart:ui';

import 'package:mhealth/widgets/custom_chip_widget.dart';

class AppConstant {
  AppConstant._();

  static const String APP_NAME_KEY = "APP_NAME";
  static const String BASE_URL_KEY = "BASE_URL";
  static const String ENV_KEY = "ENV";
  static const String SOURCE_APP_NAME_KEY = "SOURCE_APP_NAME";
  static const String ENCRYPTION_KEY = "ENCRYPTION_KEY";
  static const String FONT_FAMILY = "Montserrat";
  static const String M_HEALTH_LABEL = "mHealth";
  static const String AI_BASED_CANCER_RISK_ASSESSMENT = "AI Based Cancer Risk Assessment";

  static const String RISK_ASSESSMENT = "Risk Assessment";
  static const String COMPLETED_QUESTIONNAIRE = "Completed Questionnaire";
  static const String EMAIL = "Email";
  static const String PAYMENT = "Payment";
  static const String VALUE = "value";
  static const String FIELD = "field";
  static const String TYPE = 'type';
  static const String QUESTION = 'question';
  static const String QUESTIONS = 'questions';
  static const String INPUT = "input";
  static const String INPUTS = "inputs";
  static const String OPTION = "option";
  static const String OPTIONS = "options";
  static const String SUGGESTIONS = 'suggestions';
  static const String DETAILS = 'details';
  static const String SCORE = 'score';
  static const String LANGUAGE_INTENT = "languageIntent";
  static const String RISK_ASSESSMENT_INTENT = "riskAssessment";
  static const String LOGIN_INTENT = "loginIntent";
  static const String RETURN_TO_HOME = "Return To Home";
  static const double TEXT_HEIGHT = 1.6;
  static const String SIGNATURE_SCREEN_APP_BAR_TITLE = "Signature";
  static const List<String> WHITE_LISTED_SECTIONS = [
    "Details Of Habits",
    "Baseline Signs Or Symptoms",
    "Periodontal Status",
    "Lesion Location",
    "Measurement of lesions",
    "Investigations",
    "Verification form"
  ];
  static const SYNC_COMPLETED = "Sync completed";
  static const NO_DATA_TO_SYNC_COMPLETED = "No data to sync";
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
  static const String UPDATE_BUTTON_TITLE = "Update";

  //KEYS
  static const String KEY_BUTTON_CONTINUE = "key_continue_button";

  // ERRORS
  static const String SELECT_FILE = "Upload Consent";
  static const String ERROR_SOMETHING_WENT_WRONG = "Something Went Wrong";
  static const String AN_UNKNOWN_ERROR = "An Unknown error occurred! Please Try again later!";
  static const String YOU_HAVE_SET_HAS_FOLLOW_UP_AS_TRUE = "You have set hasFollowUp as false, "
      "but followupQuestions is not empty or You have set hasFollowUp as true,"
      " but followupQuestions is empty.";
  static const String YOU_HAVE_SET_HAS_OPTIONS_AS_TRUE = "You have set hasOptions as true, but options is empty or You have "
      "set hasOptions as false, but options is not empty.";
  static const String PLEASE_SELECT_PREFERRED_LANGUAGE = "Please select your preferred language";
  static const String ERROR_FILL_REQUIRED_FIELDS = "Fill required fields";
  static const String FIELD_REQUIRED = "This field is required";
  static const String ERROR_INVALID_ID = "Invalid Id";
  static const String CONSENT_REQUIRED = "Consent is required to continue";
  static const String INVALID_OTP = "OTP is invalid";
  static const String NO_RECORD_FOUND = "No Records Found";
  static const String SELECT_FILE_BEFORE_SUBMITTING = "Fill required fields";

  // LANGUAGE CODE KEYS
  static const String ENGLISH_LANGUAGE_CODE_KEY = "en_US";
  static const String HINDI_LANGUAGE_CODE_KEY = "hi";

  // SHARED PREFERENCE KEYS
  static const String LANGUAGE_KEY = "LANGUAGE";
  static const CASE_ID = "caseId";
  static const String PATIENT_DOB_KEY = "PatientDOB";
  static const String PATIENT_GENDER_KEY = "PatientGender";
  static const String LOCATION_ID_KEY = "locationId";
  static const String TEMPLATE_VERSION = "template_version";
  static const String SHREAD_PREF_DOC_KEY = "SHREAD_PREF_DOC_KEY";

  //Gender List
  static const List<CustomChipItem<String>> GENDER_LIST = [
    CustomChipItem(data: "Male", text: "male"),
    CustomChipItem(data: "Female", text: "female"),
    CustomChipItem(data: "Other", text: "other"),
  ];

  ///SECURE STORAGE KEYS
  static const String SHARED_PREFERENCE_USER_DETAILS = "SHARED_PREFERENCE_USER_DETAILS";
  static const String SHARED_PREFERENCE_LOGIN_TIME = "SHARED_PREFERENCE_LOGIN_TIME";

  // QUESTIONNAIRE TYPE
  static const String BUTTON_TYPE = "BUTTON_TYPE";
  static const String CHIP_OPTIONS = 'CHIP_OPTIONS';
  static const String CHIP_OPTIONS_WITH_TEXTFORM = "CHIP_OPTIONS_WITH_TEXTFORM";
  static const String CHIP_WITH_SINGLE_SELECT_CHIP = "CHIP_WITH_SINGLE_SELECT_CHIP";
  static const String CHIP_OPTIONS_WITH_CONDITIONAL = "CHIP_OPTIONS_WITH_CONDITIONAL";
  static const String CHIP_OPTIONS_WITH_MULTI_INPUT = "CHIP_OPTIONS_WITH_MULTI_INPUT";
  static const String CHIP_OPTIONS_WITH_AUTOSUGGEST = "CHIP_OPTIONS_WITH_AUTOSUGGEST";
  static const String CHIP_WITH_MULTISELECT_TEXTFORM = "CHIP_WITH_MULTISELECT_TEXTFORM";
  static const String CHECKBOX = "CHECKBOX";
  static const String TEXT_AREA = "TEXT_AREA";
  static const String SINGLE_TEXT_FIELD = "SINGLE_TEXT_FIELD";
  static const String SINGLE_CHOICE_TOGGLE = "SINGLE_CHOICE_TOGGLE";
  static const String SINGLE_CHOICE_TOGGLE_TEXTFORM = "SINGLE_CHOICE_TOGGLE_TEXTFORM";
  static const String SINGLE_MULTI_MULTI_CHIP_OPTIONS = "SINGLE_MULTI_MULTI_CHIP_OPTIONS";
  static const String SINGLE_CHOICE_TOGGLE_WITH_MULTI_INPUT = "SINGLE_CHOICE_TOGGLE_WITH_MULTI_INPUT";
  static const String SINGLE_CHOICE_TOGGLE_WITH_AUTOSUGGEST = "SINGLE_CHOICE_TOGGLE_WITH_AUTOSUGGEST";
  static const String MULTI_SELECT_TEXTFORM = "MULTI_SELECT_TEXTFORM";
  static const String CHIP_OPTIONS_WITH_MULTI_SELECTION = "CHIP_OPTIONS_WITH_MULTI_SELECTION";
  static const String ENCOUNTER_CATEGORY_MAP_IDS_KEY = "EncounterCategoryMapIds";
  static const String INSURANCE_SECTION_NAME = "Insurance related information";
  static const String IN_BUILT_QUESTION = "InBuiltQuestion";
  static const String PREVIOUS_RISK_ASSESSMENT = "Previous Risk Assessment";
  static const String THANKS_FOR_ENTERING_YOUR_DETAILS = "Thanks for entering your details, \nTo Proceed further click on \nTake Assessment";

  /// Language Supported
  static const List<Map<String, String>> languages = [
    {"locale": "en_US", "name": "English", "englishText": "English"},
    // {"locale": "hi", "name": "हिन्दी", "englishText": "Hindi"},
    // {"locale": "mr", "name": "मराठी", "englishText": "Marathi"},
    // {"locale": "te", "name": "తెలుగు", "englishText": "Telugu"},
    // {"locale": "ru", "name": "മലയാളം", "englishText": "Malayalam"},
    // {"locale": "kn", "name": "ಕನ್ನಡ", "englishText": "Kannada"},
    // {"locale": "bn", "name": "বাংলা", "englishText": "Bengali"},
    // {"locale": "ta", "name": "தமிழ்", "englishText": "Tamil"},
    // {"locale": "or", "name": "ଓଡ଼ିଆ", "englishText": "Odia"},
  ];

  static const List<CustomChipItem<String>> BINARY_LIST = [
    CustomChipItem(text: 'yes', data: 'yes'),
    CustomChipItem(text: 'no', data: 'no'),
  ];

  // HERO TAGS
  static const String CONSENT_HEADER_BACKGROUND_TAG = "hero_background";
  static const String CONSENT_HEADER_LOGO_TAG = "hero_small_logo";
  static const String CONSENT_HEADER_HEADING_TAG = "hero_label";
  static const String CONSENT_HEADER_SUB_HEADING_TAG = "hero_subtext";

  static const String NO_INTERNET_MESSAGE = "No internet.. Please try again later!";
}
