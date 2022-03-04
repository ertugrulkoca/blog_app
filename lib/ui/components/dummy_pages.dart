import 'package:flutter/material.dart';

Widget get notFoundWidget => const Center(
        child: Text(
      "NOT FOUND",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ));
Widget get waitingWidget => const Center(child: CircularProgressIndicator());
