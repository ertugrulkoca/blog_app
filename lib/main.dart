import 'package:flutter/material.dart';
import 'ui/home/home_view.dart';
import 'ui/home/my_favorites_view.dart';
import 'ui/login/login_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
      ),
      title: 'Blog App',
      home: MyFavorites(),
    );
  }
}
