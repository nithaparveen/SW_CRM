import 'package:flutter/material.dart';

import '../../../core/constants/textstyles.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leads",
          style: GLTextStyles.robotoStyle(size: 22, weight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
    );
  }
}
