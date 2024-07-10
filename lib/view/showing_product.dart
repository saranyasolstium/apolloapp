import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/view/cart/cart.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/view/home/eye_detail_screen.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/widgets/cart_icon.dart';
import 'package:sizer/sizer.dart';

import '../model/list_model.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  String radioButtonItem = 'ONE';

  List<ListModel> modelList = [];
  int id = 1;
  int myCartCount = -1;

  @override
  void initState() {
    super.initState();
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
              makeCallOrSendMessage("call", myDefaultLandLineNumber, "");
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
          CartIcon(),

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
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Showing out 10 of 500 products",
                  style: zzBoldBlackTextStyle13)),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height),
                ),
                shrinkWrap: true,
                itemCount: modelList.length,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemBuilder: (BuildContext context, int index) {
                  ListModel model = modelList[index];
                  debugPrint('MODEL IMAGE :${model.srcname}');
                  debugPrint('MODEL ID :${model.id}');
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EyeDetailsScreen(
                                  id: model.id,
                                  productHandle: "",
                                ))),
                    child: Container(
                      margin: const EdgeInsets.only(
                          right: 2.0, left: 2.0, top: 2.0, bottom: 2.0),
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
                            padding: EdgeInsets.only(top: 4.0, right: 22.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.favorite_outline_sharp),
                            ),
                          ),
                          Image.asset("assets/images/eye_glass.png"),
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
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Text(
                                model.product,
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
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      model.variants!.length > i;
                                      i++) ...{
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Visibility(
                                                visible: i == 0 ? true : false,
                                                child: Text(model.variants![i]
                                                    ['price'])),
                                            SizedBox(
                                              height: i == 0 ? 5 : 10,
                                            ),
                                            const CircleAvatar(
                                              backgroundColor:
                                                  Color(0xFF454545),
                                              radius: 10.0,
                                            )
                                          ],
                                        ))
                                  },
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                color: loginBlue),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
            width: 100.w,
            height: 8.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/updown_arrow.png",
                  width: 20.0,
                  height: 20.0,
                ),
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 40,
                ),
                const VerticalDivider(
                  color: white,
                  thickness: 1,
                ),
                const SizedBox(
                  width: 40,
                ),
                Image.asset(
                  "assets/images/filter.png",
                  width: 20.0,
                  height: 20.0,
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(child: const Text("Filter")),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
