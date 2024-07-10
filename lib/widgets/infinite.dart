import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/utils/global.dart';

class Infinite extends StatefulWidget {
  const Infinite({Key? key}) : super(key: key);

  @override
  State<Infinite> createState() => _InfiniteState();
}

class _InfiniteState extends State<Infinite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: loginTextColor,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                "assets/images/inf_logo_tm.png",
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text("Need any help?",
              style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white,
                  decoration: TextDecoration.none)),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 260,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () => makeCallOrSendMessage(
                  "call", "+0421$myDefaultLandLineNumber", ""),
              icon: SvgPicture.asset(
                "assets/svg/call.svg",
                width: 20,
                height: 20,
              ),
              label: const Text("Contact Us"),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: loginTextColor,
                  side: const BorderSide(
                    width: 1,
                    color: Colors.white,
                  )),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 260,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () => Freshchat.showConversations(),
              icon:
                  Image.asset("assets/images/chat.png", height: 20, width: 20),
              label: const Text("Chat with us"),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: loginTextColor,
                  side: const BorderSide(
                    width: 1,
                    color: Colors.white,
                  )),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 260,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () => makeCallOrSendMessage("mail", myDefaultMail, ""),
              icon: Image.asset(
                "assets/images/mail.png",
                width: 20,
                height: 20,
              ),
              label: const Text("Mail us"),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: loginTextColor,
                  side: const BorderSide(
                    width: 1,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
