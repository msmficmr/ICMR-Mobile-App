import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/encrypt_helper.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DirectoryDbService {
  static bool isEncryptionEnabled = false;
  static String fileExtension = ".json";

  Future<bool> savePatient(PatientRegistration patientRegistration) async {
    Map<String, dynamic> data = patientRegistration.objectToJson();
    bool? isSuccess = await _writeListToExternalStorage(data);
    return isSuccess ?? false;
  }

  Future<List<PatientRegistration>> getAllPatients() async {
    String selectedDirectory = await _getBasePath();
    List<Map<String, dynamic>> patientMapList = await _getPatients(selectedDirectory);
    List<PatientRegistration> details = [];
    for (var map in patientMapList) {
      try {
        PatientRegistration patientObj = PatientRegistration.fromJson(map);
        if (details.any((element) => element.primaryId == patientObj.primaryId)) {
          continue;
        }

        details.add(patientObj);
      } catch (e) {}
    }
    return details;
  }

  Future<bool?> _writeListToExternalStorage(Map<String, dynamic> data) async {
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
    Map<String, dynamic> jsonData = message['data'];

    try {
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
        sendPort.send(true);
      } else {
        sendPort.send(false);
      }
    } catch (e) {
      sendPort.send(false);
    }
  }

  static Future<String> _getBasePath() async {
    Directory? dir = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();

    String basePath = dir?.path ?? "";

    /* String pattern = Platform.isAndroid ? "/" : "\\";

    String basePath = dir?.path.split(pattern).sublist(0, 4).join("/") ?? "";
    if (basePath.endsWith("/")) {
      basePath = basePath.substring(0, basePath.length - 2);
    } */

    return "${basePath}/mhealth/";
  }

  static Future<String?> _createFolder(String folderName) async {
    try {
      String basePath = await _getBasePath();

      String orgDirectory = "$basePath$folderName";
      Directory newDirectory = Directory(orgDirectory);
      if (!await newDirectory.exists()) {
        await newDirectory.create(recursive: true);
      }
      return orgDirectory;
    } finally {}
  }

  ///read
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
    List<Map<String, dynamic>> data = [];
    if (directory.existsSync()) {
      final List<FileSystemEntity> entities = directory.listSync();

      // Filter only directories
      final directories = entities.whereType<Directory>();

      // Print all directories
      for (var dir in directories) {
        String directoryName = path.basename(dir.path);

        bool hasMatch = AppValues.primaryIdPattern.hasMatch(directoryName);

        if (hasMatch) {
          String filePath = "${dir.path}/patient_data${fileExtension}";
          File file = new File(filePath);
          if (file.existsSync()) {
            try {
              String encryptedText = await file.readAsString();
              String decrypted = isEncryptionEnabled ? EncryptionHelper.decryptText(encryptedText) : encryptedText;
              data.add(jsonDecode(decrypted));
            } catch (e) {
              //sendPort.send(AppException(null, "Invalid files", null));
              //break;
            }
          }
        }
      }
    }
    sendPort.send(data);
  }

  Future<bool> markPatientSynced(PatientRegistration patientRegistration) async {
    return await savePatient(patientRegistration);
  }
}
