import 'package:flutter/material.dart';
import '../components/ui_components.dart';
import '../home/components/home_components.dart';

class MyFavorites extends StatelessWidget {
  const MyFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, "My Favorites"),
      body: SingleChildScrollView(
          child: SizedBox(
              height: size.height,
              width: size.width,
              child: articleGridView())),
      bottomNavigationBar: buttomBar(context, 0),
    );
  }
}
