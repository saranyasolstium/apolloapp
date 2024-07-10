import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/services/network/dio_client.dart';
import 'package:infinite/services/network/endpoints.dart';
import 'package:infinite/utils/global.dart';
import 'package:sizer/sizer.dart';

import '../model/product_model.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<ProductModel> myProductList = [];

  @override
  void initState() {
    loading = true;
    getProductList();
    super.initState();
  }

  void getProductList() {
    try {
      DioClient(
              myUrl:
                  "${EndPoints.allProductsList}?title=Arnette Fastball Polarized Alpina TR4")
          .getProductList()
          .then((value) {
        debugPrint("SHOW LOGIN PAGE RESPONSE: $value");
        setState(() {
          if (value.isNotEmpty) {
            myProductList = [];
            myProductList = value;
          } else {
            myProductList = [];
          }
          loading = false;
        });
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: loginTextColor,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios_sharp),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      makeCallOrSendMessage(
                          "call", myDefaultLandLineNumber, "");
                    });
                  },
                  child: SvgPicture.asset(
                    "assets/svg/call.svg",
                    color: white,
                    height: 20.0,
                    width: 20.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                SizedBox(
                  width: 6.0.w,
                ),
                SvgPicture.asset(
                  "assets/svg/search.svg",
                  color: white,
                  height: 20.0,
                  width: 20.0,
                  allowDrawingOutsideViewBox: true,
                ),
                SizedBox(
                  width: 6.0.w,
                ),
                SvgPicture.asset(
                  "assets/svg/cart.svg",
                  color: white,
                  height: 20.0,
                  width: 20.0,
                  allowDrawingOutsideViewBox: true,
                ),
                SizedBox(
                  width: 6.0.w,
                ),
                SvgPicture.asset(
                  "assets/svg/left_menu.svg",
                  color: white,
                  height: 15.0,
                  width: 15.0,
                  allowDrawingOutsideViewBox: true,
                ),
                SizedBox(
                  width: 3.w,
                ),
              ],
            ),
            body: ListView.builder(
                itemCount: myProductList.length,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemBuilder: (BuildContext context, int index) {
                  var model = myProductList[index];
                  String aImage =
                      model.image!.isNotEmpty ? model.image!['src'] : "";
                  return Container(
                    width: 46.0.w,
                    height: 54.0.h,
                    margin: const EdgeInsets.only(
                        top: 8.0, right: 2.0, left: 2.0, bottom: 4.0),
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
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 22.0, right: 22.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.favorite_outline_sharp),
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        aImage.isEmpty
                            ? Image.asset("assets/images/eye_glass.png")
                            : Image.asset("assets/images/eye_glass.png"),

                        SizedBox(
                          height: 5.0.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 30.0.w,
                            height: 4.0.h,
                            padding: const EdgeInsets.all(2.0),
                            margin: const EdgeInsets.only(left: 22.0),
                            decoration: BoxDecoration(
                              color: loginBlue,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              style: zzRegularBlackTextStyle15,
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
                            child: Row(
                              children: [
                                Text(
                                  "₹${model.variantsList![0]['price']}",
                                  style: zzRegularBlackTextStyle10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: loginTextColor,
                                  radius: 14.0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 12.0,
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFFE1D6CB),
                                      radius: 10.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF454545),
                                  radius: 10.0,
                                )
                              ],
                            ),
                          ),
                        ),
                        //   SizedBox(height: 1.0.h,),
                      ],
                    ),
                  );
                })));
  }
}
