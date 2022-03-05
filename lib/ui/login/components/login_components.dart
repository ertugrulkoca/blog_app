import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../constants/constants.dart';
import '../../../core/provider/login_provider.dart';

AppBar appBarLogin(String text) {
  return AppBar(
    title: Text(text,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    centerTitle: true,
  );
}

//  obsecure text için provider kullanımı.
//  gönderilen obsecureText parametresi sadec email içindir.
//  height ve width GestureDetector için
Consumer textField(String text, TextEditingController controlller,
    Icon prefIcon, sufIcon, bool obsecureText, double height, width) {
  return Consumer<LoginModelProvider>(
    builder: (context, value, child) {
      return TextField(
        controller: controlller,
        // gönderilen obsecureText false ise mail için textField'dır, değil ise password textField'dir.
        obscureText:
            obsecureText == false ? obsecureText : value.getObsecureText(),
        decoration: InputDecoration(
            hintText: text,
            prefixIcon: prefIcon,
            suffixIcon: SizedBox(
              height: height,
              width: width,
              child: GestureDetector(
                onTap: () {
                  // parolanın gizli - görünür durumuna getirilmesi ve provider ile dinlenilmesi.
                  value.changeObsecureText(!value.getObsecureText());
                },
                child: sufIcon,
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: dark))),
      );
    },
  );
}

SizedBox customSizedBox(double size) {
  return SizedBox(height: size);
}

SizedBox loginRegisterButton(String text, Color textColor,
    Color backgroundColor, IconData icon, void Function() fun) {
  return SizedBox(
    width: double.infinity,
    height: 60,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: textColor)),
      ),
      onPressed: fun,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.login, color: textColor),
          Center(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ),
          const Icon(Icons.login, color: Colors.transparent),
        ],
      ),
    ),
  );
}

// login uyarıları için alert
loginAlert(context, String text) {
  Alert(
    context: context,
    type: AlertType.error,
    title: text,
    buttons: [
      DialogButton(
        child: const Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
