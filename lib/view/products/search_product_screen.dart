import 'package:get/get.dart';
import 'package:infinite/utils/packeages.dart';
import 'package:infinite/view/home/oral_care/oralcare_detail.dart';
import 'package:infinite/view/home/skin_care/skincare_detail.dart';
import 'package:infinite/view/home/sleep_care/sleep_details.dart';

class SearchProductScreen extends StatefulWidget {
  final int collectionId;
  const SearchProductScreen({Key? key, required this.collectionId})
      : super(key: key);

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  int calculateDiscountPercentage(
      String? actualPriceStr, String? comparePriceStr,
      {int decimalPlaces = 2}) {
    final actualPrice = double.parse(actualPriceStr ?? '0');
    final comparePrice = double.parse(comparePriceStr ?? '0');

    final discountAmount = actualPrice - comparePrice;

    final discountPercentage = (discountAmount / actualPrice) * 100;

    final roundedDiscountPercentage =
        double.parse(discountPercentage.toStringAsFixed(decimalPlaces));

    if (roundedDiscountPercentage - roundedDiscountPercentage.floorToDouble() >=
        0.6) {
      return roundedDiscountPercentage.ceil().toInt();
    } else {
      return roundedDiscountPercentage.toInt();
    }
  }

  final searchCtrl = Get.isRegistered<SearchControllers>()
      ? Get.find<SearchControllers>()
      : Get.put(SearchControllers());

  @override
  void initState() {
    searchCtrl.collectionID = widget.collectionId;
    searchCtrl.getProductList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllers>(
        init: SearchControllers(),
        builder: (searchCtrl) {
          return DefaultAppBarWidget(
              title: "Search",
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 7.h,
                        child: TextFormField(
                            controller: searchCtrl.controller2,
                            autofocus: true,
                            //autocorrect: false,
                            onChanged: (value) {
                              searchCtrl.filterSearchResults(value);
                              searchCtrl.update();
                            },
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search product',
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                prefixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        searchCtrl.controller2.clear();
                                        searchCtrl.update();
                                      });
                                    },
                                    child: const Icon(Icons.search)))),
                      ),
                      Visibility(
                        visible: searchCtrl.controller2.text.isNotEmpty
                            ? true
                            : false,
                        //visible: list.length == 0 ? true : false,

                        child: GridView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2.0,
                                    mainAxisSpacing: 2.0,
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height *
                                            1.03)),
                            shrinkWrap: true,
                            itemCount: searchCtrl.list.length,
                            itemBuilder: (BuildContext context, int index) {
                              var model = searchCtrl.list[index];
                              String aImage = model.image!.isNotEmpty
                                  ? model.image!['src']
                                  : "";
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    String aProductType = model.productType!;
                                    if (aProductType == "Audiology") {
                                      Get.to(
                                          () => EarDetailScreen(id: model.id));
                                    } else if (aProductType == "Frame") {
                                      Get.to(() => EyeDetailsScreen(
                                          id: model.id!, toCart: "",productHandle: "",));
                                    } else if (aProductType == "Oral Care") {
                                      Get.to(() =>
                                          OralDetailScreen(id: model.id!));
                                    } else if (aProductType == "Skin Care" ||
                                        aProductType ==
                                            "Laser Hair Reduction" ||
                                        aProductType == "Hydra Facial" ||
                                        aProductType ==
                                            "RF Skin Rejuvenation") {
                                      Get.to(() =>
                                          SkinDetailScreen(id: model.id!));
                                    } else {
                                      print(aProductType);
                                      Get.to(() =>
                                          SleepDetailScreen(id: model.id!));
                                    }
                                  });
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: model.variantsList![0][
                                                        'inventory_quantity'] <=
                                                    0
                                                ? true
                                                : false,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                color: Colors.black,
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 10, 10, 0),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 5, 0),
                                                child: Text(' Sold Out ',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        zzBoldBlueDarkTextStyle10A1),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     setState(() {
                                          //       if (model.wishlistIconColor ==
                                          //           Colors.red) {
                                          //         model.wishlistIconColor =
                                          //             Colors.black;
                                          //         removeFromWishlist(index);
                                          //       } else {
                                          //         model.wishlistIconColor =
                                          //             Colors.red;
                                          //         addToWishlist(index);
                                          //       }
                                          //     });
                                          //   },
                                          //   child: Align(
                                          //     alignment: Alignment.topRight,
                                          //     child: Container(
                                          //       margin:
                                          //           const EdgeInsets.fromLTRB(
                                          //               20, 10, 0, 0),
                                          //       padding:
                                          //           const EdgeInsets.fromLTRB(
                                          //               5, 0, 5, 0),
                                          //       child: Icon(
                                          //         Icons.favorite_border,
                                          //         color:
                                          //             model.wishlistIconColor,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      Center(
                                        child: CachedNetworkImage(
                                          imageUrl: aImage,
                                          height: 120.0,
                                          width: 120.0,
                                          fit: BoxFit.contain,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                          errorWidget: (context, url, error) =>
                                              Center(
                                                  child: Image.asset(
                                            "assets/images/no_image.gif",
                                            height: 350,
                                          )),
                                        ),
                                      ),
                                      Container(
                                        width: 28.0.w,
                                        height: 4.0.h,
                                        padding: const EdgeInsets.all(2.0),
                                        margin:
                                            const EdgeInsets.only(left: 12.0),
                                        decoration: BoxDecoration(
                                          color: loginBlue,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                // style: zzBoldBlackTextStyle11,
                                                style: fontMethod(context),
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
                                                //style: zzRegularBlackTextStyle10,
                                                style: fontMethod(context),
                                              ),
                                              SizedBox(
                                                width: 1.5.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${model.title}",
                                          style: fontMethod(context),
                                          overflow: TextOverflow.ellipsis,
                                          // softWrap:false,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                      model.productType == "Laser Hair Reduction" ||
                                              model.productType ==
                                                  "Hydra Facial" ||
                                              model.productType ==
                                                  "RF Skin Rejuvenation"
                                          ? Container(
                                              color: Colors.red,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                "Sale ${calculateDiscountPercentage(model.variantsList![0]['compare_at_price'].toString(), model.variantsList![0]['price'].toString())}%",
                                                textAlign: TextAlign.center,
                                                style:
                                                    zzBoldBlueDarkTextStyle10A1,
                                              ),
                                            )
                                          : const SizedBox(),
                                      model.productType == "Nasal"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  model.variantsList![0]
                                                              ['title'] ==
                                                          'Rent'
                                                      ? Text(
                                                          "Rent: ₹${model.variantsList![0]['price']}/M",
                                                          style: fontMethod(
                                                              context),
                                                        )
                                                      : Text(
                                                          "₹${model.variantsList![0]['price']}",
                                                          style: fontMethod(
                                                              context),
                                                        ),
                                                  if (model.variantsList!
                                                          .length >
                                                      1)
                                                    const SizedBox(width: 10),
                                                  if (model.variantsList!.any(
                                                      (variant) =>
                                                          variant['title'] ==
                                                          'Sale'))
                                                    Text(
                                                      "Sale: ₹${model.variantsList!.firstWhere((variant) => variant['title'] == 'Sale')['price']}",
                                                      style:
                                                          fontMethod(context),
                                                    ),
                                                ],
                                              ))
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "₹${model.variantsList![0]['price']}",
                                                    //  style: zzRegularBlackTextStyle10,
                                                    style: fontMethod(context),
                                                  ),
                                                  SizedBox(
                                                    width: 1.0.w,
                                                  ),
                                                  Visibility(
                                                    visible: model
                                                            .variantsList![0][
                                                                'compare_at_price']
                                                            .toString() !=
                                                        "null",
                                                    child: Text(
                                                      '₹${model.variantsList![0]['compare_at_price']}',
                                                      // style: zzRegularBlackTextStyle10_,
                                                      style:
                                                          fontMethod2(context),
                                                    ),
                                                  ),
                                                ],
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
                    ],
                  ),
                ),
              ));
        });
  }
}
