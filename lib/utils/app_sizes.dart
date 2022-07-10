import 'package:flutter/material.dart';

class AppSizes {
  static double screenWidth;
  static double screenHeight;
  static double unit;

  static double tinyTxt;
  static double txt_12;
  static double txt_15;
  static double txt_16;
  static double txt_18;
  static double txt_20;

  static double w0_008;
  static double w0_015;
  static double w0_016;
  static double w0_02;
  static double w0_025;
  static double w0_03;
  static double w0_035;
  static double w0_032;
  static double w0_037;
  static double w0_04;
  static double w0_045;
  static double w0_05;
  static double w0_064;
  static double w0_07;
  static double w0_074;
  static double w0_1;
  static double w0_116;
  static double w0_13;
  static double w0_17;
  static double w0_2;
  static double w0_25;
  static double w0_3;
  static double w0_4;
  static double w0_47;
  static double w0_86;

  static double h0_007;
  static double h0_014;
  static double h0_018;
  static double h0_028;
  static double h0_036;
  static double h0_01;
  static double h0_02;
  static double h0_03;
  static double h0_05;
  static double h0_06;
  static double h0_08;
  static double h0_1;
  static double h0_12;
  static double h0_15;
  static double h0_051;
  static double h0_056;
  static double h0_28;
  static double h0_35;
  static double h0_27;
  static double h0_18;
  static double h0_21;
  static double h0_225;
  static double h0_2;
  static double h0_221;
  static double h0_4;
  static double h0_45;
  static double h0_5;




  static EdgeInsetsGeometry e0_001;
  static EdgeInsetsGeometry e0_002;
  static EdgeInsetsGeometry e0_004;

  static void init(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    unit = (screenWidth * screenHeight) / 100;

    tinyTxt = 8;
    txt_12 = 12;
    txt_16 = 16;
    txt_15 = 15;
    txt_18 =  18;
    txt_20 =  20;

    w0_008 = screenWidth * 0.008;
    w0_015 = screenWidth * 0.015;
    w0_02 = screenWidth * 0.02;
    w0_025 = screenWidth * 0.025;
    w0_03 = screenWidth * 0.03;
    w0_032 = screenWidth * 0.032;
    w0_037 = screenWidth * 0.037;
    w0_064 = screenWidth * 0.064;
    w0_016 = screenWidth * 0.016;
    w0_04 = screenWidth * 0.04;
    w0_045 = screenWidth * 0.045;
    w0_05 = screenWidth * 0.05;
    w0_035 = screenWidth * 0.035;
    w0_07 = screenWidth * 0.07;
    w0_074 = screenWidth * 0.074;
    w0_1 = screenWidth * 0.1;
    w0_116 = screenWidth * 0.116;
    w0_13 = screenWidth * 0.13;
    w0_17 = screenWidth * 0.17;
    w0_2 = screenWidth * 0.2;
    w0_25 = screenWidth * 0.25;
    w0_3 = screenWidth * 0.3;
    w0_4 = screenWidth * 0.4;
    w0_47 = screenWidth * 0.47;
    w0_86 = screenWidth * 0.86;

    h0_007 = screenHeight * 0.007;

    h0_01 = screenHeight * 0.01;
    h0_014 = screenHeight * 0.014;
    h0_018 = screenHeight * 0.018;
    h0_02 = screenHeight * 0.02;
    h0_028 = screenHeight * 0.028;
    h0_036 = screenHeight * 0.036;
    h0_03 = screenHeight * 0.03;
    h0_05 = screenHeight * 0.05;
    h0_051 = screenHeight * 0.051;
    h0_056 = screenHeight * 0.056;
    h0_06 = screenHeight * 0.06;
    h0_08 = screenHeight * 0.08;
    h0_1 = screenHeight * 0.1;
    h0_12 = screenHeight * 0.12;
    h0_15 = screenHeight * 0.15;
    h0_28 = screenHeight * 0.28;
    h0_35 = screenHeight * 0.35;
    h0_27 = screenHeight * 0.27;
    h0_18 = screenHeight * 0.18;
    h0_21 = screenHeight * 0.21;
    h0_225 = screenHeight * 0.225;
    h0_2 = screenHeight * 0.2;
    h0_221 = screenHeight * 0.221;
    h0_4 = screenHeight * 0.4;
    h0_45 = screenHeight * 0.45;
    h0_5 = screenHeight * 0.5;


    e0_001 =  EdgeInsets.symmetric(horizontal: AppSizes.screenWidth*0.0085,vertical:  AppSizes.screenHeight*0.004);
    e0_002 =  EdgeInsets.symmetric(horizontal: AppSizes.screenWidth*0.017,vertical:  AppSizes.screenHeight*0.008);
    e0_004 =  EdgeInsets.symmetric(horizontal: AppSizes.screenWidth*0.034,vertical:  AppSizes.screenHeight*0.016);

  }
}
