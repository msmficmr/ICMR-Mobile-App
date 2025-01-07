class PermissionException implements Exception {
  String? message;
  PermissionException([this.message]) : super();
}

class BluetoothOffException implements Exception {
  String? message;
  BluetoothOffException([this.message]) : super();
}

class CameraPermissionException implements Exception {
  String? message;
  CameraPermissionException([this.message]) : super();
}

class CameraPermanentlyPermissionException implements Exception {
  String? message;
  CameraPermanentlyPermissionException([this.message]) : super();
}

class BluetoothPermissionException implements Exception {
  String? message;
  BluetoothPermissionException([this.message]) : super();
}

class BluetoothPermanentlyPermissionException implements Exception {
  String? message;
  BluetoothPermanentlyPermissionException([this.message]) : super();
}

class StoragePermissionException implements Exception {
  String? message;
  StoragePermissionException([this.message]) : super();
}
class StoragePermanentlyPermissionException implements Exception {
  String? message;
  StoragePermanentlyPermissionException([this.message]) : super();
}

class USBDeviceNotAvailablePermissionException implements Exception {
  String? message;
  USBDeviceNotAvailablePermissionException([this.message]) : super();
}

class USBPermissionDenied implements Exception {
  String? message;
  USBPermissionDenied([this.message]) : super();
}
