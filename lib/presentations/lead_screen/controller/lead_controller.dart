import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sw_crm/repository/api/lead_screen/model/leads_model.dart';
import 'package:sw_crm/repository/api/lead_screen/service/lead_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';

class LeadController extends ChangeNotifier {
  LeadListResponse leadsModel = LeadListResponse(data: []);
  bool isLoading = false;

  Future<void> fetchData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    log("LeadController -> fetchData()");
    try {
      var value = await LeadService.fetchData();
      log("Fetched value: $value");
      if (value != null && value.isNotEmpty) {
        leadsModel = LeadListResponse.fromJson(value);
      } else {
        AppUtils.oneTimeSnackBar("No data received",
            context: context, bgColor: ColorTheme.red);
      }
    } catch (e, stackTrace) {
      log("Error fetching data: $e\nStackTrace: $stackTrace");
      AppUtils.oneTimeSnackBar("An error occurred while fetching data",
          context: context, bgColor: ColorTheme.red);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
