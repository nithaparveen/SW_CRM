import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sw_crm/presentations/lead_screen/view/lead_screen.dart';
import '../../../app_config/app_config.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/login_screen/service/login_service.dart';
import '../../verify_otp_screen/view/verify_otp_screen.dart';

class LoginController extends ChangeNotifier {
  bool visibility = true;
  late SharedPreferences sharedPreferences;

  Future onLogin(id, otp, BuildContext context) async {
    log("loginController -> onLogin() started");
    LoginService.postLoginData(id, otp).then((value) {
      log("postLoginData() -> ${value["success"]}");
      if (value["success"] == true) {
        log("token -> ${value["data"]["token"]} ");
        storeLoginData(value);
        storeUserToken(value["data"]["token"]);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LeadScreen()),
            (route) => false);
      } else {
        log("Else Condition >> Api failed");
      }
    });
  }

  sendOTP(String email, context) async {
    log("loginController -> sendOTP()");
    LoginService.sendOTP(email).then((value) {
      if (value["success"] == true) {
        log("id -> ${value["data"]["id"]} ");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyOTPScreen(
                      id: value["data"]["id"],
                    )),
            (route) => false);
        AppUtils.oneTimeSnackBar(value["message"],
            context: context,
            textStyle: const TextStyle(fontSize: 18),
            bgColor: Colors.white24);
      } else {
        AppUtils.oneTimeSnackBar(value["message"],
            context: context, bgColor: Colors.redAccent);
      }
    });
  }

  void storeLoginData(loginReceivedData) async {
    log("storeLoginData()");
    sharedPreferences = await SharedPreferences.getInstance();
    String storeData = jsonEncode(loginReceivedData);
    sharedPreferences.setString(AppConfig.loginData, storeData);
    sharedPreferences.setBool(AppConfig.loggedIn, true);
  }

  void storeUserToken(resData) async {
    log("storeUserToken");
    sharedPreferences = await SharedPreferences.getInstance();
    String dataUser = json.encode(resData);
    sharedPreferences.setString(AppConfig.token, dataUser);
  }
}
