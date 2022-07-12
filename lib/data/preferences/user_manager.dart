import 'dart:ui';

import 'package:empoweromics/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences _prefs;

  // call this method from iniState() function of mainApp().
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  static bool isLoggedIn() =>
      _prefs.getBool(CONSTANTS.IS_LOGGED_IN) ?? false;

  static void setLoggedIn(bool isLoggedIn) =>
      _prefs.setBool(CONSTANTS.IS_LOGGED_IN, isLoggedIn);


  static void setLocale(String language, String country) {
    _prefs.setString(CONSTANTS.LANGUAGE, language);
    _prefs.setString(CONSTANTS.COUNTRY, country);
  }

  static Locale getLocale() => Locale(
      _prefs.getString(CONSTANTS.LANGUAGE) ?? "ar",
      _prefs.getString(CONSTANTS.COUNTRY) ?? "SA");


  static void removeUser() => _prefs.clear();
}
