import 'package:flutter/material.dart';

Future<void> showPaymentLoading({required BuildContext context}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: CircularProgressIndicator(),
    ),
  );
}
