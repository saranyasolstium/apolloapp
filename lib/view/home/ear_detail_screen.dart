import 'dart:convert';

import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/control/home_controller/ear_detail_controller.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/services/remote_service.dart';
import 'package:infinite/view/book/book_appointment.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:infinite/view/review.dart';
import 'package:infinite/widgets/cart_icon.dart';
import 'package:infinite/widgets/html_textview.dart';
import 'package:infinite/widgets/show_offers_widget.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/navigation_widget.dart';
import 'enquiry_screen.dart';

class EarDetailScreen extends StatefulWidget {
  final int? id;

  final String? fromWhere;
  const EarDetailScreen({this.id, Key? key, this.fromWhere}) : super(key: key);

  @override
  State<EarDetailScreen> createState() => _EarDetailScreenState();
}

class _EarDetailScreenState extends State<EarDetailScreen> {
  final earCtrl = Get.isRegistered<EarDetailController>()
      ? Get.find<EarDetailController>()
      : Get.put(EarDetailController());
  int? customerId;
  List<String> reviewList = [];
  int wishlistStatus = 0;
  int reviewCount = 0;
  double averageRating = 0;

  @override
  void initState() {
    customerId = sharedPreferences!.getInt("id");
    earCtrl.earID = widget.id;
    earCtrl.fromWhere = '';
    earCtrl.getDetails();
    fetchProductAvgRating();
    super.initState();
  }

  Color _iconColor = Colors.black;
  Future<void> fetchProductAvgRating() async {
    try {
      var response =
          await RemoteServices().fetchProductAvgRating(earCtrl.earID!);
      print(response.body);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        // Extract reviews
        if (jsonData.containsKey('reviews')) {
          var reviews = jsonData['reviews'] as List<dynamic>;
          reviewList.clear();
          reviews.forEach((review) {
            String reviewText = review['review'];
            reviewList.add(reviewText);
          });
        } else {
          print('No reviews found in the response.');
        }

        // Extract wishlist
        if (jsonData.containsKey('wishlist')) {
          var wishlist = jsonData['wishlist'] as List<dynamic>;
          wishlist.forEach((item) {
            wishlistStatus = item['wishlist_status'];
            _iconColor = Colors.red;
          });
        } else {
          wishlistStatus = 0;
          _iconColor = Colors.black;
        }

        // Extract review_count
        setState(() {
          reviewCount = jsonData['review_count'];
        });

        if (jsonData.containsKey('products')) {
          var products = jsonData['products'] as List<dynamic>;

          if (products.isNotEmpty) {
            var product = products[0];

            setState(() {
              averageRating = product['average_rating'];
              print('averageRating: $averageRating');
            });
          } else {
            print('No products found in the response.');
          }
        } else {
          print('No products key found in the response.');
        }
      } else {
        print('Failed to fetch reviews: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  void _toggleColor() {
    setState(() {
      _iconColor = _iconColor == Colors.black ? Colors.red : Colors.black;
    });
    if (_iconColor == Colors.red) {
      addToWishlist(earCtrl.earID!);
    } else {
      removeFromWishlist(earCtrl.earID!);
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    try {
      final response = await RemoteServices().updateWishlist(
        customerId: customerId!,
        productId: productId,
      );

      if (response.statusCode == 200) {
        showSuccessSnackBar(context, "Wishlist Removed Successfully");
      } else {
        showErrorSnackBar(context, "Failed to remove wishlist!");
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  Future<void> addToWishlist(int productId) async {
    try {
      final response = await RemoteServices().createWishlist(
        customerId: customerId!,
        productId: productId,
      );

      if (response.statusCode == 200) {
        showSuccessSnackBar(context, "Wishlist Added Successfully");
      } else {
        showErrorSnackBar(context, "Failed to add wishlist!");
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EarDetailController>(
        init: EarDetailController(),
        builder: (earCtrl) {
          earCtrl.productId = widget.id;
          return Scaffold(
              endDrawer: const NavigationWidget(),
              appBar: AppBar(
                backgroundColor: loginTextColor,
                leading: IconButton(
                    onPressed: () =>
                        // Get.to(()=> const TrialRequestProductList(411751645428)),
                        Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                actions: [
                  GestureDetector(
                    onTap: () {
                      makeCallOrSendMessage(
                          "call", myDefaultLandLineNumber, "");
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
                    width: 6.w,
                  ),
                  // InkWell(
                  //   onTap: () =>
                  //       Get.to(() => const SearchProductScreen(), arguments: [
                  //     {
                  //       "fromwhere": 'EAR',
                  //     }
                  //   ])!
                  //           .then((value) => earCtrl.applyCartCount()),
                  //   child: SvgPicture.asset(
                  //     "assets/svg/search.svg",
                  //     color: white,
                  //     height: 20.0,
                  //     width: 20.0,
                  //     allowDrawingOutsideViewBox: true,
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 6.w,
                  // ),

                  CartIcon(
                    productId: earCtrl.earID,
                    type: "ear",
                  ),

                  // Badge(
                  //   toAnimate: true,
                  //   animationType: BadgeAnimationType.fade,
                  //   shape: BadgeShape.circle,
                  //   showBadge: earCtrl.myCartCount +
                  //           earCtrl.myBookCount +
                  //           earCtrl.myFrameCount +
                  //           earCtrl.myAddOnCount >
                  //       0,
                  //   position: BadgePosition.topEnd(top: 0),
                  //   badgeContent: Text(
                  //     "${earCtrl.myCartCount + earCtrl.myBookCount + earCtrl.myFrameCount + earCtrl.myAddOnCount}",
                  //     style: zzRegularWhiteTextStyle12,
                  //   ),
                  //   child: InkWell(
                  //     onTap: () => Get.to(() => const Cart())!
                  //         .then((value) => earCtrl.applyCartCount()),
                  //     child: SvgPicture.asset(
                  //       "assets/svg/cart.svg",
                  //       color: white,
                  //       height: 20.0,
                  //       width: 20.0,
                  //       allowDrawingOutsideViewBox: true,
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    width: 6.w,
                  ),
                  Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: SvgPicture.asset(
                        "assets/svg/left_menu.svg",
                        color: white,
                        height: 15.0,
                        width: 15.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                    );
                  }),
                  SizedBox(
                    width: 3.w,
                  ),
                ],
              ),
              body: loading == true
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: 100.w,
                      height: 120.h,
                      child: Column(children: [
                        earCtrl.variantList.isEmpty
                            ? Container()
                            : Expanded(
                                child: SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    earCtrl
                                                        .shareProductOnSocial();
                                                  },
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 20.0,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            earCtrl
                                                                .shareProductOnSocial();
                                                          },
                                                          icon: const Icon(
                                                            Icons.share,
                                                            color: Colors.black,
                                                          ))),
                                                ),
                                                const SizedBox(width: 10.0),
                                                CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 20.0,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          _toggleColor();
                                                        },
                                                        icon: Icon(
                                                          Icons.favorite_border,
                                                          color: _iconColor,
                                                        ))),
                                                const SizedBox(width: 10.0),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 500.0,
                                              height: 300.0,
                                              child: Stack(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                children: [
                                                  PageView.builder(
                                                      physics:
                                                          const AlwaysScrollableScrollPhysics(),
                                                      itemCount: earCtrl
                                                          .imgList2.length,
                                                      onPageChanged:
                                                          (int index) {
                                                        setState(() {
                                                          earCtrl.currentPage2 =
                                                              index;
                                                          earCtrl.imageIndex =
                                                              index;
                                                        });
                                                      },
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        debugPrint(
                                                            'IMG NETWORK: ${earCtrl.imgList2[index]['src']}');

                                                        return InkWell(
                                                            onTap: () {
                                                              // Get.to(() => const Cart());
                                                            },
                                                            child: Image.network(
                                                                earCtrl.imgList2[
                                                                        index]
                                                                    ['src'],
                                                                width: ScreenSize
                                                                    .getScreenWidth(
                                                                        context),
                                                                height: 300));
                                                      }),
                                                  Positioned(
                                                    bottom: 20,
                                                    left: 0,
                                                    right: 0,
                                                    height: 20,
                                                    child: SizedBox(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: List<
                                                                Widget>.generate(
                                                            earCtrl.imgList2
                                                                .length,
                                                            (index) => Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      earCtrl.pageController2.animateToPage(
                                                                          index,
                                                                          duration: const Duration(
                                                                              milliseconds:
                                                                                  300),
                                                                          curve:
                                                                              Curves.easeIn);
                                                                    },
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius: 5,
                                                                      // check if a dot is connected to the current page
                                                                      // if true, give it a different color
                                                                      backgroundColor: earCtrl.currentPage2 ==
                                                                              index
                                                                          ? loginTextColor
                                                                          : loginBlue,
                                                                    ),
                                                                  ),
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(5.0),
                                              width: 100.0.w,
                                              decoration: BoxDecoration(
                                                color: white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xffDDDDDD),
                                                    blurRadius: 6.0,
                                                    spreadRadius: 2.0,
                                                    offset: Offset(0.0, 0.0),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 4.0.h,
                                                    ),
                                                    Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          earCtrl.productTitle!,
                                                          // 'Product Name will be here',
                                                          style:
                                                              zzBoldBlueDarkTextStyle10,
                                                        )),
                                                    SizedBox(
                                                      height: 2.0.h,
                                                    ),
                                                    earCtrl.variantList[earCtrl
                                                                    .mySelectedColorIndex]
                                                                ['price'] !=
                                                            "1.00"
                                                        ? Row(
                                                            children: [
                                                              Text(
                                                                //variantList[i]['price'],
                                                                // variantList![0]['price'],

                                                                '₹${earCtrl.variantList.isEmpty ? "0" : earCtrl.variantList[earCtrl.mySelectedColorIndex]['price']}',
                                                                style:
                                                                    zzBoldBlackTextStyle10,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              // const SizedBox(
                                                              //   width: 5.0,
                                                              // ),
                                                              Visibility(
                                                                visible: earCtrl
                                                                        .variantList[
                                                                            0][
                                                                            'compare_at_price']
                                                                        .toString() !=
                                                                    "null",
                                                                child: Text(
                                                                  '₹${earCtrl.variantPrice}',
                                                                  style:
                                                                      zzBoldGrayDarkStrikeTextStyle10,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Visibility(
                                                        visible: earCtrl.variantList[
                                                                        earCtrl
                                                                            .mySelectedColorIndex]
                                                                    [
                                                                    'inventory_quantity'] <=
                                                                0
                                                            ? true
                                                            : false,
                                                        child: Text(
                                                            'Availability: Sold Out',
                                                            style:
                                                                zzBoldBlueDarkTextStyle10A)),
                                                    Visibility(
                                                        visible: earCtrl.variantList[
                                                                        earCtrl
                                                                            .mySelectedColorIndex]
                                                                    [
                                                                    'inventory_quantity'] <=
                                                                0
                                                            ? false
                                                            : true,
                                                        child: Text(
                                                            'Availability: ${earCtrl.variantList[earCtrl.mySelectedColorIndex]['inventory_quantity']} in stock',
                                                            style:
                                                                zzBoldBlueDarkTextStyle10B)),
                                                    const SizedBox(
                                                        height: 20.0),
                                                    Text(
                                                      'Style : ${earCtrl.selectedStyle}',
                                                      style: zzBoldBlueDarkTextStyle10B
                                                          .copyWith(
                                                              color:
                                                                  loginTextColor),
                                                    ),
                                                    const SizedBox(
                                                        height: 20.0),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 20),
                                                      height: 40,
                                                      child: ListView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: List<
                                                            Widget>.generate(
                                                          earCtrl.myColorList
                                                                      .length *
                                                                  2 -
                                                              1,
                                                          (index) {
                                                            if (index.isEven) {
                                                              int colorIndex =
                                                                  index ~/ 2;
                                                              final String
                                                                  color =
                                                                  earCtrl.myColorList[
                                                                      colorIndex];
                                                              final bool
                                                                  isSelected =
                                                                  color ==
                                                                      earCtrl
                                                                          .selectedStyle;
                                                              return TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    earCtrl.selectedStyle =
                                                                        color;
                                                                    print(
                                                                        'varshan123');
                                                                    print(
                                                                        colorIndex);
                                                                    earCtrl.mySelectedColorIndex =
                                                                        colorIndex;
                                                                  });
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  backgroundColor: isSelected
                                                                      ? loginTextColor
                                                                      : Colors
                                                                          .grey
                                                                          .shade200,
                                                                ),
                                                                child: Text(
                                                                  color,
                                                                  style:
                                                                      TextStyle(
                                                                    color: isSelected
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return const SizedBox(
                                                                  width: 10);
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    earCtrl.variantList[earCtrl
                                                                    .mySelectedColorIndex]
                                                                ['price'] !=
                                                            "1.00"
                                                        ? Center(
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        (() {
                                                                      earCtrl.showAlertDialog(
                                                                          context);
                                                                    }),
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            loginTextColor,
                                                                        padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                            15,
                                                                            10,
                                                                            15,
                                                                            10)),
                                                                    child:
                                                                        const Text(
                                                                      'Trial Request',
                                                                      style: TextStyle(
                                                                          color:
                                                                              white),
                                                                    )),
                                                          )
                                                        : const SizedBox(),
                                                    const SizedBox(
                                                        height: 20.0),
                                                    Text('Description : ',
                                                        style: zzBoldBlueDarkTextStyle10B
                                                            .copyWith(
                                                                color:
                                                                    loginTextColor)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    earCtrl.bodyHtml.isNotEmpty
                                                        ? HtmlTextView(
                                                            htmlContent: earCtrl
                                                                .bodyHtml,
                                                          )
                                                        : const SizedBox(),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 20),
                                                      child: Divider(
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Reviews : ',
                                                          style: zzBoldBlueDarkTextStyle10B
                                                              .copyWith(
                                                                  color:
                                                                      loginTextColor),
                                                        ),
                                                        const Expanded(
                                                          child: SizedBox(),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Get.off(
                                                                ReviewScreen(
                                                              productId: earCtrl
                                                                  .earID!,
                                                              routeType: "ear",
                                                            ));
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                                        loginTextColor),
                                                          ),
                                                          child: const Text(
                                                            'Write Review',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    reviewList.isEmpty
                                                        ? Text(
                                                            "No reviews yet",
                                                            style:
                                                                zzBoldBlueDarkTextStyle10B,
                                                          )
                                                        : Column(
                                                            children: [
                                                              for (var reviewText
                                                                  in reviewList)
                                                                ListTile(
                                                                  title: Text(
                                                                      reviewText),
                                                                ),
                                                            ],
                                                          ),
                                                    const SizedBox(
                                                        height: 10.0),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10.0),
                                            Container(
                                                margin:
                                                    const EdgeInsets.all(5.0),
                                                width: 100.0.w,
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.07,
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color(0xffDDDDDD),
                                                      blurRadius: 6.0,
                                                      spreadRadius: 2.0,
                                                      offset: Offset(0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(width: 10.0),
                                                    const Icon(
                                                      Icons.star,
                                                      color: ratingColor,
                                                      size: 20.0,
                                                    ),
                                                    const SizedBox(width: 3.0),
                                                    Text(
                                                        averageRating
                                                            .toString(),
                                                        style:
                                                            zzRegularGrayTextStyle10),
                                                    const VerticalDivider(
                                                      color: Colors.black12,
                                                      thickness: 2,
                                                      indent: 10.0,
                                                      endIndent: 10.0,
                                                    ),
                                                    Text(
                                                      '$reviewCount Reviews',
                                                      style:
                                                          zzRegularGrayTextStyle10,
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    const Spacer(),
                                                    IconButton(
                                                        onPressed: () {
                                                          Get.off(ReviewScreen(
                                                            productId:
                                                                earCtrl.earID!,
                                                            routeType: "ear",
                                                          ));
                                                        },
                                                        icon: const Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color: black))
                                                  ],
                                                )),
                                            const SizedBox(height: 10.0),
                                            Container(
                                              height: 11.0.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                gradient: const LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [
                                                      Color(0xFFffd9b6),
                                                      Color(0xFFffebbc)
                                                    ]),
                                              ),
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                  left: 20.0,
                                                  top: 5.0,
                                                  right: 20.0,
                                                ),
                                                title: Text(
                                                  "Exclusive offer",
                                                  style:
                                                      zzRegularBlackTextStyle10,
                                                ),
                                                subtitle: Text(
                                                  "Get a 25% off + tax",
                                                  style: zzBoldBlackTextStyle10,
                                                ),
                                                trailing: const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 14.0,
                                                    child: Icon(
                                                      Icons.check,
                                                      color: loginTextColor,
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.0.h,
                                            ),
                                            Visibility(
                                              visible: false,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(5.0),
                                                width: 100.0.w,
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.17,
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color(0xffDDDDDD),
                                                      blurRadius: 6.0,
                                                      spreadRadius: 2.0,
                                                      offset: Offset(0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 25.0,
                                                      ),
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Check delivery location',
                                                            style:
                                                                zzBoldBlackTextStyle13,
                                                          )),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      TextFormField(
                                                        autofocus: false,
                                                        style: GoogleFonts.lato(
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.black),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        maxLength: 10,
                                                        decoration:
                                                            InputDecoration(
                                                          suffix: Text(
                                                            'Check',
                                                            style:
                                                                zzBoldBlueDarkTextStyle10,
                                                          ),
                                                          counter:
                                                              const SizedBox(
                                                                  height: 0.0),
                                                          border:
                                                              InputBorder.none,
                                                          hintText: '160001',
                                                          hintStyle:
                                                              zzBoldBlueDarkTextStyle10,
                                                          filled: true,
                                                          fillColor: white,
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.0),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //const SizedBox(height: 10.0),
                                            // Visibility(
                                            //   visible: earCtrl.bodyHtml != '',
                                            //   child: Container(
                                            //     margin:
                                            //         const EdgeInsets.all(5.0),
                                            //     width: 100.0.w,
                                            //     decoration: BoxDecoration(
                                            //       color: white,
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               10.0),
                                            //       boxShadow: const [
                                            //         BoxShadow(
                                            //           color: Color(0xffDDDDDD),
                                            //           blurRadius: 6.0,
                                            //           spreadRadius: 2.0,
                                            //           offset: Offset(0.0, 0.0),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //     child: const Padding(
                                            //       padding: EdgeInsets.only(
                                            //           left: 15.0, right: 15.0),
                                            //       child: Column(
                                            //         crossAxisAlignment:
                                            //             CrossAxisAlignment
                                            //                 .start,
                                            //         children: [
                                            //           SizedBox(
                                            //             height: 10.0,
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            InkWell(
                                              onTap: () => Get.to(() =>
                                                  const BookAppointment()),
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(5.0),
                                                width: 100.0.w,
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.50,
                                                child: Image.asset(
                                                    "assets/images/eye_doctor.png"),
                                              ),
                                            ),
                                            const SizedBox(height: 10.0),
                                            const ShowOfferWidget(
                                                'Similar Product',
                                                'ear',
                                                'new_arrival',
                                                true),
                                            const SizedBox(height: 20.0),
                                            Container(
                                              color: loginTextColor,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 2.0.h,
                                                  ),
                                                  Center(
                                                    child: Image.asset(
                                                      "assets/images/inf_logo_white.png",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6.0.h,
                                                  ),
                                                  Text("Need any help?",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                  SizedBox(
                                                    height: 6.0.h,
                                                  ),
                                                  SizedBox(
                                                    width: 260,
                                                    height: 50,
                                                    child: ElevatedButton.icon(
                                                      onPressed: () =>
                                                          makeCallOrSendMessage(
                                                              "call",
                                                              "+0421$myDefaultLandLineNumber",
                                                              ""),
                                                      icon: const Icon(
                                                        Icons.phone,
                                                        color: Colors.white,
                                                      ),
                                                      label: Text(
                                                        "Contact Us     ",
                                                        style:
                                                            zzRegularWhiteTextStyle14,
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  loginTextColor,
                                                              foregroundColor:
                                                                  loginTextColor,
                                                              side:
                                                                  const BorderSide(
                                                                width: 1,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4.0.h,
                                                  ),
                                                  SizedBox(
                                                    width: 260,
                                                    height: 50,
                                                    child: ElevatedButton.icon(
                                                      onPressed: () => Freshchat
                                                          .showConversations(),
                                                      icon: const Icon(
                                                        Icons.message,
                                                        color: Colors.white,
                                                      ),
                                                      label: Text(
                                                          "Chat with us",
                                                          style:
                                                              zzRegularWhiteTextStyle14),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  loginTextColor,
                                                              foregroundColor:
                                                                  loginTextColor,
                                                              side:
                                                                  const BorderSide(
                                                                width: 1,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4.0.h,
                                                  ),
                                                  SizedBox(
                                                    width: 260,
                                                    height: 50,
                                                    child: ElevatedButton.icon(
                                                      onPressed: () =>
                                                          makeCallOrSendMessage(
                                                              "mail",
                                                              myDefaultMail,
                                                              ""),
                                                      icon: const Icon(
                                                        Icons.mail_sharp,
                                                        color: Colors.white,
                                                      ),
                                                      label: Text(
                                                          "Mail us         ",
                                                          style:
                                                              zzRegularWhiteTextStyle14),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  loginTextColor,
                                                              foregroundColor:
                                                                  loginTextColor,
                                                              side:
                                                                  const BorderSide(
                                                                width: 1,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6.0.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]))),
                        Visibility(
                          visible: earCtrl.fromWhere == 'CART' ? false : true,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 5, right: 5),
                                  decoration: const BoxDecoration(
                                      color: lightBlue,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // Column(
                                        //   children: [
                                        //     SvgPicture.asset(
                                        //         "assets/svg/cart_ayush_icon.svg"),
                                        //     Text('Virtual Mirror')
                                        //   ],
                                        // ),
                                        InkWell(
                                          onTap: () {
                                            sendMessageToWhatsApp(
                                                earCtrl.clientMobileNumber
                                                    .toString(),
                                                context,
                                                'Product Title :${earCtrl.productTitle}\nPrice :${earCtrl.variantPrice}');
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/svg/cart_ayush_icon2.svg"),
                                              const Text('Buy on WhatsApp')
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                            visible: earCtrl.myTags
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                    'enquiry'.toLowerCase()),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.to(() => EnquiryScreen(
                                                      productName:
                                                          earCtrl.productTitle!,
                                                    ));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      loginTextColor),
                                              child: const Text(
                                                'Enquiry Now',
                                                style: TextStyle(color: white),
                                              ),
                                            )),
                                        // myTags.contains("Hearing - Enquiry")
                                        //  myTags.contains("Enquiry")
                                        //      ? ElevatedButton(
                                        //    onPressed: () {
                                        //      Get.to(() => const EnquiryScreen());
                                        //    },
                                        //    style: ElevatedButton.styleFrom(
                                        //        backgroundColor: loginTextColor),
                                        //    child: const Text('Enquiry Now'),
                                        //  ):
                                        Visibility(
                                          visible: !earCtrl.myTags
                                              .toString()
                                              .toLowerCase()
                                              .contains(
                                                  'enquiry'.toLowerCase()),
                                          child: Visibility(
                                            visible: earCtrl.variantList
                                                        ?.isNotEmpty ==
                                                    true &&
                                                earCtrl.mySelectedColorIndex >=
                                                    0 &&
                                                earCtrl.mySelectedColorIndex <
                                                    earCtrl
                                                        .variantList.length &&
                                                earCtrl.variantList[earCtrl
                                                            .mySelectedColorIndex]
                                                        ['inventory_quantity'] >
                                                    0,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                earCtrl.gotoCart(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: loginTextColor,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 10, 15, 10),
                                              ),
                                              child: const Text(
                                                'Add to Cart',
                                                style: TextStyle(color: white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]))),
                        )
                      ])));
        });
  }
}
