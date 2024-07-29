import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sw_crm/core/constants/colors.dart';
import 'package:sw_crm/presentations/lead_screen/controller/lead_controller.dart';
import '../../../app_config/app_config.dart';
import '../../../core/constants/textstyles.dart';
import '../../lead_detail_screen/view/lead_detail_screen.dart';
import '../../login_screen/view/login_screen.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Provider.of<LeadController>(context, listen: false)
        .fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("M&G",
                style: GLTextStyles.openSans(
                    color: ColorTheme.black,
                    size: 22,
                    weight: FontWeight.w700)),
            const SizedBox(width: 18),
            Text(
              "Leads",
              style:
                  GLTextStyles.robotoStyle(size: 20, weight: FontWeight.w500),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              size: 20,
            ),
            onPressed: () => logoutConfirmation(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchData();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<LeadController>(builder: (context, controller, _) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.leadsModel.data == null ||
                controller.leadsModel.data!.isEmpty) {
              return const Center(child: Text("No data available"));
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: size.width * .02),
                ),
                SliverList.separated(
                  itemCount: controller.leadsModel.data!.length,
                  itemBuilder: (context, index) {
                    var lead = controller.leadsModel.data![index];
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LeadDetailScreen(leadId: controller.leadsModel.data?[index].id,),));
                      },
                      child: Card(
                        surfaceTintColor: ColorTheme.white,
                        color: ColorTheme.white,
                        elevation: 2,
                        margin: const EdgeInsets.all(6),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lead.name ?? "No Name",
                                    style: GLTextStyles.openSans(
                                        size: 16, weight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    lead.email ?? "",
                                    style: GLTextStyles.openSans(
                                        size: 15, weight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    lead.phoneNumber ?? "",
                                    style: GLTextStyles.openSans(
                                        size: 15, weight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  formatDate(lead.createdAt),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: size.width * .02,
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) return 'Invalid date';
    try {
      return GetTimeAgo.parse(dateTime);
    } catch (e) {
      return 'Invalid date format';
    }
  }

  Future<void> logout(BuildContext context) async {
    log("Logout");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(AppConfig.token);
    sharedPreferences.setBool(AppConfig.loggedIn, false);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

  void logoutConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await logout(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
