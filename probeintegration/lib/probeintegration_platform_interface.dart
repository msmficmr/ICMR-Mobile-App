import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'probeintegration_method_channel.dart';

abstract class ProbeintegrationPlatform extends PlatformInterface {
  /// Constructs a ProbeintegrationPlatform.
  ProbeintegrationPlatform() : super(token: _token);

  static final Object _token = Object();

  static ProbeintegrationPlatform _instance = MethodChannelProbeintegration();

  /// The default instance of [ProbeintegrationPlatform] to use.
  ///
  /// Defaults to [MethodChannelProbeintegration].
  static ProbeintegrationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ProbeintegrationPlatform] when
  /// they register themselves.
  static set instance(ProbeintegrationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> playShutterSound() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> processCapturedImage(String imageOnePath, String imageTwoPath) {
    throw UnimplementedError('processCapturedImage(String imageOnePath, String imageTwoPath) has not been implemented.');
  }
  Future<Map<String,Uint8List>?> processCapturedImageInBytes(String imageOnePath, String imageTwoPath) {
    throw UnimplementedError('processCapturedImage(String imageOnePath, String imageTwoPath) has not been implemented.');
  }

  Future<Map<String, String>> getConnectedUsbDevices() async {
    throw UnimplementedError('getConnectedUsbDevices() has not been implemented.');
  }

  Future<void> requestUSBPermission() async{
    throw UnimplementedError('getConnectedUsbDevices() has not been implemented.');
  }

  Future<bool> hasUSBPermission() async{
    throw UnimplementedError('getConnectedUsbDevices() has not been implemented.');
  }
}
