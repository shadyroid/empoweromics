import 'package:empoweromics/data/preferences/user_manager.dart';
import 'package:empoweromics/ui/componants/app_svg.dart';
import 'package:empoweromics/ui/screens/installment_calculator/screen.dart';
import 'package:empoweromics/ui/screens/login/screen.dart';
import 'package:empoweromics/ui/screens/splash/screen.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NavDrawer extends StatelessWidget {
  int selectedPage;

  NavDrawer(this.selectedPage);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: AppSizes.h0_28,
            child: DrawerHeader(
              child: Column(
                children: [
                  Padding(
                    padding:
                    EdgeInsetsDirectional.only(bottom: AppSizes.h0_014),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: AppSizes.w0_47,
                      height: AppSizes.h0_1,
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: ToggleSwitch(
                      minHeight: AppSizes.h0_05,
                      minWidth: AppSizes.w0_3,
                      initialLabelIndex:
                      Get.locale.languageCode == "ar" ? 0 : 1,
                      cornerRadius: AppSizes.w0_3,
                      activeFgColor: AppColors.red,
                      inactiveBgColor: Colors.white,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      labels: [
                        'arabic_language_btn'.tr,
                        'english_language_btn'.tr
                      ],
                      activeBgColors: [
                        [AppColors.red],
                        [AppColors.red]
                      ],
                      customTextStyles: [
                        TextStyle(
                            color: AppColors.black,
                            fontSize: AppSizes.txt_12),
                        TextStyle(
                            color: AppColors.black, fontSize: AppSizes.txt_12)
                      ],
                      onToggle: (index) {
                        if (index == 0 && Get.locale.languageCode == 'en') {
                          UserPreferences.setLocale('ar', 'SA');
                          Get.updateLocale(Locale('ar', 'SA'));
                        } else {
                          UserPreferences.setLocale('en', 'US');
                          Get.updateLocale(Locale('en', 'US'));
                        }
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()),
                                (route) => false);
                      },
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(color: AppColors.colorPrimaryDark),
            ),
          ),

          ListTile(
            leading: AppSvg.load(
              selectedPage == 1
                  ? 'assets/icons/ic_main_active.svg'
                  : 'assets/icons/ic_main_inactive.svg',
            ),
            title: Text(
              'main_screen'.tr,
              style: TextStyle(
                  color: selectedPage == 1
                      ? AppColors.colorPrimary
                      : AppColors.black),
            ),
            onTap: () {
              _onMainClick(context);
            },
          ),
          ListTile(
            leading: AppSvg.load(
              selectedPage == 2
                  ? 'assets/icons/ic_calculator_active.svg'
                  : 'assets/icons/ic_calculator_inactive.svg',
            ),
            title: Text(
              'installment_calculator'.tr,
              style: TextStyle(
                  color: selectedPage == 2
                      ? AppColors.colorPrimary
                      : AppColors.black),
            ),
            onTap: () {
              _onInstallmentCalculatorClick(context);
            },
          ),
          ListTile(
            leading: AppSvg.load('assets/icons/ic_login.svg'),
            title: Text(
              'login'.tr,
              style: TextStyle(color: AppColors.black),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onMainClick(BuildContext context) {
    Navigator.of(context).pop();
    if (selectedPage != 1) {
      Navigator.of(context).pop();
    }
  }

  void _onInstallmentCalculatorClick(BuildContext context) {
    Navigator.of(context).pop();
    if (selectedPage != 2) {
      if (selectedPage == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InstallmentCalculatorScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => InstallmentCalculatorScreen()),
        );
      }
    }
  }
}
