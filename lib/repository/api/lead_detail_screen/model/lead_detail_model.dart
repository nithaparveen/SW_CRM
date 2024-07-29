// To parse this JSON data, do
//
//     final leadDetailModel = leadDetailModelFromJson(jsonString);

import 'dart:convert';

LeadDetailModel leadDetailModelFromJson(String str) => LeadDetailModel.fromJson(json.decode(str));

String leadDetailModelToJson(LeadDetailModel data) => json.encode(data.toJson());

class LeadDetailModel {
  bool? status;
  Data? data;

  LeadDetailModel({
    this.status,
    this.data,
  });

  factory LeadDetailModel.fromJson(Map<String, dynamic> json) => LeadDetailModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? location;
  String? message;
  dynamic extraData;
  String? leadType;
  dynamic utmSource;
  dynamic utmMedium;
  dynamic utmCampaign;
  dynamic gclid;
  dynamic sourceUrl;
  dynamic ipAddress;
  dynamic userAgent;
  dynamic referrerLink;
  dynamic remarks;
  String? status;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.location,
    this.message,
    this.extraData,
    this.leadType,
    this.utmSource,
    this.utmMedium,
    this.utmCampaign,
    this.gclid,
    this.sourceUrl,
    this.ipAddress,
    this.userAgent,
    this.referrerLink,
    this.remarks,
    this.status,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    location: json["location"],
    message: json["message"],
    extraData: json["extra_data"],
    leadType: json["lead_type"],
    utmSource: json["utm_source"],
    utmMedium: json["utm_medium"],
    utmCampaign: json["utm_campaign"],
    gclid: json["gclid"],
    sourceUrl: json["source_url"],
    ipAddress: json["ip_address"],
    userAgent: json["user_agent"],
    referrerLink: json["referrer_link"],
    remarks: json["remarks"],
    status: json["status"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "location": location,
    "message": message,
    "extra_data": extraData,
    "lead_type": leadType,
    "utm_source": utmSource,
    "utm_medium": utmMedium,
    "utm_campaign": utmCampaign,
    "gclid": gclid,
    "source_url": sourceUrl,
    "ip_address": ipAddress,
    "user_agent": userAgent,
    "referrer_link": referrerLink,
    "remarks": remarks,
    "status": status,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
