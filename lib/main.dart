import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_crm/presentations/login_screen/controller/login_controller.dart';
import 'package:sw_crm/presentations/login_screen/view/login_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
