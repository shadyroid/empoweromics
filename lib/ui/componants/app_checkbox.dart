import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:empoweromics/utils/app_colors.dart';

class AppCheckbox extends StatefulWidget {
  bool isChecked = false;
  ValueChanged<bool> onChanged;

  AppCheckbox({this.onChanged, this.isChecked});

  @override
  State<AppCheckbox> createState() => AppCheckboxState();
}

class AppCheckboxState extends State<AppCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.all(AppColors.red),
      value: widget.isChecked,
      onChanged: (value) {
        widget.onChanged(value);
        setState(() {
          widget.isChecked = value;
        });
      },
    );
  }
}
