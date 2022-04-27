import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //static String sharedprefrenceIsAppVersionKey = "App_Version";
  //static String sharedprefrenceIsRememberMeKey = "REMEMBER_ME";
  static String sharedprefrenceLoggerInKey = "ISLOGGEDIN";
  static String sharedprefrenceUserName = "USERNAME";
  static String sharedprefrenceFirstTimeVisit = "FirstTimeVisit";
  static String sharedprefrencePassword= "Password";
  static String sharedprefrenceLocality = "Locality";
  // static String sharedprefrenceUserType = "USERTYPE";
  //static String sharedprefrenceCompanyNo = "COMPANYNO";
  // static String sharedprefrencePassword = "PASSWORD";
  // static String sharedprefrenceIsPlotRoute = "ISPLOTROUTE";
  //static String sharedprefrenceVehicleOrigin = "VEHICLE_ORIGIN";
  //static String sharedprefrenceVehicleDestination = "VEHICLE_DESTINATION";

  //----Save Data To Sharedprefrence----
  // static Future<bool> saveAppVersionState(String appVersion) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setString(sharedprefrenceIsAppVersionKey, appVersion);
  // }

  // static Future<bool> saveUserRememberMeState(bool rememberMe) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setBool(sharedprefrenceIsRememberMeKey, rememberMe);
  // }
  static Future<bool> savePassword(String Password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefrencePassword, Password);
  }

  static Future<bool> saveLocality(String Locality) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefrenceLocality, Locality);
  }

  static Future<bool> saveFirstTimeUser(bool firstTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedprefrenceFirstTimeVisit, firstTime);
  }

  static Future<bool> saveUserLoggedInState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedprefrenceLoggerInKey, isLoggedIn);
  }

  static Future<bool> saveUserNameInSharedPrefrence(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefrenceUserName, username);
  }

  // static Future<bool> saveUserTypeInSharedPrefrence(String userType) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setString(sharedprefrenceUserType, userType);
  // }

  // static Future<bool> saveCompanyNoInSharedPrefrence(String companyNo) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setString(sharedprefrenceCompanyNo, companyNo);
  // }
  //
  // static Future<bool> savePasswordSharedPrefrence(String password) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setString(sharedprefrencePassword, password);
  // }
  //
  // static Future<bool> saveIsRoutePlotSharedPrefrence(bool isRoute) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setBool(sharedprefrenceIsPlotRoute, isRoute);
  // }
  //
  // static Future<bool> saveVehicleOriginSharedPrefrence(
  //     String vehicleOrigin) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setString(sharedprefrenceVehicleOrigin, vehicleOrigin);
  // }

  // static Future<bool> saveVehicleDestinationSharedPrefrence(
  //     String vehicleDestination) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setString(
  //       sharedprefrenceVehicleDestination, vehicleDestination);
  // }

  //--Getting Data from SharedPrefrences-----
  // static Future<String?> getAppVersionState() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(sharedprefrenceIsAppVersionKey);
  // }
  //
  // static Future<bool?> getUserRememberMeState() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(sharedprefrenceIsRememberMeKey);
  // }
  static Future<bool?> getFirstTimeloginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? state = await prefs.getBool(sharedprefrenceFirstTimeVisit);
    return state;
  }

  static Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedprefrencePassword);
  }

  static Future<String?> getLocality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedprefrenceLocality);
  }

  static Future<bool?> getUserLoggedInState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedprefrenceLoggerInKey);
  }

  static Future<String?> getUserNameFromSharedPrefrence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedprefrenceUserName);
  }

// static Future<String?> getUserTypeFromSharedPrefrence() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString(sharedprefrenceUserType);
// }
//
// static Future<String?> getCompanyNoFromSharedPrefrence() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString(sharedprefrenceCompanyNo);
// }
//
// static Future<String?> getPasswordFromSharedPrefrence() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString(sharedprefrencePassword);
// }

// static Future<bool?> getIsPlotRouteFromSharedPrefrence() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getBool(sharedprefrenceIsPlotRoute);
// }
//
// static Future<String?> getVehicleOriginFromSharedPrefrence() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString(sharedprefrenceVehicleOrigin);
// }
//
// static Future<String?> getVehicleDestinationFromSharedPrefrence() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString(sharedprefrenceVehicleDestination);
// }
}
