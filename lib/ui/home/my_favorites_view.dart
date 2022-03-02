import 'package:flutter/material.dart';

import 'components/home_components.dart';

class MyFavorites extends StatelessWidget {
  const MyFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, "My Favorites", Icons.arrow_back_ios, null),
      body: SingleChildScrollView(
          child: SizedBox(
              height: size.height,
              width: size.width,
              child: articleGridView())),
    );
  }
}
