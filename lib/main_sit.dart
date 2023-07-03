import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/config/environment/sit_environment.dart';
import 'package:mhealth/m_health_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.runningEnv = SITEnvironment();
  runApp(const MHealthApp());
}