import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../model/product_model.dart';
import '../../res/colors.dart';
import '../../res/styles.dart';
import '../../services/network/dio_client.dart';
import '../../services/network/endpoints.dart';
import '../../utils/global.dart';
import '../../utils/screen_size.dart';
import '../../widgets/default_navigation_widget.dart';
import 'clinic_screen_address.dart';

class TrialListClinicLocator extends StatefulWidget {
  final String? address;

  const TrialListClinicLocator({this.address, Key? key}) : super(key: key);

  @override
  State<TrialListClinicLocator> createState() =>
      _TrialRequestProductListState();
}

class _TrialRequestProductListState extends State<TrialListClinicLocator> {
  List<ProductModel> myProductList = [];
  TextEditingController controller1 = TextEditingController();
  List<String> titleList = [];
  String title = '';
  List<ProductModel> list = [];
  List<String> radiolist = ['In Home', 'Visit clinic'];
  String radioValue = '';
  String? productTitle = '';
  String? productType = '';
  List<String> imgList = [];
  List<Map<String, dynamic>> imgList2 = [];
  List<Map<String, dynamic>> variantList = [];
  TextEditingController controller = TextEditingController();
  List<ProductModel> prouductList = [];
  List<Map<String, dynamic>> variantList2 = [];
  String imgPath = '';
  int mySelectedColorIndex = 0;
  List<String> myColorList = [];
  int indx = 0;
  int tap = -1;
   int inventory_quantity=0;


  int productId = -1;
  late String selectedColor;
  int selectedIndexColor = 0;
  int radio = 0;
  int variantId3 = 0;
  String color3 = '';
  String price3 = '';
  String src3 = '';

  int mySelectAppointmentType = 2;

  String radioButtonDefault = 'Home';
  String? RadioValue;

  @override
  void initState() {
    loading = true;
    setState(() {
      getProductList();
    });

    // titleList;
    super.initState();
  }

  // GET PRODUCT LIST
  void getProductList() {
    try {
      DioClient(myUrl: "${EndPoints.allProductsList}?product_type=Audiology")
          .getProductList()
          .then((value) {
        debugPrint("TRIAL REQUEST VALUE: $value");
        if (mounted) {
          setState(() {
            if (value.isNotEmpty) {
              myProductList = [];

              for (ProductModel model in value) {
                if(!model.tags.toString().contains("Hearing - Enquiry")) {
                  myProductList.add(model);
                }
                // myProductList.add(model);
                debugPrint(
                    "EYE PRODUCT LIST PRODUCT TYPE: ${model.productType}");

                debugPrint(
                    "EYE PRODUCT LIST INVENTORY QTY : ${model.variantsList![0]['inventory_quantity']}");
                debugPrint(
                    "EYE PRODUCT LIST OLD INVENTORY QTY : ${model.variantsList![0]['old_inventory_quantity']}");
              }
              getSortList();
            } else {
              myProductList = [];
            }
            loading = false;
          });
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void filterSearchResults(String query) {
    if (mounted) {
      setState(() {
        list.clear();
        if (query.toLowerCase().length >= 3) {
          for (ProductModel model in myProductList) {
            debugPrint("SEARCH LIST SIZE(INITIAL): ${list.length}");
            if (model.title
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
              // if the item is matched we are
              // adding it to our filtered list.
              debugPrint(
                  "TRIAL REQUEST TITLE (SEARCH) : ${model.title.toString().toLowerCase().contains(query.toLowerCase())}");
              list.add(model);
              debugPrint("SEARCH LIST TITLE: ${model.title}");
            }

            debugPrint("SEARCH LIST SIZE(IF): ${list.length}");
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Trial Request",
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Container(
          //         margin: const EdgeInsets.all(10),
          //         width: 200,
          //         height: 40,
          //         child: TextFormField(
          //             controller: controller1,
          //             onChanged: (value) {
          //               filterSearchResults(value);
          //             },
          //             textAlignVertical: TextAlignVertical.center,
          //             decoration: const InputDecoration(
          //                 border: InputBorder.none,
          //                 hintText: 'Search product',
          //                 contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          //                 enabledBorder: OutlineInputBorder(
          //                     borderSide:
          //                         BorderSide(width: 1, color: Colors.grey)),
          //                 focusedBorder: OutlineInputBorder(
          //                     borderSide:
          //                         BorderSide(width: 1, color: Colors.grey)),
          //                 prefixIcon: Icon(Icons.search))),
          //       ),
          //       // DropShadow(
          //       //     blurRadius: 5,
          //       //     offset: const Offset(10, 10),
          //       //     spread: 1,
          //       //     child: SvgPicture.asset("assets/svg/updown_arrow.svg", width: 50,height: 50,)),
          //       Card(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(150),
          //           ),
          //           elevation: 2,
          //           child: InkWell(
          //             onTap: () {
          //               showDialog(
          //                   context: context,
          //                   builder: (builder) {
          //                     return AlertDialog(
          //                       backgroundColor: loginBlue,
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(14),
          //                       ),
          //                       contentPadding: EdgeInsets.zero,
          //                       insetPadding: const EdgeInsets.all(14),
          //                       actionsPadding: const EdgeInsets.symmetric(
          //                           horizontal: 0.0, vertical: 0.0),
          //                       actions: <Widget>[
          //                         Container(
          //                           // margin: EdgeInsets.all(20),
          //                           width: 100.0.w,
          //                           padding: const EdgeInsets.all(10),
          //                           child: Column(
          //                             children: [
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Text(
          //                                     'Sort by',
          //                                     style: GoogleFonts.lato(
          //                                         fontWeight: FontWeight.bold),
          //                                   ),
          //                                   InkWell(
          //                                     onTap: () {
          //                                       Navigator.of(context).pop();
          //                                     },
          //                                     child: Padding(
          //                                       padding:
          //                                           EdgeInsets.only(right: 10),
          //                                       child: SvgPicture.asset(
          //                                         "assets/svg/close_circle_white.svg",
          //                                       ),
          //                                     ),
          //                                   )
          //                                 ],
          //                               ),
          //                               const Padding(
          //                                 padding: EdgeInsets.only(
          //                                   top: 10,
          //                                   bottom: 10,
          //                                 ),
          //                                 child: Divider(
          //                                   thickness: 1,
          //                                   color: Colors.black12,
          //                                 ),
          //                               ),
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   const Text('Bestseller'),
          //                                   Transform.scale(
          //                                     scale: 1.2,
          //                                     child: Radio(
          //                                         value: "BEST",
          //                                         groupValue: RadioValue,
          //                                         hoverColor: loginTextColor,
          //                                         //focusColor: loginTextColor,
          //                                         fillColor: MaterialStateColor
          //                                             .resolveWith((states) =>
          //                                                 loginTextColor),
          //                                         onChanged: (value) {
          //                                           RadioValue =
          //                                               value.toString();
          //                                         }),
          //                                   ),
          //                                 ],
          //                               ),
          //                               const SizedBox(
          //                                 height: 20,
          //                               ),
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   const Text('New arrival'),
          //                                   Transform.scale(
          //                                     scale: 1.2,
          //                                     child: Radio(
          //                                         value: "NEW",
          //                                         groupValue: RadioValue,
          //                                         hoverColor: loginTextColor,
          //                                         //focusColor: loginTextColor,
          //                                         fillColor: MaterialStateColor
          //                                             .resolveWith((states) =>
          //                                                 loginTextColor),
          //                                         onChanged: (value) {
          //                                           RadioValue =
          //                                               value.toString();
          //                                         }),
          //                                   ),
          //                                 ],
          //                               ),
          //                               const SizedBox(
          //                                 height: 20,
          //                               ),
          //                               // Row(
          //                               //   mainAxisAlignment:
          //                               //       MainAxisAlignment
          //                               //           .spaceBetween,
          //                               //   children: [
          //                               //     const Text('Most viewed'),
          //                               //     SvgPicture.asset(
          //                               //       "assets/svg/ayush_icon.svg",
          //                               //     ),
          //                               //   ],
          //                               // ),
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Text('Most viewed'),
          //                                   Transform.scale(
          //                                     scale: 1.2,
          //                                     child: Radio(
          //                                         value: "MOST",
          //                                         groupValue: RadioValue,
          //                                         //  hoverColor: loginTextColor,
          //                                         //focusColor: loginTextColor,
          //                                         fillColor: MaterialStateColor
          //                                             .resolveWith((states) =>
          //                                                 loginTextColor),
          //                                         activeColor: loginTextColor,
          //                                         onChanged: (value) {
          //                                           RadioValue =
          //                                               value.toString();
          //                                           debugPrint(
          //                                               'HELLOO WORLD $RadioValue');
          //                                         }),
          //                                   ),
          //                                 ],
          //                               ),
          //                               const SizedBox(
          //                                 height: 20,
          //                               ),
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Text('Price - Low to High'),
          //                                   Transform.scale(
          //                                     scale: 1.2,
          //                                     child: Radio(
          //                                         value: "LOW",
          //                                         groupValue: RadioValue,
          //                                         hoverColor: loginTextColor,
          //                                         //focusColor: loginTextColor,
          //                                         fillColor: MaterialStateColor
          //                                             .resolveWith((states) =>
          //                                                 loginTextColor),
          //                                         onChanged: (value) {
          //                                           RadioValue =
          //                                               value.toString();
          //                                           debugPrint(
          //                                               'HELLOO WORLD $RadioValue');
          //                                         }),
          //                                   ),
          //                                 ],
          //                               ),
          //
          //                               const SizedBox(
          //                                 height: 20,
          //                               ),
          //                               Row(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Text('Price - High to Low'),
          //                                   Transform.scale(
          //                                     scale: 1.2,
          //                                     child: Radio(
          //                                         value: "HIGH",
          //                                         groupValue: RadioValue,
          //                                         hoverColor: loginTextColor,
          //                                         //focusColor: loginTextColor,
          //                                         fillColor: MaterialStateColor
          //                                             .resolveWith((states) =>
          //                                                 loginTextColor),
          //                                         onChanged: (value) {
          //                                           RadioValue =
          //                                               value.toString();
          //                                           debugPrint(
          //                                               'HELLO WORLD $RadioValue');
          //                                         }),
          //                                   ),
          //                                 ],
          //                               ),
          //                               SizedBox(
          //                                 width: 120,
          //                                 child: ElevatedButton(
          //                                   onPressed: () {
          //                                     getSortList();
          //
          //                                     Navigator.of(context).pop();
          //                                   },
          //                                   child: Text('Apply'),
          //                                   style: ElevatedButton.styleFrom(
          //                                       backgroundColor:
          //                                           loginTextColor),
          //                                 ),
          //                               ),
          //                               const SizedBox(height: 10),
          //                             ],
          //                           ),
          //                         )
          //                       ],
          //                     );
          //                   });
          //             },
          //             child: SvgPicture.asset(
          //               "assets/svg/updown_arrow.svg",
          //               width: 36,
          //               height: 36,
          //             ),
          //           )),
          //
          //       // Container(
          //       //     decoration: BoxDecoration(
          //       //       color: Colors.white,
          //       //       shape: BoxShape.circle,
          //       //       boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey, spreadRadius: 2)],
          //       //     ),
          //       //     child: SvgPicture.asset("assets/svg/filter1.svg",width: 60,height: 60,)),
          //
          //       Card(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(150),
          //           ),
          //           elevation: 2,
          //           child: SvgPicture.asset("assets/svg/filter1.svg",
          //               width: 36, height: 36))
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          Expanded(
              child: myProductList.length == 0
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                      physics: const ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height * 1.05)),
                      shrinkWrap: true,
                      itemCount: myProductList.length,
                      itemBuilder: (BuildContext context, int index) {
                        //var model = list[index];
                        var model = myProductList[index];
                        //  productId=model.id!;
                        String aImage =
                            model.image!.isNotEmpty ? model.image!['src'] : "";
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (mounted) {
                                setState(() {
                                  productId = model.id!;
                                  tap = model.id!;
                                  if (tap == -1) {
                                    showErrorSnackBar(
                                        context, 'Select product');
                                  } else
                                  {
                                    // List<ProductModel> myList = myProductList
                                    //     .where((ProductModel element) =>
                                    //         element.id == productId)
                                    //     .toList();

                                    int aIndex = 0;
                                    for (var d in model.variantColorList) {

                                      if (d['index'] != -1) {
                                        aIndex = d['index'];
                                      }
                                    }

                                    productTitle = model.title;
                                    productType = model.productType;


                                    // variantId3 = model.variantsList![selectedIndexColor]['id'];
                                    // color3 = model.variantsList![selectedIndexColor]['title'];
                                    // price3 = model.variantsList![selectedIndexColor]['price'];


                                    debugPrint("TRIAL ID : $variantId3}");
                                    debugPrint("TRAIL COLOR : $color3}");
                                    debugPrint("TRAIL PRICE : $price3}");

                                    debugPrint("SHOW TRAIL CLINIC PAGE ID : ${model.variantsList![aIndex]['id']}");
                                    debugPrint(
                                        "SHOW TRAIL CLINIC PAGE PRICE: ${model.variantsList![aIndex]['price']}");
                                    debugPrint(
                                        "SHOW TRAIL CLINIC PAGE TITLE: ${model.variantsList![aIndex]['title']}");
                                    debugPrint(
                                        'IMAGE LENGTH:::   ${model.imagesList!.length}');
                                    debugPrint('IMAGE AINDEX:::   $aIndex');

                                    if (model.imagesList != null) {
                                      debugPrint('SHOW DETAIL: 1');
                                      if (model.imagesList!.isNotEmpty) {
                                        for (var img
                                            in model.imagesList!) {
                                          Map<String, dynamic> map =
                                              <String, dynamic>{};
                                          map['src'] = img['src'];
                                          map['product_id'] = img['product_id'];
                                          imgList2.add(map);
                                        }
                                      } else if (model.image != null) {
                                        debugPrint('SHOW DETAIL: 2');
                                        Map<String, dynamic> map =
                                            <String, dynamic>{};
                                        map['src'] = model.image!['src'];
                                        map['product_id'] =
                                            model.image!['product_id'];
                                        imgList2.add(map);
                                      } else {
                                        debugPrint('SHOW DETAIL: 3');
                                        Map<String, dynamic> map =
                                            <String, dynamic>{};
                                        // map['src'] = "https://cdn.shopify.com/s/files/1/0645/0574/1556/products/61-AD3eliDL._UX679_e9318fbe-4aa5-42c9-957e-dd1154504981.jpg?v=1679919401";
                                        map['src'] =
                                            "https://cdn.shopify.com/s/files/1/0645/0574/1556/products/778026.jpg?v=1676025868";
                                        map['product_id'] = model.id;
                                        imgList2.add(map);
                                      }
                                    } else if (model.image != null) {
                                      debugPrint('SHOW DETAIL: 2');
                                      Map<String, dynamic> map =
                                          <String, dynamic>{};
                                      map['src'] = model.image!['src'];
                                      map['product_id'] =
                                          model.image!['product_id'];
                                      imgList2.add(map);
                                    } else {
                                      debugPrint('SHOW DETAIL: 3');
                                      Map<String, dynamic> map =
                                          <String, dynamic>{};
                                      // map['src'] = "https://cdn.shopify.com/s/files/1/0645/0574/1556/products/61-AD3eliDL._UX679_e9318fbe-4aa5-42c9-957e-dd1154504981.jpg?v=1679919401";
                                      map['src'] =
                                          "https://cdn.shopify.com/s/files/1/0645/0574/1556/products/778026.jpg?v=1676025868";
                                      map['product_id'] = model.id;
                                      imgList2.add(map);
                                    }

                                    getDetails();
                                  }
                                });
                              }
                            });
                            // Get.to(() => EarDetailScreen(id: model.id));
                          },
                          child: Container(
                            width: 46.0.w,
                            margin: const EdgeInsets.only(
                                top: 8.0, right: 2.0, left: 4.0, bottom: 4.0),
                            //margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xffDDDDDD),
                                  blurRadius: 6.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0.0, 0.0),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 22.0, right: 22.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    //child: Icon(Icons.favorite_outline_sharp),
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: loginTextColor,
                                      child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.white,
                                          child: tap == model.id!
                                              ? const CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor:
                                                      loginTextColor,
                                                )
                                              : const CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: Colors.white,
                                                )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0.h,
                                ),
                                aImage.isEmpty
                                    ? Center(
                                        child: Image.asset(
                                          "assets/images/eye_glass.png",
                                          height: 100.0,
                                          width: 100.0,
                                        ),
                                      )
                                    : Center(
                                        child: Image.network(
                                          aImage,
                                          height: 100.0,
                                          width: 100.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                SizedBox(
                                  height: 2.0.h,
                                ),
                                Container(
                                  width: 30.0.w,
                                  height: 4.0.h,
                                  //padding: const EdgeInsets.all(4.0),
                                  padding: const EdgeInsets.all(2.0),
                                  margin: const EdgeInsets.only(left: 22.0),
                                  //margin: const EdgeInsets.only(left: 12.0),
                                  decoration: BoxDecoration(
                                    color: loginBlue,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: ratingColor,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 1.0.w,
                                            ),
                                            Text(
                                              "4.5",
                                              style: zzBoldBlackTextStyle11,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 1.0.w,
                                        ),
                                        const VerticalDivider(
                                          color: white,
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          width: 1.0.w,
                                        ),
                                        Text(
                                          "12",
                                          style: zzRegularBlackTextStyle10,
                                        ),
                                        SizedBox(
                                          width: 1.5.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0.h,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      "${model.title}",
                                      style: zzRegularBlackTextStyle10,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "₹${model.variantsList![0]['price']}",
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
                                ),
                                SizedBox(
                                  width: ScreenSize.getScreenWidth(context),
                                  height: ScreenSize.getScreenHeight(context) *
                                      0.10,
                                  child: ListView.builder(
                                      addAutomaticKeepAlives: false,
                                      addRepaintBoundaries: false,
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: model.variantColorList.length,
                                      itemBuilder:
                                          (BuildContext context, int index1) {
                                        String aColor = model.variantColorList[index1]['color'];


                                        return Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (mounted) {
                                                  setState(() {
                                                    debugPrint(
                                                        "SHOW PRODUCT LIST COLOR SELECTED TOP: $aColor INDEX: ${model.variantColorList[index1]['index']} ");
                                                    for (int i = 0;
                                                        i <
                                                            model
                                                                .variantColorList
                                                                .length;
                                                        i++) {
                                                      if (i == index1) {
                                                        model.variantColorList[i]['index'] = i;

                                                        selectedIndexColor = i;
                                                      } else {
                                                        model.variantColorList[
                                                            i]['index'] = -1;
                                                      }
                                                    }
                                                    selectedColor = aColor;
                                                    debugPrint(
                                                        'SELECTED COLOR : $selectedColor');
                                                    debugPrint(
                                                        'SELECTED COLOR : $selectedColor');

                                                    price3=model.variantsList![index1]['price'];
                                                    color3=model.variantsList![index1]['title'];
                                                    variantId3=model.variantsList![index1]['id'];
                                                    inventory_quantity = model.variantsList![index1]['inventory_quantity'];
                                                    debugPrint("SHOW PRODUCT LIST COLOR SELECTED BOTTOM: $aColor INDEX: ${model.variantColorList[index1]['index']}");
                                                    debugPrint("CLINIC LIST PRICE :: ${model.variantsList![index1]['price']}");
                                                    debugPrint("CLINIC LIST TITLE :: ${model.variantsList![index1]['title']}");
                                                  });
                                                }
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    model.variantColorList[
                                                                    index1]
                                                                ['index'] ==
                                                            index1
                                                        ? loginTextColor
                                                        : Colors.white,
                                                radius: 18.0,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 16.0,
                                                  child: Container(
                                                    width: 27,
                                                    height: 27,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: aColor ==
                                                              "Default Title"
                                                          ? Colors.black
                                                          : getColorFromStringValue(
                                                              aColor
                                                                  .toLowerCase(),
                                                            ),
                                                    ),
                                                  ),
                                                  // child: CircleAvatar(
                                                  //   backgroundColor: aColor ==
                                                  //       "Default Title"
                                                  //       ? Colors.black
                                                  //       : getColorFromStringValue(
                                                  //       aColor
                                                  //           .toLowerCase()),
                                                  //   radius: 14.0,
                                                  // ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10.0),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
        ],
      ),
    );
  }

  void getDetails() {
    localDBHelper!
        .getParticularCartAddedOrNot(productId)
        .then((value) {
      if (value.isNotEmpty) {
        showErrorSnackBar(context, "Product already added to cart");
      } else {
        Get.to(() => ClinicScreenAddress(
              type: mySelectAppointmentType,
              id: productId,
              title: productTitle.toString(),
              variantId: variantId3,
              productType: productType.toString(),
              variantName: color3,
              unitPrice: price3,
              src: imgList2.first['src'].toString(),
              invenQty: inventory_quantity,
              address: widget.address,
            ));
      }
    });
  }

  void getSortList() {
    setState(() {
      if (RadioValue == 'HIGH') {
        myProductList.sort((a, b) {
          return b.variantsList![0]['price']
              .compareTo(a.variantsList![0]['price']);
        });
      } else if (RadioValue == 'LOW') {
        myProductList.sort((a, b) {
          return a.variantsList![0]['price']
              .compareTo(b.variantsList![0]['price']);
        });
      } else if (RadioValue == 'MOST') {
        myProductList.sort((a, b) {
          return a.createdAt!.compareTo(b.createdAt!);
        });
      }
    });
  }
}
