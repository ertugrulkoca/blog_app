import 'package:flutter/material.dart';

import '../model/blog_model.dart';
import '../service/account_service.dart';

class FavoritiesModelProvider extends ChangeNotifier {
  bool favState = false;

  bool getfavState() {
    return favState;
  }

  void changefavState(bool state) {
    favState = state;
    notifyListeners();
  }
  // int favBlogListlength = 0;

  // Future<int> getfavBlogListlength() async {
  //   List<BlogData> blogs = await AccountService.instance.getFavoriBlogs();
  //   if (blogs.isNotEmpty) {
  //     favBlogListlength = blogs.length;
  //     notifyListeners();
  //   } else {
  //     favBlogListlength = 0;
  //     notifyListeners();
  //   }
  //   return favBlogListlength;
  // }

  // void changeListLength(int length) {
  //   favBlogListlength = length;
  //   notifyListeners();
  // }
}
