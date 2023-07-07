import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  static LoginViewModel loginViewModel = LoginViewModel._();

  LoginViewModel._() {
    _isLoggedIn = false;
  }

  factory LoginViewModel() {
    return loginViewModel;
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

}