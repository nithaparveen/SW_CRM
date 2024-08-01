import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sw_crm/repository/api/lead_screen/model/leads_model.dart';
import 'package:sw_crm/repository/api/lead_screen/service/lead_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';

class LeadController extends ChangeNotifier {
  LeadListResponse leadsModel = LeadListResponse(data: []);
  bool isLoading = false;
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;

  bool get isLoadingMore => _isLoadingMore;

  Future<void> fetchData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    log("LeadController -> fetchData()");
    try {
      var value = await LeadService.fetchData();
      log("Fetched value: $value");
      if (value != null && value.isNotEmpty) {
        leadsModel = LeadListResponse.fromJson(value);
        _currentPage = 2;
        _hasMoreData = true;
      } else {
        AppUtils.oneTimeSnackBar("No data received", context: context, bgColor: ColorTheme.red);
      }
    } catch (e, stackTrace) {
      log("Error fetching data: $e\nStackTrace: $stackTrace");
      AppUtils.oneTimeSnackBar("An error occurred while fetching data", context: context, bgColor: ColorTheme.red);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreData(BuildContext context) async {
    if (!_isLoadingMore && _hasMoreData) {
      _isLoadingMore = true;
      notifyListeners();
      log("LeadController -> loadMoreData() -> page $_currentPage");
      try {
        var response = await LeadService.fetchLeads(page: _currentPage);
        log("Fetched more data: $response");
        if (response != null && response.isNotEmpty) {
          var newData = LeadListResponse.fromJson(response);
          if (newData.data?.isNotEmpty ?? false) {
            leadsModel.data?.addAll(newData.data ?? []);
            _currentPage++;
          } else {
            _hasMoreData = false;
            AppUtils.oneTimeSnackBar("No more data received", context: context, bgColor: ColorTheme.red);
          }
        }
      } catch (e, stackTrace) {
        log("Error loading more data: $e\nStackTrace: $stackTrace");
        AppUtils.oneTimeSnackBar("An error occurred while loading more data", context: context, bgColor: ColorTheme.red);
      } finally {
        _isLoadingMore = false;
        notifyListeners();
      }
    }
  }
}


