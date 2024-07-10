import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/res/colors.dart';

class Week extends StatefulWidget {
  const Week({Key? key}) : super(key: key);

  @override
  State<Week> createState() => _WeekState();
}

class _WeekState extends State<Week> {
  bool isSelected = false;
  String radioButtonItem = 'ONE';
  int id = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(
                    Icons.favorite_border_sharp,
                    color: Colors.black54,
                    size: 24,
                  ))
            ]),
            Image.asset("assets/images/eye_glass_2.png"),
            Container(
              decoration: const BoxDecoration(
                color: lightBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              height: 60,
              width: 200,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    "assets/images/star.png",
                    width: 12,
                    height: 12,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("4.5",
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.black54,
                          decoration: TextDecoration.none)),
                  const SizedBox(
                    width: 40,
                  ),
                  const VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Text("12",
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.black54,
                          decoration: TextDecoration.none))
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Product Name will be here",
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.black54,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text("₹ 500",
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.black54,
                        decoration: TextDecoration.none)),
                Text("₹ 1500",
                    style: GoogleFonts.lato(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 16,
                      color: Colors.black54,
                    )),
              ],
            ),
            const Row(
              children: [
                SizedBox(width: 15.0),
                CircleAvatar(
                  backgroundColor: loginTextColor,
                  radius: 14.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12.0,
                    child: CircleAvatar(
                      backgroundColor: pink,
                      radius: 10.0,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                CircleAvatar(
                  backgroundColor: black2,
                  radius: 10.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
