import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:probeintegration/services/probe_bluetooth_service.dart';
import 'package:probeintegration/probeintegration.dart';
import 'package:probeintegration/utils/probe_constants.dart';

class ProbeController {
  ProbeController._();
  static ProbeController _obj = ProbeController._();
  factory ProbeController() => _obj;

  StreamController<BluetoothAdapterState> bluetoothAdapterStateStream = StreamController.broadcast();
  StreamController<BluetoothConnectionState> probeStateStream = StreamController.broadcast();
  StreamController<bool> scanningStream = StreamController.broadcast();
  StreamController<bool> LEDStream = StreamController.broadcast();
  StreamController<bool> UVStream = StreamController.broadcast();
  StreamController<String> batteryStream = StreamController.broadcast();
  StreamController<String> captureStream = StreamController.broadcast();

  late BluetoothService oralProbeBleService;
  late BluetoothCharacteristic oralProbeBleTxCharacteristic;
  BluetoothCharacteristic? oralProbeBleRxCharacteristic;

  init() {
    ProbeBluetoothService().init();
  }

  dispose() {
    setInitialStatus();
    ProbeBluetoothService().dispose();
  }

  Future<void> turnOnTorch() async {
    await _sendCommand(ProbeConstants.PROBE_HARDWARE_PERIPHERAL_WHITE_LED_ON);
  }

  Future<void> turnOffTorch() async {
    await _sendCommand(ProbeConstants.PROBE_HARDWARE_PERIPHERAL_WHITE_LED_OFF);
  }

  Future<void> turnOnUV() async {
    await _sendCommand(ProbeConstants.PROBE_HARDWARE_PERIPHERAL_UV_LED_ON);
  }

  Future<void> turnOffUV() async {
    await _sendCommand(ProbeConstants.PROBE_HARDWARE_PERIPHERAL_UV_LED_OFF);
  }

  Future<void> captureImage() async {
    await _sendCommand(ProbeConstants.PROBE_HARDWARE_PERIPHERAL_CAMERA_PRESS);
  }

  setInitialStatus() {
    turnOffTorch();
    turnOffUV();
  }

  _sendCommand(String commandCode) async {
    log("Command ${commandCode}");
    try {
      if (oralProbeBleRxCharacteristic != null) {
        await oralProbeBleRxCharacteristic?.write(ascii.encode(commandCode));
      }
    } catch (e) {}
  }

  Future<void> processImages(String imageOnePath, String imageTwoPath) async {
    String processStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      processStatus = await Probeintegration().processCapturedImage(imageOnePath, imageTwoPath) ?? 'Unknown Process Status';
    } on PlatformException {
      processStatus = 'Failed to get platform version.';
      //TBD: Handle Image Processing Errors
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    log("- - ${processStatus}");
  }
}
