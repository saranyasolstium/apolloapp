

import 'package:get/get.dart';
import 'package:infinite/view/book/book_appointment_address_details.dart';

import '../../utils/packeages.dart';

class BookAppointmentDetails extends StatefulWidget {
  final int? type;
  const BookAppointmentDetails({
    this.type,
    Key? key}) : super(key: key);

  @override
  State<BookAppointmentDetails> createState() => _BookAppointmentDetailsState();
}

class _BookAppointmentDetailsState extends State<BookAppointmentDetails> {
  int activeStep = 0; // Initial step set to 0.

  // OPTIONAL: can be set directly.
  int dotCount = 3;
  String myCountryCode = "+91";

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Book Home Test",
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: ScreenSize.getScreenHeight(context),
                  width: ScreenSize.getScreenWidth(context),
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset("assets/svg/profile_img2.svg"),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your Details",
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

                          /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
                          activeStep: activeStep,
                          shape: Shape.circle,
                          spacing: 40,
                          tappingEnabled: false,
                          lineConnectorsEnabled: true,
                          indicator: Indicator.blink,

                          /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
                          onDotTapped: (tappedDotIndex) {
                            setState(() {
                              activeStep = tappedDotIndex;
                            });
                          },

                          // DOT-STEPPER DECORATIONS
                          fixedDotDecoration: const FixedDotDecoration(
                            color: lightBlue3,
                          ),

                          indicatorDecoration: const IndicatorDecoration(
                            // style: PaintingStyle.stroke,
                            // strokeWidth: 8,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: white,
                            hintText: 'Your Name',
                            labelText: 'Name',
                            contentPadding:
                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, left: 16),
                      child: SizedBox(
                        width: double.infinity,
                        //height: 8.5.h,
                        height: 60,
                        child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CountryCodePicker(
                                  onChanged: (CountryCode countryCode) {
                                    myCountryCode = countryCode.toString();
                                    debugPrint(
                                        "New Country selected: $countryCode == $myCountryCode");
                                  },
                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                  initialSelection: 'IN',
                                  favorite: const ['+91', 'IN'],
                                  showCountryOnly: false,
                                  showFlag: true,
                                  enabled: false,
                                  showDropDownButton: false,
                                ),
                                const VerticalDivider(
                                  endIndent: 10.0,
                                  indent: 10.0,
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    autofocus: false,
                                    style: zzRegularBlackTextStyle13,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .digitsOnly,
                                    ],
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      counter: const SizedBox(height: 0.0),
                                      border: InputBorder.none,
                                      hintText: 'Enter mobile number',
                                      hintStyle: zzRegularGrayTextStyle10,
                                      filled: true,
                                      fillColor: white,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      // focusedBorder: OutlineInputBorder(
                                      //   borderSide: const BorderSide(color: Colors.grey),
                                      //   borderRadius: BorderRadius.circular(7.0),
                                      // ),
                                      // enabledBorder: OutlineInputBorder(
                                      //   borderSide: const BorderSide(color: Colors.grey),
                                      //   borderRadius: BorderRadius.circular(7.0),
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            labelText: 'Email',
                            contentPadding:
                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            hintText: 'Upload priscription (if any)',
                            labelText: 'Priscription',
                            contentPadding:
                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey)),
                            suffixIcon: Icon(
                              Icons.upgrade_sharp,
                              size: 30,
                              color: loginTextColor,
                            ),
                            // suffix:SvgPicture.asset('assets/svg/upload_arrow.svg',width: 30.0,height: 30.0,
                            //   fit: BoxFit.scaleDown,)
                          ),
                        ),
                      ),
                    ),
                  ]),
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
                    const Text(
                        '* Rs. 50 will need to pay\n before request'),
                    ElevatedButton(
                      onPressed: () => Get.to(() => BookAppointmentAddressDetails(type: widget.type,)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: loginTextColor,
                          padding:
                          const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)),
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
        ));
    // return SafeArea(
    //     child: Scaffold(
    //         endDrawer: const NavigationWidget(),
    //         resizeToAvoidBottomInset: false,
    //         appBar: AppBar(
    //           backgroundColor: loginTextColor,
    //           title: const Text("Book Appointment"),
    //           // leading: Image.asset("assets/images/back_arrow.png",),
    //           leading: InkWell(
    //               onTap: () => Get.back(),
    //               child: const Icon(
    //                 Icons.arrow_back_ios,
    //                 size: 28.0,
    //               )),
    //
    //           actions: <Widget>[
    //             Builder(
    //               builder: (BuildContext context) {
    //                 return IconButton(
    //                   icon: Image.asset("assets/images/menu.png"),
    //                   onPressed: () {
    //                     Scaffold.of(context).openEndDrawer();
    //                   },
    //                 );
    //               },
    //             ), //IconButton
    //           ], //
    //         ),
    //         body: Column(
    //           children: [
    //             Expanded(
    //               child: SingleChildScrollView(
    //                 padding: EdgeInsets.only(
    //                     bottom: MediaQuery.of(context).viewInsets.bottom),
    //                 physics: const AlwaysScrollableScrollPhysics(),
    //                 child: SizedBox(
    //                   height: ScreenSize.getScreenHeight(context),
    //                   width: ScreenSize.getScreenWidth(context),
    //                   child: Column(children: [
    //                     const SizedBox(
    //                       height: 20,
    //                     ),
    //                     SvgPicture.asset("assets/svg/profile_img2.svg"),
    //                     const SizedBox(
    //                       height: 20,
    //                     ),
    //                     Text(
    //                       "Your Details",
    //                       style: GoogleFonts.lato(
    //                           fontWeight: FontWeight.bold, fontSize: 14),
    //                     ),
    //                     const SizedBox(
    //                       height: 20,
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         DotStepper(
    //                           dotCount: dotCount,
    //                           dotRadius: 12,
    //
    //                           /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
    //                           activeStep: activeStep,
    //                           shape: Shape.circle,
    //                           spacing: 40,
    //                           lineConnectorsEnabled: true,
    //                           indicator: Indicator.blink,
    //
    //                           /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
    //                           onDotTapped: (tappedDotIndex) {
    //                             setState(() {
    //                               activeStep = tappedDotIndex;
    //                             });
    //                           },
    //
    //                           // DOT-STEPPER DECORATIONS
    //                           fixedDotDecoration: const FixedDotDecoration(
    //                             color: lightBlue3,
    //                           ),
    //
    //                           indicatorDecoration: const IndicatorDecoration(
    //                             // style: PaintingStyle.stroke,
    //                             // strokeWidth: 8,
    //                             color: loginTextColor,
    //                           ),
    //                           lineConnectorDecoration:
    //                               const LineConnectorDecoration(
    //                             color: lightBlue3,
    //                             strokeWidth: 0,
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                     const SizedBox(
    //                       height: 30,
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(right: 20, left: 20),
    //                       child: SizedBox(
    //                         height: 50,
    //                         child: TextFormField(
    //                           textAlignVertical: TextAlignVertical.center,
    //                           decoration: const InputDecoration(
    //                             border: InputBorder.none,
    //                             filled: true,
    //                             fillColor: white,
    //                             hintText: 'Your Name',
    //                             labelText: 'Name',
    //                             contentPadding:
    //                                 EdgeInsets.fromLTRB(10, 0, 0, 0),
    //                             enabledBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                               width: 1,
    //                               color: Colors.grey,
    //                             )),
    //                             focusedBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                                     width: 1, color: Colors.grey)),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                       height: 20,
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(right: 16, left: 16),
    //                       child: SizedBox(
    //                         width: double.infinity,
    //                         //height: 8.5.h,
    //                         height: 60,
    //                         child: Card(
    //                           elevation: 0.0,
    //                           shape: RoundedRectangleBorder(
    //                             side: const BorderSide(
    //                               color: Colors.grey,
    //                               width: 1,
    //                             ),
    //                             borderRadius: BorderRadius.circular(4.0),
    //                           ),
    //                           child: IntrinsicHeight(
    //                             child: Row(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 CountryCodePicker(
    //                                   onChanged: (CountryCode countryCode) {
    //                                     myCountryCode = countryCode.toString();
    //                                     debugPrint(
    //                                         "New Country selected: $countryCode == $myCountryCode");
    //                                   },
    //                                   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
    //                                   initialSelection: 'IN',
    //                                   favorite: const ['+91', 'IN'],
    //                                   showCountryOnly: true,
    //                                   showFlag: false,enabled: false,
    //                                   showDropDownButton: true,
    //                                 ),
    //                                 const VerticalDivider(
    //                                   endIndent: 10.0,
    //                                   indent: 10.0,
    //                                   color: Colors.grey,
    //                                   thickness: 1,
    //                                 ),
    //                                 Expanded(
    //                                   child: TextFormField(
    //                                     autofocus: false,
    //                                     style: zzRegularBlackTextStyle13,
    //                                     inputFormatters: <TextInputFormatter>[
    //                                       FilteringTextInputFormatter
    //                                           .digitsOnly,
    //                                     ],
    //                                     keyboardType: TextInputType.number,
    //                                     maxLength: 10,
    //                                     decoration: InputDecoration(
    //                                       counter: const SizedBox(height: 0.0),
    //                                       border: InputBorder.none,
    //                                       hintText: 'Enter mobile number',
    //                                       hintStyle: zzRegularGrayTextStyle10,
    //                                       filled: true,
    //                                       fillColor: white,
    //                                       focusedBorder: InputBorder.none,
    //                                       enabledBorder: InputBorder.none,
    //                                       // focusedBorder: OutlineInputBorder(
    //                                       //   borderSide: const BorderSide(color: Colors.grey),
    //                                       //   borderRadius: BorderRadius.circular(7.0),
    //                                       // ),
    //                                       // enabledBorder: OutlineInputBorder(
    //                                       //   borderSide: const BorderSide(color: Colors.grey),
    //                                       //   borderRadius: BorderRadius.circular(7.0),
    //                                       // ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                       height: 20,
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(right: 20, left: 20),
    //                       child: SizedBox(
    //                         height: 50,
    //                         child: TextFormField(
    //                           textAlignVertical: TextAlignVertical.center,
    //                           decoration: const InputDecoration(
    //                             border: InputBorder.none,
    //                             hintText: 'Email',
    //                             labelText: 'Email',
    //                             contentPadding:
    //                                 EdgeInsets.fromLTRB(10, 0, 0, 0),
    //                             enabledBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                                     width: 1, color: Colors.grey)),
    //                             focusedBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                                     width: 1, color: Colors.grey)),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                       height: 20,
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(right: 20, left: 20),
    //                       child: SizedBox(
    //                         height: 50,
    //                         child: TextFormField(
    //                           textAlignVertical: TextAlignVertical.center,
    //                           decoration: const InputDecoration(
    //                             hintText: 'Upload priscription (if any)',
    //                             labelText: 'Priscription',
    //                             contentPadding:
    //                                 EdgeInsets.fromLTRB(10, 0, 0, 0),
    //                             enabledBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                                     width: 1, color: Colors.grey)),
    //                             focusedBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                                     width: 1, color: Colors.grey)),
    //                             suffixIcon: Icon(
    //                               Icons.upgrade_sharp,
    //                               size: 30,
    //                               color: loginTextColor,
    //                             ),
    //                             // suffix:SvgPicture.asset('assets/svg/upload_arrow.svg',width: 30.0,height: 30.0,
    //                             //   fit: BoxFit.scaleDown,)
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ]),
    //                 ),
    //               ),
    //             ),
    //             Align(
    //               alignment: Alignment.bottomCenter,
    //               child: Container(
    //                 height: 100,
    //                 width: MediaQuery.of(context).size.width,
    //                 padding: const EdgeInsets.all(20),
    //                 decoration: const BoxDecoration(
    //                     borderRadius: BorderRadius.only(
    //                         topRight: Radius.circular(20.0),
    //                         topLeft: Radius.circular(20.0)),
    //                     color: loginBlue),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     const Text(
    //                         '* Rs. 500 will need to pay\n before request'),
    //                     ElevatedButton(
    //                       onPressed: () {
    //                         Get.to(() => const BookAppointmentAddressDetails());
    //                       },
    //                       child: Text(
    //                         'Next',
    //                         style: zzBoldWhiteTextStyle14A,
    //                       ),
    //                       style: ElevatedButton.styleFrom(
    //                           backgroundColor: loginTextColor,
    //                           padding:
    //                               const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         )));
  }
}
