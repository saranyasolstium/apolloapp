import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/model/clinic_model.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/res/texts.dart';
import 'package:infinite/view/book/book_appointment.dart';
import 'package:infinite/view/clinic/select_product_screen.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectClinicScreen extends StatefulWidget {
  const SelectClinicScreen({Key? key}) : super(key: key);

  @override
  State<SelectClinicScreen> createState() => _SelectClinicScreenState();
}

class _SelectClinicScreenState extends State<SelectClinicScreen> {
  String mySelectedStateId = "0", mySelectedCityId = "0";
  // final Completer<GoogleMapController> _controller = Completer();
/*  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(10.9997, 371.250021),
    zoom: 9.4746,
  );*/
  bool openMap2 = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Store Locator",
      child: SizedBox(
        width: ScreenSize.getScreenWidth(context),
        height: ScreenSize.getScreenHeight(context),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                      debugPrint('SELECTED STATE $mySelectedStateId');
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
                        debugPrint('SELECTED CITY $mySelectedCityId');
                      });
                    },
                    //     items: mySelectedStateId == "1"
                    //         ? selectCitiesInTamilNadu2
                    //         : mySelectedStateId == "2"
                    //         ? selectCitiesInKarnataka
                    //     :mySelectedStateId=="3"?
                    //         selectCitiesInTelangana:mySelectedStateId=="4"? selectCitiesInMaharashtra: mySelectedStateId=="5"? selectCitiesInMathyaPradesh:
                    // selectCitiesInAndhraPradesh),

                    items: mySelectedStateId == "1"
                        ? selectCitiesInAndhraPradesh
                        : mySelectedStateId == "2"
                            ? selectCitiesInKarnataka
                            : mySelectedStateId == "3"
                                ? selectCitiesInMaharashtra
                                : mySelectedStateId == "4"
                                    ? selectCitiesInMathyaPradesh
                                    : mySelectedStateId == "5"
                                        ? selectCitiesInTamilNadu2
                                        : selectCitiesInTelangana),
              ),
              Visibility(
                visible: mySelectedStateId != "0",
                child: SizedBox(height: 3.5.sp),
              ),
              Visibility(
                visible: mySelectedStateId != "0" && mySelectedCityId != "0",
                child: Expanded(
                  child: ListView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: mySelectedStateId == "1" &&
                            mySelectedCityId == "1"
                        ? andhraPradeshList.length
                        : mySelectedStateId == "2" && mySelectedCityId == "1"
                            ? karnatakaList.length
                            : mySelectedStateId == "2" &&
                                    mySelectedCityId == "2"
                                ? karnatakaList2.length
                                : mySelectedStateId == "3" &&
                                        mySelectedCityId == "1"
                                    ? maharastraMList.length
                                    : mySelectedStateId == "3" &&
                                            mySelectedCityId == "2"
                                        ? maharastraNList.length
                                        : mySelectedStateId == "3" &&
                                                mySelectedCityId == "3"
                                            ? maharastraPList.length
                                            : mySelectedStateId == "4" &&
                                                    mySelectedCityId == "1"
                                                ? mathyaPradeshList2.length
                                                : mySelectedStateId == "4" &&
                                                        mySelectedCityId == "2"
                                                    ? mathyaPradeshList3.length
                                                    : mySelectedStateId ==
                                                                "4" &&
                                                            mySelectedCityId ==
                                                                "3"
                                                        ? mathyaPradeshList
                                                            .length
                                                        : mySelectedStateId ==
                                                                    "5" &&
                                                                mySelectedCityId ==
                                                                    "1"
                                                            ? tamilList.length
                                                            : mySelectedStateId ==
                                                                        "6" &&
                                                                    mySelectedCityId ==
                                                                        "1"
                                                                ? telunganaHList
                                                                    .length
                                                                : mySelectedStateId ==
                                                                            "6" &&
                                                                        mySelectedCityId ==
                                                                            "2"
                                                                    ? telunganaMList
                                                                        .length
                                                                    : mySelectedStateId ==
                                                                                "6" &&
                                                                            mySelectedCityId ==
                                                                                "3"
                                                                        ? telunganaSList
                                                                            .length
                                                                        : telunganaVList
                                                                            .length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      ClinicModel model;

                      //ANDHRA PRADESH
                      if (mySelectedStateId == "1" && mySelectedCityId == "1") {
                        model = andhraPradeshList[index];
                      }
                      //KARNATAKA
                      else if (mySelectedStateId == "2" &&
                          mySelectedCityId == "1") {
                        model = karnatakaList[index];
                      } else if (mySelectedStateId == "2" &&
                          mySelectedCityId == "2") {
                        model = karnatakaList2[index];
                      }
                      //MAHARASTRA

                      else if (mySelectedStateId == "3" &&
                          mySelectedCityId == "1") {
                        model = maharastraMList[index];
                      } else if (mySelectedStateId == "3" &&
                          mySelectedCityId == "2") {
                        model = maharastraNList[index];
                      } else if (mySelectedStateId == "3" &&
                          mySelectedCityId == "3") {
                        model = maharastraPList[index];
                      }

                      //MATHYA PRADESH

                      else if (mySelectedStateId == "4" &&
                          mySelectedCityId == "1") {
                        model = mathyaPradeshList2[index];
                      } else if (mySelectedStateId == "4" &&
                          mySelectedCityId == "2") {
                        model = mathyaPradeshList3[index];
                      } else if (mySelectedStateId == "4" &&
                          mySelectedCityId == "3") {
                        model = mathyaPradeshList[index];
                      }

                      //TAMIL NADU

                      else if (mySelectedStateId == "5" &&
                          mySelectedCityId == "1") {
                        model = tamilList[index];
                      }
                      //TELUNGANA

                      else if (mySelectedStateId == "6" &&
                          mySelectedCityId == "1") {
                        model = telunganaHList[index];
                      } else if (mySelectedStateId == "6" &&
                          mySelectedCityId == "2") {
                        model = telunganaMList[index];
                      } else if (mySelectedStateId == "6" &&
                          mySelectedCityId == "3") {
                        model = telunganaSList[index];
                      } else {
                        model = telunganaVList[index];
                      }

                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            // height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  model.clinicName.toString(),
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  //  height: MediaQuery.of(context).size.height/3,
                                  child: Text(
                                    //  karnatakaAddress[index],
                                    //  mySelectedCityId=='1'? "#123, Lorem ipsum address, \nground floor, New delhi, 110001": keralaAddress[1],
                                    //   mySelectedStateId == "1" && mySelectedCityId == "1"? tamilAddress[index]: mySelectedStateId == "2" && mySelectedCityId == "1"? karnatakaAddress[index]:
                                    //   mySelectedStateId == "2" && mySelectedCityId == "2"? karnatakaAddress2[index]: mySelectedStateId == "3" && mySelectedCityId == "1"? telunganaAddress[index]:
                                    //   mySelectedStateId == "3" && mySelectedCityId == "2"? telunganaAddress2[index]: mySelectedStateId == "3" && mySelectedCityId == "3"? telunganaAddress3[index]:'',

                                    model.address!,

                                    style: zzRegularBlackTextStyle13,
                                    overflow: TextOverflow.visible,
                                    //maxLines: 5,
                                  ),
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                // Text('Latitude: ${model.latitude}'),
                                // Text('Longitude: ${model.longitude}'),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      InkWell(
                                        onTap: () {
                                          debugPrint(
                                              "SHOW SELECT CLINIC LOCATOR SCREEN LNG: ${model.longitude} LAT: ${model.latitude}");
                                          //  openMap(model.latitude!,model.longitude!);
                                          launchMap(
                                              model.address!,
                                              model.latitude!,
                                              model.longitude!);
                                          //   getAddress(model.latitude!,model.longitude!);
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svg/arrow_ayush_icon.svg",
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Get.to(()=>TrialListClinicLocator(address: model.address!));
                                          // Get.to(()=>const SelectProductScreen());
                                          Get.to(() => const BookAppointment());
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: loginTextColor,
                                            padding: const EdgeInsets.only(
                                                right: 20, left: 20)),
                                        child: Text(
                                          "Select",
                                          style: zzRegularWhiteTextStyle14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Visibility(
                                //   visible: openMap2==true,
                                //   child: Container(
                                //     height: 150,
                                //     width: 250,
                                //     child:GoogleMap(initialCameraPosition:_kGoogle,
                                //       mapType: MapType.normal,
                                //       myLocationEnabled: true,
                                //       compassEnabled: true,
                                //       onMapCreated: (GoogleMapController controller){
                                //         _controller.complete(controller);
                                //       }
                                //     )
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // SizedBox(
              //   height: 30,
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    try {
      if (mounted) {
        getAddress(latitude, longitude);
        String googleUrl =
            'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        } else {
          throw 'Could not open the map.';
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        debugPrint(
            "Address: ${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
      } else {
        debugPrint("No address found for the given coordinates.");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void launchMap(String address, double latitude, double longitude) async {
    String query = Uri.encodeComponent(address);
    getAddress(latitude, longitude);

    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  // child: GoogleMap(
  // initialCameraPosition: _kGoogle,
  // mapType: MapType.normal,
  // myLocationEnabled: true,
  // compassEnabled: true,
  // onMapCreated: (GoogleMapController controller){
  // _controller.complete(controller);
  // },
  // ),

  //  getUserLocation(double latitude, double longitude) async {//call this async method from whereever you need
  //
  //    LocationData myLocation;
  //    String error;
  //    Location location = new Location();
  //    try {
  //      myLocation = await location.getLocation();
  //    } on PlatformException catch (e) {
  //      if (e.code == 'PERMISSION_DENIED') {
  //        error = 'please grant permission';
  //        debugPrint(error);
  //      }
  //      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
  //        error = 'permission denied- please enable it from app settings';
  //        debugPrint(error);
  //      }
  //      //myLocation = null;
  //    }
  //    // currentLocation = myLocation;
  //    // final coordinates = new Coordinates(
  //    //     myLocation.latitude, myLocation.longitude);
  //
  // //  currentLocation = myLocation;
  //    final coordinates = new Coordinates(
  //        13.0400596, 80.2380421);
  //
  //    var addresses = await Geocoder.local.findAddressesFromCoordinates(
  //        coordinates);
  //    var first = addresses.first;
  //    debugPrint('HELLO WORLD');
  //    debugPrint(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
  //    return first;
  //  }

  void showClinicDetails(BuildContext context) {
    try {
      showModalBottomSheet(
          //  isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          backgroundColor: lightBlue,
          context: context,
          builder: (BuildContext builder) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "All 10 clinic nearby",
                          style: GoogleFonts.lato(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/svg/close.svg",
                          width: 16.0,
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black26,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      itemCount: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              height: 160,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Image.asset(
                                              "assets/images/skyblue_glass.png"))),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Clinic Name",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      const Text(
                                          "#123, Lorem ipsum address, \nground floor, New delhi, 110001"),
                                      Row(
                                        children: [
                                          Text(
                                            "Open ",
                                            style:
                                                GoogleFonts.lato(color: green1),
                                          ),
                                          const Text(".8:00 AM to 9:00 PM"),
                                        ],
                                      ),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            onPressed: () {
                                              // Get.offAll(()=>EyePower());
                                            },
                                            child: const Text("Select",
                                                style: TextStyle(color: white)),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: loginTextColor,
                                                padding: const EdgeInsets.only(
                                                    right: 20, left: 20)),
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
                ],
              ),
            );
          });
    } catch (e) {
      debugPrint('$e');
    }
  }
}
