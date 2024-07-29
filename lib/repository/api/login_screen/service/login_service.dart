import 'dart:developer';
import 'package:sw_crm/repository/helper/api_helper.dart';

import '../../../../core/utils/app_utils.dart';

class LoginService {
  static Future<dynamic> postLoginData(id, otp) async {
    try {
      var decodedData =
          await ApiHelper.postData(endPoint: "verify-otp?id=$id&otp=$otp");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }

  static Future<dynamic> sendOTP(email) async {
    log("LoginService -> sendOTP()");
    try {
      var decodedData = await ApiHelper.postData(
        endPoint: "login?email=$email",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
