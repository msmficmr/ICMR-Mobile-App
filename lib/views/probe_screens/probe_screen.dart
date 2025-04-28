import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:probeintegration/services/probe_provider.dart';
import 'package:probeintegration/utils/exceptions.dart';
import 'package:provider/provider.dart';

class ProbeScreen extends StatefulWidget {
  static String routerPath = "/probe";

  const ProbeScreen({super.key});

  @override
  State<ProbeScreen> createState() => _ProbeScreenState();
}

class _ProbeScreenState extends State<ProbeScreen> {
  ValueNotifier<bool> _isInitialized = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
  }

  void onError(String message, Object e) {
    log("${message} ${e.runtimeType}");
    switch (e.runtimeType) {
      case BluetoothPermanentlyPermissionException:
        CommonFunctions.openDialog(
          context: context,
          action: (context) {
            CommonFunctions.openAppSettings();
            Navigator.pop(context);
          },
          subtitle: "We require bluetooth permission to use this feature. Please grant bluetooth permissions in your app settings.",
          buttonText: "Grant permission",
        );
        break;
      case CameraPermanentlyPermissionException:
        CommonFunctions.openDialog(
          context: context,
          action: (context) {
            CommonFunctions.openAppSettings();
            Navigator.pop(context);
          },
          subtitle: "We require camera permission to use this feature. Please grant camera permissions in your app settings.",
          buttonText: "Grant permission",
        );
        break;
      case StoragePermanentlyPermissionException:
      CommonFunctions.openDialog(
          context: context,
          action: (context) {
            CommonFunctions.openAppSettings();
            Navigator.pop(context);
          },
          subtitle: "We require storage permission to use this feature. Please grant storage permissions in your app settings.",
          buttonText: "Grant permission",
        );
        break;
    }
  }

  void onCaptureSuccess(Map<String, Uint8List> data) {
    log("capture size ${data.length}");
    CommonFunctions.toastMessage("capture size ${data.length}");
  }

  init() async {
    try {
      await context.read<ProbeProvider>().initialize(context, onError, onCaptureSuccess);
    } catch (e) {
      log("ERROR");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            MaterialButton(
              onPressed: init,
              child: const Text("initialize"),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text("ON"),
            ),
          ],
        ),
      ),
    );
  }
}
