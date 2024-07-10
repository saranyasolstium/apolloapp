import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/res/colors.dart';

const String appName = "Infinite";
const String noInternet = "No Internet";
const String checkYourConnection = "Please check your internet connection";
const String dismiss = "Dismiss";

List<DropdownMenuItem<String>> get selectStates {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select State",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Andhra Pradesh",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "2",
        child: Text(
          "Karnataka",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "3",
        child: Text(
          "Maharashtra",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "4",
        child: Text(
          "Tamil Nadu",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "5",
        child: Text(
          "Telangana",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectCitiesInTamilNadu {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select City",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Chennai",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectCitiesInGoa {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select City",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Madgaon",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "2",
        child: Text(
          "Panaji",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectCitiesInKerala {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select City",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Kochi",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "2",
        child: Text(
          "Palakkad",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "3",
        child: Text(
          "Kozhikode",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectOrderFilter {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "1",
        child: Text(
          "All Orders",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "2",
        child: Text(
          "Last Week",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "3",
        child: Text(
          "Last Month",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "4",
        child: Text(
          "Last Year",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectStates2 {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select State",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Andhra Pradesh",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        )),
    DropdownMenuItem(
        value: "2",
        child: Text(
          "Karnataka",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        )),
    DropdownMenuItem(
        value: "3",
        child: Text(
          "Maharashtra",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        )),
    // DropdownMenuItem(
    //     value: "4",
    //     child: Text(
    //       "Mathya Pradesh",
    //       style: GoogleFonts.lato(fontSize: 15, color: black),
    //     )),
    DropdownMenuItem(
        value: "5",
        child: Text(
          "Tamil Nadu",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        )),
    DropdownMenuItem(
        value: "6",
        child: Text(
          "Telangana",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        ))
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectTrialRequest {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select State",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        )),
    // DropdownMenuItem(
    //     value: "1",
    //     child: Text(
    //       "Andhra Pradesh",
    //       style: GoogleFonts.lato(fontSize: 15, color: black),
    //     )),
    DropdownMenuItem(
        value: "2",
        child: Text(
          "Karnataka",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        )),
    DropdownMenuItem(
        value: "3",
        child: Text(
          "Maharashtra",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        )),
   
    DropdownMenuItem(
        value: "5",
        child: Text(
          "Tamil Nadu",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        )),
    DropdownMenuItem(
        value: "6",
        child: Text(
          "Telangana",
          style: GoogleFonts.lato(fontSize: 15, color: black),
        ))
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectCitiesInTamilNadu2 {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select City",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Chennai",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectCitiesInKarnataka {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select City",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Bengaluru",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "2",
        child: Text(
          "Mysuru",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectCitiesInTelangana {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select City",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Hyderabad",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    // DropdownMenuItem(
    //     value: "2",
    //     child: Text(
    //       "Manikonda",
    //       style: GoogleFonts.lato(
    //         fontSize: 15,
    //         color: black,
    //       ),
    //     )),
    DropdownMenuItem(
        value: "3",
        child: Text(
          "Secunderabad",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    // DropdownMenuItem(
    //     value: "4",
    //     child: Text(
    //       "Vizag",
    //       style: GoogleFonts.lato(
    //         fontSize: 15,
    //         color: black,
    //       ),
    //     ))
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectCitiesInMaharashtra {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select City",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Mumbai",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "2",
        child: Text(
          "Nashik",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "3",
        child: Text("Pune",
            style: GoogleFonts.lato(
              fontSize: 15,
              color: black,
            )))
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectCitiesInMathyaPradesh {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select City",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Indore",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "2",
        child: Text(
          "Kishanganj",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "3",
        child: Text("Ujjain",
            style: GoogleFonts.lato(
              fontSize: 15,
              color: black,
            )))
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectCitiesInAndhraPradesh {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select City",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "1",
        child: Text(
          "Vizag",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        ))
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get selectRelationShipTypes {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: "0",
        child: Text(
          "Select Type",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "Father",
        child: Text(
          "Father",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "Mother",
        child: Text(
          "Mother",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "Daughter",
        child: Text(
          "Daughter",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "Son",
        child: Text(
          "Son",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "Spouse",
        child: Text(
          "Spouse",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
    DropdownMenuItem(
        value: "Guardian",
        child: Text(
          "Guardian",
          style: GoogleFonts.lato(
            fontSize: 15,
            color: black,
          ),
        )),
  ];
  return menuItems;
}

List<String> get karnatakaAddress {
  List<String> karnatakaList = [
    'Infinite store, Apollo Clinic, Bellandur, 74/1, Service Rd, Near Soul Space Spirit Central Mall, Bellandur, Bengaluru, Karnataka – 560103',
    'Infinite Store, C/o Apollo clinic, Audiology department, 1st floor, 54, 12th Main Rd, above SBI Bank, HSR Layout, Bengaluru, Karnataka 560102',
    'Infinite Store, C/o Apollo Clinic, Room no 22 BNR complex, Near, Brigade Millenium Rd, Puttenahalli, JP Nagar 7th Phase, J. P. Nagar, Bengaluru, Karnataka 560078'
  ];

  return karnatakaList;
}

List<String> get karnatakaAddress2 {
  List<String> karnatakaList2 = [
    'Infinite Store, C/o Apollo Clinic #23, Panchavati Circle, Kalidasa Rd, Vani Vilas Mohalla, Mysuru, Karnataka 570002'
  ];

  return karnatakaList2;
}

List<String> get tamilAddress {
  List<String> tamilList = [
    'Infinite Store, C/o Apollo clinic, Door No 11, 4, Sivaprakasam St, opposite to Brilliant Tutorial, Pondy Bazaar, Parthasarathi Puram, T. Nagar, Chennai, Tamil Nadu - 600017',
    //'1&2, Prakasam Rd, Near McDonald, Chowthri Nagar, Valasaravakkam, Chennai, Tamil Nadu - 600087',
    '1, Chennai, Tamil Nadu - 600087',
  ];
  return tamilList;
}

List<String> get telunganaAddress {
  List<String> telunganaList1 = [
    'Infinite Store, C/o Apollo Clinic, #284, Shaikpet Main Rd, near Bhema Restaurant, OU Colony, Shaikpet, Manikonda, Telangana - 500089'
  ];

  return telunganaList1;
}

List<String> get telunganaAddress2 {
  List<String> telunganaList2 = [
    'Infinite Store, C/o Apollo Clinic, # 239, Ground Floor, Near Bhavyas Anandam Apartments, Nizampet , Hyderabad, Telangana	- 500090'
  ];
  return telunganaList2;
}

List<String> get telunganaAddress3 {
  List<String> telunganaList3 = [
    'Infinite Store, C/o Apollo Clinic, Rishab heights, above vodafone store, beside KFC, Trimulgherry - ECIL Rd, A. S. Rao Nagar, Secunderabad, Telangana - 500062'
  ];

  return telunganaList3;
}

// List<Widget> get TamilnaduAddress {
//   List<Widget> tamilList = [
//     Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: SizedBox(
//           height: 160,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                   child: Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: Image.asset("assets/images/skyblue_glass.png"))),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     "Clinic Name",
//                     style: GoogleFonts.lato(
//                         fontWeight: FontWeight.bold, fontSize: 14),
//                   ),
//                   Text(
//                     "Infinite Store, C/o Apollo Clinic, Gachibowli - Miyapur Rd RTC cross road, beside Swagth De-Royal Restaurants, Kothaguda, Hyderabad,500084",
//                     style: zzRegularBlackTextStyle13,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "Open ",
//                         style: zzRegularGreenTextStyle12,
//                       ),
//                       Text(
//                         "8:00 AM to 9:00 PM",
//                         style: zzRegularBlackTextStyle10,
//                       ),
//                     ],
//                   ),
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                             "assets/svg/call_ayush_icon.svg",
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           SvgPicture.asset(
//                             "assets/svg/arrow_ayush_icon.svg",
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         width: 40,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Get.offAll(()=>EyePower());
//                         },
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: loginTextColor,
//                             padding:
//                                 const EdgeInsets.only(right: 20, left: 20)),
//                         child: Text(
//                           "Select",
//                           style: zzRegularWhiteTextStyle14,
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     )
//   ];
//
//   return tamilList;
// }
// List<ClinicModel> get getModel {
//   List<ClinicModel>  list=[];
//
//   var map=<String, dynamic>{};
//   map['id']=1;
//   map['address'] = "ffff fvghgh jjjjjjhj";
//   ClinicModel model= ClinicModel();
//   model.id=1;
//   model.address=
//
//   return list;
// }
