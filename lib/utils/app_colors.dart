import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:get/get.dart';

class AppColors {
  static Color colorPrimary;
  static Color colorPrimaryDark;
  static Color colorAccent;

  static Color white;
  static Color black;
  static Color red;
  static Color blue;
  static Color darkerRed;
  static Color gray;
  static Color darkerGray;
  static Color gold;

  static Color transparent;
  static void init() {
    colorPrimary = HexColor("#42CBA1");
    colorPrimaryDark = HexColor("#313131");
    colorAccent = Color(0x14313131);
    transparent = HexColor("#00ffffff");

    white = HexColor("#FFFFFF");
    black = HexColor("#FF000000");
    red = HexColor("#F02525");
    blue = HexColor("#3B5998");
    darkerRed = HexColor("#BC0606");
    gray = HexColor("#7AC8C8C8");
    darkerGray = HexColor("#7C7C7C");
    gold = HexColor("#ddac07");
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
