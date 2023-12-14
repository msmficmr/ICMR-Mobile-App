import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/config/environment/sit_environment.dart';
import 'package:mhealth/MHealthApp.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Environment.runningEnv = SITEnvironment();
  await Environment.runningEnv.bindServices();
  runApp(const MHealthApp());
}
