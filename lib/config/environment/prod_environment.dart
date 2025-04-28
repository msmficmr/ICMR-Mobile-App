import 'package:mhealth/config/environment/environment.dart';

class ProdEnvironment with Environment {
  ProdEnvironment._();

  static final ProdEnvironment _prodEnvironment = ProdEnvironment._();
  factory ProdEnvironment() {
    return _prodEnvironment;
  }
  
  @override
  bindServices() {
    super.bindServices();
  }
}
