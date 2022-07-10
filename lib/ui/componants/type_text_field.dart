import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:get/get.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';

class TypeTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final FormFieldValidator validator;
  final TextInputType textInputType;
  final int maxLines;
  final bool isRequired;

  TypeTextField(
      {this.labelText,
      this.textEditingController,
      this.validator,
      this.textInputType,
      this.maxLines,
      this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: AppSizes.h0_028),
      child: TextFormField(
        keyboardType: textInputType,
        maxLines: maxLines,
        cursorColor: AppColors.colorPrimary,
        controller: textEditingController,
        validator: validator,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          floatingLabelStyle: TextStyle(
            color: AppColors.colorPrimary,
          ),
          label: RichText(
            text: TextSpan(
                text: labelText,
                style: TextStyle(
                    color: AppColors.darkerGray, fontFamily: 'tajawal'),
                children: isRequired == null
                    ? null
                    : [
                        const TextSpan(
                            text: ' *', style: TextStyle(color: Colors.red))
                      ]),
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.colorPrimary,
          )),
        ),
      ),
    );
  }
}
