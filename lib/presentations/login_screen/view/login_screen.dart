import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_crm/presentations/login_screen/controller/login_controller.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/textstyles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

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
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text("Welcome Back",
                        style: GLTextStyles.interStyle(
                            color: ColorTheme.black,
                            size: 30,
                            weight: FontWeight.w500)),
                    Text(
                        "To continue, please enter your email. \nWe will send you 6 - digit OTP.",
                        style: GLTextStyles.interStyle(
                            color: ColorTheme.grey,
                            size: 12,
                            weight: FontWeight.w400)),
                    SizedBox(
                      height: size.width * .01,
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Stack(children: [
                      Container(
                        height: size.height * .4,
                        width: size.width * .9,
                        child: Image.asset("assets/images/loginImg.jpeg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 25),
                        child: Text("M&G Holidays",
                            style: GLTextStyles.openSans(
                                color: ColorTheme.white,
                                size: 14,
                                weight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 70),
                        child: Text("Simplifying \nEducational \nProcesses.",
                            style: GLTextStyles.interStyle(
                                color: ColorTheme.white,
                                size: 20,
                                weight: FontWeight.w400)),
                      ),
                    ]),
                    SizedBox(
                      height: size.width * .05,
                    ),
                    SizedBox(
                      width: size.width * .9,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Enter your official email",
                            hintStyle: GLTextStyles.openSans(
                                color: ColorTheme.black,
                                size: 14,
                                weight: FontWeight.w400),
                            prefixIcon: const Icon(Icons.email_outlined, size: 22),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xff1A3447)),
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
                          Provider.of<LoginController>(context,listen: false).sendOTP(emailController.text.trim(), context);

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Generate OTP",
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
            ],
          ),
        ),
      ),
    );
  }
}
