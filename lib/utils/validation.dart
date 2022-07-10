
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:toast/toast.dart';

class Validation {
  BuildContext context;
  int passwordLength = 6;

  Validation(this.context);

  String isNotEmpty(value) {
    if (value.isEmpty) {
      return 'errorRequired'.tr;
    }
    return null;
  }



  String isEmail(value) {
    if (value.isEmpty) {
      return 'errorRequired'.tr;
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value);
    if (!emailValid) {
      return 'errorInvalidEmail'.tr;
    }

    return null;
  }

  bool isNotNull(Object value, String message) {
    if (value == null) {
      Toast.show(message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }
  bool isAcceptableAge(int value, String message) {
    if (value >= 65) {
      Toast.show(message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }




  bool isPasswordsMatches(String password, String confirmPassword) {
    if (password != confirmPassword) {
      Toast.show('errorPasswordMatchingMessage'.tr, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }

  bool isChecked(bool isChecked, String message) {
    if (!isChecked) {
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
}
