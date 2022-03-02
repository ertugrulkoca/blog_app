import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import 'components/login_components.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLogin("Login"),
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
              loginRegisterButton("Login", white, dark, Icons.login, (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterView()));
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
