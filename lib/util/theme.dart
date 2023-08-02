import 'package:flutter/material.dart';

const Color bluisClr = Color(0XFF4e5ae8);
const Color yellowClr = Color(0XFFffb746);
const Color pinkClr = Color(0XFFff4667);
const Color white = Colors.white;
const primaryClr = bluisClr;
const Color darkGreyClr = Color(0XFF121212);
Color darkHeaderClr = Color(0XFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}
