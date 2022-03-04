import 'package:flutter/material.dart';

class CategoryModelProvider extends ChangeNotifier {
  String? categoryID;

  String? getCategoryID() {
    return categoryID;
  }

  void changeCategory(String? id) {
    categoryID = id;
    notifyListeners();
  }
}
