import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:probeintegration/services/probe_controller.dart';
import 'package:probeintegration/utils/exceptions.dart';
import 'package:probeintegration/utils/probe_constants.dart';

class ProbeBluetoothService {
  ProbeBluetoothService._();
  static ProbeBluetoothService _obj = ProbeBluetoothService._();
  factory ProbeBluetoothService() => _obj;

  StreamSubscription<BluetoothAdapterState>? bluetoothAdapterStateSubscription;
  StreamSubscription<List<ScanResult>>? bluetoothScanResultSubscription;
  StreamSubscription<bool>? bluetoothIsScanningSubscription;
  StreamSubscription<BluetoothConnectionState>? probeDeviceSubscription;
  StreamSubscription<List<int>>? probeCharacteristicsSubscription;
  BluetoothDevice? probeDevice;

  var batteryVoltageHigh = 4;
  var batteryVoltageLow = 3.3;
  String _batteryLevel = 'Unknown';

  Future<bool> init() async {
    probeDevice = null;
    if (await FlutterBluePlus.isSupported == false) {
      throw Exception("Bluetooth is not supported on this device");
    }
    await bluetoothAdapterStateSubscription?.cancel();

    bluetoothAdapterStateSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      log("adapter state change ${state}");
      ProbeController().bluetoothAdapterStateStream.sink.add(state);
      switch (state) {
        case BluetoothAdapterState.unknown:
        case BluetoothAdapterState.unavailable:
        case BluetoothAdapterState.unauthorized:
        case BluetoothAdapterState.turningOn:
        case BluetoothAdapterState.turningOff:
          break;
        case BluetoothAdapterState.on:
          _scanBluetoothDevices();
          break;
        case BluetoothAdapterState.off:
          break;
      }
    });
    if (Platform.isAndroid) {
      try {
        await FlutterBluePlus.turnOn();
        return true;
      } on PlatformException catch (e) {
        if (e.message!.contains("permission")) {
          throw PermissionException("Permission required");
        }
      } on FlutterBluePlusException catch (_) {
        throw BluetoothOffException();
      } catch (e) {
        rethrow;
      }
    }
    return false;
  }

  List<BluetoothDevice> getConnectedDevices() => FlutterBluePlus.connectedDevices;

  _scanBluetoothDevices() async {
    List<BluetoothDevice> connectedDevice = getConnectedDevices();
    if (connectedDevice.isNotEmpty) {
      /// Bluetooth is already connected
      /// check if probe device is connected
      bool isDeviceFound = _checkProbeDevice(connectedDevice);
      if (isDeviceFound) {
        return;
      }
    }
    await bluetoothScanResultSubscription?.cancel();
    await bluetoothIsScanningSubscription?.cancel();

    bluetoothScanResultSubscription = FlutterBluePlus.onScanResults.listen((results) {
      //
      bool isResultContains = results.map((e) => e.device.platformName).any(
        (element) {
          return element.contains(ProbeConstants.oralProbeBLEHardwareID);
        },
      );

      if (isResultContains) {
        _checkProbeDevice(results.map((e) => e.device).toList());
        bluetoothScanResultSubscription?.cancel();
      }
    });

    bluetoothIsScanningSubscription = FlutterBluePlus.isScanning.listen((bool event) {
      log("message $event");
      ProbeController().scanningStream.sink.add(event);
    });

    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 15),
    );
  }

  bool _checkProbeDevice(List<BluetoothDevice> results) {
    bool isFound = false;
    for (int i = 0; i < results.length; i++) {
      String deviceName = results[i].platformName;
      if (deviceName.contains(ProbeConstants.oralProbeBLEHardwareID)) {
        _connect(results[i]);
        isFound = true;
        break;
      }
    }
    return isFound;
  }

  _connect(BluetoothDevice device) async {
    probeDeviceSubscription?.cancel();

    probeDeviceSubscription = device.connectionState.listen((BluetoothConnectionState event) {
      switch (event) {
        case BluetoothConnectionState.disconnected:
          log("probe disconnected ");
          probeDevice = null;
          ProbeController().probeStateStream.sink.add(BluetoothConnectionState.disconnected);
          //
          break;
        case BluetoothConnectionState.connected:
          log("probe connected ");
          probeDevice = device;
          ProbeController().probeStateStream.sink.add(BluetoothConnectionState.connected);
          //
          _discoverProbeServices();
          break;
        default:
          break;
      }
    });

    if (device.isConnected) {
      return;
    }
    await device.connect(timeout: const Duration(seconds: 15));
  }

  void _discoverProbeServices() async {
    if (probeDevice != null) {
      List<BluetoothService> services = await probeDevice!.discoverServices();
      for (BluetoothService service in services) {
        Guid uuid = service.uuid;
        if (uuid.str.startsWith(ProbeConstants.oralProbeBleServiceID)) {
          ProbeController().oralProbeBleService = service;
          //assign service
          List<BluetoothCharacteristic> characteristics = service.characteristics;
          for (BluetoothCharacteristic characteristic in characteristics) {
            Guid characteristicUUID = characteristic.uuid;
            if (characteristicUUID.str.startsWith(ProbeConstants.oralProbeBleTxCharacteristicsID)) {
              // assign tx characteristics
              ProbeController().oralProbeBleTxCharacteristic = characteristic;
              _subscribeToBLECharacteristics(characteristic);
            }
            if (characteristicUUID.str.startsWith(ProbeConstants.oralProbeBleRxCharacteristicsID)) {
              // assign rx characteristics
              ProbeController().oralProbeBleRxCharacteristic = characteristic;
            }
          }
        }
      }
    }
  }

  Future<void> _subscribeToBLECharacteristics(BluetoothCharacteristic characteristic) async {
    log("subscribed to events");
    probeCharacteristicsSubscription?.cancel();
    probeCharacteristicsSubscription = characteristic.lastValueStream.listen((value) {
      _handleProbeEvent(String.fromCharCodes(value));
    });
    await characteristic.setNotifyValue(true);
  }

  _handleProbeEvent(String event) {
    log("receved event ${event}");
    switch (event) {
      case ProbeConstants.PROBE_HARDWARE_LED_ON_STATUS:
        ProbeController().LEDStream.sink.add(true);
        break;
      case ProbeConstants.PROBE_HARDWARE_LED_OFF_STATUS:
        ProbeController().LEDStream.sink.add(false);
        break;
      case ProbeConstants.PROBE_HARDWARE_UV_LED_ON_STATUS:
        ProbeController().UVStream.sink.add(true);
        break;
      case ProbeConstants.PROBE_HARDWARE_UV_LED_OFF_STATUS:
        ProbeController().UVStream.sink.add(false);
        break;
      case ProbeConstants.PROBE_HARDWARE_EVENT_PHOTO_CAPTURE_BUTTON_PRESSED:
      case ProbeConstants.PROBE_HARDWARE_CAMERA_STATUS:
        ProbeController().captureStream.sink.add(event);
        break;
      default:
        break;
    }
    if (event.contains(ProbeConstants.PROBE_HARDWARE_STATUS_BATTERY_LEVEL)) {
      updateBatteryLevel(event);
    }
  }

  updateBatteryLevel(String batteryLevelRaw) {
    String batteryLevelNew = _batteryLevel; //Last Battery Level as default value.
    var list = batteryLevelRaw.split('~'); //Example H~B~XX.X~V
    batteryLevelNew = list[2];
    var batteryVoltage = double.parse(batteryLevelNew);
    //https://www.geeksforgeeks.org/how-to-find-the-percentage-of-a-number-between-two-numbers/
    batteryVoltage = ((batteryVoltage - batteryVoltageLow) / (batteryVoltageHigh - batteryVoltageLow) * 100);
    batteryLevelNew = batteryVoltage.round().toString();
    _batteryLevel = batteryLevelNew;
    ProbeController().batteryStream.sink.add(_batteryLevel);
  }

  _disconnectDevice() async {
    if (probeDevice != null) {
      await probeDevice?.disconnect();
    }
  }

  dispose() async {
    probeDevice = null;
    await bluetoothAdapterStateSubscription?.cancel();
    await bluetoothScanResultSubscription?.cancel();
    await bluetoothIsScanningSubscription?.cancel();
    await probeDeviceSubscription?.cancel();
    await probeCharacteristicsSubscription?.cancel();
    await _disconnectDevice();
  }
}
