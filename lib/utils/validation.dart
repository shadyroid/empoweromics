import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

class Validation {
  BuildContext context;
  int passwordLength = 6;

  Validation(this.context);

  String isNotEmpty(value) {
    if (value.isEmpty) {
      return 'required'.tr;
    }
    return null;
  }

  String isEmail(value) {
    if (value.isEmpty) {
      return 'required'.tr;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value);
    if (!emailValid) {
      return 'invalid_email'.tr;
    }

    return null;
  }

  bool isNotNull(Object value, String message) {
    if (value == null) {
      Toast.show(message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }

  bool isAcceptableAge(int value, String message) {
    if (value >= 65) {
      Toast.show(message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }

  bool isListEmpty(List<Object> list, String message) {
    if (list.isEmpty) {
      Toast.show(message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }

  String isPhoneNumber(value) {
    if (value.isEmpty) {
      return 'required'.tr;
    }
    if (value.length != 11) {
      return "${'phone_number_should_be'.tr} 11 ${'number'.tr}";
    }

    if (!value.startsWith("01")) {
      return "${'phone_number_should_start_with'.tr} 01";
    }
    return null;
  }
}
