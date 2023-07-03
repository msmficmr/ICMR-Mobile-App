import 'environment.dart';

class ProdEnvironment with Environment {
  ProdEnvironment._();

  static final ProdEnvironment _prodEnvironment = ProdEnvironment._();
  factory ProdEnvironment() {
    return _prodEnvironment;
  }
}
