import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/config/environment/sit_environment.dart';
import 'package:mhealth/device_preview_m_health_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.runningEnv = SITEnvironment();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const DevicePreviewMHealthApp(),
    ),
  );
}
