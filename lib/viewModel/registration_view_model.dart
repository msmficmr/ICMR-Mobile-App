import 'package:flutter/cupertino.dart';

class RegistrationViewModel extends ChangeNotifier {
  resetScreen() {
    _isLoading = false;
    _isConsentOptionSelectedOption = false;
  }

  bool _isConsentOptionSelectedOption = false;

  bool _isLoading = false;

  bool get isConsentOptionSelectedOption => _isConsentOptionSelectedOption;

  bool get isLoading => _isLoading;

  set consentOptionSelected(bool status) {
    _isConsentOptionSelectedOption = status;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
