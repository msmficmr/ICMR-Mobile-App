import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProbeMethods {
  static void showToast(String message, bool isSuccess) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isSuccess ? Colors.green[900] : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
