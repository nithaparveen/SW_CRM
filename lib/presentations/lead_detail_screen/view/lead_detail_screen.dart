import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/textstyles.dart';
import '../controller/lead_detail_controller.dart';

class LeadDetailScreen extends StatefulWidget {
  final int? leadId;

  const LeadDetailScreen({super.key, this.leadId});

  @override
  LeadDetailScreenState createState() => LeadDetailScreenState();
}

class LeadDetailScreenState extends State<LeadDetailScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    await Provider.of<LeadDetailController>(context, listen: false)
        .fetchDetailData(widget.leadId, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: GLTextStyles.robotoStyle(size: 22, weight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        forceMaterialTransparency: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchData(),
        child: Consumer<LeadDetailController>(
          builder: (context, controller, _) {

            String formatTime(DateTime? dateTime) {
              if (dateTime == null) return 'Invalid date';
              try {
                return GetTimeAgo.parse(dateTime);
              } catch (e) {
                print("Error formatting date: $e");
                return 'Invalid date format';
              }
            }

            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.grey,
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLeadInfoCard(controller, formatTime),
                        buildDetailSection(controller),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildLeadInfoCard(
      LeadDetailController controller, String Function(DateTime?) formatDate) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.leadDetailModel.data?.name != null)
                  Text(
                    controller.leadDetailModel.data?.name ?? "",
                    style: GLTextStyles.robotoStyle(
                        size: 18, weight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  if (controller.leadDetailModel.data?.email != null)
                  Text(
                    controller.leadDetailModel.data?.email ?? "",
                    style: GLTextStyles.robotoStyle(
                        size: 15, weight: FontWeight.w400),
                  ),
                  const SizedBox(height: 4),
                  if (controller.leadDetailModel.data?.phoneNumber != null)
                  Text(
                    controller.leadDetailModel.data?.phoneNumber ?? "",
                    style: GLTextStyles.robotoStyle(
                        size: 15, weight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                formatDate(DateTime.parse(
                    "${controller.leadDetailModel.data?.createdAt}")),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailSection(LeadDetailController controller) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            details.length,
                (index) {
              final value = getDetailValue(controller, index);
              if (value == null || value.isEmpty) return Container();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(details[index],
                          style: GLTextStyles.cabinStyle(size: 18)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Wrap(
                        children: [
                          Text(
                            ": ${getDetailValue(controller, index)}",
                            style: GLTextStyles.cabinStyle(
                                size: 18, weight: FontWeight.w500),
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String? getDetailValue(LeadDetailController controller, int index) {
    switch (details[index]) {
      case "Name":
        return controller.leadDetailModel.data?.name ?? "";
      case "Email":
        return controller.leadDetailModel.data?.email ?? "";
      case "Phone Number":
        return controller.leadDetailModel.data?.phoneNumber ?? "";
      case "Location":
        return controller.leadDetailModel.data?.location ?? "";
      case "Message":
        return controller.leadDetailModel.data?.message ?? "";
      case "Lead type":
        return controller.leadDetailModel.data?.leadType ?? "";
      case "Utm source":
        return controller.leadDetailModel.data?.utmSource ?? "";
      case "Utm medium":
        return controller.leadDetailModel.data?.utmMedium ?? "";
      case "Utm campaign":
        return controller.leadDetailModel.data?.utmCampaign ?? "";
      case "gclid":
        return controller.leadDetailModel.data?.gclid ?? "";
      case "Source url":
        return controller.leadDetailModel.data?.sourceUrl ?? "";
      case "ip address":
        return controller.leadDetailModel.data?.ipAddress ?? "";
      case "User agent":
        return controller.leadDetailModel.data?.userAgent ?? "";
      case "Referrer link":
        return controller.leadDetailModel.data?.referrerLink ?? "";
      case "Remarks":
        return controller.leadDetailModel.data?.remarks ?? "";
      case "Status":
        return controller.leadDetailModel.data?.status ?? "";
      case "Created at":
        return formatDate(
            DateTime.parse("${controller.leadDetailModel.data?.createdAt}"));
      case "Updated at":
        return formatDate(
            DateTime.parse("${controller.leadDetailModel.data?.updatedAt}"));
      default:
        return null;
    }
  }

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Invalid date';
    }
    try {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      log("Error formatting date: $e");
      return 'Invalid date format';
    }
  }
}

const List<String> details = [
  "Name",
  "Email",
  "Phone Number",
  "Location",
  "Message",
  "Lead type",
  "Utm source",
  "Utm medium",
  "Utm campaign",
  "gclid",
  "Source url",
  "ip address",
  "User agent",
  "Referrer link",
  "Remarks",
  "Status",
  "Created at",
  "Updated at"
];
