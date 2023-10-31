import 'package:mhealth/config/environment/environment.dart';

class QAEnvironment with Environment {
  QAEnvironment._();

  static final QAEnvironment _qaEnvironment = QAEnvironment._();
  factory QAEnvironment() {
    return _qaEnvironment;
  }
  
  @override
  bindServices() {
    super.bindServices();
  }

}
