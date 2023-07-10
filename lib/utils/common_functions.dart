import 'package:fluttertoast/fluttertoast.dart';

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


}