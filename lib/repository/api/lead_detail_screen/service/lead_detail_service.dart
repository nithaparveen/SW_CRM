import 'dart:developer';
import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class LeadDetailService {
  static Future<dynamic> fetchDetailData(leadId) async {
    log("LeadDetailService -> fetchDetailData()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "lead/view/$leadId",
        header: ApiHelper.getApiHeader(access: await AppUtils.getToken()),
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
