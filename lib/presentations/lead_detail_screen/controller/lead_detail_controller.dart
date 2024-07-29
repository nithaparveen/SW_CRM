import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/lead_detail_screen/model/lead_detail_model.dart';
import '../../../repository/api/lead_detail_screen/service/lead_detail_service.dart';

class LeadDetailController extends ChangeNotifier {
  bool isLoading = false;
  LeadDetailModel leadDetailModel = LeadDetailModel();

  fetchDetailData(leadId, context) async {
    isLoading = true;
    notifyListeners();
    log("LeadDetailController -> fetchDetailData()");
    LeadDetailService.fetchDetailData(leadId).then((value) {
      if (value["status"] == true) {
        leadDetailModel = LeadDetailModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
      }
      notifyListeners();
    });
  }
}
