import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import 'components/login_components.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Login"),
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
              loginRegisterButton("Register", white, dark, (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterView()));
              })),
              customSizedBox(20),
              loginRegisterButton("Login", dark, white, (() {
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
