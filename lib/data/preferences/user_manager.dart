import 'dart:ui';

import 'package:empoweromics/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences _prefs;

  // call this method from iniState() function of mainApp().
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  static bool isResettingPassword() =>
      _prefs.getBool(CONSTANTS.IS_RESETTING_PASSWORD) ?? false;

  static void setResettingPassword(bool isResettingPassword) =>
      _prefs.setBool(CONSTANTS.IS_RESETTING_PASSWORD, isResettingPassword);

  static String getAuthenticationToken() =>
      _prefs.getString(CONSTANTS.AUTHENTICATION_TOKEN);

  static void setAuthenticationToken(String authenticationToken) =>
      _prefs.setString(CONSTANTS.AUTHENTICATION_TOKEN, authenticationToken);

  static String getAuthenticationType() =>
      _prefs.getString(CONSTANTS.AUTHENTICATION_TYPE);

  static void setAuthenticationType(String authenticationType) =>
      _prefs.setString(CONSTANTS.AUTHENTICATION_TYPE, authenticationType);

  static String getUserId() => _prefs.getString(CONSTANTS.USER_ID);

  static void setUserId(String userId) =>
      _prefs.setString(CONSTANTS.USER_ID, userId);

  static String getName() => _prefs.getString(CONSTANTS.USER_NAME);

  static void setName(String name) =>
      _prefs.setString(CONSTANTS.USER_NAME, name);

  static String getImage() => _prefs.getString(CONSTANTS.IMAGE);

  static void setImage(String image) =>
      _prefs.setString(CONSTANTS.IMAGE, image);

  static String getLanguage() => _prefs.getString(CONSTANTS.LANGUAGE);

  static void setLanguage(String language) =>
      _prefs.setString(CONSTANTS.LANGUAGE, language);

  static void setLocale(String language, String country) {
    _prefs.setString(CONSTANTS.LANGUAGE, language);
    _prefs.setString(CONSTANTS.COUNTRY, country);
  }

  static Locale getLocale() => Locale(
      _prefs.getString(CONSTANTS.LANGUAGE) ?? "ar",
      _prefs.getString(CONSTANTS.COUNTRY) ?? "SA");

  static String getCountryId() => _prefs.getString(CONSTANTS.COUNTRY_ID);

  static void setCountryId(String countryId) =>
      _prefs.setString(CONSTANTS.COUNTRY_ID, countryId);

  static String getCountryCode() =>
      _prefs.getString(CONSTANTS.COUNTRY_CODE) ?? "KSA";

  static void setCountryCode(String countryCode) =>
      _prefs.setString(CONSTANTS.COUNTRY_CODE, countryCode);

  static String getMobileNumber() =>
      _prefs.getString(CONSTANTS.MOBILE_PHONE_NUMBER);

  static void setMobileNumber(String mobileNumber) =>
      _prefs.setString(CONSTANTS.MOBILE_PHONE_NUMBER, mobileNumber);

  static String getMembershipType() =>
      _prefs.getString(CONSTANTS.MEMBERSHIP_TYPE);

  static void setMembershipType(String membershipType) =>
      _prefs.setString(CONSTANTS.MEMBERSHIP_TYPE, membershipType);

  static String getMembershipTypeId() =>
      _prefs.getString(CONSTANTS.MEMBERSHIP_TYPE_ID);

  static void setMembershipTypeId(String membershipTypeId) =>
      _prefs.setString(CONSTANTS.MEMBERSHIP_TYPE_ID, membershipTypeId);

  static String getEmail() => _prefs.getString(CONSTANTS.EMAIL);

  static void setEmail(String email) =>
      _prefs.setString(CONSTANTS.EMAIL, email);

  static void setThemeColor(int color) =>
      _prefs.setInt(CONSTANTS.THEME_COLOR, color);

  static int getThemeColor() => _prefs.getInt(CONSTANTS.THEME_COLOR);

  static void removeUser() => _prefs.clear();
}
