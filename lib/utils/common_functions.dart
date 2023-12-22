import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mhealth/services/permission_service.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/widgets/custom_alert_dialog.dart';
import 'package:mhealth/widgets/image_view_widget.dart';
import 'package:mhealth/widgets/pdf_preview.dart';
import 'package:uuid/uuid.dart';

class CommonFunctions {
  /// opens browser with privacy policy link
  static void onPrivacyPolicyClick() {
    //TODO: add url launcher implementation
  }

// open the Location service setting
  static void openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  /// opens the apps settings
  static void openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  /// call this method to display dialog within app
  /// it accepts 3 parameter
  /// 1. context of current screen
  /// subtitle : text that will be description message for dialog
  /// buttonText : text of the button
  /// action: this is optional parameter if we don't pass it will popup the dialog
  static Future<T> openDialog<T>({
    required BuildContext context,
    required String subtitle,
    required String buttonText,
    required Function(BuildContext context)? action,
    String? title,
    Function(BuildContext context)? onCancelAction,
    String? buttonCancelText,
  }) async {
    const String _ALERT = "Alert";
    const String _KEY_TITLE = "key_text_title";
    const String _KEY_SUBTITLE = "key_text_subtitle";
    const String _KEY_BUTTON = "key_button_dialog";
    const String _KEY_BUTTON_NO = "key_button_no_dialog";

    return await showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: true,
      builder: (context) => CustomAlertDialog(
        title: title ?? _ALERT,
        subtitle: subtitle,
        buttonText: buttonText,
        titleKey: _KEY_TITLE,
        subtitleKey: _KEY_SUBTITLE,
        buttonKey: _KEY_BUTTON,
        buttonCancelKey: _KEY_BUTTON_NO,
        buttonCancelText: buttonCancelText,
        onCancelPress: onCancelAction == null
            ? null
            : () {
                onCancelAction(context);
              },
        onOkPressed: action == null
            ? null
            : () {
                action(context);
              },
      ),
    );
  }

  /// opens browser with Terms and conditions link
  static void onTermsConditionClick() {
    //TODO: add url launcher implementation
  }

  /// displays toast message on screen
  static void toastMessage(String message) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_LONG, fontSize: 16.0);
  }

  static void viewImage({required BuildContext context, required AttachmentModel model}) {
    if (model.fileName.contains(".pdf")) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => PdfPreview(fileName: model.fileName, bytes: Uint8List.fromList(model.bytes))));
    } else {
      showDialog(
          barrierDismissible: true,
          context: context,
          useSafeArea: true,
          builder: (_) {
            return ImageViewWidget(
              imageList: model.bytes,
            );
          });
    }
  }

  static Future<XFile?> getImage({required BuildContext context, required ImageSource imageSource}) async {
    bool hasCameraPermission = await PermissionService.permissionService.checkCameraPermission(context);
    if (hasCameraPermission) {
      XFile? file = await ImagePicker().pickImage(source: imageSource);
      return file;
    }
  }

  static Future<XFile?> getAttachment({required BuildContext context, List<String> extensions = const ["jpg", "jpeg", "png", "JPG", "JPEG", "PNG"]}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );
    if (result != null && result.files.isNotEmpty) {
      XFile xFile = XFile(result.files.first.path!);
      return xFile;
    }
    return null;
  }

  static void showRetrySnackbar() {
    try {
      if (AppValues.scaffoldMessengerKey.currentState?.mounted ?? false) {
        AppValues.scaffoldMessengerKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text("No Internet Connection"),
          ),
        );
      }
    } catch (e) {}
  }

  static String currentDate() {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    String formattedDate = dateFormat.format(now);
    return formattedDate;
  }

  static String randomNumber(int length) {
    const uuid = Uuid();
    final randomUuid = uuid.v4().toString().substring(0, length);
    return randomUuid;
  }

  static DateTime textToDateTime(String dateString) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.parse(dateString);
  }

  static String getGender(String gender) {
    switch (gender) {
      case "MALE" :
        return "Male";
      case "FEMALE" :
        return "Female";
      default:
        return "Other";
    }
  }

  static String getGenderImage(String gender) {
    switch (gender) {
      case "Male":
        return AppAssetsPath.icMale;
      case "Female":
        return AppAssetsPath.icFemale;
      default:
        return AppAssetsPath.icTransgender;
    }
  }

  static List<String> convertStringToListOfNames(String inputString) {
    String cleanedInput = inputString.replaceAll(RegExp(r'[\[\]\{\}]'), '');


    List<String> mapRepresentations = customSplit(cleanedInput);

    List<String> namesList = [];

    for (String mapRepresentation in mapRepresentations) {
      List<String> keyValue = mapRepresentation.split(':');

      if (keyValue.length == 2) {
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();

        if (key == "name") {
          String name = value.replaceAll(RegExp(r'^[\"\"]|[\"\"]$'), '').trim();
          namesList.add(name);
        }
      }
    }
    return namesList;
  }

  static List<String> customSplit(String input) {
    List<String> result = [];
    int bracketCount = 0;
    StringBuffer currentChunk = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      if (input[i] == '(') {
        bracketCount++;
      } else if (input[i] == ')') {
        bracketCount--;
      }

      if (input[i] == ',' && bracketCount == 0) {
        result.add(currentChunk.toString().trim());
        currentChunk.clear();
      } else {
        currentChunk.write(input[i]);
      }
    }
    result.add(currentChunk.toString().trim());

    return result;
  }

  static List<String> convertStringToListOfIds(String inputString) {
    String cleanedInput = inputString.replaceAll(RegExp(r'[\[\]\{\}]'), '');


    List<String> mapRepresentations = cleanedInput.split(',');

    List<String> namesList = [];

    for (String mapRepresentation in mapRepresentations) {
      List<String> keyValue = mapRepresentation.split(':');

      if (keyValue.length == 2) {
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();

        if (key == "id") {
          String name = value.replaceAll(RegExp(r'^[\"\"]|[\"\"]$'), '').trim();
          namesList.add(name);
        }
      }
    }
    return namesList;
  }

  static List<String> convertStringToList(String input) {
    List<String> result = [];
    StringBuffer currentWord = StringBuffer();
    bool insideParentheses = false;

    for (int i = 0; i < input.length; i++) {
      final char = input[i];

      if (char == '(') {
        insideParentheses = true;
      } else if (char == ')') {
        insideParentheses = false;
      }

      if (char == ',' && !insideParentheses) {
        if (currentWord.isNotEmpty) {
          result.add(currentWord.toString().trim());
          currentWord.clear();
        }
      } else {
        currentWord.write(char);
      }
    }

    if (currentWord.isNotEmpty) {
      result.add(currentWord.toString().trim());
    }

    if (result.isNotEmpty) {
      result[0] = result[0].replaceAll('[', '');
      result[result.length - 1] = result[result.length - 1].replaceAll(']', '');
    }

    return result;
  }
}
