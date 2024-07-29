import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class LeadService {
  static Future<Map<String, dynamic>?> fetchData() async {
    log("LeadService -> fetchData()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "lead/list",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData is Map<String, dynamic> ? decodedData : null;
    } catch (e, stackTrace) {
      log("Error in LeadService: $e\nStackTrace: $stackTrace");
      return null;
    }
  }
}
