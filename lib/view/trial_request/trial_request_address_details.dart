import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:infinite/view/trial_request/trial_request_slot.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';

import '../../res/colors.dart';
import '../../res/styles.dart';

class TrialRequestAddress extends StatefulWidget {
  final int id;
  final String title;
  final int variantId;
  final String productType;
  final String variantName;
  final String unitPrice;
  final String src;
  final int invQty;

  const TrialRequestAddress(
      {Key? key,
      required this.id,
      required this.title,
      required this.variantId,
      required this.productType,
      required this.variantName,
      required this.unitPrice,
      required this.src,
      required this.invQty})
      : super(key: key);

  @override
  State<TrialRequestAddress> createState() => _TrialRequestAddressState();
}

class _TrialRequestAddressState extends State<TrialRequestAddress> {
  int activeStep = 0;
  int dotCount = 3;
  String radioButtonItem = 'ONE';

  int id = 1;

  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Trial Request",
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                width: ScreenSize.getScreenWidth(context),
                height: ScreenSize.getScreenHeight(context),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SvgPicture.asset("assets/svg/profile_img2.svg"),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Address details",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DotStepper(
                              dotCount: dotCount,
                              dotRadius: 12,
                              activeStep: activeStep,
                              shape: Shape.circle,
                              spacing: 40,
                              tappingEnabled: false,
                              lineConnectorsEnabled: true,
                              indicator: Indicator.blink,
                              onDotTapped: (tappedDotIndex) {
                                setState(() {
                                  activeStep = tappedDotIndex;
                                });
                              },
                              fixedDotDecoration: const FixedDotDecoration(
                                color: lightBlue3,
                              ),
                              indicatorDecoration: const IndicatorDecoration(
                                color: loginTextColor,
                              ),
                              lineConnectorDecoration:
                                  const LineConnectorDecoration(
                                color: lightBlue3,
                                strokeWidth: 0,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: lightBlue,
                          width: 3,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'House no. / Floor no.',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: grayTxt, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Location (Apartment / Road / Area)',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: grayTxt, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: '160014',
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: grayTxt, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Label as:",
                                style: GoogleFonts.lato(fontSize: 14.0),
                              ),
                              Radio(
                                value: 1,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'ONE';
                                    id = 1;
                                  });
                                },
                              ),
                              Text(
                                'Home',
                                style: GoogleFonts.lato(fontSize: 14.0),
                              ),
                              Radio(
                                value: 2,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'TWO';
                                    id = 2;
                                  });
                                },
                              ),
                              Text(
                                'Office',
                                style: GoogleFonts.lato(fontSize: 14.0),
                              ),
                              Radio(
                                value: 3,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'THREE';
                                    id = 3;
                                  });
                                },
                              ),
                              Text(
                                'Other',
                                style: GoogleFonts.lato(fontSize: 14.0),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                      width: 1, color: loginTextColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  padding: const EdgeInsets.only(
                                      right: 30,
                                      left: 30,
                                      top: 10,
                                      bottom: 10)),
                              child: Text(
                                "Select",
                                style:
                                    (GoogleFonts.lato(color: loginTextColor)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(8),
                            color: loginTextColor,
                            strokeWidth: 3,
                            dashPattern: [10, 6],
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: lightBlue,
                                  ),
                                  height: 50,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Icon(
                                        Icons.add,
                                        color: loginTextColor,
                                        size: 32,
                                      ),
                                      Text(
                                        "Add Address",
                                        style: GoogleFonts.lato(
                                            color: loginTextColor,
                                            fontSize: 20.0),
                                      )
                                    ],
                                  )),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                  color: loginBlue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('10 product selected for trial request'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Edit products',
                        style: GoogleFonts.lato(
                            color: loginTextColor,
                            decoration: TextDecoration.underline,
                            decorationColor: loginTextColor),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => TrialRequestSlot(
                            id: widget.id,
                            title: widget.title.toString(),
                            variantId: widget.variantId,
                            productType: widget.productType.toString(),
                            variantName: widget.variantName.toString(),
                            unitPrice: widget.unitPrice.toString(),
                            src: widget.src.toString(),
                            invQty: widget.invQty,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: loginTextColor,
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)),
                    child: Text(
                      'Next',
                      style: zzBoldWhiteTextStyle14A,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
