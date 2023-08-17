import 'package:flutter/cupertino.dart';

class RegistrationViewModel extends ChangeNotifier {

  bool _isConsentOptionSelectedOption = false;

  bool get isConsentOptionSelectedOption => _isConsentOptionSelectedOption;

  set consentOptionSelected(bool status) {
    _isConsentOptionSelectedOption = status;
    notifyListeners();
  }

}