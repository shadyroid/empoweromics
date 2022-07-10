import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:get/get.dart';
import 'package:empoweromics/ui/componants/app_svg.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';

class ShowTextField extends StatelessWidget {
  String valueText;

  ShowTextField({this.valueText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: AppSizes.h0_028),
      child: TextFormField(
        initialValue: valueText,
        enabled: false,
        cursorColor: AppColors.colorPrimary,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          suffixIconConstraints: BoxConstraints(minHeight: 32, minWidth: 32),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.darkerGray,
          )),
        ),
      ),
    );
  }
}
