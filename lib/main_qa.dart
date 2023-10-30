import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/config/environment/qa_environment.dart';
import 'package:mhealth/MHealthApp.dart';
import 'package:mhealth/services/shared_preference_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.sharedPreferencesService.init();
  Environment.runningEnv = QAEnvironment();
  runApp(const MHealthApp());
}
