import 'package:flutter/material.dart';

bool isDarkTheme(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  return brightness == Brightness.dark;
}

Color getPrimaryColor(BuildContext context) {
  bool usingDarkTheme = isDarkTheme(context);
  if (usingDarkTheme) return Colors.white;

  return Theme.of(context).primaryColor;
}
