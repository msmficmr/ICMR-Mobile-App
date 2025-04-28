import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'probeintegration_platform_interface.dart';

/// An implementation of [ProbeintegrationPlatform] that uses method channels.
class MethodChannelProbeintegration extends ProbeintegrationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('probeintegration');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> playShutterSound() async {
    final status = await methodChannel.invokeMethod<String>('playShutterSound');
    return status;
  }

  @override
  Future<String?> processCapturedImage(String imageOnePath, String imageTwoPath) async {
    final imageProcessStatus = await methodChannel.invokeMethod<String>('processCapturedImage', {'imageOnePath': imageOnePath, 'imageTwoPath': imageTwoPath});
    return imageProcessStatus;
  }

  @override
  Future<Map<String,Uint8List>?> processCapturedImageInBytes(String imageOnePath, String imageTwoPath) async {
    final result = await methodChannel.invokeMethod('processCapturedImageInBytes', {
      'imageOnePath': imageOnePath,
      'imageTwoPath': imageTwoPath,
    });
    Map<String,Uint8List> images = Map<String,Uint8List>.from(result);
    return images;
  }

  @override
  Future<Map<String, String>> getConnectedUsbDevices() async {
    final devices = await methodChannel.invokeMethod<Map<dynamic, dynamic>>('getConnectedUsbDevices');
    return devices?.map((key, value) => MapEntry(key as String, value as String)) ?? {};
  }

  @override
  Future<void> requestUSBPermission() async {
    await methodChannel.invokeMethod<void>('requestUSBPermission');
  }

  @override
  Future<bool> hasUSBPermission() async {
    return await methodChannel.invokeMethod<bool>('hasUSBPermission') ?? false;
  }
}
