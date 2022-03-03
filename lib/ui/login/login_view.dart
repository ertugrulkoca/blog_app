import 'package:blog_app_assignment/ui/home/home_view.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../core/helper/shared_manager.dart';
import '../../core/service/login_service.dart';
import '../components/ui_components.dart';
import 'components/login_components.dart';
import 'register_view.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((val) {
      if (SharedManager.instance.getStringValue(SharedKeys.TOKEN).isNotEmpty) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeView()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Login"),
      // appBar: appBarLogin("Login"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/logo.png", width: 230, height: 230),
              customSizedBox(20),
              textField("Email", email,
                  Icon(Icons.mail, color: Colors.grey.shade400), null),
              customSizedBox(20),
              textField(
                  "Password",
                  password,
                  Icon(Icons.lock, color: Colors.grey.shade400),
                  Icon(Icons.remove_red_eye, color: Colors.grey.shade400)),
              customSizedBox(30),
              loginRegisterButton("Login", white, dark, Icons.login, (() async {
                if (email.text != null && password.text != null) {
                  bool isSigned = await LoginService.instance
                      .login(email.text, password.text);
                  if (isSigned == true) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomeView()),
                        (Route<dynamic> route) => false);
                  } else {
                    print("kullanıcı adı ve şifre hatalı");
                  }
                } else {
                  print("eksik bilgiler");
                }
              })),
              customSizedBox(20),
              loginRegisterButton("Register", dark, white, Icons.login, (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterView()));
              })),
            ],
          ),
        ),
      ),
    );
  }
}