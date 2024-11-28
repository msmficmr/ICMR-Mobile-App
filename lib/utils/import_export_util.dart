import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/services/permission_service.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/encrypt_helper.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImportExportUtil {
  final BuildContext context;
  ImportExportUtil({required this.context});

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  static bool isEncryptionEnabled = false;
  static String fileExtension = ".json";

  Future<bool> exportPatients() async {
    bool success = false;
    try {
      bool storagePermission = await PermissionService.requestStoragePermission(context);
      if (storagePermission) {
        isLoading.value = true;
        List<Map<String, dynamic>> data = await _runExportIsolate();

        bool? result = await _writeListToExternalStorage(data);
        if (result != null && result) {
          CommonFunctions.toastMessage("Data has been exported successfully.");
        }
      } else {
        CommonFunctions.toastMessage("Permission Denied");
      }
    } catch (e) {
      CommonFunctions.toastMessage("Something went wrong");
    } finally {
      isLoading.value = false;
    }

    return success;
  }

  Future<bool?> importPatients() async {
    try {
      bool storagePermission = await PermissionService.requestStoragePermission(context);
      if (storagePermission) {
        String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
        if (selectedDirectory != null) {
          List<Map<String, dynamic>> data = await _getPatients(selectedDirectory);
          _validateJson(data);
          bool isSuccess = await _writeToDb(data);
          if (isSuccess) {
            CommonFunctions.toastMessage("Data has been imported successfully.");
            return isSuccess;
          } else {
            CommonFunctions.toastMessage("Something went wrong");
          }
        }
      } else {
        CommonFunctions.toastMessage("Permission Denied");
      }
    } catch (e) {
      if (e.runtimeType == AppException) {
        CommonFunctions.toastMessage((e as AppException).message ?? "");
      } else {
        CommonFunctions.toastMessage("Something went wrong");
      }
    }
    return null;
  }

  Future<bool> _validateJson(List<Map<String, dynamic>> json) async {
    try {
      for (var data in json) {
        PatientRegistration.fromJson(data);
      }
    } catch (e) {
      throw AppException(null, "Invalid data found in file", null);
    }

    return true;
  }

  Future<bool> _writeToDb(List<Map<String, dynamic>> data) async {
    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    ReceivePort receivePort = ReceivePort();
    Completer<bool> completer = Completer();

    await Isolate.spawn(setDataToIsolate, {'sendPort': receivePort.sendPort, "rootIsolateToken": rootIsolateToken, "data": data});

    // Listen for messages from the isolate
    receivePort.listen((message) {
      if (message is bool) {
        if (message) {
          completer.complete(message);
        } else {
          completer.completeError(false);
        }
      } else {
        completer.completeError(message);
      }
      receivePort.close(); // Close the port when done
    });

    return completer.future;
  }

  //reading folder
  Future<List<Map<String, dynamic>>> _getPatients(String selectedDirectory) async {
    Completer<List<Map<String, dynamic>>> completer = Completer();
    ReceivePort receivePort = ReceivePort();
    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    await Isolate.spawn(_readFolder, {
      'sendPort': receivePort.sendPort,
      "rootIsolateToken": rootIsolateToken,
      "directory": selectedDirectory,
    });

    receivePort.listen((message) {
      if (message is List<Map<String, dynamic>>) {
        completer.complete(message);
      } else {
        completer.completeError(message);
      }
      receivePort.close();
    });

    return completer.future;
  }

  static void _readFolder(Map<String, dynamic> message) async {
    SendPort sendPort = message['sendPort'];
    var rootIsolateToken = message['rootIsolateToken'];
    String basePath = message["directory"];
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken!);
    final directory = Directory(basePath);
    final List<FileSystemEntity> entities = directory.listSync();

    // Filter only directories
    final directories = entities.whereType<Directory>();
    List<Map<String, dynamic>> data = [];
    if (directories.isEmpty) {
      sendPort.send(AppException(null, "Folder that you have selected does not contain any data", null));
      return;
    }
    // Print all directories
    for (var dir in directories) {
      String filePath = "${dir.path}/patient_data${fileExtension}";
      File file = new File(filePath);
      if (file.existsSync()) {
        try {
          String encryptedText = await file.readAsString();
          String decrypted = isEncryptionEnabled ? EncryptionHelper.decryptText(encryptedText) : encryptedText;
          data.add(jsonDecode(decrypted));
        } catch (e) {
          sendPort.send(AppException(null, "Invalid files", null));
          break;
        }
      } else {
        sendPort.send(AppException(null, "Invalid folder selected", null));
        break;
      }
    }
    sendPort.send(data);
  }

  //Writing folder

  static Future<String?> _createFolder(String folderName) async {
    PermissionStatus externalStorage = await Permission.manageExternalStorage.request();

    if (externalStorage.isGranted) {
      try {
        Directory? dir = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();

        String pattern = Platform.isAndroid ? "/" : "\\";

        String basePath = dir?.path.split(pattern).sublist(0, 4).join("/") ?? "";
        if (basePath.endsWith("/")) {
          basePath = basePath.substring(0, basePath.length - 2);
        }
        String orgDirectory = "${basePath}/mhealth/$folderName";
        Directory newDirectory = Directory(orgDirectory);
        if (!await newDirectory.exists()) {
          await newDirectory.create(recursive: true);
        }
        return orgDirectory;
      } finally {}
    } else {
      CommonFunctions.toastMessage("Permission not granted");
    }
    return null;
  }

  Future<bool?> _writeListToExternalStorage(List<Map<String, dynamic>> data) async {
    Completer<bool> completer = Completer();
    ReceivePort receivePort = ReceivePort();
    try {
      RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

      await Isolate.spawn(_writeFile, {
        'sendPort': receivePort.sendPort,
        "rootIsolateToken": rootIsolateToken,
        "data": data,
      });

      // Listen for messages from the isolate
      receivePort.listen((message) {
        if (message is bool) {
          completer.complete(message);
        } else {
          completer.completeError(false);
        }
        receivePort.close();
      });
    } finally {}
    return completer.future;
  }

  static void _writeFile(Map<String, dynamic> message) async {
    SendPort sendPort = message['sendPort'];
    var rootIsolateToken = message['rootIsolateToken'];
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken!);
    List<Map<String, dynamic>> data = message['data'];

    try {
      for (var jsonData in data) {
        String primaryId = jsonData["primaryId"];

        String? basePath = await _createFolder(primaryId);
        if (basePath != null) {
          String filePath = "";
          if (basePath.endsWith("/")) {
            filePath = "${basePath}patient_data$fileExtension";
          } else {
            filePath = "$basePath/patient_data$fileExtension";
          }

          String jsonString = jsonEncode(jsonData); // Convert to JSON string

          String encryptedData = isEncryptionEnabled ? EncryptionHelper.encryptText(jsonString) : jsonString;

          // Write the data to the file
          final file = File(filePath);
          await file.writeAsString(encryptedData);
        } else {
          sendPort.send(false);
          break;
        }
      }
      sendPort.send(true);
    } catch (e) {
      sendPort.send(false);
    }
  }

  Future<List<Map<String, dynamic>>> _runExportIsolate() async {
    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    ReceivePort receivePort = ReceivePort();
    Completer<List<Map<String, dynamic>>> completer = Completer();
    await Isolate.spawn(getDataFromIsolate, {'sendPort': receivePort.sendPort, "rootIsolateToken": rootIsolateToken});

    // Listen for messages from the isolate
    receivePort.listen((message) {
      if (message is List<Map<String, dynamic>>) {
        completer.complete(message);
      } else {
        completer.completeError(message);
      }
      receivePort.close(); // Close the port when done
    });

    return completer.future;
  }

  static void getDataFromIsolate(Map<String, dynamic> message) async {
    SendPort sendPort = message['sendPort'];
    var rootIsolateToken = message['rootIsolateToken'];
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken!);
    Isar db = await IsarDbService.isarDbService.isar;
    List<Map<String, dynamic>> data = await db.patientRegistrations.where().exportJson();

    sendPort.send(data);
  }

  static void setDataToIsolate(Map<String, dynamic> message) async {
    SendPort sendPort = message['sendPort'];
    var rootIsolateToken = message['rootIsolateToken'];
    List<Map<String, dynamic>> data = message["data"];

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken!);
    try {
      Isar db = await IsarDbService.isarDbService.isar;
      await db.writeTxn(
        () async {
          await db.patientRegistrations.importJson(data);
        },
      );

      sendPort.send(true);
    } catch (error) {
      sendPort.send(false);
    }
  }
}
