import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/textstyles.dart';
import '../../login_screen/controller/login_controller.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.id});

  final int id;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  var otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("M&G",
                style: GLTextStyles.openSans(
                    color: ColorTheme.black,
                    size: 20,
                    weight: FontWeight.w700)),
            SizedBox(
              width: size.width * .04,
            ),
            Text("MANAGEMENT PORTAL",
                style: GLTextStyles.openSans(
                    color: ColorTheme.black,
                    size: 14,
                    weight: FontWeight.w400)),
          ],
        ),
        forceMaterialTransparency: false,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.width * .04,
            ),
            Text(
              "Verification Code",
              style: GLTextStyles.interStyle(
                  size: 22, color: ColorTheme.black, weight: FontWeight.w600),
            ),
            Text("Please enter the Verification code sent to your email",
                style: GLTextStyles.interStyle(
                    color: ColorTheme.grey, size: 14, weight: FontWeight.w400)),
            SizedBox(
              height: size.width * .05,
            ),
            SizedBox(
              width: size.width * .9,
              child: TextFormField(
                controller: otpController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.numbers, size: 22),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xff1A3447)),
                    )),
              ),
            ),
            SizedBox(
              height: size.width * .05,
            ),
            SizedBox(
              height: size.height * 0.085,
              width: size.width * 0.9,
              child: MaterialButton(
                color: ColorTheme.lightBlue,
                onPressed: () {
                  Provider.of<LoginController>(context, listen: false)
                      .onLogin(widget.id, otpController.text.trim(), context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Verify & Sign In",
                      style: GLTextStyles.robotoStyle(
                          color: ColorTheme.white,
                          size: 18,
                          weight: FontWeight.w600),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 21,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
