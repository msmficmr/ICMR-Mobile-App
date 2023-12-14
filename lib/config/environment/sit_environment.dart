import 'dart:developer';

import 'package:mhealth/config/environment/environment.dart';

class SITEnvironment with Environment {
  SITEnvironment._();

  static final SITEnvironment _sitEnvironment = SITEnvironment._();
  factory SITEnvironment() {
    return _sitEnvironment;
  }
  
  @override
  bindServices() {
    super.bindServices();
  }
}
