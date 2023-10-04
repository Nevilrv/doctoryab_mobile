import 'package:flutter/material.dart';

class AppColors {
  //TODO Handle light theme and dark theme here
  static const primary = Color(0xFF333E92);
  static const primaryLight = Color(0xFF999EC8);
  static const easternBlue = Color(0xff15A6B7);

  static const scaffoldColor = Color(0xFFF1F6FC);
  static const lgt = Color(0xFFC8C8C8);
  static const lgt2 = Color(0xFF8D8D8D);
  static const black = Color(0xff000000);
  static const black2 = Color(0xff333333);
  static const lightBlack = Color(0xff404040);
  static const lightOrange = Color(0xffFFF1ED);
  static const lightGreen = Color(0xffF0FFED);
  static const lightRed = Color(0xffFFE3E1);
  static const lightBlue = Color(0xffB7EAFF);
  static const lightBlue2 = Color(0xffEDFEFF);
  static const lightYellow = Color(0xffFFF6D7);
  static const disabledButtonColor = Color(0xff5C65A8);
  static const green = Color(0xff15B76C);
  static const verified = Color(0xff42A5F5);
  // the new ui Guy
  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xff8A3BEE),
      Color(0xffF200B7),
      Color(0xffFE9402),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
  static final grey = Color(0xFF585858);
  static const white = Colors.white;
  static final lightWhite = Color(0xFFFFFFFF).withOpacity(0.5);
  static const yellow = Color(0xffFFC702);
  static const lightBlack2 = Color(0xFF343F54);
  static const red = Color(0xffF31155);
  static const red2 = Color(0xffFF0101);
  static const lightPurple = Color(0xffECEEFF);
  static const secondary = Color(0xff0ED2B3);
  static const lightGrey = Color(0xFFF6F8FE);
  static const MaterialColor primarySwatch = MaterialColor(
    0xff333e92,
    {
      50: Color(0xff6977b5),
      100: Color(0xff5664a9),
      200: Color(0xff44519e),
      300: Color(0xff333e92),
      400: Color(0xff333e92),
      500: Color(0xff333e92),
      600: Color(0xff333e92),
      700: Color(0xff2b357e),
      800: Color(0xff232b6b),
      900: Color(0xff1c2358),
    },
  );
}
