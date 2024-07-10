import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';
import 'package:sizer/sizer.dart';

class Notification1 extends StatefulWidget {
  const Notification1({Key? key}) : super(key: key);

  @override
  State<Notification1> createState() => _NotificationState();
}

class _NotificationState extends State<Notification1> {
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Notification",
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: sandal,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ratingColor,
                      ),
                      height: 26,
                      width: 80,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '45% OFF',
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0.sp),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/ear_mask_group.png",
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "On Hearing Aids of your Choice ",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("View Now"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery by today",
                            style:
                                GoogleFonts.lato(color: green1, fontSize: 18.0),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 24,
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.black12,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/eye_glass.png",
                            width: 130,
                            height: 130,
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Product Name will be here",
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 14.0)),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "₹500",
                                    style: zzRegularBlackTextStyle10,
                                  ),
                                  SizedBox(
                                    width: 1.0.w,
                                  ),
                                  Text(
                                    "₹1500",
                                    style: zzRegularBlackTextStyle10_,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Frame size:medium"),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Text("Appointment reminder"),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/call_ayush_icon.svg",
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset("assets/svg/arrow_ayush_icon.svg")
                          ],
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.black12,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/eye_glass.png",
                          width: 130,
                          height: 130,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Clinic Name",
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                                "#123, Lorem ipsum address, \ngroundfloor,  \nNew Delhi, 110001"),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Open",
                                  style: GoogleFonts.lato(
                                      color: green1, fontSize: 14),
                                ),
                                const Text("  8.00 AM to 9.00 PM")
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Offer of the day')),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              width: 100.w,
              height: 70.0.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset("assets/images/notification_img.png"),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Offer for you')),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: sandal,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ratingColor,
                      ),
                      height: 26,
                      width: 80,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '45% OFF',
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0.sp),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/ear_mask_group.png",
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Audio kit that may you \nlike",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("View Now"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black,
                  ),
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Image.asset("assets/images/eye_glass.png",
                          width: 120, height: 130),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Icon(
                            Icons.star,
                            color: ratingColor,
                            size: 15,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "You won a gift voucher",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("use WON50%OFF coupon on your next order",
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 10)),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                padding: const EdgeInsets.only(
                                    right: 30, left: 30, top: 10, bottom: 10)),
                            child: Text(
                              "Copy",
                              style: (GoogleFonts.lato(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
