import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/config/environment/prod_environment.dart';
import 'package:mhealth/m_health_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.runningEnv = ProdEnvironment();
  runApp(const MHealthApp());
}