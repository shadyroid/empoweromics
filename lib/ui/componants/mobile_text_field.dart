import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';

class MobileTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final FormFieldValidator validator;
  final TextInputType textInputType;
  final int maxLines;
  final bool isRequired;

  MobileTextField(
      {this.labelText,
      this.textEditingController,
      this.validator,
      this.textInputType,
      this.maxLines,
      this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.h0_35,
      width: AppSizes.screenWidth,
      margin: EdgeInsets.symmetric(
          horizontal: AppSizes.w0_032, vertical: AppSizes.h0_007),
      decoration: BoxDecoration(
          color: AppColors.colorAccent,
          border: Border.all(
            color: AppColors.colorAccent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          Container(color: AppColors.colorPrimaryDark, child: Text("+966")),
          TextFormField(
            keyboardType: textInputType,
            maxLines: maxLines,
            cursorColor: AppColors.colorPrimary,
            controller: textEditingController,
            validator: validator,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              floatingLabelStyle: TextStyle(
                color: AppColors.colorPrimary,
              ),
              label: Text(
                labelText,
                style: TextStyle(
                    color: AppColors.darkerGray, fontFamily: 'din'),
              ),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.colorPrimary,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
