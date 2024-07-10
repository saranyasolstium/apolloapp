import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/colors.dart';
import '../../res/styles.dart';
import '../../utils/global.dart';
import '../../widgets/default_navigation_widget.dart';
import '../book/trial_list_book_appointment.dart';
import '../products/product_list_screen.dart';

class SelectProductScreen extends StatefulWidget {
  final String handle;
  const SelectProductScreen({Key? key, required this.handle}) : super(key: key);

  @override
  State<SelectProductScreen> createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  int mySelectType = 0, mySelectAppointmentType = 1;
  String mySelectAppointmentType2 = 'In Home';

  @override
  void initState() {
    mySelectType=0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
        title: "Book Home Test",
        child: Column(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Select options to follow the step to",
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "book an appointment",
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     if (mounted) {
                    //       setState(() => mySelectType = 1);
                    //     }
                    //     // Get.to(()=>const BookAppointmentDetails());
                    //   },
                    //   child: Card(
                    //     margin: const EdgeInsets.all(10),
                    //     child: Container(
                    //       height: 100,
                    //       padding: const EdgeInsets.all(10),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //         color: mySelectType == 1 ? loginBlue2 : white,
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           SvgPicture.asset("assets/svg/ear1.svg"),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Text("For Ear",
                    //                   style: GoogleFonts.lato(
                    //                       fontSize: 18,
                    //                       fontWeight: FontWeight.bold)),
                    //               const Text("Unleash the Power of Our Hearing Aids!"),
                    //             ],
                    //           ),
                    //           mySelectType == 1
                    //               ? SvgPicture.asset("assets/svg/ayush_icon2.svg")
                    //               : SvgPicture.asset("assets/svg/ayush_icon.svg"),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        style: ListTileStyle.drawer,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        dense: true,
                        tileColor: mySelectType == 1 ? loginBlue2 : white,
                        onTap: () {
                          if (mounted) {
                            setState(() => mySelectType = 1);
                          }
                          // Get.to(()=>const BookAppointmentDetails());
                        },
                        trailing:  SizedBox(
                            height: double.infinity,
                            child: mySelectType == 1
                                ? SvgPicture.asset("assets/svg/ayush_icon2.svg")
                                : SvgPicture.asset("assets/svg/ayush_icon.svg")),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("For Ear",
                                style: GoogleFonts.lato(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                           // const Text("Unleash the Power of Our Hearing Aids!"),
                             Text("Advanced Solutions to hear Clear and Natural Sound. Home Visits with Just a Click.", style:zzRegularBlackTextStyle10A),
                          ],
                        ),
                        leading: SizedBox(
                            height: double.infinity,
                            child: SvgPicture.asset("assets/svg/ear1.svg")),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () {
                          if (mounted) {
                            setState(() => mySelectType = 2);

                          //  Get.to(()=> const ViewProductListScreen(411246690548,fromWhere: 6));
                          }
                          // Get.to(()=>const BookAppointmentDetails());
                        },
                        style: ListTileStyle.drawer,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        dense: true,
                        leading: SizedBox(
                            height: double.infinity,
                            child: SvgPicture.asset("assets/svg/eye1.svg")),
                        tileColor: mySelectType == 2 ? loginBlue2 : white,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("For Eye",
                                style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold)),
                          //  const Text("Elevate Your Look with our Trendsetting Eyewear!"),
                            Text("Check your Vision & Try out your favorite eyewear from the comfort of your home.",style:zzRegularBlackTextStyle10A)
                          ],
                        ),
                        trailing:
                        SizedBox(
                          height: double.infinity,
                          child: mySelectType == 2
                              ? SvgPicture.asset("assets/svg/ayush_icon2.svg")
                              : SvgPicture.asset("assets/svg/ayush_icon.svg")
                        )
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () {
                          if (mounted) {
                      //      setState(() => mySelectType = 2);
                       setState(() {
                         mySelectType = 3;
                              });
                          }
                          // Get.to(()=>const BookAppointmentDetails());
                        },
                        style: ListTileStyle.drawer,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        dense: true,
                        leading: SizedBox(
                            height:double.infinity,
                            child: SvgPicture.asset("assets/svg/sleepcare.svg",width: 50,height: 50)),
                        tileColor: mySelectType == 3 ? loginBlue2 : white,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sleep Care",
                                style: GoogleFonts.lato(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            //  const Text("Elevate Your Look with our Trendsetting Eyewear!"),
                            Text("Enhance your sleep quality and well-being with comprehensive sleep care solutions.",style:zzRegularBlackTextStyle10A)
                          ]),
                        trailing:  SizedBox(
                            height: double.infinity,
                            child: mySelectType == 3
                                ? SvgPicture.asset("assets/svg/ayush_icon2.svg")
                                : SvgPicture.asset("assets/svg/ayush_icon.svg")
                        )
                      ),
                    ),

                  ]),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  height: 100,
                  //margin: EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                      color: loginBlue2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (mySelectType == 1) {
                              Get.to(() => TrialListBookAppointment(411751645428,type: mySelectAppointmentType2));
                            } else if(mySelectType == 2){
                              Get.to(()=>  ViewProductListScreen(411246690548,fromWhere: 6,handle: widget.handle));
                            } else {
                            showSuccessSnackBar(context, 'Coming soon...');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.only(
                                  right: 30, left: 30, top: 15, bottom: 15),
                              backgroundColor: loginTextColor),
                          child: const Text(
                            "Proceed",
                          )),
                    ],
                  )),
            ),
          ],
        ));
  }
}
