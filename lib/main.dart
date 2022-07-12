import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:empoweromics/ui/screens/splash/screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:empoweromics/data/preferences/user_manager.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toast/toast.dart';
import 'firebase_options.dart';
Future main() async {
  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserPreferences.init();
  AppColors.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Empoweromics',
        locale: UserPreferences.getLocale(),
        translations: AppStrings(),
        builder: (context, child) {
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'din',
        ),
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: SplashScreen());
  }
}
