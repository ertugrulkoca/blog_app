import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

AppBar appBarLogin(String text) {
  return AppBar(
    title: Text(text,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    centerTitle: true,
  );
}

TextField textField(
    String text, TextEditingController controlller, Icon prefIcon, sufIcon) {
  return TextField(
    controller: controlller,
    decoration: InputDecoration(
        hintText: text,
        prefixIcon: prefIcon,
        suffixIcon: sufIcon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: dark))),
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
