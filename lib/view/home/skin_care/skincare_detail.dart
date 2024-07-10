import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/control/home_controller/oral_detail_controller.dart';
import 'package:infinite/control/home_controller/skin_detail_controller.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/services/remote_service.dart';
import 'package:infinite/view/book/book_appointment.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:infinite/view/cart/cart.dart';
import 'package:infinite/view/home/enquiry_screen.dart';
import 'package:infinite/view/products/search_product_screen.dart';
import 'package:infinite/view/review.dart';
import 'package:infinite/widgets/cart_icon.dart';
import 'package:infinite/widgets/html_textview.dart';
import 'package:infinite/widgets/navigation_widget.dart';
import 'package:infinite/widgets/show_offers_widget.dart';
import 'package:sizer/sizer.dart';

class SkinDetailScreen extends StatefulWidget {
  final int? id;
  final String? fromWhere;
  const SkinDetailScreen({this.id, Key? key, this.fromWhere}) : super(key: key);

  @override
  State<SkinDetailScreen> createState() => _SkinDetailScreenState();
}

class _SkinDetailScreenState extends State<SkinDetailScreen> {
  final skinCtrl = Get.isRegistered<SkinDetailController>()
      ? Get.find<SkinDetailController>()
      : Get.put(SkinDetailController());
  int? customerId;
  List<String> reviewList = [];
  int wishlistStatus = 0;
  int reviewCount = 0;
  double averageRating = 0;
  @override
  void initState() {
    customerId = sharedPreferences!.getInt("id");
    skinCtrl.skinID = widget.id;
    skinCtrl.fromWhere = '';
    skinCtrl.getDetails();
    fetchProductAvgRating();
    super.initState();
  }

  Future<void> fetchProductAvgRating() async {
    try {
      var response =
          await RemoteServices().fetchProductAvgRating(skinCtrl.skinID!);
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

        var products = jsonData['products'] as List<dynamic>;
        var product = products.isNotEmpty ? products[0] : null;
        if (product != null) {
          setState(() {
            averageRating = product['average_rating'];
          });
        } else {
          print('No product found in the response.');
        }
      } else {
        print('Failed to fetch reviews: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  Color _iconColor = Colors.black;

  void _toggleColor() {
    setState(() {
      _iconColor = _iconColor == Colors.black ? Colors.red : Colors.black;
    });
    if (_iconColor == Colors.red) {
      addToWishlist(skinCtrl.skinID!);
    } else {
      removeFromWishlist(skinCtrl.skinID!);
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

  final BadgeController badgeController = Get.find<BadgeController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('saranya');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkinDetailController>(
        init: SkinDetailController(),
        builder: (skinCtrl) {
          skinCtrl.productId = widget.id;
          return Scaffold(
              endDrawer: const NavigationWidget(),
              appBar: AppBar(
                backgroundColor: loginTextColor,
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
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
                  CartIcon(
                    productId: skinCtrl.skinID,
                    type: "skin",
                  ),
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
                        skinCtrl.variantList.isEmpty
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
                                                    skinCtrl
                                                        .shareProductOnSocial();
                                                  },
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 20.0,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            skinCtrl
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
                                              height: 350.0,
                                              child: Stack(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                children: [
                                                  PageView.builder(
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    controller: skinCtrl
                                                        .pageController4,
                                                    itemCount: skinCtrl
                                                        .imgList2.length,
                                                    onPageChanged: (int index) {
                                                      setState(() {
                                                        skinCtrl.currentPage4 =
                                                            index;
                                                        skinCtrl.imageIndex =
                                                            index;
                                                      });
                                                    },
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          // Get.to(() => const Cart());
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      15.sp),
                                                          child: Image.network(
                                                            skinCtrl.imgList2[
                                                                index]['src'],
                                                            width: ScreenSize
                                                                .getScreenWidth(
                                                                    context),
                                                            fit: BoxFit.contain,
                                                            height: 300.0,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Positioned(
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
                                                          skinCtrl
                                                              .imgList2.length,
                                                          (index) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: InkWell(
                                                              onTap: () {
                                                                skinCtrl
                                                                    .pageController4
                                                                    .animateToPage(
                                                                  index,
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  curve: Curves
                                                                      .easeIn,
                                                                );
                                                              },
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 5,
                                                                backgroundColor:
                                                                    skinCtrl.currentPage4 ==
                                                                            index
                                                                        ? loginTextColor
                                                                        : loginBlue,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(5.0),
                                              padding: const EdgeInsets.only(
                                                  right: 10),
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
                                                          skinCtrl
                                                              .productTitle!,
                                                          // 'Product Name will be here',
                                                          style:
                                                              zzBoldBlueDarkTextStyle14,
                                                        )),
                                                    SizedBox(
                                                      height: 2.0.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          //variantList[i]['price'],
                                                          // variantList![0]['price'],

                                                          '₹${skinCtrl.variantList.isEmpty ? "0" : skinCtrl.variantList[skinCtrl.mySelectedColorIndex]['price']}',
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
                                                          visible: skinCtrl
                                                                  .variantList[
                                                                      0][
                                                                      'compare_at_price']
                                                                  .toString() !=
                                                              "null",
                                                          child: Text(
                                                            '₹${skinCtrl.variantPrice}',
                                                            style:
                                                                zzBoldGrayDarkStrikeTextStyle10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    // Container(
                                                    //     height: 40.0,
                                                    //     width: 100.0,
                                                    //     decoration: const BoxDecoration(
                                                    //         color: loginBlue,
                                                    //         borderRadius:
                                                    //             BorderRadius.all(
                                                    //                 Radius.circular(
                                                    //                     20.0))),
                                                    //     child: Row(
                                                    //       children: [
                                                    //         const SizedBox(
                                                    //             width: 10.0),
                                                    //         const Icon(
                                                    //           Icons.star,
                                                    //           color:
                                                    //               ratingColor,
                                                    //           size: 20.0,
                                                    //         ),
                                                    //         const SizedBox(
                                                    //             width: 3.0),
                                                    //         Text('4.5',
                                                    //             style:
                                                    //                 zzBoldBlueDarkTextStyle10),
                                                    //         const VerticalDivider(
                                                    //           color: Colors
                                                    //               .white38,
                                                    //           thickness: 2,
                                                    //           indent: 5.0,
                                                    //           endIndent: 5.0,
                                                    //         ),
                                                    //         const Divider(),
                                                    //         const Spacer(),
                                                    //         Text(
                                                    //           '12',
                                                    //           style:
                                                    //               zzBoldBlueDarkTextStyle10,
                                                    //         ),
                                                    //         const SizedBox(
                                                    //             width: 10.0),
                                                    //       ],
                                                    //     )),
                                                    // const SizedBox(height: 20),

                                                    // Text(
                                                    //     'Availability: ${skinCtrl.variantList[skinCtrl.mySelectedColorIndex]['inventory_quantity']} in stock',
                                                    //     style:
                                                    //         zzBoldBlueDarkTextStyle10B),
                                                    Visibility(
                                                        visible: skinCtrl.variantList[
                                                                        skinCtrl
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
                                                        visible: skinCtrl.variantList[
                                                                        skinCtrl
                                                                            .mySelectedColorIndex]
                                                                    [
                                                                    'inventory_quantity'] <=
                                                                0
                                                            ? false
                                                            : true,
                                                        child: Text(
                                                            'Availability: ${skinCtrl.variantList[skinCtrl.mySelectedColorIndex]['inventory_quantity']} in stock',
                                                            style:
                                                                zzBoldBlueDarkTextStyle10B)),
                                                    // const SizedBox(
                                                    //     height: 20.0),
                                                    // skinCtrl.sizeName.isNotEmpty
                                                    //     ? Text(
                                                    //         'Size : ${skinCtrl.sizeName.first} ',
                                                    //         style: zzBoldBlueDarkTextStyle10B
                                                    //             .copyWith(
                                                    //                 color:
                                                    //                     loginTextColor),
                                                    //       )
                                                    //     : SizedBox(),

                                                    const SizedBox(
                                                        height: 20.0),

                                                    Text(
                                                      'Style : ${skinCtrl.selectedStyle}',
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
                                                          skinCtrl.myColorList
                                                                      .length *
                                                                  2 -
                                                              1,
                                                          (index) {
                                                            if (index.isEven) {
                                                              int colorIndex =
                                                                  index ~/ 2;
                                                              final String
                                                                  color =
                                                                  skinCtrl.myColorList[
                                                                      colorIndex];
                                                              final bool
                                                                  isSelected =
                                                                  color ==
                                                                      skinCtrl
                                                                          .selectedStyle;
                                                              return TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    skinCtrl.selectedStyle =
                                                                        color;
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
                                                        height: 20.0),
                                                    Text('Description : ',
                                                        style: zzBoldBlueDarkTextStyle10B
                                                            .copyWith(
                                                                color:
                                                                    loginTextColor)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    skinCtrl.bodyHtml.isNotEmpty
                                                        ? HtmlTextView(
                                                            htmlContent:
                                                                skinCtrl
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
                                                              productId:
                                                                  skinCtrl
                                                                      .skinID!,
                                                              routeType: "skin",
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
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("No reviews yet",
                                                        style:
                                                            zzBoldBlueDarkTextStyle10B),
                                                    const SizedBox(
                                                      height: 20,
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
                                                            productId: skinCtrl
                                                                .skinID!,
                                                            routeType: "skin",
                                                          ));
                                                        },
                                                        icon: const Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color: black))
                                                  ],
                                                )),
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
                                                'skin',
                                                'new_arrival',
                                                true),
                                            const SizedBox(height: 10.0),
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
                          visible: skinCtrl.fromWhere == 'CART' ? false : true,
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
                                                skinCtrl.clientMobileNumber
                                                    .toString(),
                                                context,
                                                'Product Title :${skinCtrl.productTitle}\nPrice :${skinCtrl.variantPrice}');
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
                                        // Visibility(
                                        //     visible: skinCtrl.myTags
                                        //         .toString()
                                        //         .toLowerCase()
                                        //         .contains(
                                        //             'enquiry'.toLowerCase()),
                                        //     child: ElevatedButton(
                                        //       onPressed: () {
                                        //         Get.to(() =>
                                        //             const EnquiryScreen());
                                        //       },
                                        //       style: ElevatedButton.styleFrom(
                                        //           backgroundColor:
                                        //               loginTextColor),
                                        //       child: const Text(
                                        //         'Enquiry Now',
                                        //         style: TextStyle(color: white),
                                        //       ),
                                        //     )),

                                        Visibility(
                                          visible: !skinCtrl.myTags
                                              .toString()
                                              .toLowerCase()
                                              .contains(
                                                  'enquiry'.toLowerCase()),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              skinCtrl.gotoCart(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: loginTextColor,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 10, 15, 10)),
                                            child: const Text(
                                              'Add to Cart',
                                              style: TextStyle(color: white),
                                            ),
                                          ),
                                        ),
                                      ]))),
                        )
                      ])));
        });
  }
}
