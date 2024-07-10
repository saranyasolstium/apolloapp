import 'package:flutter/material.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:infinite/view/book/book_appointment.dart';
import 'package:sizer/sizer.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Get.to(() => const BookAppointment()),
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
            width: 100.0.w,
            height: ScreenSize.getScreenHeight(context) * 0.50,
            child: Image.asset("assets/images/eye_doctor.png"),
          ),
        ),
        Container(
          color: loginTextColor,
          child: Column(
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              Center(
                child: Image.asset(
                  "assets/images/inf_logo_white.png",
                ),
              ),
              SizedBox(
                height: 6.0.h,
              ),
              Text("Need any help?",
                  style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.none)),
              SizedBox(
                height: 6.0.h,
              ),
              SizedBox(
                width: 260,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => makeCallOrSendMessage(
                      "call", "+0421$myDefaultLandLineNumber", ""),
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Contact Us     ",
                    style: zzRegularWhiteTextStyle14,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: loginTextColor,
                      foregroundColor: loginTextColor,
                      side: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(
                height: 4.0.h,
              ),
              SizedBox(
                width: 260,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => Freshchat.showConversations(),
                  icon: const Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  label: Text("Chat with us", style: zzRegularWhiteTextStyle14),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: loginTextColor,
                      foregroundColor: loginTextColor,
                      side: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(
                height: 4.0.h,
              ),
              SizedBox(
                width: 260,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      makeCallOrSendMessage("mail", myDefaultMail, ""),
                  icon: const Icon(
                    Icons.mail_sharp,
                    color: Colors.white,
                  ),
                  label: Text("Mail us         ",
                      style: zzRegularWhiteTextStyle14),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: loginTextColor,
                      foregroundColor: loginTextColor,
                      side: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      )),
                ),
              ),
              SizedBox(
                height: 6.0.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
