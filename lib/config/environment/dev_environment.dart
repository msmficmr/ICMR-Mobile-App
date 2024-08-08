import 'dart:developer';

import 'package:mhealth/config/environment/environment.dart';

class DEVEnvironment with Environment {
  DEVEnvironment._();

  static final DEVEnvironment _devEnvironment = DEVEnvironment._();
  factory DEVEnvironment() {
    return _devEnvironment;
  }
  
  @override
  bindServices() {
    super.bindServices();
  }
}