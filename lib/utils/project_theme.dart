import 'dart:ui';

import 'package:flutter/material.dart';

class ProjectColor {
  static const Color main = Color(0xffFFC700);

  static const Color white1 = Colors.white;
  static const Color white2 = Color(0xffE5E5E5);
  static const Color white3 = Color(0xffFAFAFC);
  static const Color black1 = Colors.black;
  static const Color black2 = Color(0xff020202);
  static const Color grey1 = Colors.grey;
  static const Color grey2 = Color(0xff8D92A3);
  static const Color grey3 = Color(0xfff2f2f2);

  static const Color red1 = Colors.red;
  static const Color red2 = Color(0xffD9435E);
  static const Color green1 = Colors.green;
  static const Color green2 = Color(0xff1ABC9C);
}

class Gap {
  static const double zero = 0;
  static const double xxs = 4;
  static const double xs = 6;
  static const double s = 12;
  static const double m = 16;
  static const double main = 24;
  static const double l = 32;
  static const double xl = 48;
}

class TypoSize {
  static const double header1 = 22;
  static const double header2 = 20;
  static const double header3 = 18;
  static const double title = 16;
  static const double main = 14;
  static const double secondary = 12;
  static const double small = 10;
}

class TypoStyle {
  static const header1Black500 = TextStyle(
    fontSize: TypoSize.header1,
    color: ProjectColor.black2,
    fontWeight: FontWeight.w500,
  );

  static const header2Black = TextStyle(
    fontSize: TypoSize.header2,
    color: ProjectColor.black2,
  );

  static const header2Black500 = TextStyle(
    fontSize: TypoSize.header2,
    color: ProjectColor.black2,
    fontWeight: FontWeight.w500,
  );

  static const header3Black500 = TextStyle(
    fontSize: TypoSize.header3,
    color: ProjectColor.black2,
    fontWeight: FontWeight.w500,
  );

  static const titleBlack500 = TextStyle(
    fontSize: TypoSize.title,
    color: ProjectColor.black2,
    fontWeight: FontWeight.w500,
  );

  static const mainBlack = TextStyle(
    fontSize: TypoSize.main,
    color: ProjectColor.black2,
  );

  static const mainBlack500 = TextStyle(
    fontSize: TypoSize.main,
    color: ProjectColor.black2,
    fontWeight: FontWeight.w500,
  );
  static const mainWhite500 = TextStyle(
    fontSize: TypoSize.main,
    color: ProjectColor.white1,
    fontWeight: FontWeight.w500,
  );

  static const mainGrey = TextStyle(
    fontSize: TypoSize.main,
    color: ProjectColor.grey2,
  );

  static const mainGrey300 = TextStyle(
    fontSize: TypoSize.main,
    color: ProjectColor.grey2,
    fontWeight: FontWeight.w300,
  );

  static const secondaryGrey = TextStyle(
    fontSize: TypoSize.secondary,
    color: ProjectColor.grey2,
  );

  static const smallRed = TextStyle(
    fontSize: TypoSize.small,
    color: ProjectColor.red2,
  );

  static const smallGreen = TextStyle(
    fontSize: TypoSize.small,
    color: ProjectColor.green2,
  );
}

class IconSize {
  static const double s = 16;
  static const double m = 24;
  static const double l = 32;
}

class RadiusSize {
  static const double xs = 2;
  static const double s = 4;
  static const double m = 8;
  static const double l = 16;
  static const double xl = 20;
  static const double xxl = 32;
}

ThemeData projectTheme = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: ProjectColor.main,
  backgroundColor: ProjectColor.white1,
  scaffoldBackgroundColor: ProjectColor.white2,
  iconTheme: IconThemeData(
    color: ProjectColor.main,
    size: IconSize.m,
  ),
  hintColor: ProjectColor.grey2,
  errorColor: ProjectColor.red2,
);
