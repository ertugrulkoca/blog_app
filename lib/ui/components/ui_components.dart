import 'package:blog_app_assignment/ui/favorites/my_favorites_view.dart';
import 'package:blog_app_assignment/ui/home/home_view.dart';
import 'package:blog_app_assignment/ui/profile/profile_view.dart';
import 'package:flutter/material.dart';

AppBar appBar(BuildContext context, String text) {
  return AppBar(
    centerTitle: true,
    title: Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black, //change your color here
    ),
  );
}

Container buttomBar(BuildContext context, int currentPage) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 35),
    height: 75,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, -7),
          blurRadius: 33,
          color: const Color(0xFF6DAED9).withOpacity(0.11),
        ),
      ],
    ),
    child: icons(currentPage, context),
  );
}

Row icons(int currentPage, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      IconButton(
        onPressed: () {
          if (0 != currentPage) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyFavorites()));
          }
        },
        icon: Icon(Icons.favorite,
            color: 0 == currentPage ? Colors.black : Colors.grey.shade400),
      ),
      IconButton(
        onPressed: () {
          if (1 != currentPage) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeView()));
          }
        },
        icon: Icon(Icons.home,
            color: 1 == currentPage ? Colors.black : Colors.grey.shade400),
      ),
      IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileView()));
        },
        icon: Icon(Icons.person,
            color: 2 == currentPage ? Colors.black : Colors.grey.shade400),
      ),
    ],
  );
}
