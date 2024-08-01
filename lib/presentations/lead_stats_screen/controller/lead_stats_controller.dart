import 'package:flutter/cupertino.dart';

import '../../../repository/api/lead_stats_screen/model/lead_stats_model.dart';
import '../../../repository/api/lead_stats_screen/service/lead_stats_service.dart';

class LeadStatsController with ChangeNotifier {
  final LeadStatsService _leadStatsService;
  List<LeadStatsModel>? _leadStats;
  bool _isLoading = false;
  String? _errorMessage;

  LeadStatsController(this._leadStatsService);

  List<LeadStatsModel>? get leadStats => _leadStats;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadLeadStats() async {
    _isLoading = true;
    notifyListeners();

    try {
      _leadStats = await _leadStatsService.fetchLeadStats();
      _errorMessage = null;
      print('Loaded lead stats: $_leadStats'); // Debug line
    } catch (e) {
      _errorMessage = e.toString();
      print('Error fetching data: $_errorMessage'); // Debug line
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
