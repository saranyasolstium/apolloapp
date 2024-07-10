import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/model/filter_model.dart';
import 'package:infinite/view/products/product_filter.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/widgets/cart_icon.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';
import 'package:infinite/widgets/navigation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../model/product_model.dart';
import '../../res/colors.dart';
import '../../res/styles.dart';
import '../../services/network/dio_client.dart';
import '../../services/network/endpoints.dart';
import '../../utils/screen_size.dart';
import '../home/ear_detail_screen.dart';

class TrialRequestProductList extends StatefulWidget {
  final int? myCollectionId;
  final String? address;
  final int? myTab;
  final String? fromFilter;
  final List<String>? aBrandList;
  final List<String>? aMaterialList;
  final List<String>? aShapeList;
  final List<String>? aStyleList;
  final List<String>? aColorList;
  final List<String>? aGenderList;
  final List<String>? aAvailabilityList;
  final List<String>? aProductTypeList;
  final int? aStartPrice;
  final int? aEndPrice;
  final List<bool>? aBoolBrandList;
  final List<bool>? aBoolMaterialList;
  final List<bool>? aBoolShapeList;
  final List<bool>? aBoolStyleList;
  final List<bool>? aBoolColorList;
  final List<bool>? aBoolGenderList;
  final List<bool>? aBoolAvailabilityList;
  final List<bool>? aBoolTypeList;

  const TrialRequestProductList(this.myCollectionId,
      {this.address,
      this.myTab,
      this.fromFilter,
      this.aBrandList,
      this.aMaterialList,
      this.aShapeList,
      this.aStyleList,
      this.aColorList,
      this.aGenderList,
      this.aAvailabilityList,
      this.aProductTypeList,
      this.aStartPrice,
      this.aEndPrice,
      this.aBoolBrandList,
      this.aBoolMaterialList,
      this.aBoolShapeList,
      this.aBoolStyleList,
      this.aBoolColorList,
      this.aBoolGenderList,
      this.aBoolAvailabilityList,
      this.aBoolTypeList,
      Key? key})
      : super(key: key);

  @override
  State<TrialRequestProductList> createState() =>
      _TrialRequestProductListState();
}

class _TrialRequestProductListState extends State<TrialRequestProductList> {
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
  late int variantId;
  int inventory_quantity = 0;
  late String colorTitle;
  late String price;
  int productId = -1;
  late String selectedColor;
  int selectedIndexColor = 0;
  int selectedIndexColor2 = 0;
  int radio = 0;
  int variantId3 = 0;
  String color3 = '';
  String price3 = '';
  String src3 = '';
  String? variantPrice;
  String? variantPrice2;
  int count = 0;
  int mySelectAppointmentType = 1;

  String radioButtonDefault = 'Home';
  String RadioValue = '';
  int pageItemCount = 50;
  String isColor = '';
  bool hasNextPage = true;
  final ScrollController _controller = ScrollController();
  List<String> productIds = [];

  @override
  void initState() {
    super.initState();
    loading = true;
    getProductList();

    // _controller.addListener(_scrollListener);

    if (widget.myTab == null) {
      widget.myTab == 1;
    }
    debugPrint('SHOW THE TAB SELECTION::::${widget.myTab}');
    getProductListCount();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void getProductList() {
    try {
      String aUrl = "";
      if (widget.myCollectionId == 0) {
        aUrl = "${EndPoints.allProductsList}?limit=$pageItemCount";
      } else {
        aUrl =
            "${EndPoints.allProductsList}?limit=$pageItemCount&product_type=Audiology";
      }

      DioClient(myUrl: aUrl).getProductList().then((value) {
        if (mounted) {
          setState(() {
            if (value.isNotEmpty) {
              myProductList = [];
              for (ProductModel model in value) {
                myProductList.add(model);
                // Optionally, you can check variantColorList here if needed
              }

              if (widget.fromFilter == 'F') {
                // Apply filters based on price range
                if (widget.aStartPrice != null && widget.aEndPrice != null) {
                  myProductList = myProductList.where((product) {
                    bool isInRange = product.price >= widget.aStartPrice! &&
                        product.price <= widget.aEndPrice!;
                    print(
                        "Product price: ${product.price}, Is in range: $isInRange");
                    return isInRange;
                  }).toList();

                  print("Filtered product count: ${myProductList.length}");
                  print("Start price: ${widget.aStartPrice}");
                  print("End price: ${widget.aEndPrice}");
                  print(widget.aAvailabilityList!);

                  if (widget.aAvailabilityList!.contains("InStock") &&
                      !widget.aAvailabilityList!.contains("Out of Stock")) {
                    myProductList = myProductList
                        .where((product) => product.variantsList!.any(
                            (variant) => variant['inventory_quantity'] > 0))
                        .toList();
                  }
                  if (widget.aAvailabilityList!.contains("Out of Stock") &&
                      !widget.aAvailabilityList!.contains("InStock")) {
                    myProductList = myProductList
                        .where((product) => product.variantsList!.any(
                            (variant) => variant['inventory_quantity'] == 0))
                        .toList();
                  }

                  setState(() {
                    count = myProductList.length;
                  });
                }
              }
            } else {
              hasNextPage = false;
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

  void getBestSellingList() {
    try {
      String aUrl = "";
      aUrl =
          "${EndPoints.allProductsList}?collection_id=410986807540&product_type=Audiology";
      debugPrint("BEST SELLING LIST URL: $aUrl");
      DioClient(myUrl: aUrl).getProductList().then((value) {
        debugPrint("BEST SELLING LIST RESPONSE: $value");

        if (mounted) {
          setState(() {
            if (value.isNotEmpty) {
              myProductList = [];
              for (ProductModel model in value) {
                myProductList.add(model);
              }
              getSortList();
              debugPrint("BEST SELLING LIST SIZE: ${myProductList.length}");
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

  void getProductListCount() {
    try {
      String aUrl = "";
      if (widget.myCollectionId == 0) {
        aUrl = EndPoints.productsListCount;
      } else {
        aUrl =
            "${EndPoints.productsListCount}?collection_id=410986807540&product_type=Audiology";
      }
      DioClient(myUrl: aUrl).getDetails().then((value) {
        if (mounted) {
          setState(() {
            if (value.statusCode == 200) {
              count = value.data['count'] ?? 0;
            }
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
            if (model.title
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
              list.add(model);
            }
          }
          getSearchSortList();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        endDrawer: const NavigationWidget(),
        appBar: AppBar(
          backgroundColor: loginTextColor,
          title: Text(
            "Trial Request",
            style: zzRegularWhiteAppBarTextStyle14,
          ),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 28.0,
            ),
          ),
          actions: <Widget>[
            CartIcon(
              productId: productId,
              type: "trial",
            ),
            const SizedBox(
              width: 10,
            ),
            Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset(
                    "assets/svg/left_menu.svg",
                    color: white,
                    height: 15.0,
                    width: 15.0,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              );
            }),
            SizedBox(
              width: 3.w,
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 200,
                    height: 40,
                    child: TextFormField(
                        controller: controller1,
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search product',
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                            prefixIcon: Icon(Icons.search))),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function()) setState) {
                                return AlertDialog(
                                  backgroundColor: loginBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  insetPadding: const EdgeInsets.all(14),
                                  actionsPadding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 0.0),
                                  actions: <Widget>[
                                    Container(
                                      width: 100.0.w,
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Sort by',
                                                style: GoogleFonts.lato(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: SvgPicture.asset(
                                                    "assets/svg/close_circle_white.svg",
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                            ),
                                            child: Divider(
                                              thickness: 1,
                                              color: Colors.black12,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Bestseller'),
                                              Transform.scale(
                                                scale: 1.2,
                                                child: Radio(
                                                    value: "BEST",
                                                    activeColor: loginTextColor,
                                                    groupValue: RadioValue,
                                                    hoverColor: loginTextColor,
                                                    fillColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            loginTextColor),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        RadioValue =
                                                            value.toString();
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('New arrival'),
                                              Transform.scale(
                                                scale: 1.2,
                                                child: Radio(
                                                    value: "NEW",
                                                    activeColor: loginTextColor,
                                                    groupValue: RadioValue,
                                                    hoverColor: loginTextColor,
                                                    fillColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            loginTextColor),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        RadioValue =
                                                            value.toString();
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Most viewed'),
                                              Transform.scale(
                                                scale: 1.2,
                                                child: Radio(
                                                    value: "MOST",
                                                    groupValue: RadioValue,
                                                    fillColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            loginTextColor),
                                                    activeColor: loginTextColor,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        RadioValue =
                                                            value.toString();
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Price - Low to High'),
                                              Transform.scale(
                                                scale: 1.2,
                                                child: Radio(
                                                    value: "LOW",
                                                    activeColor: loginTextColor,
                                                    groupValue: RadioValue,
                                                    hoverColor: loginTextColor,
                                                    fillColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            loginTextColor),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        RadioValue =
                                                            value.toString();
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Price - High to Low'),
                                              Transform.scale(
                                                scale: 1.2,
                                                child: Radio(
                                                    value: "HIGH",
                                                    activeColor: loginTextColor,
                                                    groupValue: RadioValue,
                                                    hoverColor: loginTextColor,
                                                    fillColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            loginTextColor),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        RadioValue =
                                                            value.toString();
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (list.isEmpty) {
                                                  getSortList();
                                                } else {
                                                  getSearchSortList();
                                                }
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      loginTextColor),
                                              child: const Text(
                                                'Apply',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 16.sp,
                      child: SvgPicture.asset("assets/svg/updown_arrow.svg"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => ProductFilter(
                            myCollectionId: widget.myCollectionId,
                            brandList: FilterModel.earBrand,
                            materialList: [],
                            productTypeList: FilterModel.earProduct,
                            shapeList: [],
                            styleList: [],
                            colorList: [],
                            navigationTrailRequset: true,
                            gender: [],
                            endPrice: "709990",
                          ));
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 16.sp,
                        child: SvgPicture.asset("assets/svg/filter1.svg")),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: loading == false,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.5.w),
                    child: Text(
                        "Showing out ${myProductList.length} of $count products",
                        style: zzBoldBlackTextStyle13),
                  )),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: controller1.text.isEmpty
                  ? listWidget()
                  : controller1.text.length > 2
                      ? searchListWidget()
                      : noList(),
            ),
          ],
        ),
      ),
    );
  }

  void getSortList() {
    setState(() {
      if (RadioValue == 'HIGH') {
        // getProductList();
        debugPrint("HIGH TO LOW");
        myProductList.sort((a, b) {
          double priceA = double.tryParse(a.variantsList![0]['price']) ?? 0;
          double priceB = double.tryParse(b.variantsList![0]['price']) ?? 0;
          return priceB.compareTo(priceA);
        });
        _controller.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else if (RadioValue == 'LOW') {
        // getProductList();

        debugPrint("LOW TO HIGH");
        myProductList.sort((a, b) {
          double f = double.tryParse(a.variantsList![0]['price']) ?? 0;
          double s = double.tryParse(b.variantsList![0]['price']) ?? 0;
          return f.compareTo(s);
        });
        _controller.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else if (RadioValue == 'MOST') {
        getProductList();

        for (var item in myProductList) {
          item.createdAt = DateTime.parse(item.createdAt!).toIso8601String();
        }
        myProductList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      } else if (RadioValue == 'BEST') {
        getProductList();

        loading = true;
        getBestSellingList();
      } else if (RadioValue == 'NEW') {
        getProductList();

        getNewArrivalsList();
      }
    });
  }

  void getNewArrivalsList() {
    DateTime currentDate = DateTime.now();
    DateTime thresholdDate = currentDate.subtract(const Duration(days: 7));
    List<ProductModel> newProductList = myProductList.where((product) {
      DateTime productCreatedAt = DateTime.parse(product.createdAt!);
      return productCreatedAt.isAfter(thresholdDate);
    }).toList();

    setState(() {
      myProductList = newProductList;
    });
  }

  void getSearchSortList() {
    setState(() {
      if (RadioValue == 'HIGH') {
        debugPrint("HIGH TO LOW");
        list.sort((a, b) {
          double f = double.parse(a.variantsList![0]['price']);
          double s = double.parse(b.variantsList![0]['price']);
          return s.compareTo(f);
        });
      } else if (RadioValue == 'LOW') {
        debugPrint("LOW TO HIGH");
        list.sort((a, b) {
          double f = double.parse(a.variantsList![0]['price']);
          double s = double.parse(b.variantsList![0]['price']);
          return f.compareTo(s);
        });
      } else if (RadioValue == 'MOST') {
        for (var item in list) {
          item.createdAt = DateTime.parse(item.createdAt!).toIso8601String();
        }
        list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      } else if (RadioValue == 'BEST') {
        loading = true;
        return getBestSellingList();
      } else if (RadioValue == 'NEW') {
        return showSuccessSnackBar(context, 'Coming soon..!');
      }
    });
  }

  Widget listWidget() {
    if (myProductList.isEmpty) {
      if (loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Center(child: Image.asset("assets/images/no_records_found.png"));
      }
    } else {
      return GridView.builder(
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          controller: _controller,
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            childAspectRatio: 2 / 3.5,
          ),
          shrinkWrap: true,
          itemCount: myProductList.length,
          itemBuilder: (BuildContext context, int index) {
            final item = myProductList[index];
            int k = 0;
            var model = myProductList[index];
            String aImage = model.image!.isNotEmpty ? model.image!['src'] : "";
            return InkWell(
              onTap: () {
                if (mounted) {
                  setState(() {
                    productId = model.id!;
                    tap = model.id!;
                    Get.to(() =>
                        EarDetailScreen(id: model.id, fromWhere: 'TRIAL'));
                  });
                }
              },
              child: Container(
                margin: const EdgeInsets.all(4.0),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: loginTextColor,
                          child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                              child: tap == model.id!
                                  ? const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: loginTextColor,
                                    )
                                  : const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.white,
                                    )),
                        ),
                      ),
                    ),
                    aImage.isEmpty
                        ? Center(
                            child: Image.asset(
                              "assets/images/eye_glass.png",
                              height: 120.0,
                              width: 120.0,
                            ),
                          )
                        : Center(
                            child: Image.network(
                              aImage,
                              height: 120.0,
                              width: 120.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                    Container(
                      width: 28.0.w,
                      height: 4.0.h,
                      margin: const EdgeInsets.only(left: 12.0),
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
                                SizedBox(
                                  width: 2.0.w,
                                ),
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
                    SizedBox(height: 0.5.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "${model.title}",
                        style: zzRegularBlackTextStyle11,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    model.variantsList![k]['price'] != "1.00"
                        ? Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  "₹${model.variantsList![k]['price']}",
                                  overflow: TextOverflow.visible,
                                  style: zzRegularBlackTextStyle10,
                                ),
                                SizedBox(
                                  width: 1.0.w,
                                ),
                                Visibility(
                                  visible: model.variantsList![0]
                                              ['compare_at_price']
                                          .toString() !=
                                      "null",
                                  child: Text(
                                    '₹${model.variantsList![0]['compare_at_price']}',
                                    style: zzRegularBlackTextStyle10_,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: 0.5.h),
                    SizedBox(height: 0.5.h),
                  ],
                ),
              ),
            );
          });
    }
  }

  Widget searchListWidget() {
    if (list.isEmpty) {
      return Center(child: Image.asset("assets/images/no_records_found.png"));
    } else {
      return  GridView.builder(
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          controller: _controller,
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            childAspectRatio: 2 / 3.5,
          ),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            final item = list[index];
            int k = 0;
            var model = list[index];
            String aImage = model.image!.isNotEmpty ? model.image!['src'] : "";
            return InkWell(
              onTap: () {
                if (mounted) {
                  setState(() {
                    productId = model.id!;
                    tap = model.id!;
                    Get.to(() =>
                        EarDetailScreen(id: model.id, fromWhere: 'TRIAL'));
                  });
                }
              },
              child: Container(
                margin: const EdgeInsets.all(4.0),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: loginTextColor,
                          child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                              child: tap == model.id!
                                  ? const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: loginTextColor,
                                    )
                                  : const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.white,
                                    )),
                        ),
                      ),
                    ),
                    aImage.isEmpty
                        ? Center(
                            child: Image.asset(
                              "assets/images/eye_glass.png",
                              height: 120.0,
                              width: 120.0,
                            ),
                          )
                        : Center(
                            child: Image.network(
                              aImage,
                              height: 120.0,
                              width: 120.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                    Container(
                      width: 28.0.w,
                      height: 4.0.h,
                      margin: const EdgeInsets.only(left: 12.0),
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
                                SizedBox(
                                  width: 2.0.w,
                                ),
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
                    SizedBox(height: 0.5.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "${model.title}",
                        style: zzRegularBlackTextStyle11,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    model.variantsList![k]['price'] != "1.00"
                        ? Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  "₹${model.variantsList![k]['price']}",
                                  overflow: TextOverflow.visible,
                                  style: zzRegularBlackTextStyle10,
                                ),
                                SizedBox(
                                  width: 1.0.w,
                                ),
                                Visibility(
                                  visible: model.variantsList![0]
                                              ['compare_at_price']
                                          .toString() !=
                                      "null",
                                  child: Text(
                                    '₹${model.variantsList![0]['compare_at_price']}',
                                    style: zzRegularBlackTextStyle10_,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: 0.5.h),
                    SizedBox(height: 0.5.h),
                  ],
                ),
              ),
            );
          });
   
      
      // GridView.builder(
      //     addAutomaticKeepAlives: false,
      //     addRepaintBoundaries: false,
      //     physics: const ScrollPhysics(),
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //         crossAxisSpacing: 2.0,
      //         mainAxisSpacing: 2.0,
      //         childAspectRatio: MediaQuery.of(context).size.width /
      //             (MediaQuery.of(context).size.height * 1.02)),
      //     shrinkWrap: true,
      //     itemCount: list.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       var model = list[index];
      //       int j = 0;
      //       String aImage = model.image!.isNotEmpty ? model.image!['src'] : "";
      //       return InkWell(
      //         onTap: () {
      //           if (mounted) {
      //             setState(() {
      //               tap = model.id!;
      //               Get.to(() =>
      //                   EarDetailScreen(id: model.id!, fromWhere: 'TRIAL'));
      //             });
      //           }
      //         },
      //         child: Container(
      //           width: 46.0.w,
      //           margin: const EdgeInsets.only(
      //               top: 8.0, right: 2.0, left: 4.0, bottom: 4.0),
      //           decoration: BoxDecoration(
      //             color: white,
      //             borderRadius: BorderRadius.circular(10.0),
      //             boxShadow: const [
      //               BoxShadow(
      //                 color: Color(0xffDDDDDD),
      //                 blurRadius: 6.0,
      //                 spreadRadius: 2.0,
      //                 offset: Offset(0.0, 0.0),
      //               ),
      //             ],
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Container(
      //                 margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      //                 padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      //                 child: Align(
      //                   alignment: Alignment.centerRight,
      //                   child: InkWell(
      //                     onTap: () {
      //                       if (mounted) {
      //                         setState(() {
      //                           productId = model.id!;
      //                           tap = model.id!;
      //                         });
      //                       }
      //                     },
      //                     child: CircleAvatar(
      //                       radius: 12,
      //                       backgroundColor: loginTextColor,
      //                       child: CircleAvatar(
      //                           radius: 10,
      //                           backgroundColor: Colors.white,
      //                           child: tap == model.id!
      //                               ? const CircleAvatar(
      //                                   radius: 8,
      //                                   backgroundColor: loginTextColor,
      //                                 )
      //                               : const CircleAvatar(
      //                                   radius: 8,
      //                                   backgroundColor: Colors.white,
      //                                 )),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               aImage.isEmpty
      //                   ? Image.asset("assets/images/eye_glass.png",
      //                       width: 100, height: 100)
      //                   : Image.network(
      //                       aImage,
      //                       height: 100.0,
      //                       width: 100.0,
      //                       fit: BoxFit.contain,
      //                     ),
      //               SizedBox(
      //                 height: 2.0.h,
      //               ),
      //               Container(
      //                 width: 28.0.w,
      //                 height: 4.0.h,
      //                 padding: const EdgeInsets.all(2.0),
      //                 margin: const EdgeInsets.only(left: 12.0),
      //                 decoration: BoxDecoration(
      //                   color: loginBlue,
      //                   borderRadius: BorderRadius.circular(20.0),
      //                 ),
      //                 child: IntrinsicHeight(
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     children: [
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           SizedBox(
      //                             width: 2.0.w,
      //                           ),
      //                           const Icon(
      //                             Icons.star,
      //                             color: ratingColor,
      //                             size: 15,
      //                           ),
      //                           SizedBox(
      //                             width: 1.0.w,
      //                           ),
      //                           Text(
      //                             "4.5",
      //                             style: zzBoldBlackTextStyle11,
      //                           ),
      //                         ],
      //                       ),
      //                       SizedBox(
      //                         width: 1.0.w,
      //                       ),
      //                       const VerticalDivider(
      //                         color: white,
      //                         thickness: 1,
      //                       ),
      //                       SizedBox(
      //                         width: 1.0.w,
      //                       ),
      //                       Text(
      //                         "12",
      //                         style: zzRegularBlackTextStyle10,
      //                       ),
      //                       SizedBox(
      //                         width: 1.5.w,
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 2.0.h,
      //               ),
      //               Container(
      //                   height: 7.0.h,
      //                   padding: const EdgeInsets.only(left: 15.0),
      //                   child: Text("${model.title}",
      //                       style: zzRegularBlackTextStyle11,
      //                       overflow: TextOverflow.visible)),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 25.0),
      //                 child: Row(
      //                   children: [
      //                     Text(
      //                       "₹${model.variantsList![j]['price']}",
      //                       style: zzRegularBlackTextStyle10,
      //                     ),
      //                     SizedBox(
      //                       width: 1.0.w,
      //                     ),
      //                     Visibility(
      //                       visible: model.variantsList![j]['compare_at_price']
      //                               .toString() !=
      //                           "null",
      //                       child: Text(
      //                         '₹${model.variantsList![j]['compare_at_price']}',
      //                         style: zzRegularBlackTextStyle10_,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: ScreenSize.getScreenWidth(context),
      //                 height: ScreenSize.getScreenHeight(context) * 0.10,
      //                 child: ListView.builder(
      //                     addAutomaticKeepAlives: false,
      //                     addRepaintBoundaries: false,
      //                     padding: const EdgeInsets.only(left: 25.0),
      //                     scrollDirection: Axis.horizontal,
      //                     itemCount: model.variantColorList.length,
      //                     itemBuilder: (BuildContext context, int index1) {
      //                       String aColor =
      //                           model.variantColorList[index1]['color'];
      //                       return Row(
      //                         children: [
      //                           InkWell(
      //                             onTap: () {
      //                               if (mounted) {
      //                                 setState(() {
      //                                   j = index1;
      //                                   for (int i = 0;
      //                                       i < model.variantColorList.length;
      //                                       i++) {
      //                                     if (i == index1) {
      //                                       model.variantColorList[i]['index'] =
      //                                           i;
      //                                     } else {
      //                                       model.variantColorList[i]['index'] =
      //                                           -1;
      //                                     }
      //                                   }
      //                                   mySelectedColorIndex = model
      //                                       .variantColorList[index1]['index'];
      //                                   debugPrint(
      //                                       'MY SELECTED INDEX: $mySelectedColorIndex');
      //                                   debugPrint(
      //                                       "SHOW PRODUCT LIST COLOR SELECTED BOTTOM: $aColor INDEX: ${model.variantColorList[index1]['index']}");
      //                                   debugPrint(
      //                                       "TRIAL LIST INVENTORY QTY: ${model.variantsList![mySelectedColorIndex]['inventory_quantity']}");
      //                                 });
      //                               }
      //                             },
      //                             child: Visibility(
      //                               visible: model.variantsList![index1]
      //                                       ['title'] !=
      //                                   'Default Title',
      //                               child: CircleAvatar(
      //                                 backgroundColor:
      //                                     model.variantColorList[index1]
      //                                                 ['index'] ==
      //                                             index1
      //                                         ? loginTextColor
      //                                         : Colors.white,
      //                                 radius: 18.0,
      //                                 child: CircleAvatar(
      //                                   backgroundColor: Colors.white,
      //                                   radius: 16.0,
      //                                   child: Container(
      //                                     width: 27,
      //                                     height: 27,
      //                                     decoration: BoxDecoration(
      //                                       shape: BoxShape.circle,
      //                                       color: aColor == "Default Title"
      //                                           ? Colors.black
      //                                           : getColorFromStringValue(
      //                                               aColor.toLowerCase(),
      //                                             ),
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       );
      //                     }),
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     });
    
    }
  }

  Widget noList() {
    return Container();
  }
}
