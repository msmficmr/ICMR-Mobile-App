import 'package:flutter/services.dart';

import 'probeintegration_platform_interface.dart';

class Probeintegration {
  static const EventChannel _usbEventChannel = EventChannel('probeintegration/usb_events');

  static Stream<String> get usbEvents {
    return _usbEventChannel.receiveBroadcastStream().map((event) => event as String);
  }

  Future<String?> getPlatformVersion() {
    return ProbeintegrationPlatform.instance.getPlatformVersion();
  }

  Future<String?> playShutterSound() {
    return ProbeintegrationPlatform.instance.playShutterSound();
  }

  Future<String?> processCapturedImage(String imageOnePath, String imageTwoPath) {
    return ProbeintegrationPlatform.instance.processCapturedImage(imageOnePath, imageTwoPath);
  }
  Future<Map<String,Uint8List>?> processCapturedImageInBytes(String imageOnePath, String imageTwoPath) {
    return ProbeintegrationPlatform.instance.processCapturedImageInBytes(imageOnePath, imageTwoPath);
  }

  Future<Map<String, String>> checkUSBDevice() {
    return ProbeintegrationPlatform.instance.getConnectedUsbDevices();
  }

  Future<void> requestUSBPermission() {
    return ProbeintegrationPlatform.instance.requestUSBPermission();
  }

  Future<bool> hasUSBPermission() {
    return ProbeintegrationPlatform.instance.hasUSBPermission();
  }
}
