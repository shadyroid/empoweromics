import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';

class PasswordTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final FormFieldValidator validator;
  final TextInputType textInputType;
  final int maxLines;
  final bool isRequired;

  PasswordTextField(
      {this.labelText,
      this.textEditingController,
      this.validator,
      this.textInputType,
      this.maxLines,
      this.isRequired});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: AppSizes.h0_028),
      child: TextFormField(
        obscureText: _isObscure,
        cursorColor: AppColors.colorPrimary,
        controller: widget.textEditingController,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          floatingLabelStyle: TextStyle(
            color: AppColors.colorPrimary,
          ),
          label: RichText(
            text: TextSpan(
                text: widget.labelText,
                style: TextStyle(
                    color: AppColors.darkerGray, fontFamily: 'din'),
                children: widget.isRequired == null
                    ? null
                    : [
                        const TextSpan(
                            text: ' *', style: TextStyle(color: Colors.red))
                      ]),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
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
