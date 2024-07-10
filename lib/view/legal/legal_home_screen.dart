import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/view/legal/view_legal_webview_screen.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';

class LegalHomeScreen extends StatelessWidget {
  const LegalHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Legal",
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            ListTile(
              dense: true,
              onTap: () {
                launchURL("https://my6senses.com/pages/term-of-use");
              },
              title: Text(
                "Terms & Conditions",
                style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.0,
                color: colorPrimary,
              ),
            ),
            const Divider(
              height: 1,
              color: grayDark,
              thickness: 1,
            ),
            const SizedBox(
              height: 10.0,
            ),
            ListTile(
              dense: true,
              onTap: () {
                launchURL("https://my6senses.com/pages/privacy-policy");
              },
              title: Text(
                "Privacy Policy",
                style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.0,
                color: colorPrimary,
              ),
            ),
            const Divider(
              height: 1,
              color: grayDark,
              thickness: 1,
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
