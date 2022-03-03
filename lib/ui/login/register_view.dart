import 'package:blog_app_assignment/ui/components/ui_components.dart';
import 'package:blog_app_assignment/ui/login/login_view.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../core/service/login_service.dart';
import '../home/home_view.dart';
import 'components/login_components.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
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
              customSizedBox(20),
              textField(
                  "RePassword",
                  rePassword,
                  Icon(Icons.lock, color: Colors.grey.shade400),
                  Icon(Icons.remove_red_eye, color: Colors.grey.shade400)),
              customSizedBox(30),
              loginRegisterButton("Register", white, dark, Icons.login,
                  (() async {
                if (email.text != null && password.text != null) {
                  if (password.text == rePassword.text) {
                    bool isSigned = await LoginService.instance
                        .register(email.text, password.text);
                    if (isSigned == true) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomeView()),
                          (Route<dynamic> route) => false);
                    } else {
                      print("kullanıcı adı ve şifre hatalı");
                    }
                  } else {
                    print("parola eşleşmiyor");
                  }
                } else {
                  print("eksik bilgiler");
                }

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeView()),
                    (Route<dynamic> route) => false);
              })),
              customSizedBox(20),
              loginRegisterButton("Login", dark, white, Icons.login, (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
              })),
            ],
          ),
        ),
      ),
    );
  }
}
