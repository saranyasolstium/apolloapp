import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/view/home/home_screen.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:sizer/sizer.dart';

import '../auth/login_screen_mail.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      String aMobile = sharedPreferences!.getString("mobileNumber") ?? "";
      if(aMobile.isNotEmpty) {
        Get.offAll(() => const HomeScreen(index: 0));
      } else {
        Get.offAll(() => const LoginScreenMail());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: splashWhite,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/images/inf_logo_tm.png",
                  width: ScreenSize.getScreenWidth(context),
                ),
              ),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Powered By",
                  style: GoogleFonts.lato(
                    color: black,
                    fontSize: 12.0.sp,
                  ),
                ),
                const SizedBox(
                  width: 3.0,
                ),
                Image.asset(
                  "assets/images/apollo_hospitals_logo.png",
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
