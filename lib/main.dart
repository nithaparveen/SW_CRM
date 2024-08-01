import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sw_crm/presentations/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:sw_crm/presentations/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:sw_crm/presentations/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:sw_crm/presentations/lead_detail_screen/view/lead_detail_screen.dart';
import 'package:sw_crm/presentations/lead_screen/controller/lead_controller.dart';
import 'package:sw_crm/presentations/login_screen/controller/login_controller.dart';
import 'package:sw_crm/presentations/login_screen/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sw_crm/app_config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool(AppConfig.loggedIn) ?? false;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginController()),
    ChangeNotifierProvider(create: (context) => BottomNavigationController()),
    ChangeNotifierProvider(create: (context) => LeadController()),
    ChangeNotifierProvider(create: (context) => LeadDetailController()),
  ], child: MyApp(isLoggedIn: loggedIn)));
  initOneSignal();
}
Future<void> initOneSignal() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("0bca5bfa-cc62-4069-960a-4e2af3932a01");
  await OneSignal.Notifications.requestPermission(true);
  OneSignal.User.addTags({"segment":"Notifications"});
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});
  static final navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    onClickOneSignal();
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const BottomNavBar() : const LoginScreen(),
    );
  }
  void onClickOneSignal() {
    int? leadId;
    OneSignal.Notifications.addClickListener((event) {
      final data = event.notification.additionalData;
      leadId = data?['lead_id'];
      if (leadId != null) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => LeadDetailScreen(
              leadId: leadId,
            ),
          ),
        );
      }
      log("DATA =====> $leadId");
      final id = OneSignal.User.pushSubscription.id;
      log("############### $id");
    });
  }
}
