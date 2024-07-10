import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';

import '../../res/colors.dart';
import '../../res/styles.dart';

class MapView1 extends StatefulWidget {
  const MapView1({Key? key}) : super(key: key);

  @override
  State<MapView1> createState() => _MapView1State();
}

class _MapView1State extends State<MapView1> {
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Book Home Test",
        child: Stack(
          children: [
            Image.asset("assets/images/google_logo.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar( backgroundColor: loginTextColor,
                title: const Text("Add lens"),
                // leading: Image.asset("assets/images/back_arrow.png",),
                leading: InkWell(
                    onTap: ()=> Get.back(),
                    child: const Icon(Icons.arrow_back_ios,size: 28.0,)),
                // actions: <Widget>[
                //   IconButton(
                //     icon: Image.asset("assets/images/menu.png"),
                //     onPressed: () {},
                //   ), //IconButton
                // ], //
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Locality / Area / City',
                                contentPadding: EdgeInsets.fromLTRB(10,5,5,10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: grayTxt, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: grayTxt, width: 1.0),
                                ),
                                prefixIcon: Icon(Icons.search)
                            ),
                          ),
                          Expanded(
                            child: Center(
                                child: Image.asset('assets/images/google_logo.png', width: 100,height: 100,fit: BoxFit.fill,)),
                          )
                        ],
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
                          const Text('10 clinic available near your \nlocation'),
                          ElevatedButton(onPressed:(){
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: loginBlue,
                                context: context, builder:(BuildContext context){
                              return Column(
                                children: [
                                  Padding(
                                    padding:const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('All 10 clinic nearby',style: zzBoldBlackTextStyle14,),
                                        CircleAvatar(
                                            radius: 13,
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset("assets/svg/close_icon.svg")),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      addAutomaticKeepAlives: false,
                                      addRepaintBoundaries: false,
                                      itemCount: 2,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext context, int index) {
                                        return  Card(
                                          margin: const EdgeInsets.all(10),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            // decoration: BoxDecoration(
                                            // //  borderRadius: BorderRadius.circular(16),
                                            //   // border: BorderSide(width: 2, color: Colors.black12)
                                            // ),
                                            child: Column(
                                              children: [
                                                // Row(
                                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //   children: [
                                                //     Row(
                                                //       children: [
                                                //         Text("Appointment reminder"),
                                                //       ],
                                                //     ),
                                                //     Row(
                                                //       children: [
                                                //         SvgPicture.asset("assets/svg/call_ayush_icon.svg",
                                                //         ),
                                                //         SizedBox(
                                                //           width: 20,
                                                //         ),
                                                //         SvgPicture.asset("assets/svg/arrow_ayush_icon.svg")
                                                //       ],
                                                //     )
                                                //
                                                //   ],
                                                // ),
                                                // Divider(
                                                //   color: Colors.black12,
                                                //   thickness: 1,
                                                // ),
                                                Row(
                                                  children: [
                                                    Image.asset("assets/images/eye_glass.png", width: 130,height: 130,),
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
                                                        const Text("#123, Lorem ipsum address, \ngroundfloor,  \nNew Delhi, 110001"),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text("Open", style: GoogleFonts.lato(color: green1, fontSize: 14),),
                                                            const Text("  8.00 AM to 9.00 PM")
                                                          ],
                                                        ),
                                                        Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                          children: [
                                                            SvgPicture.asset("assets/svg/call_ayush_icon.svg"),
                                                            // Spacer(),
                                                            const SizedBox(width: 20,),
                                                            SvgPicture.asset("assets/svg/arrow_ayush_icon.svg"),
                                                            const SizedBox(width: 30,),
                                                            ElevatedButton(onPressed: (){},
                                                              style: ElevatedButton.styleFrom(backgroundColor: loginTextColor,
                                                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)),
                                                              child: Text('Select', style: zzBoldWhiteTextStyle14A,),)
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              );
                            });
                          },
                            style: ElevatedButton.styleFrom(backgroundColor: loginTextColor, padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)), child: Text('View', style: zzBoldWhiteTextStyle14A,),)
                        ],),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
    // return SafeArea(
    //     child: Stack(
    //       children: [
    //         Image.asset("assets/images/google_logo.png",
    //       height: MediaQuery.of(context).size.height,
    //       width: MediaQuery.of(context).size.width,
    //       fit: BoxFit.cover,
    //     ),
    //   Scaffold(
    //         resizeToAvoidBottomInset: false,
    //         appBar: AppBar( backgroundColor: loginTextColor,
    //         title: const Text("Add lens"),
    //   // leading: Image.asset("assets/images/back_arrow.png",),
    //   leading: InkWell(
    //       onTap: ()=> Get.back(),
    //       child: const Icon(Icons.arrow_back_ios,size: 28.0,)),
    //   actions: <Widget>[
    //   IconButton(
    //   icon: Image.asset("assets/images/menu.png"),
    //   onPressed: () {},
    //   ), //IconButton
    //   ], //
    //   ),
    //           body: Column(
    //             children: [
    //               Expanded(
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Column(
    //                     children: [
    //                       TextFormField(
    //           decoration: const InputDecoration(
    //           hintText: 'Locality / Area / City',
    //             contentPadding: EdgeInsets.fromLTRB(10,5,5,10),
    //             enabledBorder: OutlineInputBorder(
    //                       borderSide: BorderSide(color: grayTxt, width: 1.0),
    //             ),
    //             focusedBorder: OutlineInputBorder(
    //                       borderSide: BorderSide(color: grayTxt, width: 1.0),
    //             ),
    //             prefixIcon: Icon(Icons.search)
    //           ),
    //                       ),
    //                       Expanded(
    //                         child: Center(
    //                             child: Image.asset('assets/images/google_logo.png', width: 100,height: 100,fit: BoxFit.fill,)),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Align(
    //                 alignment: Alignment.bottomCenter,
    //                 child: Container(
    //                   height: 100,
    //                   width: MediaQuery.of(context).size.width,
    //                   padding: const EdgeInsets.all(20),
    //                   decoration: const BoxDecoration(
    //                       borderRadius: BorderRadius.only(
    //                           topRight: Radius.circular(20.0),
    //                           topLeft: Radius.circular(20.0)),
    //                       color: loginBlue),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       const Text('10 clinic available near your \nlocation'),
    //                       ElevatedButton(onPressed:(){
    //                       showModalBottomSheet(
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(10.0),
    //                           ),
    //                           backgroundColor: loginBlue,
    //                           context: context, builder:(BuildContext context){
    //                         return Column(
    //                           children: [
    //                             Padding(
    //                               padding:const EdgeInsets.all(10),
    //                               child: Row(
    //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Text('All 10 clinic nearby',style: zzBoldBlackTextStyle14,),
    //                                   CircleAvatar(
    //                                     radius: 13,
    //                                       backgroundColor: Colors.white,
    //                                       child: SvgPicture.asset("assets/svg/close_icon.svg")),
    //                                 ],
    //                               ),
    //                             ),
    //                         Expanded(
    //                           child: ListView.builder(
    //                             itemCount: 2,
    //                             shrinkWrap: true,
    //                             itemBuilder: (BuildContext context, int index) {
    //                               return  Card(
    //                                 margin: const EdgeInsets.all(10),
    //                                 shape: RoundedRectangleBorder(
    //                                     borderRadius: BorderRadius.circular(10)
    //                                 ),
    //                                 child: Container(
    //                                   padding: const EdgeInsets.all(10),
    //                                   // decoration: BoxDecoration(
    //                                   // //  borderRadius: BorderRadius.circular(16),
    //                                   //   // border: BorderSide(width: 2, color: Colors.black12)
    //                                   // ),
    //                                   child: Column(
    //                                     children: [
    //                                       // Row(
    //                                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                       //   children: [
    //                                       //     Row(
    //                                       //       children: [
    //                                       //         Text("Appointment reminder"),
    //                                       //       ],
    //                                       //     ),
    //                                       //     Row(
    //                                       //       children: [
    //                                       //         SvgPicture.asset("assets/svg/call_ayush_icon.svg",
    //                                       //         ),
    //                                       //         SizedBox(
    //                                       //           width: 20,
    //                                       //         ),
    //                                       //         SvgPicture.asset("assets/svg/arrow_ayush_icon.svg")
    //                                       //       ],
    //                                       //     )
    //                                       //
    //                                       //   ],
    //                                       // ),
    //                                       // Divider(
    //                                       //   color: Colors.black12,
    //                                       //   thickness: 1,
    //                                       // ),
    //                                       Row(
    //                                         children: [
    //                                           Image.asset("assets/images/eye_glass.png", width: 130,height: 130,),
    //                                           Column(
    //                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                             crossAxisAlignment: CrossAxisAlignment.start,
    //                                             children: [
    //                                               Text(
    //                                                 "Clinic Name",
    //                                                 style: GoogleFonts.lato(
    //                                                     fontSize: 14,
    //                                                     fontWeight: FontWeight.bold,
    //                                                     color: Colors.black54),
    //                                               ),
    //                                               const SizedBox(
    //                                                 height: 10,
    //                                               ),
    //                                               const Text("#123, Lorem ipsum address, \ngroundfloor,  \nNew Delhi, 110001"),
    //                                               const SizedBox(
    //                                                 height: 10,
    //                                               ),
    //                                               Row(
    //                                                 children: [
    //                                                   Text("Open", style: GoogleFonts.lato(color: green1, fontSize: 14),),
    //                                                   const Text("  8.00 AM to 9.00 PM")
    //                                                 ],
    //                                               ),
    //                                               Row(
    //                                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                                                 // crossAxisAlignment: CrossAxisAlignment.stretch,
    //                                                 children: [
    //                                                   SvgPicture.asset("assets/svg/call_ayush_icon.svg"),
    //                                                   // Spacer(),
    //                                                   const SizedBox(width: 20,),
    //                                                   SvgPicture.asset("assets/svg/arrow_ayush_icon.svg"),
    //                                                   const SizedBox(width: 30,),
    //                                                   ElevatedButton(onPressed: (){},
    //                                                     style: ElevatedButton.styleFrom(backgroundColor: loginTextColor,
    //                                                         padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)),
    //                                                     child: Text('Select', style: zzBoldWhiteTextStyle14A,),)
    //                                                 ],
    //                                               )
    //                                             ],
    //                                           )
    //                                         ],
    //                                       )
    //                                     ],
    //                                   ),
    //                                 ),
    //                               );
    //                             },
    //                           ),
    //                         )
    //                           ],
    //                         );
    //                       });
    //                       },
    //                         style: ElevatedButton.styleFrom(backgroundColor: loginTextColor, padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)), child: Text('View', style: zzBoldWhiteTextStyle14A,),)
    //                     ],),
    //                 ),
    //               )
    //             ],
    //           ),
    //   ),
    // ],
    //     ));
  }
}
