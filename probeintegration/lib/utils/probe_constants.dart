class ProbeConstants {
  static const String oralProbeBLEHardwareID = "Oral_ProbeV1-1";
  static const String oralProbeBleServiceID = "6e400001";
  static const String oralProbeBleTxCharacteristicsID = "6e400003";
  static const String oralProbeBleRxCharacteristicsID = "6e400002";

  //
  static const String PROBE_HARDWARE_STATUS_HEARTBEAT = "H~H";
  static const String PROBE_HARDWARE_STATUS_BATTERY_LEVEL = "H~B";

  static const String PROBE_HARDWARE_WARNING_AUTO_OFF_LED = "H~E~AOL";
  static const String PROBE_HARDWARE_WARNING_AUTO_OFF_CAMERA = "H~E~AOC";
  static const String PROBE_HARDWARE_EVENT_PHOTO_CAPTURE_BUTTON_PRESSED = "H~E~CB~1";
  
  static const String PROBE_HARDWARE_LED_ON_STATUS = "H~A~P~W~1";
  static const String PROBE_HARDWARE_LED_OFF_STATUS = "H~A~P~W~0";
  static const String PROBE_HARDWARE_UV_LED_ON_STATUS = "H~A~P~U~1";
  static const String PROBE_HARDWARE_UV_LED_OFF_STATUS = "H~A~P~U~0";
  static const String PROBE_HARDWARE_CAMERA_STATUS = "H~A~P~CB~1";


  static const String PROBE_HARDWARE_PERIPHERAL_WHITE_LED_ON = "A~P~W~1";
  static const String PROBE_HARDWARE_PERIPHERAL_WHITE_LED_OFF = "A~P~W~0";
  static const String PROBE_HARDWARE_PERIPHERAL_UV_LED_ON = "A~P~U~1";
  static const String PROBE_HARDWARE_PERIPHERAL_UV_LED_OFF = "A~P~U~0";
  static const String PROBE_HARDWARE_PERIPHERAL_CAMERA_PRESS = "A~P~CB~1";

  
  static const String icNotOnline = "packages/probeintegration/assets/icons/ic_not_online.svg";
  static const String icBluetoothOff = "packages/probeintegration/assets/icons/ic_bluetooth_disabled.svg";
  static const String icBluetooth = "packages/probeintegration/assets/icons/ic_bluetooth.svg";
  static const String icUSB = "packages/probeintegration/assets/icons/ic_cable.svg";
  static const String icCamera = "packages/probeintegration/assets/icons/ic_photo_camera.svg";
}
