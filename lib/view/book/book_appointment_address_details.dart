import 'package:get/get.dart';
import 'package:infinite/view/book/book_appoinment_slot.dart';

import '../../utils/packeages.dart';

class BookAppointmentAddressDetails extends StatefulWidget {
  final int? type;
  const BookAppointmentAddressDetails({this.type, Key? key}) : super(key: key);

  @override
  State<BookAppointmentAddressDetails> createState() =>
      _BookAppointmentAddressDetailsState();
}

class _BookAppointmentAddressDetailsState
    extends State<BookAppointmentAddressDetails> {
  int activeStep = 0;
  int dotCount = 3;
  String radioButtonItem = 'ONE';

  int id = 1;

  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String mySelectedStateId = "0", mySelectedCityId = "0";

  String address = '';
  bool addressSelected = false;
  List<String> addressList = [];

  @override
  void initState() {
    super.initState();
  }

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
                child: SizedBox(
                  height: ScreenSize.getScreenHeight(context),
                  width: ScreenSize.getScreenWidth(context),
                  child: Column(
                    children: [
                      Container(
                        color: loginBlue,
                        child: Column(
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
                                  activeStep: 1,
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
                                  indicatorDecoration:
                                      const IndicatorDecoration(
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                          visible: widget.type == 1 ? true : false,
                          child: showHomeDetails()),
                      Visibility(
                          visible: widget.type == 1 ? true : false,
                          child: AddAddress()),
                      Visibility(
                          visible: widget.type == 2 ? true : false,
                          child: clinicDetails2(context))
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
                    const Text('* Rs. 50 will need to pay\n before request'),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => const BookAppointmentSlot());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: loginTextColor,
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)),
                      child: Text(
                        'Next',
                        style: zzBoldBlueDarkTextStyle10A1,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget showHomeDetails() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: lightBlue,
          width: 3,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: TextField(
              controller: address1Controller,
              decoration: const InputDecoration(
                hintText: 'House no. / Floor no.',
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: grayTxt, width: 1.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: TextField(
              controller: address2Controller,
              decoration: const InputDecoration(
                hintText: 'Location (Apartment / Road / Area)',
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: grayTxt, width: 1.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: TextField(
              controller: cityController,
              decoration: const InputDecoration(
                hintText: '160001',
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: grayTxt, width: 1.0),
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
                activeColor: loginTextColor,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = 'ONE';
                    id = 1;
                  });
                },
              ),
              Text('Home', style: GoogleFonts.lato(fontSize: 14.0)),
              Radio(
                value: 2,
                activeColor: loginTextColor,
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
                activeColor: loginTextColor,
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
                  side: const BorderSide(width: 1, color: loginTextColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  padding: const EdgeInsets.only(
                      right: 30, left: 30, top: 10, bottom: 10)),
              child: Text(
                "Select",
                style: (GoogleFonts.lato(color: loginTextColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget AddAddress() {
    return InkWell(
      onTap: () {},
      child: Container(
          padding: const EdgeInsets.all(20),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            color: loginTextColor,
            strokeWidth: 3,
            dashPattern: const [10, 6],
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
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
                            color: loginTextColor, fontSize: 20.0),
                      )
                    ],
                  )),
            ),
          )),
    );
  }

  Widget ClinicDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField(
              dropdownColor: const Color(0xFFC8F8C8),
              iconDisabledColor: Colors.red,
              iconEnabledColor: colorPrimary,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                labelText: "Select State",
                alignLabelWithHint: true,
                filled: true,
                focusColor: colorPrimary,
                fillColor: grayLight,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                counter: const SizedBox(height: 0.0),
                labelStyle: GoogleFonts.lato(
                  fontSize: 15,
                  color: black,
                ),
              ),
              style: GoogleFonts.lato(
                fontSize: 15,
                color: black,
              ),
              value: mySelectedStateId,
              onChanged: (String? newValue) {
                setState(() {
                  mySelectedStateId = newValue!;
                  mySelectedCityId = "0";
                });
              },
              items: selectStates),
          SizedBox(height: 3.5.sp),
          Visibility(
            visible: mySelectedStateId != "0",
            child: DropdownButtonFormField(
                dropdownColor: const Color(0xFFC8F8C8),
                iconDisabledColor: Colors.red,
                iconEnabledColor: colorPrimary,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  labelText: "Select City",
                  alignLabelWithHint: true,
                  filled: true,
                  focusColor: colorPrimary,
                  fillColor: grayLight,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  counter: const SizedBox(height: 0.0),
                  labelStyle: GoogleFonts.lato(
                    fontSize: 15,
                    color: black,
                  ),
                ),
                style: GoogleFonts.lato(
                  fontSize: 15,
                  color: black,
                ),
                value: mySelectedCityId,
                onChanged: (String? newValue) {
                  setState(() {
                    mySelectedCityId = newValue!;
                  });
                },
                items: mySelectedStateId == "1"
                    ? selectCitiesInTamilNadu
                    : mySelectedStateId == "2"
                        ? selectCitiesInGoa
                        : selectCitiesInKerala),
          ),
          Visibility(
            visible: mySelectedStateId != "0",
            child: SizedBox(height: 3.5.sp),
          ),
          Visibility(
            visible: mySelectedStateId != "0" && mySelectedCityId != "0",
            child: Expanded(
              child: ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                        "assets/images/skyblue_glass.png"))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Clinic Name",
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  "#123, Lorem ipsum address, \nground floor, New delhi, 110001",
                                  style: zzRegularBlackTextStyle13,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Open ",
                                      style: zzRegularGreenTextStyle12,
                                    ),
                                    Text(
                                      "8:00 AM to 9:00 PM",
                                      style: zzRegularBlackTextStyle10,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/call_ayush_icon.svg",
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SvgPicture.asset(
                                          "assets/svg/arrow_ayush_icon.svg",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: loginTextColor,
                                          padding: const EdgeInsets.only(
                                              right: 20, left: 20)),
                                      child: Text(
                                        "Select",
                                        style: zzRegularWhiteTextStyle14,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget clinicDetails2(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
            dropdownColor: const Color(0xFFC8F8C8),
            iconDisabledColor: Colors.red,
            iconEnabledColor: colorPrimary,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              labelText: "Select State",
              alignLabelWithHint: true,
              filled: true,
              focusColor: colorPrimary,
              fillColor: grayLight,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              counter: const SizedBox(height: 0.0),
              labelStyle: GoogleFonts.lato(
                fontSize: 15,
                color: black,
              ),
            ),
            style: GoogleFonts.lato(
              fontSize: 15,
              color: black,
            ),
            value: mySelectedStateId,
            onChanged: (String? newValue) {
              setState(() {
                mySelectedStateId = newValue!;
                mySelectedCityId = "0";
              });
            },
            items: selectStates2),
        SizedBox(height: 3.5.sp),
        Visibility(
          visible: mySelectedStateId != "0",
          child: DropdownButtonFormField(
              dropdownColor: const Color(0xFFC8F8C8),
              iconDisabledColor: Colors.red,
              iconEnabledColor: colorPrimary,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                labelText: "Select City",
                alignLabelWithHint: true,
                filled: true,
                focusColor: colorPrimary,
                fillColor: grayLight,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                counter: const SizedBox(height: 0.0),
                labelStyle: GoogleFonts.lato(
                  fontSize: 15,
                  color: black,
                ),
              ),
              style: GoogleFonts.lato(
                fontSize: 15,
                color: black,
              ),
              value: mySelectedCityId,
              onChanged: (String? newValue) {
                setState(() {
                  mySelectedCityId = newValue!;
                });
              },
              items: mySelectedStateId == "1"
                  ? selectCitiesInTamilNadu2
                  : mySelectedStateId == "2"
                      ? selectCitiesInKarnataka
                      : mySelectedStateId == "3"
                          ? selectCitiesInTelangana
                          : mySelectedStateId == "4"
                              ? selectCitiesInMaharashtra
                              : mySelectedStateId == "5"
                                  ? selectCitiesInMathyaPradesh
                                  : selectCitiesInAndhraPradesh),
        ),
        Visibility(
          visible: mySelectedStateId != "0",
          child: SizedBox(height: 3.5.sp),
        ),
        Visibility(
          visible: mySelectedStateId != "0" && mySelectedCityId != "0",
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            child: ListView.builder(
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              itemCount: mySelectedStateId == "1" && mySelectedCityId == "1"
                  ? tamilList.length
                  : mySelectedStateId == "2" && mySelectedCityId == "1"
                      ? karnatakaList.length
                      : mySelectedStateId == "2" && mySelectedCityId == "2"
                          ? karnatakaList2.length
                          : mySelectedStateId == "3" && mySelectedCityId == "1"
                              ? telunganaHList.length
                              : mySelectedStateId == "3" &&
                                      mySelectedCityId == "2"
                                  ? telunganaMList.length
                                  : mySelectedStateId == "3" &&
                                          mySelectedCityId == "3"
                                      ? telunganaSList.length
                                      : mySelectedStateId == "3" &&
                                              mySelectedCityId == "4"
                                          ? telunganaVList.length
                                          : mySelectedStateId == "4" &&
                                                  mySelectedCityId == "1"
                                              ? maharastraPList.length
                                              : mySelectedStateId == "4" &&
                                                      mySelectedCityId == "2"
                                                  ? maharastraNList.length
                                                  : mySelectedStateId == "4" &&
                                                          mySelectedCityId ==
                                                              "3"
                                                      ? maharastraMList.length
                                                      : mySelectedStateId ==
                                                                  "5" &&
                                                              mySelectedCityId ==
                                                                  "1"
                                                          ? mathyaPradeshList
                                                              .length
                                                          : mySelectedStateId ==
                                                                      "5" &&
                                                                  mySelectedCityId ==
                                                                      "2"
                                                              ? mathyaPradeshList2
                                                                  .length
                                                              : mySelectedStateId ==
                                                                          "5" &&
                                                                      mySelectedCityId ==
                                                                          "3"
                                                                  ? mathyaPradeshList3
                                                                      .length
                                                                  : andhraPradeshList
                                                                      .length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var model;

                if (mySelectedStateId == "1" && mySelectedCityId == "1") {
                  model = tamilList[index];
                } else if (mySelectedStateId == "2" &&
                    mySelectedCityId == "1") {
                  model = karnatakaList[index];
                } else if (mySelectedStateId == "2" &&
                    mySelectedCityId == "2") {
                  model = karnatakaList2[index];
                } else if (mySelectedStateId == "3" &&
                    mySelectedCityId == "1") {
                  model = telunganaHList[index];
                } else if (mySelectedStateId == "3" &&
                    mySelectedCityId == "2") {
                  model = telunganaMList[index];
                } else if (mySelectedStateId == "3" &&
                    mySelectedCityId == "3") {
                  model = telunganaSList[index];
                } else if (mySelectedStateId == "3" &&
                    mySelectedCityId == "4") {
                  model = telunganaVList[index];
                } else if (mySelectedStateId == "4" &&
                    mySelectedCityId == "1") {
                  model = maharastraPList[index];
                } else if (mySelectedStateId == "4" &&
                    mySelectedCityId == "2") {
                  model = maharastraNList[index];
                } else if (mySelectedStateId == "4" &&
                    mySelectedCityId == "3") {
                  model = maharastraMList[index];
                } else if (mySelectedStateId == "5" &&
                    mySelectedCityId == "1") {
                  model = mathyaPradeshList[index];
                } else if (mySelectedStateId == "5" &&
                    mySelectedCityId == "2") {
                  model = mathyaPradeshList2[index];
                } else if (mySelectedStateId == "5" &&
                    mySelectedCityId == "3") {
                  model = mathyaPradeshList3[index];
                } else {
                  model = andhraPradeshList[index];
                }

                return InkWell(
                  onTap: () {
                    debugPrint(
                        'TAMIL LIST SIZE:' + tamilList.length.toString());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: 140,
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                      "assets/images/skyblue_glass.png"),
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  model.clinicName.toString(),
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.8,
                                  child: Text(
                                   
                                    model.address!,
                                    style: zzRegularBlackTextStyle13,
                                    overflow: TextOverflow.visible,
                                    maxLines: 5,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Open ",
                                      style: zzRegularGreenTextStyle12,
                                    ),
                                    Text(
                                      "8:00 AM to 9:00 PM",
                                      style: zzRegularBlackTextStyle10,
                                    ),
                                  ],
                                ),
                                
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (model.phone == 0) {
                                              makeCallOrSendMessage("call",
                                                  myDefaultLandLineNumber, "");
                                            } else {
                                              makeCallOrSendMessage("call",
                                                  model.phone.toString(), "");
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            "assets/svg/call_ayush_icon.svg",
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SvgPicture.asset(
                                          "assets/svg/arrow_ayush_icon.svg",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        addressSelected = true;
                                        if (addressSelected == true) {
                                          setState(() {
                                            addressList.add(model.address!);
                                            address = model.address!;
                                            debugPrint(
                                                'ADDRESS LIST SIZE: ${addressList.length}');
                                            debugPrint('ADDRESS : $address');
                                          });
                                        }
                                        setState(() {
                                          activeStep = 2;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: loginTextColor,
                                          padding: const EdgeInsets.only(
                                              right: 20, left: 20)),
                                      child: Text(
                                        "Select",
                                        style: zzRegularWhiteTextStyle14,
                                      ),
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
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    ));
  }
}
