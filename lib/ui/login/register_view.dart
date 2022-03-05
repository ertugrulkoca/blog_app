import 'package:blog_app_assignment/ui/components/ui_components.dart';
import 'package:blog_app_assignment/ui/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../core/provider/login_provider.dart';
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/logo.png", width: 230, height: 230),
              customSizedBox(20),
              textField(
                  "Email",
                  email,
                  Icon(Icons.mail, color: Colors.grey.shade400),
                  null,
                  false,
                  20.0,
                  20.0),
              customSizedBox(20),
              //  obsecure text için provider
              Consumer<LoginModelProvider>(builder: (context, value, child) {
                return textField(
                    "Password",
                    password,
                    Icon(Icons.lock, color: Colors.grey.shade400),
                    Icon(Icons.remove_red_eye, color: Colors.grey.shade400),
                    value.getObsecureText(),
                    20.0,
                    20.0);
              }),
              customSizedBox(20),
              //  obsecure text için provider
              Consumer<LoginModelProvider>(builder: (context, value, child) {
                return textField(
                    "RePassword",
                    rePassword,
                    Icon(Icons.lock, color: Colors.grey.shade400),
                    Icon(Icons.remove_red_eye, color: Colors.grey.shade400),
                    value.getObsecureText(),
                    20.0,
                    20.0);
              }),
              customSizedBox(30),
              loginRegisterButton("Register", white, dark, Icons.login,
                  (() async {
                if (email.text != null && password.text != null) {
                  if (password.text == rePassword.text) {
                    // kayıt işleminin başarılı olup olmadığı kontrol edilir
                    bool isSigned = await LoginService.instance
                        .register(email.text, password.text);
                    if (isSigned == true) {
                      // eğer başarılı ise homeview a yönlendirilir.
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomeView()),
                          (Route<dynamic> route) => false);
                    } else {
                      // hata mesajı
                      loginAlert(context, "INVALID MAIL OR PASSWORD");
                    }
                  } else {
                    // hata mesajı
                    loginAlert(context, "Password does not match");
                  }
                } else {
                  // hata mesajı
                  loginAlert(context, "MISSING INFORMATION");
                }
              })),
              customSizedBox(20),
              // Login butonu
              loginRegisterButton("Login", dark, white, Icons.login, (() {
                // LoginView a geçiş
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
