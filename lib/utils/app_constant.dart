import 'package:mhealth/widgets/custom_chip_widget.dart';

class AppConstant {

  AppConstant._();

  static const String APP_NAME_KEY = "APP_NAME";
  static const String BASE_URL_KEY = "BASE_URL";
  static const String ENV_KEY = "ENV";
  static const String FONT_FAMILY = "Montserrat";

  // BUTTON TITLES
  static const String CONTINUE_BUTTON_TITLE = "Continue";
  static const String TAKE_CRA_BUTTON_TITLE = "Take CRA";
  static const String CONSENT_BUTTON_TITLE = "Consent";
  static const String ONLINE_SYNC_DATA_BUTTON_TITLE = "You are online, Sync data";

  // ERRORS
  static const String ERROR_SOMETHING_WENT_WRONG = "Something Went Wrong";

  // Shared Preferences keys
  static const String LANGUAGE_KEY = "LANGUAGE";

  //Gender List
  static const List<CustomChipItem<String>> GENDER_LIST = [
    CustomChipItem(data: "m", text: "Male"),
    CustomChipItem(data: "f", text: "Female"),
    CustomChipItem(data: "u", text: "Other"),
  ];

}