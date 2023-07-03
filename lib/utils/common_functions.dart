import 'package:fluttertoast/fluttertoast.dart';

class CommonFunctions {

  /// displays toast message on screen
  static void toastMessage(String message) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_LONG, fontSize: 16.0);
  }

  

}