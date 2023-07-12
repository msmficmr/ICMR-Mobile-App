import 'package:mhealth/widgets/custom_chip_widget.dart';

class AppConstant {

  AppConstant._();

  static const String APP_NAME_KEY = "APP_NAME";
  static const String BASE_URL_KEY = "BASE_URL";
  static const String ENV_KEY = "ENV";
  static const String FONT_FAMILY = "Montserrat";

  // BUTTON TITLES
  static const String CONTINUE_BUTTON_TITLE = "Continue";

  /// ERRORS
  static const String ERROR_SOMETHING_WENT_WRONG = "Something Went Wrong";

  //Gender List
  static const List<CustomChipItem<String>> GENDER_LIST = [
    CustomChipItem(data: "m", text: "Male"),
    CustomChipItem(data: "f", text: "Female"),
    CustomChipItem(data: "u", text: "Other"),
  ];


}