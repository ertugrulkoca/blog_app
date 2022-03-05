import 'package:flutter/material.dart';

class FavoritiesModelProvider extends ChangeNotifier {
  bool favState = false;

  bool getfavState() {
    return favState;
  }

  void changefavState(bool state) {
    favState = state;
    notifyListeners();
  }
}
