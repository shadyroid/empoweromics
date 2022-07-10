import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:empoweromics/data/preferences/user_manager.dart';
import 'package:empoweromics/ui/screens/main/screen.dart';
import 'package:empoweromics/utils/validation.dart';

import '../../data/models/responses/base_response.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  BaseStatefulWidget({Key key}) : super(key: key);
}

abstract class BaseStatefulWidgetState<Screen extends BaseStatefulWidget>
    extends State<Screen> {
  // ArsProgressDialog _progress;
  Validation validation;
  bool isErrorDialogShowing = false;

  @override
  void initState() {
    super.initState();
    validation = Validation(context);

    // _progress ??= ArsProgressDialog(context,
    //     blur: 2,
    //     dismissable: false,
    //     backgroundColor: Color(0x33000000),
    //     animationDuration: Duration(milliseconds: 500));
  }

  void onApiError(BaseResponse response) {
    switch (response.statusCode) {
      //BAD_REQUEST
      case 400:
        _showErrorDialog(
            response != null && response.message != null
                ? response.message
                : 'badRequest'.tr,
            onOkClick);
        break;
      //UNAUTHORISED
      case 401:
        break;
      //NO_RESPONSE
      case 503:
        _showErrorDialog(
            response != null && response.message != null
                ? response.message
                : 'errorAPI'.tr,
            onOkClick);
        break;
      //NO_INTERNET
      case 0:
        _showErrorDialog(response.message, onRetryClick);
        break;
      //OTHER_ERROR
      case -1:
        _showErrorDialog(response.message, onOkClick);
        break;
    }
  }

  void onLoading(bool isLoading) {
    // if (isLoading) {
    //   _progress.show();
    // } else {
    //   _progress.dismiss();
    // }
  }

  bool isLoggedIn() {
    if (UserPreferences.getAuthenticationToken() == null) {
      // showDialog(
      //     context: context, builder: (BuildContext context) => LoginDialog());
      return false;
    } else {
      return true;
    }
  }

  void onBackClick() {
    Navigator.pop(context);
  }

  void onLogoClick() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
        (route) => false);
  }

  void _showErrorDialog(String message, VoidCallback onPressed) {
    if (!isErrorDialogShowing) {
      isErrorDialogShowing = true;
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('error'.tr),
                content: Text(message),
                actions: <Widget>[
                  TextButton(
                    onPressed: onPressed,
                    child: Text('ok'.tr),
                  ),
                ],
              ));
    }
  }

  void onRetryClick() {
    isErrorDialogShowing = false;
    Navigator.pop(context);
  }

  void onOkClick() {
    isErrorDialogShowing = false;
    Navigator.pop(context);
  }
}
