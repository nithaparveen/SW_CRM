import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sw_crm/presentations/lead_screen/view/lead_screen.dart';
import '../../../app_config/app_config.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/login_screen/service/login_service.dart';
import '../../verify_otp_screen/view/verify_otp_screen.dart';
import '../view/login_screen.dart';

class LoginController extends ChangeNotifier {
  bool visibility = true;
  late SharedPreferences sharedPreferences;

  Future onLogin(id, otp, BuildContext context) async {
    log("loginController -> onLogin() started");
    var response = await LoginService.postLoginData(id, otp);
    if (response != null && response["success"] == true) {
      log("token -> ${response["data"]["token"]} ");
      await storeLoginData(response);
      await storeUserToken(response["data"]["token"]);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LeadScreen()),
          (route) => false);
    } else {
      log("Login failed, response: $response");
    }
  }

  Future<void> sendOTP(String email, BuildContext context) async {
    log("loginController -> sendOTP()");
    var response = await LoginService.sendOTP(email);
    if (response != null && response["success"] == true) {
      log("id -> ${response["data"]["id"]} ");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VerifyOTPScreen(id: response["data"]["id"])),
          (route) => false);
      AppUtils.oneTimeSnackBar(response["message"],
          context: context,
          textStyle: const TextStyle(fontSize: 18),
          bgColor: Colors.white24);
    } else {
      AppUtils.oneTimeSnackBar(response["message"],
          context: context, bgColor: Colors.redAccent);
    }
  }

  Future<void> storeLoginData(Map<String, dynamic> loginReceivedData) async {
    log("storeLoginData()");
    sharedPreferences = await SharedPreferences.getInstance();
    String storeData = jsonEncode(loginReceivedData);
    sharedPreferences.setString(AppConfig.loginData, storeData);
    sharedPreferences.setBool(AppConfig.loggedIn, true);
  }

  Future<void> storeUserToken(String token) async {
    log("storeUserToken");
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AppConfig.token, token);
  }

  Future<void> logout(BuildContext context) async {
    log("Logout");
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(AppConfig.token);
    sharedPreferences.setBool(AppConfig.loggedIn, false);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
