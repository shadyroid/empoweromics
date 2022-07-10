import 'package:empoweromics/ui/componants/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:get/get.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';

class SelectTextField extends StatelessWidget {
  String hintText;
  String valueText;
  bool isRequired;
  String hexColor;
  String icon;

  TextEditingController textEditingController = TextEditingController();

  FormFieldValidator validator;

  VoidCallback onTap;

  SelectTextField(
      {this.hintText,
      this.valueText,
      this.hexColor,
      this.isRequired,
      this.onTap,
      this.icon});

  @override
  Widget build(BuildContext context) {
    textEditingController.text = valueText;
    return Padding(
      padding: EdgeInsetsDirectional.only(top: AppSizes.h0_028),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: TextFormField(
          enabled: false,
          cursorColor: AppColors.colorPrimary,
          controller: textEditingController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            hintText: hintText,
            floatingLabelStyle: TextStyle(
              color: hexColor != null
                  ? HexColor(hexColor)
                  : AppColors.colorPrimary,
            ),
            suffixIcon: AppSvg.load(
              icon ?? "assets/icons/ic_arrow_down.svg",
            ),
            suffixIconConstraints: BoxConstraints(minHeight: 32, minWidth: 32),
            label: RichText(
              text: TextSpan(
                  text: hintText,
                  style: TextStyle(
                      color: AppColors.darkerGray, fontFamily: 'tajawal'),
                  children: isRequired == null
                      ? null
                      : [
                          const TextSpan(
                              text: ' *', style: TextStyle(color: Colors.red))
                        ]),
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color:
                  hexColor != null ? HexColor(hexColor) : AppColors.darkerGray,
            )),
          ),
        ),
      ),
    );
  }
}
