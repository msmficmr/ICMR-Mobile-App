import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';

class MHealthApp extends StatelessWidget {
  const MHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Environment.runningEnv.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const Scaffold(),
    );
  }
}