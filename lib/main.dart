import 'dart:io';
import 'package:blog_app_assignment/core/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/helper/shared_manager.dart';
import 'core/provider/favorities_provider.dart';
import 'core/provider/login_provider.dart';
import 'ui/login/login_view.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await SharedManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryModelProvider()),
        ChangeNotifierProvider(create: (context) => FavoritiesModelProvider()),
        ChangeNotifierProvider(create: (context) => LoginModelProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
        ),
        title: 'Blog App',
        home: LoginView(),
      ),
    );
  }
}
