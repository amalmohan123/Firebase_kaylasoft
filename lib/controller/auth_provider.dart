import 'package:flutter/material.dart';

class AuthProvi extends ChangeNotifier {
  bool isSignUp = true;
  bool obscurePassword = true;

  void iisSignUp() {
    isSignUp = !isSignUp;
    notifyListeners();
  }

  void obscurePass() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}
