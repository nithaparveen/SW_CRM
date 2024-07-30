// To parse this JSON data, do
//
//     final leadStatsModel = leadStatsModelFromJson(jsonString);

import 'dart:convert';

List<LeadStatsModel> leadStatsModelFromJson(String str) => List<LeadStatsModel>.from(json.decode(str).map((x) => LeadStatsModel.fromJson(x)));

String leadStatsModelToJson(List<LeadStatsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeadStatsModel {
  String? day;
  DateTime? date;
  int? count;

  LeadStatsModel({
    this.day,
    this.date,
    this.count,
  });

  factory LeadStatsModel.fromJson(Map<String, dynamic> json) => LeadStatsModel(
    day: json["day"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "count": count,
  };
}
