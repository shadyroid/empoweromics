import 'package:empoweromics/ui/componants/app_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:empoweromics/ui/screens/main/screen.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:empoweromics/data/preferences/user_manager.dart';
import 'package:empoweromics/utils/app_sizes.dart';

class MessageScreen extends StatelessWidget {
  String message ;

  MessageScreen(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Lottie.asset(
                 'assets/animations/successful.json',
                animate: true,
                repeat: true),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: AppSizes.e0_004,
              child: AppButton(
                fontSize: AppSizes.txt_16,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                          (route) => false);
                },
                text: 'back_to_home'.tr,
              ),
            )
          ])),
    );
  }
}
