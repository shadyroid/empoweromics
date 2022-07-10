import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:empoweromics/data/preferences/user_manager.dart';

class AppSvg {

  static Widget load(
    String assetName, {
    double width,
    double height,
    fit = BoxFit.none,
    Color color,
    semanticsLabel,
    isRTLIcon = true,
  }) {
    if (isRTLIcon && Get.locale.languageCode != 'en') {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: SvgPicture.asset(assetName,
            width: width,
            height: height,
            fit: fit,
            semanticsLabel: semanticsLabel,
            color: color),
      );
    } else {
      return SvgPicture.asset(assetName,
          width: width,
          height: height,
          fit: fit,
          semanticsLabel: semanticsLabel,
          color: color);
    }
  }
}
