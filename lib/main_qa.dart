import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/config/environment/qa_environment.dart';
import 'package:mhealth/MHealthApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.runningEnv = QAEnvironment();
  await Environment.runningEnv.bindServices();
  runApp(const MHealthApp());
}
