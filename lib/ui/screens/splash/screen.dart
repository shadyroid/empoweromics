import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:empoweromics/ui/screens/main/screen.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Animation animation;

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);
    Timer(Duration(seconds: 3), navigate);
    return AnimatedSplashScreen(
        duration: 1000,
        splash: 'assets/images/logo.png',
        disableNavigation: true,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.topToBottom,
        splashIconSize: AppSizes.screenWidth*2,
        backgroundColor: AppColors.white);
  }


  void navigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }
}
