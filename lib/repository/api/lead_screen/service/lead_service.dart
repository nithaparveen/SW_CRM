import 'dart:developer';
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
  static Future<dynamic> fetchLeads({required int page}) async {
    log("LeadService -> fetchLeads()");
    try {
      var nextPage = "http://be.mandgholidays.com/api/app/lead/list?page=$page";
      var decodedData = await ApiHelper.getDataWObaseUrl(
        endPoint: nextPage,
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
      throw Exception('Failed to fetch leads');
    }
  }
}
