import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mhealth/utils/app_values.dart';

class CommonFunctions {

  /// opens browser with privacy policy link
  static void onPrivacyPolicyClick() {
    //TODO: add url launcher implementation
  }

  /// opens browser with Terms and conditions link
  static void onTermsConditionClick() {
    //TODO: add url launcher implementation
  }

  /// displays toast message on screen
  static void toastMessage(String message) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_LONG, fontSize: 16.0);
  }

  static int? getAge(String? dob) {
    try {
      if (dob == null || dob.isEmpty) {
        return null;
      }
      if (dob.isNotEmpty) {
        DateTime birthDate = DateFormat(AppValues.dobDateFormat).parse(dob);

        DateTime today = DateTime.now();
        Duration duration = today.difference(birthDate);

        return (duration.inDays / 365).round();
      }

      return null;
    } catch (e) {
      return null;
    }
  }


}