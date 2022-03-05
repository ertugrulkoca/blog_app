import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../constants/constants.dart';

GestureDetector profilePicture(BuildContext context) {
  return GestureDetector(
    child: SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        children: const [
          CircleAvatar(
              radius: 100, backgroundImage: AssetImage("assets/logo.png")),
          Padding(
              padding: EdgeInsets.only(bottom: 25, right: 25),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.camera_alt, size: 40)))
        ],
      ),
    ),
    onTap: () {
      // profile modal ve profile pop up için alert.
      profileModal(context, () {
        profilePopUp(context, () {});
      });
    },
  );
}

profileModal(context, void Function() fun) {
  Alert(
    context: context,
    image: Image.asset(
      "assets/logo.png",
      width: 300,
      height: 300,
      fit: BoxFit.cover,
    ),
    buttons: [
      alertButton(context, "Select", Icons.login, white, dark, fun),
      alertButton(context, "Remove", Icons.login, dark, white, fun)
    ],
  ).show();
}

profilePopUp(context, void Function() fun) {
  Alert(
    context: context,
    title: "Select a Picture",
    buttons: [
      alertButton(context, "Camera", Icons.camera_alt, white, dark, fun),
      alertButton(context, "Galery", Icons.photo_size_select_large_rounded,
          dark, white, fun)
    ],
  ).show();
}

// profileModal ve profilePopUp için ortak buton.
DialogButton alertButton(context, String text, IconData icon, Color textColor,
    backgroundColor, void Function() fun) {
  return DialogButton(
    border: Border.fromBorderSide(BorderSide(color: dark, width: 1)),
    radius: const BorderRadius.all(Radius.circular(10)),
    color: backgroundColor,
    child: Row(
      children: [
        Icon(icon, color: textColor),
        const SizedBox(width: 10),
        Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      ],
    ),
    onPressed: fun,
  );
}
