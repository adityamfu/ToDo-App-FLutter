import 'package:flutter/material.dart';

const Color barClr = Color(0XFFE67E22);
const Color bar2Clr = Color(0XFF262A32);
const Color yellowClr = Color(0XFFffb746);
const Color pinkClr = Color(0XFFff4667);
const Color white = Color(0XFFE67E22);
const Color backGrnd = Color(0Xff8EE8C8);
const primaryClr = barClr;
const secondaryClr = bar2Clr;
const Color darkGreyClr = Color(0XFF262A32);
Color darkHeaderClr = Color(0XFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    fontFamily: 'Montserrat',
    colorScheme:const ColorScheme.light(
      background: Color(0XFF8EE8C8),
      primary: Color(0XFF262A32),
      tertiary: Color(0XFFD0DFDE),
      scrim: Color(0XFFFF8F50),
      secondary: Color(0XFF574D45),
      surface: Colors.white,
      // inverseSurface: Color(0XFF262A32),
    ),
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: secondaryClr,
    fontFamily: 'Montserrat',
    colorScheme:const ColorScheme.dark(
      background: Color(0XFF757575),
      primary: Colors.white,
      tertiary: Color(0XFF262A32),
      scrim: Colors.white,
      secondary: Color(0XFF574D45),
      surface: Color(0XFF262A32),
      // inverseSurface: Colors.white,
    ),
    brightness: Brightness.dark,
  );
}
