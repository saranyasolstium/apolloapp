import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/services/remote_service.dart';
import 'package:infinite/utils/packeages.dart';
import 'package:infinite/view/home/oral_care/oralcare_detail.dart';
import 'package:infinite/view/home/skin_care/skincare_detail.dart';
import 'package:infinite/view/home/sleep_care/sleep_details.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  late List<ProductModel> myProductList;
  String isColor = '';
  final ScrollController _controller = ScrollController();
  List<String> productIds = [];
  int? customerId;

  @override
  void initState() {
    myProductList = [];
    loading = true;
    customerId = sharedPreferences!.getInt("id");
    fetchWishlists();
    super.initState();
  }

  Future<void> removeFromWishlist(int productId) async {
    try {
      final response = await RemoteServices().updateWishlist(
        customerId: customerId!,
        productId: productId,
      );

      if (response.statusCode == 200) {
        print("Wishlist Removed Successfully");
        fetchWishlists();
      } else {
        print("Failed to remove wishlist!");
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  Future<void> fetchWishlists() async {
    try {
      List<String> idS = await RemoteServices().fetchWishlists(customerId);
      setState(() {
        productIds = idS;
        if (productIds.isNotEmpty) {
          getDetails(productIds);
        }else{
          loading=false;
          myProductList=[];
        }
      });
      print(productIds);
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  void getDetails(List<String> productIds) async {
    try {
      setState(() {
        loading = true;
      });
      myProductList = [];
      String baseUrl =
          'https://apollohospitals.myshopify.com/admin/api/2024-04/products.json';
      String idsQueryParam = productIds.join(',');
      String url = '$baseUrl?ids=$idsQueryParam';
      print(url);

      final response = await DioClient(myUrl: url).getProductList();
      if (response.isNotEmpty) {
        setState(() {
          for (ProductModel model in response) {
            myProductList.add(model);
            for (var values in model.variantColorList) {
              isColor = values['color'];
            }
          }
        });
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        loading = false;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Wishlist",
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.center,
              child: Text("${myProductList.length} product added",
                  style: zzBoldBlackTextStyle13)),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(5),
            child: buildPostsView(),
          )),
        ],
      ),
    );
  }

  Future<Future<ProductModel>> refresh(bool reload) async {
    Completer<ProductModel> completer = Completer<ProductModel>();
    Timer(const Duration(seconds: 1), () {
      if (completer != null) {
        completer.complete();
      }
    });
    return completer.future;
  }

  Widget buildPostsView() {
    if (myProductList.isEmpty) {
      if (loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Center(child: Image.asset("assets/images/no_records_found.png"));
      }
    } else {
      return RefreshIndicator(
          onRefresh: () async => setState(() async => await refresh(true)),
          color: loginTextColor,
          strokeWidth: 3,
          edgeOffset: 10.0,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          child: GridView.builder(
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 2.2 / 3.6,
              ),
              controller: _controller,
              itemCount: myProductList.length,
              itemBuilder: (BuildContext context, int index) {
                var model = myProductList[index];
                String aImage =
                    model.image!.isNotEmpty ? model.image!['src'] : "";
                return InkWell(
                  onTap: () {
                    setState(() {
                      String aProductType = model.productType!;
                      if (aProductType == "Audiology") {
                        Get.to(() => EarDetailScreen(id: model.id));
                      } else if (aProductType == "Frame") {
                        Get.to(() => EyeDetailsScreen(
                              id: model.id!,
                              productHandle: "",
                            ));
                      } else if (aProductType == "Oral Care") {
                        Get.to(() => OralDetailScreen(id: model.id!));
                      } else if (aProductType == "Skin Care" ||
                          aProductType == "Laser Hair Reduction" ||
                          aProductType == "Hydra Facial" ||
                          aProductType == "RF Skin Rejuvenation") {
                        Get.to(() => SkinDetailScreen(id: model.id!));
                      } else {
                        print(aProductType);
                        Get.to(() => SleepDetailScreen(id: model.id!));
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Visibility(
                              visible: model.variantsList![0]
                                          ['inventory_quantity'] <=
                                      0
                                  ? true
                                  : false,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  color: Colors.black,
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(' Sold Out ',
                                      textAlign: TextAlign.center,
                                      style: zzBoldBlueDarkTextStyle10A1),
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  removeFromWishlist(model.id!);
                                });
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: const Icon(Icons.delete,
                                      color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: aImage,
                            height: 120.0,
                            width: 120.0,
                            fit: BoxFit.contain,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress)),
                            errorWidget: (context, url, error) => Center(
                                child: Image.asset(
                              "assets/images/no_image.gif",
                              height: 350,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "${model.title}",
                            style: fontMethod(context),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        model.productType == "Laser Hair Reduction" ||
                                model.productType == "Hydra Facial" ||
                                model.productType == "RF Skin Rejuvenation"
                            ? Container(
                                color: Colors.red,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Sale ${calculateDiscountPercentage(model.variantsList![0]['compare_at_price'].toString(), model.variantsList![0]['price'].toString())}%",
                                  textAlign: TextAlign.center,
                                  style: zzBoldBlueDarkTextStyle10A1,
                                ),
                              )
                            : const SizedBox(),
                        model.productType == "Nasal"
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    model.variantsList![0]['title'] == 'Rent'
                                        ? Text(
                                            "Rent: ₹${model.variantsList![0]['price']}/M",
                                            style: fontMethod(context),
                                          )
                                        : Text(
                                            "₹${model.variantsList![0]['price']}",
                                            style: fontMethod(context),
                                          ),
                                    if (model.variantsList!.length > 1)
                                      const SizedBox(width: 10),
                                    if (model.variantsList!.any((variant) =>
                                        variant['title'] == 'Sale'))
                                      Text(
                                        "Sale: ₹${model.variantsList!.firstWhere((variant) => variant['title'] == 'Sale')['price']}",
                                        style: fontMethod(context),
                                      ),
                                  ],
                                ))
                            : Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "₹${model.variantsList![0]['price']}",
                                      style: fontMethod(context),
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
                                        style: fontMethod2(context),
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
              }));
    }
  }
}
