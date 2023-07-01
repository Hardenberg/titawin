import 'package:flutter/material.dart';

class ColorHelper {
  Color getAppBarColor() {
    return Colors.blueAccent.shade100;
  }

  Color getHeadLineColor() {
    return Color.fromARGB(78, 130, 178, 255);
  }

  Color getBodyColor(context) {
    return Theme.of(context).colorScheme.onSecondary;
  }
}
