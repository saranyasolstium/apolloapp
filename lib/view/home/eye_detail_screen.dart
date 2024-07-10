import 'dart:convert';

import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/services/network/dio_client.dart';
import 'package:infinite/services/remote_service.dart';
import 'package:infinite/view/book/book_appointment.dart';
import 'package:infinite/view/review.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:infinite/widgets/cart_icon.dart';
import 'package:infinite/widgets/html_textview.dart';
import 'package:infinite/widgets/show_offers_widget.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/product_details_model.dart';
import '../../model/product_model.dart';
import '../../services/network/endpoints.dart';
import '../../widgets/navigation_widget.dart';
import '../cart/cart.dart';
import '../lens/lens_list.dart';
import '../mirror_webview.dart';
import '../products/product_list_screen.dart';
import '../products/search_product_screen.dart';
import 'ear_detail_screen.dart';

class EyeDetailsScreen extends StatefulWidget {
  final int id;
  final String? fromWhere;
  final String? toCart;
  final String productHandle;
  const EyeDetailsScreen(
      {Key? key,
      required this.id,
      this.fromWhere,
      this.toCart,
      required this.productHandle})
      : super(key: key);

  @override
  State<EyeDetailsScreen> createState() => _EyeDetailsScreenState();
}

class _EyeDetailsScreenState extends State<EyeDetailsScreen> {
  final PageController _pageController2 = PageController();
  int currentPage2 = 0;
  //int currentPage = 1;
  List<ProductDetails> detailList = [];
  String? productTitle = '';
  String? productType = '';
  String? handle = '';
  String? bodyHtml = '';

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
  int variantId = 0;
  late int inventory_quantity = 0;
  bool absorbPointer = false;

  // final dbHelper = DatabaseHelper();
  int productId = 0;
  int variantID = 0;
  int myCartCount = 0;
  int myBookCount = 0;
  int myFrameCount = 0;
  int myAddOnCount = 0;
  String prType = '';
  var currentTime;
  int? invQty;
  String myMobile = '';
  int clientMobileNumber = 8121012908;
  String? variantPrice;
  int? checkId;

  //NEWLY ADDED
  final PageController _pageController = PageController();
  var currentPage = 1.0;
  List<ProductModel> myProductList = [];
  List<ProductModel> myList = [];
  final DateTime _currentDate = DateTime.now();
  late DateTime previousDate;

  int j = 0, k = 0;
  int? customerId;
  List<String> reviewList = [];
  int wishlistStatus = 0;
  int reviewCount = 0;
  double averageRating = 0;
  @override
  void initState() {
    checkProduct();
    debugPrint('SIMILAR FROM WHERE :: ${widget.fromWhere}');
    customerId = sharedPreferences!.getInt("id");

    _pageController2.addListener(() {
      setState(() {
        currentPage2 = _pageController2.page!.toInt();
        myCartCount;
        myBookCount;
        myFrameCount;
        myAddOnCount;
        myMobile = sharedPreferences!.getString("mobileNumber") ?? "";
      });
    });
    setState(() {
      getDetails();
      getProductList();
    });

    controller.text = widget.id.toString();
    // dbHelper.init();
    productId = widget.id;
    debugPrint('PRODUCT ID: $productId');
    debugPrint('FROM WHERE :: ${widget.toCart}');
    currentTime = DateTime.now();
    fetchProductAvgRating();

    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Havish123');
  }

  Future<void> fetchProductAvgRating() async {
    try {
      var response = await RemoteServices().fetchProductAvgRating(widget.id);
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

  @override
  void dispose() {
    _pageController2.dispose();
    super.dispose();
  }

  void checkProduct() {
    localDBHelper!.getParticularCartAddedOrNot(widget.id).then((value) {
      if (value.isNotEmpty) {
        checkId = 1;
      } else {
        checkId = 0;
      }
    });
  }

  void getDetails() {
    try {
      DioClient(myUrl: "products/${widget.id}.json").getDetails().then((value) {
        setState(() {
          if (value.statusCode == 200) {
            var data = value.data['product'];
            productTitle = data['title'];
            productType = data['product_type'];
            handle = data['handle'];
            bodyHtml = data['body_html'];
            productTitle!.toLowerCase().replaceAll(' ', '');
            if (data['images'] != null) {
              var imgvar = data['images'] as List;
              if (imgvar.isNotEmpty) {
                for (var img in imgvar) {
                  Map<String, dynamic> map = <String, dynamic>{};
                  map['src'] = img['src'];
                  map['product_id'] = img['product_id'];
                  imgList2.add(map);
                }
              } else if (data['image'] != null) {
                var aImageMap = data['image'];
                Map<String, dynamic> map = <String, dynamic>{};
                map['src'] = aImageMap['src'];
                map['product_id'] = aImageMap['product_id'];
                imgList2.add(map);
              } else {
                debugPrint('SHOW DETAIL: 3');
                Map<String, dynamic> map = <String, dynamic>{};
                map['src'] =
                    "https://cdn.shopify.com/s/files/1/0645/0574/1556/products/778026.jpg?v=1676025868";
                map['product_id'] = data['id'];
                imgList2.add(map);
              }
            } else if (data['image'] != null) {
              var aImageMap = data['image'];
              Map<String, dynamic> map = <String, dynamic>{};
              map['src'] = aImageMap['src'];
              map['product_id'] = aImageMap['product_id'];
              imgList2.add(map);
            } else {
              Map<String, dynamic> map = <String, dynamic>{};
              map['src'] =
                  "https://cdn.shopify.com/s/files/1/0645/0574/1556/products/61-AD3eliDL._UX679_e9318fbe-4aa5-42c9-957e-dd1154504981.jpg?v=1679919401";
              map['product_id'] = data['id'];
              imgList2.add(map);
            }

            var varData = data['variants'] as List;
            for (var d in varData) {
              Map<String, dynamic> map = <String, dynamic>{};
              map['price'] = d['price'];
              map['title'] = d['title'];
              map['id'] = d['id'];
              map['inventory_quantity'] = d['inventory_quantity'];
              map['old_inventory_quantity'] = d['old_inventory_quantity'];
              map['compare_at_price'] = d['compare_at_price'];
              map['sku'] = d['sku'];
              variantId = map['id'];
              inventory_quantity = map['inventory_quantity'];
              variantList.add(map);
            }
            variantPrice = variantList[0]['price'];

            var aOptionsData = data['options'] as List;
            if (aOptionsData.isNotEmpty) {
              for (var option in aOptionsData) {
                if (option['values'] != null) {
                  var aColorData = option['values'] as List;
                  if (aColorData.isNotEmpty) {
                    myColorList = [];
                    for (var color in aColorData) {
                      myColorList.add(color);
                    }
                  } else {
                    myColorList = [];
                  }
                }
              }
            } else {
              myColorList = [];
            }
          } else {}
        });
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  Color _iconColor = Colors.black;

  void _toggleColor() {
    setState(() {
      _iconColor = _iconColor == Colors.black ? Colors.red : Colors.black;
    });
    if (_iconColor == Colors.red) {
      addToWishlist(widget.id);
    } else {
      removeFromWishlist(widget.id);
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
    return Scaffold(
        endDrawer: const NavigationWidget(),
        appBar: AppBar(
          backgroundColor: loginTextColor,
          leading: IconButton(
              onPressed: () => Get.to(() => ViewProductListScreen(
                    411246690548,
                    handle: widget.productHandle,
                  )),
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  makeCallOrSendMessage("call", myDefaultLandLineNumber, "");
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
              width: 6.w,
            ),
            CartIcon(
              productId: productId,
              type: "eye",
            ),
            SizedBox(
              width: 6.w,
            ),
            Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  setState(() {
                    Scaffold.of(context).openEndDrawer();
                  });
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
        body: imgList2.isEmpty
            ? Center(
                child: Lottie.asset(
                animationLoading,
                repeat: true,
                reverse: true,
                animate: true,
                width: ScreenSize.getScreenWidth(context) * 0.40,
                height: ScreenSize.getScreenHeight(context) * 0.40,
              ))
            : SizedBox(
                width: 100.w,
                height: 100.h,
                child: Column(children: [
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        shareProductOnSocial();
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20.0,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            shareProductOnSocial();
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.share,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20.0,
                                    child: IconButton(
                                      onPressed: () {
                                        _toggleColor();
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: _iconColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                ],
                              ),

                              SizedBox(
                                width: 500.0,
                                height: 300.0,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [
                                    PageView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: imgList2.length,
                                        onPageChanged: (int index) {
                                          setState(() {
                                            currentPage2 = index;
                                          });
                                        },
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          debugPrint(
                                              'IMG NETWORK: ${imgList2[index]['src']}');

                                          return InkWell(
                                              onTap: () {
                                                // Get.to(() => const Cart());
                                              },
                                              child: Image.network(
                                                  imgList2[index]['src'],
                                                  width:
                                                      ScreenSize.getScreenWidth(
                                                          context),
                                                  height: 300));
                                        }),
                                    Positioned(
                                      bottom: 40,
                                      left: 0,
                                      right: 0,
                                      height: 20,
                                      child: SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                              imgList2.length,
                                              (index) => Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _pageController2.animateToPage(
                                                              index,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                              curve: Curves
                                                                  .easeIn);
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 5,
                                                        // check if a dot is connected to the current page
                                                        // if true, give it a different color
                                                        backgroundColor:
                                                            currentPage2 ==
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
                                // height: ScreenSize.getScreenHeight(context) * 0.56,
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
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            productTitle!,
                                            // 'Product Name will be here',
                                            style: zzBoldBlueDarkTextStyle10,
                                          )),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                      Row(
                                        children: [
                                          //  for(int i=0; variantList.length>i; i++)...{
                                          Text(
                                            //variantList[i]['price'],
                                            //'₹${variantList[mySelectedColorIndex]['price']}',
                                            '₹$variantPrice',
                                            style: zzBoldBlackTextStyle10,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          // }
                                          // Text(
                                          //   '₹500',
                                          //   style: zzBoldBlackTextStyle10,
                                          // ),
                                          // const SizedBox(
                                          //   width: 5.0,
                                          // ),
                                          Visibility(
                                            visible: variantList[0]
                                                        ['compare_at_price']
                                                    .toString() !=
                                                "null",
                                            child: Text(
                                              '₹${variantList[0]['compare_at_price']}',
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
                                      //         borderRadius: BorderRadius.all(
                                      //             Radius.circular(20.0))),
                                      //     child: Row(
                                      //       children: [
                                      //         const SizedBox(width: 10.0),
                                      //         const Icon(
                                      //           Icons.star,
                                      //           color: ratingColor,
                                      //           size: 20.0,
                                      //         ),
                                      //         const SizedBox(width: 3.0),
                                      //         Text('4.5',
                                      //             style:
                                      //                 zzBoldBlueDarkTextStyle10),
                                      //         const VerticalDivider(
                                      //           color: Colors.white38,
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
                                      //         const SizedBox(width: 10.0),
                                      //       ],
                                      //     )),
                                      // const SizedBox(height: 10.0),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text('SKU : ',
                                              style:
                                                  zzBoldBlueDarkTextStyle10B),
                                          Text(variantList[0]['sku'],
                                              style:
                                                  zzBoldBlueDarkTextStyle10B),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Visibility(
                                          visible: variantList[
                                                          mySelectedColorIndex]
                                                      ['inventory_quantity'] <=
                                                  0
                                              ? true
                                              : false,
                                          child: Text('Availability: Sold Out',
                                              style:
                                                  zzBoldBlueDarkTextStyle10A)),
                                      Visibility(
                                          visible: variantList[
                                                          mySelectedColorIndex]
                                                      ['inventory_quantity'] <=
                                                  0
                                              ? false
                                              : true,
                                          child: Text(
                                              'Availability: ${variantList[mySelectedColorIndex]['inventory_quantity']} in stock',
                                              style:
                                                  zzBoldBlueDarkTextStyle10B)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text('Description : ',
                                          style: zzBoldBlueDarkTextStyle10B
                                              .copyWith(color: loginTextColor)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      HtmlTextView(
                                        htmlContent: bodyHtml!,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Divider(
                                          color: Colors.grey.shade300,
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
                                                    color: loginTextColor),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.off(ReviewScreen(
                                                productId: widget.id,
                                                routeType: "eye",
                                              ));
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      loginTextColor),
                                            ),
                                            child: const Text(
                                              'Write Review',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                              style: zzBoldBlueDarkTextStyle10B,
                                            )
                                          : Column(
                                              children: [
                                                for (var reviewText
                                                    in reviewList)
                                                  ListTile(
                                                    title: Text(reviewText),
                                                  ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                  margin: const EdgeInsets.all(5.0),
                                  width: 100.0.w,
                                  height: ScreenSize.getScreenHeight(context) *
                                      0.07,
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 10.0),
                                      const Icon(
                                        Icons.star,
                                        color: ratingColor,
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 3.0),
                                      Text(averageRating.toString(),
                                          style: zzRegularGrayTextStyle10),
                                      const VerticalDivider(
                                        color: Colors.black12,
                                        thickness: 2,
                                        indent: 10.0,
                                        endIndent: 10.0,
                                      ),
                                      Text(
                                        '$reviewCount Reviews',
                                        style: zzRegularGrayTextStyle10,
                                      ),
                                      const SizedBox(width: 10.0),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            Get.off(ReviewScreen(
                                              productId: widget.id,
                                              routeType: "eye",
                                            ));
                                          },
                                          icon: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: black))
                                    ],
                                  )),

                              SizedBox(
                                height: 2.0.h,
                              ),
                              Container(
                                height: 13.0.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        Color(0xFFffd9b6),
                                        Color(0xFFffebbc)
                                      ]),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(
                                    left: 20.0,
                                    top: 10.0,
                                    right: 20.0,
                                  ),
                                  title: Text(
                                    "Exclusive offer",
                                    style: zzRegularBlackTextStyle10,
                                  ),
                                  subtitle: Text(
                                    "Get a 10% off + tax",
                                    style: zzBoldBlackTextStyle10,
                                  ),
                                  trailing: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 14.0,
                                      child: Icon(
                                        Icons.check,
                                        color: loginTextColor,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 4.0.h,
                              ),
                              Visibility(
                                visible: false,
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  width: 100.0.w,
                                  // height: ScreenSize.getScreenHeight(context) * 0.35,
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 25.0,
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Check delivery location',
                                              style: zzBoldBlackTextStyle13,
                                            )),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        TextFormField(
                                          autofocus: false,
                                          style: GoogleFonts.lato(
                                              fontSize: 15.0,
                                              color: Colors.black),
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
                                          decoration: InputDecoration(
                                            suffix: Text(
                                              'Check',
                                              style: zzBoldBlueDarkTextStyle10,
                                            ),
                                            counter:
                                                const SizedBox(height: 0.0),
                                            border: InputBorder.none,
                                            hintText: '160001',
                                            hintStyle:
                                                zzBoldBlueDarkTextStyle10,
                                            filled: true,
                                            fillColor: white,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20.0),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/svg/home_delivery.svg",
                                              height: 40.0,
                                              width: 40.0,
                                              allowDrawingOutsideViewBox: true,
                                            ),
                                            const SizedBox(width: 15.0),
                                            Text(
                                                'Home delivery in 2 business days',
                                                style:
                                                    zzRegularBlackTextStyle12),
                                          ],
                                        ),
                                        SizedBox(height: 3.0.h),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/svg/easy_return.svg",
                                              height: 40.0,
                                              width: 40.0,
                                              allowDrawingOutsideViewBox: true,
                                            ),
                                            const SizedBox(width: 15.0),
                                            Text('Easy 7 day return applicable',
                                                style:
                                                    zzRegularBlackTextStyle12),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () =>
                                    Get.to(() => const BookAppointment()),
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  width: 100.0.w,
                                  height: ScreenSize.getScreenHeight(context) *
                                      0.50,
                                  child: Image.asset(
                                      "assets/images/eye_doctor.png"),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              const ShowOfferWidget(
                                  'Similar Product', 'eye', "", true),
                              // ShowOffer(),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
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
                                      decoration: TextDecoration.none)),
                              SizedBox(
                                height: 6.0.h,
                              ),
                              SizedBox(
                                width: 260,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: () => makeCallOrSendMessage("call",
                                      "+0421$myDefaultLandLineNumber", ""),
                                  icon: const Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Contact Us     ",
                                    style: zzRegularWhiteTextStyle14,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: loginTextColor,
                                      foregroundColor: loginTextColor,
                                      side: const BorderSide(
                                        width: 1,
                                        color: Colors.white,
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
                                      Freshchat.showConversations(),
                                  icon: const Icon(
                                    Icons.message,
                                    color: Colors.white,
                                  ),
                                  label: Text("Chat with us",
                                      style: zzRegularWhiteTextStyle14),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: loginTextColor,
                                      foregroundColor: loginTextColor,
                                      side: const BorderSide(
                                        width: 1,
                                        color: Colors.white,
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
                                  onPressed: () => makeCallOrSendMessage(
                                      "mail", myDefaultMail, ""),
                                  icon: const Icon(
                                    Icons.mail_sharp,
                                    color: Colors.white,
                                  ),
                                  label: Text("Mail us         ",
                                      style: zzRegularWhiteTextStyle14),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: loginTextColor,
                                      foregroundColor: loginTextColor,
                                      side: const BorderSide(
                                        width: 1,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 6.0.h,
                              ),
                            ],
                          ),
                        ),
                        // Align(
                        //     alignment: Alignment.bottomCenter,
                        //     child: Container(
                        //       padding: EdgeInsets.only(
                        //           top: 20, bottom: 20, left: 5, right: 5),
                        //       decoration: BoxDecoration(
                        //           // color:lightBlue,
                        //           borderRadius: BorderRadius.only(
                        //               topLeft: Radius.circular(10.0),
                        //               topRight: Radius.circular(10.0))),
                        //       child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             Column(
                        //               children: [
                        //                 SvgPicture.asset(
                        //                     "assets/svg/cart_ayush_icon.svg"),
                        //                 Text('Virtual Mirror')
                        //               ],
                        //             ),
                        //             Column(
                        //               children: [
                        //                 SvgPicture.asset(
                        //                     "assets/svg/cart_ayush_icon2.svg"),
                        //                 Text('Buy on WhatsApp')
                        //               ],
                        //             ),
                        //             ElevatedButton(
                        //               onPressed: () {
                        //                 insertData2(context);
                        //               },
                        //               child: Text('Add to cart'),
                        //               style: ElevatedButton.styleFrom(
                        //                   backgroundColor: loginTextColor),
                        //             ),
                        //           ]),
                        //     ))
                      ],
                    ),
                  )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 5, right: 5),
                          decoration: const BoxDecoration(
                              color: lightBlue2,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Visibility(
                                  visible: productType == "Frame",
                                  child: InkWell(
                                    onTap: () async {
                                      debugPrint(
                                          'VIRTUAL MIRROR ::: ${widget.id}');
                                      // await Permission.camera.request();
                                      // await Permission.microphone.request();
                                      // await Permission.storage.request();
                                      // You can request multiple permissions at once.

                                      // debugPrint(statuses[Permission.camera]);
                                      // Get.to(() => EyeDetailsScreen(id: widget.id));
                                      Get.to(() => const MyWebView());
                                    },
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/svg/cart_ayush_icon.svg"),
                                        const Text('Virtual Mirror')
                                      ],
                                    ),
                                  ),
                                ),
                                AbsorbPointer(
                                  absorbing: absorbPointer,
                                  child: InkWell(
                                    onTap: () {
                                      sendMessageToWhatsApp(
                                          clientMobileNumber.toString(),
                                          context,
                                          'Product Title :$productTitle\nPrice :$variantPrice');
                                    },
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/svg/cart_ayush_icon2.svg"),
                                        const Text('Buy on WhatsApp')
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                    //  visible: invQty == 0 ? false : true,

                                    // || checkId == 1
                                    //   visible: variantList[mySelectedColorIndex]['inventory_quantity'] == 0 || invQty == 0 || widget.fromWhere == 'CART' ? false : true,
                                    visible: widget.fromWhere == 'CART'
                                        ? false
                                        : true,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          debugPrint(
                                              'ON PRESS CART ${widget.toCart}');

                                          //  if (btnText=='View cart') {
                                          //  Get.to(()=> const Cart());
                                          // }
                                          //  else {
                                          //            if(widget.toCart=='BOOK'){
                                          //              insertData3(context);
                                          //            }
                                          //            else{
                                          insertData2(context);
                                          //    }

                                          //   }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: loginTextColor,
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 10, 15, 10)),
                                        child: const Text(
                                          'Add to cart',
                                          style: TextStyle(color: white),
                                        )))
                              ])))
                ])));
  }

  void insertData2(BuildContext context) {
    if (variantList[mySelectedColorIndex]['inventory_quantity'].toString() ==
        "0") {
      showErrorSnackBar(context, "Product is out of stock");
    } else if (variantList[mySelectedColorIndex]['inventory_quantity'] <= 0) {
      showErrorSnackBar(context, "Selected variant out of stock");
    } else {
      debugPrint('DETAIL ID: $productId');

      // localDBHelper!.getParticularCartAddedOrNot(widget.id).then((
      //     value) {
      //   debugPrint('VALUE :: $value');
      //
      //
      //   for(var data in value){
      //     debugPrint('TYPE :: ${data['pr_type']}');
      //     debugPrint('NAME :: ${data['name']}');
      //     debugPrint('PRODUCT TYPE :: ${data['product_type']}');
      //   }

      // if (value.isNotEmpty) {
      //
      //   showErrorSnackBar(context, "Product already added to cart");
      // }
      // else
      // {
      var data = <String, dynamic>{};
      data['product_id'] = widget.id;
      //  data['pr_type'] = 'order';

      data['variant_id'] = variantId;
      data['product_name'] = productTitle;
      data['product_type'] = productType;

      //   data['variant_name'] = 'RED';
      data['variant_name'] = variantList[mySelectedColorIndex]['title'];
      data['unit_price'] = variantList[mySelectedColorIndex]['price'];
      data['quantity'] = 1;
      data['total'] = (variantList[mySelectedColorIndex]['price']) * 1;

      //  data['is_sync'] = 0;
      data['image_url'] = imgList2.first['src'];
      data['inventory_quantity'] =
          variantList[mySelectedColorIndex]['inventory_quantity'];

      data['created_at'] = currentTime.toString();
      data['updated_at'] = currentTime.toString();

      debugPrint('PRODUCT TYPE: $productType');
      Get.to(() => LensList(
            // fromWhere2:'ORDER',
            id: productId,
            title: productTitle.toString(),
            variantId: variantId,
            productType: productType.toString(),
            variantName: variantList[mySelectedColorIndex]['title'].toString(),
            unitPrice: variantList[mySelectedColorIndex]['price'].toString(),
            src: imgList2.first['src'].toString(),
            invQty: inventory_quantity,
            productTitle: productTitle.toString(),
          ));

      //NOT VALID
      // if (productType == "Frame") {
      //   // post3();
      //   Get.to(() =>
      //       LensList(
      //           id: productId,
      //           title: productTitle.toString(),
      //           variantId: variantId,
      //           productType: productType.toString(),
      //           variantName: variantList![mySelectedColorIndex]['title']
      //               .toString(),
      //           unitPrice: variantList[mySelectedColorIndex]['price']
      //               .toString(),
      //           src: imgList2.first['src'].toString(),
      //           invQty: inventory_quantity));
      // }
      // else {
      //   post2();
      //   //post3();
      //   localDBHelper!.insertValuesIntoCartTable(data).then((value) =>
      //       showSuccessSnackBar(
      //           context, "Product added to cart successfully!"));
      //
      //   Get.to(() => Cart(lensType: productType, fromWhere: 2,));
      // }

      //  }
      // }
      //  );
    }
  }

  void insertData3(BuildContext context) {
    if (variantList[mySelectedColorIndex]['inventory_quantity'].toString() ==
        "0") {
      showErrorSnackBar(context, "Product is out of stock");
    } else {
      debugPrint('DETAIL ID: $productId');

      // localDBHelper!.getParticularCartAddedOrNot(productId, 'order').then((
      //     value) {
      //   debugPrint('VALUE :: $value');
      //
      //
      //   for(var data in value){
      //     debugPrint('TYPE :: ${data['pr_type']}');
      //     debugPrint('NAME :: ${data['name']}');
      //     debugPrint('PRODUCT TYPE :: ${data['product_type']}');
      //   }
      //
      //
      //   if (value.isNotEmpty) {
      //
      //     showErrorSnackBar(context, "Product already added to cart");
      //   }
      //   else
      //   {
      var data = <String, dynamic>{};
      data['product_id'] = productId;
      data['pr_type'] = 'book';

      data['variant_id'] = variantId;
      data['name'] = productTitle;
      data['product_type'] = productType;

      //   data['variant_name'] = 'RED';
      data['variant_name'] = variantList[mySelectedColorIndex]['title'];
      data['unit_price'] = variantList[mySelectedColorIndex]['price'];
      data['quantity'] = 1;
      data['total'] = (variantList[mySelectedColorIndex]['price']) * 1;

      data['is_sync'] = 0;
      data['image_url'] = imgList2.first['src'];
      data['inventory_quantity'] =
          variantList[mySelectedColorIndex]['inventory_quantity'];

      data['created_at'] = currentTime.toString();
      data['updated_at'] = currentTime.toString();

      debugPrint('PRODUCT TYPE: $productType');
      Get.to(() => LensList(
          //fromWhere2: widget.toCart,
          id: productId,
          title: productTitle.toString(),
          variantId: variantId,
          productType: productType.toString(),
          variantName: variantList[mySelectedColorIndex]['title'].toString(),
          unitPrice: variantList[mySelectedColorIndex]['price'].toString(),
          src: imgList2.first['src'].toString(),
          invQty: inventory_quantity,
          productTitle:productTitle.toString()))!;

      //NOT VALID
      // if (productType == "Frame") {
      //   // post3();
      //   Get.to(() =>
      //       LensList(
      //           id: productId,
      //           title: productTitle.toString(),
      //           variantId: variantId,
      //           productType: productType.toString(),
      //           variantName: variantList![mySelectedColorIndex]['title']
      //               .toString(),
      //           unitPrice: variantList[mySelectedColorIndex]['price']
      //               .toString(),
      //           src: imgList2.first['src'].toString(),
      //           invQty: inventory_quantity));
      // }
      // else {
      //   post2();
      //   //post3();
      //   localDBHelper!.insertValuesIntoCartTable(data).then((value) =>
      //       showSuccessSnackBar(
      //           context, "Product added to cart successfully!"));
      //
      //   Get.to(() => Cart(lensType: productType, fromWhere: 2,));
      // }

      //  }
      //  }
      //);
    }
  }

  void post2() async {
    Map<String, dynamic> map = <String, dynamic>{};
    map['product_id2'] = widget.id;
    map['lens_type'] = '';

    map['priscription'] = '';
    map['frame_name'] = '';
    map['frame_price'] = 0;
    map['frame_qty'] = 1;
    map['frame_total'] = 0;

    map['rd_sph'] = '';
    map['rd_cyl'] = '';
    map['rd_axis'] = '';
    map['rd_bcva'] = '';

    map['ra_sph'] = '';
    map['ra_cyl'] = '';
    map['ra_axis'] = '';
    map['ra_bcva'] = '';

    map['ld_sph'] = '';
    map['ld_cyl'] = '';
    map['ld_axis'] = '';
    map['ld_bcva'] = '';

    map['la_sph'] = '';
    map['la_cyl'] = '';
    map['la_axis'] = '';
    map['la_bcva'] = '';

    map['re'] = '';
    map['le'] = '';

    map['addon_title'] = '';
    map['addon_price'] = 0;
    map['addon_qty'] = 1;
    map['addon_total'] = 0;

    await localDBHelper!.insertValuesIntoCartTable2(map);
  }

  // SHARE PRODUCTS ON SOCIAL MEDIA
  void shareProductOnSocial() async {
    try {
      await FlutterShare.share(
          title: productTitle!,
          text: 'Take a look at this $productTitle on Infinite',
          //linkUrl: imgList2[0]['src'],
          //linkUrl:"https://my6senses.com/collections/eyeglasses-colors-black/products/$handle",
          linkUrl:
              "https://my6senses.com/collections/eyeglasses/products/$handle",
          chooserTitle: 'Share');
    } catch (e) {
      debugPrint('$e');
    }
  }

  void sendMessageToWhatsApp(
      String mobile, BuildContext context, String aContent) async {
    var whatsappUrl =
        "whatsapp://send?phone=+91$mobile&text=${Uri.encodeComponent(aContent)}";
    // var whatsappUrl = "https://wa.me/$mobile?text=$aContent";
    try {
      launch(whatsappUrl);
    } catch (e) {
      absorbPointer = true;
      //To handle error and display error message
      showErrorSnackBar(context, 'Whatsapp Not Installed in the Device');
      Future.delayed(const Duration(seconds: 2), () {
        absorbPointer = false;
      });
    }
  }

  void getProductList() {
    try {
      String aUrl =
          "${EndPoints.allProductsList}?limit=6&collection_id=411246690548";

      DioClient(myUrl: aUrl).getProductList().then((value) {
        if (mounted) {
          setState(() {
            if (value.isNotEmpty) {
              myProductList = [];
              myProductList = value;
              debugPrint("SHOW LIST: $value");
              getFilterByDate();
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

  void getFilterByDate() {
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(_currentDate);
    for (ProductModel model in myProductList) {
      String prevDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(_currentDate);

      previousDate = DateFormat('yyyy-MM-dd').parse(model.createdAt.toString());
      var inputDate = DateTime.parse(previousDate.toString());
      var fart = DateFormat('dd-MM-yyyy');
      var aDate = fart.format(inputDate);

      if (previousDate.isBefore(_currentDate)) {
        if (myList.length <= 9) {
          myList.add(model);
        }
      }
    }
  }

  Widget clampingList() {
    if (myList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return PageView.builder(
          itemCount: myList.length > 6 ? 6 : myList.length,
          physics: const ClampingScrollPhysics(),
          controller: _pageController,
          itemBuilder: (context, index) {
            //var model = myProductList[index];
            var model = myList[index];
            String aImage = model.image!.isNotEmpty ? model.image!['src'] : "";
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                Matrix4 matrix = Matrix4.identity();
                if (index == currentPage.floor()) {
                  var currScale = 1 - (currentPage - index) * (1 - 0.8);
                  var currTrans = 230.0 * (1 - currScale) / 2;
                  matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                    ..setTranslationRaw(0, currTrans, 0);
                } else if (index == currentPage.floor() + 1) {
                  var currScale = 0.8 + (currentPage - index + 1) * (1 - 0.8);
                  var currTrans = 230.0 * (1 - currScale) / 2;
                  matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                    ..setTranslationRaw(0, currTrans, 0);
                } else if (index == currentPage.floor() - 1) {
                  var currScale = 1 - (currentPage - index) * (1 - 0.8);
                  var currTrans = 230.0 * (1 - currScale) / 2;
                  matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                    ..setTranslationRaw(0, currTrans, 0);
                } else {
                  var currScale = 0.8;
                  matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
                    ..setTranslationRaw(0, 230.0 * (1 - 0.8) / 2, 0);
                }
                return Transform(
                  transform: matrix,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: InkWell(
                          // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          //     EyeDetailsScreen(id: model.id!))),

                          onTap: () {
                            String aProductType = model.productType!;
                            debugPrint('SIMILAR PRODUCT $aProductType');
                            if (aProductType == "Audiology") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EarDetailScreen(id: model.id)));
                              // Get.to(() => EarDetailScreen(id: model.id));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EyeDetailsScreen(
                                            id: model.id!,
                                            productHandle: widget.productHandle,
                                          )));
                              // Get.to(() => EyeDetailsScreen(id: model.id!,))!.then((value) => getDetails());
                            }
                          },

                          child: Container(
                            width: ScreenSize.getScreenWidth(context) * 0.90,
                            // height: ScreenSize.getScreenHeight(context) * 0.48,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              children: [
                                // const Padding(
                                //   padding: EdgeInsets.only(
                                //       top: 10.0, right: 20.0),
                                //   child: Align(
                                //     alignment:
                                //     Alignment.centerRight,
                                //     child: Icon(Icons
                                //         .favorite_outline_sharp),
                                //   ),
                                // ),
                                Visibility(
                                    visible: model.variantsList![j]
                                                ['inventory_quantity'] ==
                                            0
                                        ? true
                                        : false,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        color: Colors.black,
                                        margin: const EdgeInsets.fromLTRB(
                                            20, 10, 0, 0),
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 5, 0),
                                        child: Text(' Sold Out ',
                                            textAlign: TextAlign.center,
                                            style: zzBoldBlueDarkTextStyle10A1),
                                      ),
                                    )),
                                aImage.isEmpty
                                    ? Image.asset("assets/images/eye_glass.png")
                                    : Image.network(
                                        aImage,
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.contain,
                                      ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 28.0.w,
                                      height: 4.0.h,
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.only(left: 22.0),
                                      decoration: BoxDecoration(
                                        color: loginBlue,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  style:
                                                      zzBoldBlueDarkTextStyle10,
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
                                              style: zzBoldBlueDarkTextStyle10,
                                            ),
                                            SizedBox(
                                              width: 1.5.w,
                                            ),
                                          ],
                                        ),
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
                                      style: zzRegularBlackTextStyle15B,
                                      overflow: TextOverflow.visible,
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
                                          "₹${model.variantsList![j]['price']}",
                                          style: zzRegularBlackTextStyle10,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Visibility(
                                          visible: model.variantsList![j]
                                                      ['compare_at_price']
                                                  .toString() !=
                                              "null",
                                          child: Text(
                                            "₹${model.variantsList![j]['compare_at_price']}",
                                            style:
                                                zzBoldGrayDarkStrikeTextStyle10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: ScreenSize.getScreenWidth(context),
                                    height:
                                        ScreenSize.getScreenHeight(context) *
                                            0.10,
                                    child: ListView.builder(
                                        addAutomaticKeepAlives: false,
                                        addRepaintBoundaries: false,
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            model.variantColorList.length,
                                        itemBuilder:
                                            (BuildContext context, int index1) {
                                          j = index1;
                                          String aColor =
                                              model.variantColorList[index1]
                                                  ['color'];
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
                                                          model.variantColorList[
                                                              i]['index'] = i;
                                                        } else {
                                                          model.variantColorList[
                                                              i]['index'] = -1;
                                                        }
                                                      }
                                                      debugPrint(
                                                          "SHOW PRODUCT LIST COLOR SELECTED BOTTOM: $aColor INDEX: ${model.variantColorList[index1]['index']}");
                                                    });
                                                  }
                                                },
                                                child: Visibility(
                                                  visible: model.variantsList![
                                                          index1]['title'] !=
                                                      'Default Title',
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        model.variantColorList[
                                                                        index1]
                                                                    ['index'] ==
                                                                index1
                                                            ? loginTextColor
                                                            : Colors.white,
                                                    radius: 16.0,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 14.0,
                                                      child: Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
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
                                                      //       aColor.toLowerCase()),
                                                      //   radius: 14.0,
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
    }
  }

  Widget ShowOffer() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          width: ScreenSize.getScreenWidth(context),
          // height: ScreenSize.getScreenHeight(context) * 0.67,
          decoration: BoxDecoration(
            color: const Color(0xFFe2eafd),
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
              SizedBox(
                height: 3.0.h,
              ),
              Text(
                'Similar Product',
                style: zzBoldBlackTextStyle14,
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  AspectRatio(
                    aspectRatio: 0.83,
                    child: clampingList(),
                  ),
                  Positioned(
                    // bottom: 25.0,
                    bottom: MediaQuery.of(context).size.height * 0.03,
                    //bottom: 3.h,
                    left: 0,
                    right: 0,
                    height: 20.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                          myProductList.length >= 6 ? 6 : myProductList.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: currentPage == index
                                      ? loginTextColor
                                      : loginBlue2,
                                ),
                              )),
                    ),
                  ),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: List<Widget>.generate(
              //       6,
              //           (index) => Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 5),
              //         // child: InkWell(
              //         //   onTap: () {
              //         //     _pageController.animateToPage(index,
              //         //         duration: const Duration(
              //         //             milliseconds: 300),
              //         //         curve: Curves.easeIn);
              //         //   },
              //           child: CircleAvatar(
              //             radius: 5,
              //             // check if a dot is connected to the current page
              //             // if true, give it a different color
              //             backgroundColor: currentPage == index
              //                 ? loginTextColor
              //                 : loginBlue2,
              //           ),
              //         // ),
              //       )),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
