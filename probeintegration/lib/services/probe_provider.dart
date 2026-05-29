import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_uvc_camera/flutter_uvc_camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:probeintegration/services/probe_bluetooth_service.dart';
import 'package:probeintegration/services/probe_controller.dart';
import 'package:probeintegration/probeintegration.dart';
import 'package:probeintegration/utils/exceptions.dart';
import 'package:probeintegration/utils/probe_enums.dart';
import 'package:probeintegration/utils/probe_methods.dart';
import 'package:probeintegration/widgets/widget_error.dart';
import 'package:provider/provider.dart';

enum ProbeNewEnum {
  none,
  error,
  success,
  bluetoothOff,
  deviceNotConnected,
  deviceConnected,
  scanningDevice,
  bluetoothPermissionDenied,
  cameraPermissionDenied,
  storagePermissionDenied,
  usbDisconnected,
  usbPermissionDenied
}

typedef OnProbeCallback = void Function(String message, Object e);
typedef OnProbeSuccessCallback = void Function(Map<String, Uint8List> images);

class ProbeProvider extends ChangeNotifier {
  ProbeProvider._();
  static ProbeProvider _obj = ProbeProvider._();
  factory ProbeProvider() => _obj;
  ProbeNewEnum _state = ProbeNewEnum.none;

  BluetoothAdapterState _bluetooth = BluetoothAdapterState.off;

  UVCCameraController? _cameraController;
  bool _LEDStatus = false;
  bool _UVStatus = false;
  String _batteryLevel = "";
  bool _isCapturing = false;

  UVCCameraController? get cameraController => _cameraController;
  BluetoothAdapterState get bluetooth => _bluetooth;
  ProbeNewEnum get state => _state;
  bool get LEDStatus => _LEDStatus;
  bool get UVStatus => _UVStatus;
  String get batteryLevel => _batteryLevel;
  bool get isCapturing => _isCapturing;

  set isCapturing(bool status) {
    _isCapturing = status;
    notifyListeners();
  }

  set batteryLevel(String status) {
    _batteryLevel = status;
    notifyListeners();
  }

  set LEDStatus(bool status) {
    _LEDStatus = status;
    notifyListeners();
  }

  set UVStatus(bool status) {
    _UVStatus = status;
    notifyListeners();
  }

  set cameraController(UVCCameraController? controller) {
    _cameraController = controller;
    notifyListeners();
  }

  set state(ProbeNewEnum s) {
    _state = s;
    notifyListeners();
  }

  set bluetooth(BluetoothAdapterState value) {
    _bluetooth = value;
    notifyListeners();
  }

  resetStatus() {
    _state = ProbeNewEnum.none;
    _LEDStatus = false;
    _UVStatus = false;
    _isCapturing = false;
  }

  StreamSubscription<String>? _usbSubscription;
  late OnProbeCallback theProbeCallBack;
  late OnProbeSuccessCallback theSuccessCallback;
  late BuildContext theContext;
  initialize(BuildContext aContext, OnProbeCallback function, OnProbeSuccessCallback aSuccessCallback) async {
    theProbeCallBack = function;
    theSuccessCallback = aSuccessCallback;
    theContext = aContext;

    resetStatus();
    try {
      showProbeDialog();
      listenToProbeEvents();
      await initDevice();
    } catch (e) {
      theProbeCallBack("Something Went Wrong", e);
    }
  }

  retry() async {
    try {
      resetStatus();

      await ProbeController().dispose();
      await initDevice();
    } catch (e) {
      theProbeCallBack("Something Went Wrong", e);
    }
  }

  initDevice() async {
    try {
      await _checkBluetoothPermission();
      await _checkCameraPermission();
      await ProbeController().init();
      await _checkCamera();
    } on BluetoothPermissionException {
      state = ProbeNewEnum.bluetoothPermissionDenied;
    } on BluetoothPermanentlyPermissionException catch (e) {
      state = ProbeNewEnum.bluetoothPermissionDenied;
      theProbeCallBack("Please grant bluetooth permission", e);
    } on CameraPermissionException {
      state = ProbeNewEnum.cameraPermissionDenied;
    } on CameraPermanentlyPermissionException catch (e) {
      state = ProbeNewEnum.cameraPermissionDenied;
      theProbeCallBack("Please grant camera permission", e);
    } on StoragePermissionException {
      state = ProbeNewEnum.storagePermissionDenied;
    } on StoragePermanentlyPermissionException catch (e) {
      state = ProbeNewEnum.storagePermissionDenied;
      theProbeCallBack("Please grant storage permission", e);
    } on USBDeviceNotAvailablePermissionException catch (_) {
      state = ProbeNewEnum.usbDisconnected;
    } catch (ex, s) {
      log("message $s");
      state = ProbeNewEnum.error;
      theProbeCallBack("Something went wrong", ex);
    }
  }

  _checkBluetoothPermission() async {
    try {
      PermissionStatus bluetoothConnectStatus = await Permission.bluetoothConnect.request();
      if (bluetoothConnectStatus.isDenied) {
        throw BluetoothPermissionException();
      }
      if (bluetoothConnectStatus.isPermanentlyDenied) {
        throw BluetoothPermanentlyPermissionException();
      }
    } catch (e) {
      rethrow;
    }
  }

  _checkCameraPermission() async {
    try {
      PermissionStatus cameraStatus = await Permission.camera.request();
      if (cameraStatus.isDenied) {
        throw CameraPermissionException();
      }
      if (cameraStatus.isPermanentlyDenied) {
        throw CameraPermanentlyPermissionException();
      }
      /* PermissionStatus photosStorageStatus = await Permission.storage.request();
      if (photosStorageStatus.isDenied) {
        throw StoragePermissionException();
      }
      if (photosStorageStatus.isPermanentlyDenied) {
        throw StoragePermanentlyPermissionException();
      } */
    } catch (e) {
      rethrow;
    }
  }

  _checkCamera() async {
    log("message check camera");
    _usbSubscription?.cancel();
    _usbSubscription = Probeintegration.usbEvents.listen((event) async{
      log("usb status ${event}");
      switch (event) {
        case "USB_ATTACHED":
        case "USB_DISCONNECTED":
          state = ProbeNewEnum.usbDisconnected;
          break;
        case "USB_PERMISSION_GRANTED":
          if (ProbeBluetoothService().probeDevice == null) {
            state = ProbeNewEnum.deviceNotConnected;
          } else {
            initCamera();
            state = ProbeNewEnum.deviceConnected;
          }
          break;
        case "USB_PERMISSION_DENIED":
          state = ProbeNewEnum.usbPermissionDenied;
          break;
      }
    });
    Map<String, String> devices = await Probeintegration().checkUSBDevice();
    log("devices ${devices}");
    if (devices.isEmpty) {
      throw USBDeviceNotAvailablePermissionException();
    } else {
      await Probeintegration().requestUSBPermission();
    }
  }

  initCamera() async {
    log("param ");
    ProbeController().setInitialStatus();
    cameraController = UVCCameraController();
    log("camera initialized  ");
  }

  listenToProbeEvents() {
    ProbeController().bluetoothAdapterStateStream.stream.listen((event) {
      if (event == BluetoothAdapterState.off) {
        state = ProbeNewEnum.bluetoothOff;
      }
    });
    ProbeController().probeStateStream.stream.listen((event) async {
      if (event == BluetoothConnectionState.connected) {
        Map<String, String> devices = await Probeintegration().checkUSBDevice();
        if (devices.isEmpty) {
          state = ProbeNewEnum.usbDisconnected;
        } else {
          bool hasUSBPermission = await Probeintegration().hasUSBPermission();
          if (hasUSBPermission) {
            initCamera();
            state = ProbeNewEnum.deviceConnected;
          } else {
            state = ProbeNewEnum.usbPermissionDenied;
          }
        }
      } else {
        state = ProbeNewEnum.deviceNotConnected;
      }
    });
    ProbeController().scanningStream.stream.listen((event) async {
      if (event) {
        if (ProbeBluetoothService().probeDevice == null) {
          state = ProbeNewEnum.scanningDevice;
        } else {
          Map<String, String> devices = await Probeintegration().checkUSBDevice();
          if (devices.isEmpty) {
            state = ProbeNewEnum.usbDisconnected;
          } else {
            bool hasUSBPermission = await Probeintegration().hasUSBPermission();
            if (hasUSBPermission) {
              initCamera();
              state = ProbeNewEnum.deviceConnected;
            } else {
              state = ProbeNewEnum.usbPermissionDenied;
            }
          }
        }
      } else {
        if (ProbeBluetoothService().probeDevice == null) {
          state = ProbeNewEnum.deviceNotConnected;
        } else {
          Map<String, String> devices = await Probeintegration().checkUSBDevice();
          if (devices.isEmpty) {
            state = ProbeNewEnum.usbDisconnected;
          } else {
            bool hasUSBPermission = await Probeintegration().hasUSBPermission();
            log("222 ${hasUSBPermission}");
            if (hasUSBPermission) {
              initCamera();
              state = ProbeNewEnum.deviceConnected;
            } else {
              state = ProbeNewEnum.usbPermissionDenied;
            }
          }
        }
      }
    });

    ProbeController().UVStream.stream.listen((event) {
      UVStatus = event;
    });

    ProbeController().LEDStream.stream.listen((event) {
      LEDStatus = event;
    });
    ProbeController().batteryStream.stream.listen((event) {
      batteryLevel = event;
    });

    ProbeController().captureStream.stream.listen((event) {
      _capturePhoto();
    });
  }

  _capturePhoto() async {
    if (_isCapturing) return;
    isCapturing = true;
    try {
      var ledOnTime = const Duration(milliseconds: 1300);
      var imageCaptureDelay = const Duration(milliseconds: 500);

      /// Turn on LED
      await ProbeController().turnOnTorch();

      /// waiting till led is on
      await Future<void>.delayed(ledOnTime);

      /// Capture Image
      String? imageOnePath = await cameraController?.takePicture();
      if (imageOnePath == null) {
        throw Exception("Unable to capture Image");
      }
      Probeintegration().playShutterSound();
      await Future<void>.delayed(imageCaptureDelay);
      await ProbeController().turnOffTorch();
      await Future<void>.delayed(imageCaptureDelay);
      await ProbeController().turnOnUV();

      /// waiting till led is on
      await Future<void>.delayed(ledOnTime);
      String? imageTwoPath = await cameraController?.takePicture();

      if (imageTwoPath == null) {
        throw Exception("Unable to capture Image");
      }
      await Probeintegration().playShutterSound();
      await Future<void>.delayed(imageCaptureDelay);
      await ProbeController().turnOffUV();

      if (imageOnePath.isNotEmpty && imageTwoPath.isNotEmpty) {
        Map<String, Uint8List>? result = await Probeintegration().processCapturedImageInBytes(imageOnePath, imageTwoPath);
        if (result != null) {
          //ProbeMethods.showToast("Images captured successfully", true);
          theSuccessCallback(result);
          if (theContext.mounted) {
            Navigator.pop(theContext, result);
          }
        } else {
          ProbeMethods.showToast("Unable to capture images", false);
        }
      }
    } catch (e) {
      ProbeMethods.showToast("Unable to capture images", false);
    }
    isCapturing = false;
  }

  showProbeDialog() async {
    await showDialog(
      context: theContext,
      builder: (context) {
        return Material(
          child: SafeArea(
            child: Column(
              children: [
                AppBar(
                  foregroundColor: Colors.black,
                  title: Text("Capture Probe Image", style: Theme.of(context).textTheme.titleMedium),
                  centerTitle: false,
                ),
                Expanded(
                  child: Selector<ProbeProvider, ProbeNewEnum>(
                      selector: (p0, p1) => p1.state,
                      builder: (context, value, _) {
                        switch (value) {
                          case ProbeNewEnum.usbPermissionDenied:
                            return WidgetError(
                              onRetry: retry,
                              type: WidgetEnums.usbPermission,
                            );
                          case ProbeNewEnum.bluetoothPermissionDenied:
                            return WidgetError(
                              onRetry: retry,
                              type: WidgetEnums.bluetoothPermission,
                            );
                          case ProbeNewEnum.cameraPermissionDenied:
                            return WidgetError(
                              onRetry: retry,
                              type: WidgetEnums.cameraPermission,
                            );
                          case ProbeNewEnum.storagePermissionDenied:
                            return WidgetError(
                              onRetry: retry,
                              type: WidgetEnums.storagePermission,
                            );

                          case ProbeNewEnum.deviceConnected:
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Selector<ProbeProvider, UVCCameraController?>(
                                      selector: (p0, p1) => p1.cameraController,
                                      builder: (context, _, __) {
                                        return UVCCameraView(
                                          cameraController: _cameraController!,
                                          width: double.infinity,
                                          height: double.infinity,
                                          
                                        );
                                      }),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Selector<ProbeProvider, bool>(
                                          selector: (p0, p1) => p1.LEDStatus,
                                          builder: (context, _, __) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "LED",
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                ),
                                                const SizedBox(width: 5),
                                                CupertinoSwitch(
                                                  value: LEDStatus,
                                                  activeColor: Theme.of(context).primaryColor,
                                                  onChanged: (value) {
                                                    if (value) {
                                                      ProbeController().turnOnTorch();
                                                    } else {
                                                      ProbeController().turnOffTorch();
                                                    }
                                                  },
                                                )
                                              ],
                                            );
                                          }),
                                      const SizedBox(width: 10),
                                      Selector<ProbeProvider, bool>(
                                          selector: (p0, p1) => p1.UVStatus,
                                          builder: (context, _, __) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "UV",
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                ),
                                                const SizedBox(width: 5),
                                                CupertinoSwitch(
                                                  value: UVStatus,
                                                  activeColor: Theme.of(context).primaryColor,
                                                  onChanged: (value) {
                                                    if (value) {
                                                      ProbeController().turnOnUV();
                                                    } else {
                                                      ProbeController().turnOffUV();
                                                    }
                                                  },
                                                )
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Selector<ProbeProvider, bool>(
                                  selector: (p0, p1) => p1.isCapturing,
                                  builder: (context, value, child) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: FilledButton(
                                          onPressed: () {
                                            ProbeController().captureImage();
                                          },
                                          child: Text("Capture"),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          case ProbeNewEnum.scanningDevice:
                            return const WidgetError(
                              type: WidgetEnums.scanning,
                            );

                          case ProbeNewEnum.bluetoothOff:
                            return WidgetError(
                              type: WidgetEnums.bluetoothOff,
                              onRetry: retry,
                            );

                          case ProbeNewEnum.usbDisconnected:
                            return const WidgetError(
                              type: WidgetEnums.usbDisconnected,
                            );

                          case ProbeNewEnum.deviceNotConnected:
                            return WidgetError(
                              type: WidgetEnums.probeOffline,
                              onRetry: retry,
                            );

                          default:
                            return WidgetError(
                              type: WidgetEnums.other,
                              onRetry: retry,
                            );
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
    _usbSubscription?.cancel();
    ProbeController().dispose();
  }
}
