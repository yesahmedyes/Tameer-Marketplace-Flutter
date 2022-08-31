import 'package:flutter/material.dart';

const Color redColor = Color.fromRGBO(255, 81, 82, 1);
const Color blueColor = Color.fromRGBO(61, 139, 255, 1);

ThemeData theme() {
  return ThemeData(
    primaryColor: redColor,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.transparent), primary: redColor),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 18, height: 1.8, fontWeight: FontWeight.w600, color: Colors.black87),
      headline2: TextStyle(fontSize: 17, height: 1.8, color: Colors.black87),
      headline4: TextStyle(fontSize: 14, color: Colors.grey),
      bodyText1: TextStyle(fontSize: 15, height: 1.5, fontWeight: FontWeight.w400, color: Colors.black87),
      subtitle1: TextStyle(fontSize: 15, height: 1.5, fontWeight: FontWeight.w500, color: Colors.black87, letterSpacing: 1),
      subtitle2: TextStyle(fontSize: 15, height: 1.5, fontWeight: FontWeight.w500, color: blueColor, decoration: TextDecoration.underline),
    ),
    fontFamily: 'Roboto',
  );
}
