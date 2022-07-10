import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:get/get.dart';
import 'package:empoweromics/ui/componants/app_svg.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  String iconPath;
  double fontSize;
  Color color;
  Color textColor;
  bool isRTLIcon;

  AppButton(
      {this.text, this.onPressed, this.iconPath, this.fontSize, this.color, this.textColor,this.isRTLIcon = true});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color ?? AppColors.colorPrimary),
        padding: MaterialStateProperty.all(
            EdgeInsets.only(bottom: AppSizes.h0_02,top: AppSizes.h0_01)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: iconPath != null
                  ? EdgeInsetsDirectional.only(
                  start: AppSizes.w0_008,
                  end: AppSizes.w0_008)
                  : EdgeInsets.zero,
              child: iconPath != null ? AppSvg.load(iconPath,isRTLIcon:isRTLIcon) : null),
          Text(
            text,
            style: TextStyle(
              color: textColor??AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: fontSize ?? AppSizes.txt_18,
            ),
          )
        ],
      ),
    );
  }
}
