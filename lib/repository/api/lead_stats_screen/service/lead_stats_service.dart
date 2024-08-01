import '../model/lead_stats_model.dart';
import 'package:http/http.dart'as http;

class LeadStatsService {
  final String _baseUrl = 'http://be.mandgholidays.com/api/app/lead/stats';

  Future<List<LeadStatsModel>> fetchLeadStats() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      print('API Response: ${response.body}'); // Debug line
      return leadStatsModelFromJson(response.body);
    } else {
      print('Failed to load data: ${response.statusCode}'); // Debug line
      throw Exception('Failed to load lead stats');
    }
  }
}
