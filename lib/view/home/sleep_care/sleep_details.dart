import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/control/home_controller/sleep_detail_controller.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/services/remote_service.dart';
import 'package:infinite/view/book/book_appointment.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:infinite/view/home/enquiry_screen.dart';
import 'package:infinite/view/review.dart';
import 'package:infinite/widgets/cart_icon.dart';
import 'package:infinite/widgets/html_textview.dart';
import 'package:infinite/widgets/navigation_widget.dart';
import 'package:infinite/widgets/show_offers_widget.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class SleepDetailScreen extends StatefulWidget {
  final int? id;
  final String? fromWhere;
  const SleepDetailScreen({this.id, Key? key, this.fromWhere})
      : super(key: key);

  @override
  State<SleepDetailScreen> createState() => _SleepDetailScreenState();
}

class _SleepDetailScreenState extends State<SleepDetailScreen> {
  final sleepCtrl = Get.isRegistered<SleepDetailController>()
      ? Get.find<SleepDetailController>()
      : Get.put(SleepDetailController());
  late DateTime _selectedDate;
  int? customerId;
  List<String> reviewList = [];
  int wishlistStatus = 0;
  int reviewCount = 0;
  double averageRating = 0;

  @override
  void initState() {
    customerId = sharedPreferences!.getInt("id");
    sleepCtrl.sleepID = widget.id;
    sleepCtrl.fromWhere = '';
    sleepCtrl.getDetails();
    _selectedDate = DateTime.now();
    fetchProductAvgRating();
    super.initState();
  }

  Future<void> fetchProductAvgRating() async {
    try {
      var response =
          await RemoteServices().fetchProductAvgRating(sleepCtrl.sleepID!);
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
      addToWishlist(sleepCtrl.sleepID!);
    } else {
      removeFromWishlist(sleepCtrl.sleepID!);
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        startDateController.text =
            DateFormat('dd-MM-yyyy').format(_selectedDate);
        _populateDropdown();
      });
    }
  }

  List<String> _dropdownItems = [];

  void _populateDropdown() {
    _dropdownItems.clear();
    DateTime currentDate = _selectedDate;
    DateTime endDate = _selectedDate.add(const Duration(days: 365 * 2));

    while (currentDate.isBefore(endDate)) {
      currentDate = currentDate.add(const Duration(days: 30));
      String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
      _dropdownItems.add(formattedDate);
    }
  }

  String? _selectedDropdownItem;

  Widget _buildDropdownButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 12),
      child: DropdownButton<String>(
        value: _selectedDropdownItem,
        hint: const Text('Select End Date'),
        onChanged: (String? newValue) {
          setState(() {
            _selectedDropdownItem = newValue!;
            int selectedIndex = _dropdownItems.indexOf(newValue);
            double price = double.parse(sleepCtrl.variantPrice!);
            double totalPrice = price * (selectedIndex + 1);
            sleepCtrl.variantPrice = totalPrice.toStringAsFixed(2);
            print(sleepCtrl.variantPrice);
          });
        },
        items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Widget buildDatePickerRow(
      TextEditingController controller, Function onTap, String hintText) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextFormField(
              showCursor: false,
              readOnly: true,
              onTap: onTap as void Function()?,
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: hintText,
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
                suffixIcon: InkWell(
                  onTap: onTap as void Function()?,
                  child: const Icon(Icons.calendar_month),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SleepDetailController>(
        init: SleepDetailController(),
        builder: (sleepCtrl) {
          sleepCtrl.productId = widget.id;
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
                    productId: sleepCtrl.sleepID,
                    type: "sleep",
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
                        sleepCtrl.variantList.isEmpty
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
                                                    sleepCtrl
                                                        .shareProductOnSocial();
                                                  },
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 20.0,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            sleepCtrl
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
                                                    controller: sleepCtrl
                                                        .pageController5,
                                                    itemCount: sleepCtrl
                                                        .imgList2.length,
                                                    onPageChanged: (int index) {
                                                      setState(() {
                                                        sleepCtrl.currentPage5 =
                                                            index;
                                                        sleepCtrl.imageIndex =
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
                                                            sleepCtrl.imgList2[
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
                                                          sleepCtrl
                                                              .imgList2.length,
                                                          (index) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            child: InkWell(
                                                              onTap: () {
                                                                sleepCtrl
                                                                    .pageController5
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
                                                                    sleepCtrl.currentPage5 ==
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
                                                          sleepCtrl
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
                                                        sleepCtrl.variantList[0]
                                                                    ['title'] !=
                                                                "Rent"
                                                            ? Text(
                                                                '₹${sleepCtrl.variantList.isEmpty ? "0" : sleepCtrl.variantList[0]['price']}',
                                                                style:
                                                                    zzBoldBlackTextStyle10,
                                                              )
                                                            : Text(
                                                                'Rent : ₹${sleepCtrl.variantList.isEmpty ? "0" : sleepCtrl.variantPrice}',
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
                                                          visible: sleepCtrl
                                                                  .variantList[
                                                                      0][
                                                                      'compare_at_price']
                                                                  .toString() !=
                                                              "null",
                                                          child: Text(
                                                            '₹${sleepCtrl.variantPrice}',
                                                            style:
                                                                zzBoldGrayDarkStrikeTextStyle10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    sleepCtrl.variantList
                                                                    .length >
                                                                1 &&
                                                            sleepCtrl.variantList[
                                                                        1]
                                                                    ['title'] ==
                                                                'Sale'
                                                        ? Text(
                                                            'Sale: ₹${sleepCtrl.variantList[1]['price']}',
                                                            style:
                                                                zzBoldBlackTextStyle10,
                                                          )
                                                        : const SizedBox(),

                                                    // const SizedBox(
                                                    //   height: 10.0,
                                                    // ),
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
                                                    const SizedBox(height: 20),

                                                    // Text(
                                                    //     'Availability: ${sleepCtrl.variantList[sleepCtrl.mySelectedColorIndex]['inventory_quantity']} in stock',
                                                    //     style:
                                                    //         zzBoldBlueDarkTextStyle10B),
                                                    Visibility(
                                                        visible: sleepCtrl.variantList[
                                                                        sleepCtrl
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
                                                        visible: sleepCtrl.variantList[
                                                                        sleepCtrl
                                                                            .mySelectedColorIndex]
                                                                    [
                                                                    'inventory_quantity'] <=
                                                                0
                                                            ? false
                                                            : true,
                                                        child: Text(
                                                            'Availability: ${sleepCtrl.variantList[sleepCtrl.mySelectedColorIndex]['inventory_quantity']} in stock',
                                                            style:
                                                                zzBoldBlueDarkTextStyle10B)),
                                                    // const SizedBox(
                                                    //     height: 20.0),
                                                    // sleepCtrl.sizeName.isNotEmpty
                                                    //     ? Text(
                                                    //         'Size : ${sleepCtrl.sizeName.first} ',
                                                    //         style: zzBoldBlueDarkTextStyle10B
                                                    //             .copyWith(
                                                    //                 color:
                                                    //                     loginTextColor),
                                                    //       )
                                                    //     : SizedBox(),

                                                    const SizedBox(
                                                        height: 20.0),

                                                    Text(
                                                      'Type : ${sleepCtrl.selectedStyle}',
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
                                                          sleepCtrl.myColorList
                                                                      .length *
                                                                  2 -
                                                              1,
                                                          (index) {
                                                            if (index.isEven) {
                                                              int colorIndex =
                                                                  index ~/ 2;
                                                              final String
                                                                  color =
                                                                  sleepCtrl
                                                                          .myColorList[
                                                                      colorIndex];
                                                              final bool
                                                                  isSelected =
                                                                  color ==
                                                                      sleepCtrl
                                                                          .selectedStyle;
                                                              return TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    sleepCtrl
                                                                            .selectedStyle =
                                                                        color;
                                                                  sleepCtrl.mySelectedColorIndex=colorIndex;
                                                                    
                                                                  });
                                                                  print(sleepCtrl.mySelectedColorIndex);
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
                                                    sleepCtrl.selectedStyle ==
                                                            "Rent"
                                                        ? const SizedBox(
                                                            height: 40.0)
                                                        : const SizedBox(),
                                                    sleepCtrl.selectedStyle ==
                                                            "Rent"
                                                        ? Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: buildDatePickerRow(
                                                                    startDateController,
                                                                    () => _selectDate(
                                                                        context),
                                                                    "Select Start Date"),
                                                              ),
                                                              const SizedBox(
                                                                  width: 20),
                                                              Expanded(
                                                                child:
                                                                    _buildDropdownButton(),
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox(),

                                                    const SizedBox(
                                                        height: 20.0),
                                                    Text('Description : ',
                                                        style: zzBoldBlueDarkTextStyle10B
                                                            .copyWith(
                                                                color:
                                                                    loginTextColor)),

                                                    sleepCtrl
                                                            .bodyHtml.isNotEmpty
                                                        ? HtmlTextView(
                                                            htmlContent:
                                                                sleepCtrl
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
                                                            Get.off(ReviewScreen(
                                                              productId:
                                                                  sleepCtrl
                                                                      .sleepID!,
                                                              routeType: "sleep",
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
                                                            productId: sleepCtrl
                                                                .sleepID!,
                                                            routeType: "sleep",
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
                                                'sleep',
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
                          visible: sleepCtrl.fromWhere == 'CART' ? false : true,
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
                                        InkWell(
                                          onTap: () {
                                            sendMessageToWhatsApp(
                                                sleepCtrl.clientMobileNumber
                                                    .toString(),
                                                context,
                                                'Product Title :${sleepCtrl.productTitle}\nPrice :${sleepCtrl.variantPrice}');
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
                                        //     visible: sleepCtrl.myTags
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
                                          visible: !sleepCtrl.myTags
                                              .toString()
                                              .toLowerCase()
                                              .contains(
                                                  'enquiry'.toLowerCase()),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              print(sleepCtrl.selectedStyle);

                                              if (sleepCtrl.selectedStyle ==
                                                  "Rent") {
                                                if (startDateController
                                                        .text.isEmpty ||
                                                    _selectedDropdownItem ==
                                                        null) {
                                                  showErrorSnackBar(context,
                                                      "Please select Start and End Date");
                                                } else {
                                                  sleepCtrl.gotoCart(
                                                      context,
                                                      sleepCtrl.selectedStyle ==
                                                              "Sale"
                                                          ? sleepCtrl
                                                                  .variantList[
                                                              1]['price']
                                                          : sleepCtrl
                                                              .variantPrice,
                                                      true,
                                                      startDateController.text
                                                          .toString(),
                                                      _selectedDropdownItem
                                                          .toString());
                                                }
                                              } else {
                                                print('havish');
                                                sleepCtrl.gotoCart(
                                                    context,
                                                    sleepCtrl.selectedStyle ==
                                                            "Sale"
                                                        ? sleepCtrl
                                                                .variantList[1]
                                                            ['price']
                                                        : sleepCtrl
                                                            .variantPrice,
                                                    false,
                                                    DateTime.now().toString(),
                                                    DateTime.now().toString());
                                              }
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
