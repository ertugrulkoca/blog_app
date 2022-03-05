import 'package:flutter/material.dart';

class LoginModelProvider extends ChangeNotifier {
  bool obsecureText = true;

  bool getObsecureText() {
    return obsecureText;
  }

  void changeObsecureText(bool state) {
    obsecureText = state;
    notifyListeners();
  }
}
