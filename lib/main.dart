import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_crm/presentations/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:sw_crm/presentations/lead_screen/controller/lead_controller.dart';
import 'package:sw_crm/presentations/login_screen/controller/login_controller.dart';
import 'package:sw_crm/presentations/lead_screen/view/lead_screen.dart';
import 'package:sw_crm/presentations/login_screen/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sw_crm/app_config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool(AppConfig.loggedIn) ?? false;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginController()),
    ChangeNotifierProvider(create: (context) => LeadController()),
    ChangeNotifierProvider(create: (context) => LeadDetailController()),
  ], child: MyApp(isLoggedIn: loggedIn)));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const LeadScreen() : const LoginScreen(),
    );
  }
}
