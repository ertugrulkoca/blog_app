import 'package:flutter/material.dart';
import 'package:qa_application/ui/home_view/home_view.dart';
import 'package:qa_application/ui/search_view/serach_view.dart';

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
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        onPressed: () {
          if (0 != currentPage) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeView()));
          }
        },
        icon: Icon(Icons.home_outlined,
            color: 0 == currentPage ? Colors.black : Colors.blue),
      ),
      IconButton(
        onPressed: () {
          if (1 != currentPage) {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => SearchView()));
          }
        },
        icon: Icon(Icons.search,
            color: 1 == currentPage ? Colors.black : Colors.blue),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.add,
            color: 2 == currentPage ? Colors.black : Colors.blue),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.bookmark,
            color: 3 == currentPage ? Colors.black : Colors.blue),
      ),
    ],
  );
}
