import 'package:infinite/view/clinic/select_product_screen.dart';
import 'package:infinite/view/home/oral_care/oralcare_detail.dart';
import 'package:infinite/view/home/skin_care/skincare_detail.dart';
import 'package:infinite/view/home/sleep_care/sleep_details.dart';

import '../utils/packeages.dart';

class ShowOfferWidget extends StatefulWidget {
  final String? title;
  final String? categoryType;
  final String? sortingCriteria;
  final bool? detail;

  const ShowOfferWidget(
      this.title, this.categoryType, this.sortingCriteria, this.detail,
      {Key? key})
      : super(key: key);

  @override
  State<ShowOfferWidget> createState() => _ShowOfferWidgetState();
}

class _ShowOfferWidgetState extends State<ShowOfferWidget> {
  PageController _pageController = PageController();
  var currentPage = 1.0;
  List<ProductModel> myProductList = [];
  List<ProductModel> myList = [];
  final DateTime _currentDate = DateTime.now();
  late DateTime previousDate;

  int j = 0, k = 0;
  @override
  void initState() {
    _pageController = PageController(
        initialPage: currentPage.toInt(), viewportFraction: 0.85);
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
    loading = true;
    getProductList(widget.sortingCriteria!);

    super.initState();
  }

  void getProductList(String sortingCriteria) {
    try {
      String aUrl = "";
      if (widget.categoryType == "eye") {
        aUrl =
            "${EndPoints.allProductsList}?limit=6&collection_id=411246690548&sort_by=$sortingCriteria";
      } else if (widget.categoryType == "ear") {
        aUrl =
            "${EndPoints.allProductsList}?limit=6&collection_id=411858239732&sort_by=$sortingCriteria";
      } else if (widget.categoryType == "oral") {
        aUrl =
            "${EndPoints.allProductsList}?limit=10&collection_id=412432498932&sort_by=$sortingCriteria";
        print(aUrl);
      } else if (widget.categoryType == "skin") {
        aUrl =
            "${EndPoints.allProductsList}?limit=10&collection_id=411832320244&sort_by=$sortingCriteria";
        print(aUrl);
      } else if (widget.categoryType == "sleep") {
        aUrl =
            "${EndPoints.allProductsList}?limit=10&collection_id=411739422964&sort_by=$sortingCriteria";
        print(aUrl);
      } else if (widget.categoryType == "mask") {
        aUrl =
            "${EndPoints.allProductsList}?limit=10&collection_id=411740635380&sort_by=$sortingCriteria";
        print(aUrl);
      } else if (widget.categoryType == "device") {
        aUrl =
            "${EndPoints.allProductsList}?limit=10&collection_id=411739554036&sort_by=$sortingCriteria";
        print(aUrl);
      }
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

  // void getProductList() {
  //   try {
  //     String aUrl = "";
  //     if (widget.categoryType == "eye") {
  //       aUrl =
  //           "${EndPoints.allProductsList}?limit=6&collection_id=411246690548";
  //     } else if (widget.categoryType == "ear") {
  //       aUrl =
  //           "${EndPoints.allProductsList}?limit=6&collection_id=411858239732";
  //     } else if (widget.categoryType == "oral") {
  //       aUrl =
  //           "${EndPoints.allProductsList}?limit=10&collection_id=412432498932";
  //     }
  //     DioClient(myUrl: aUrl).getProductList().then((value) {
  //       if (mounted) {
  //         setState(() {
  //           if (value.isNotEmpty) {
  //             myProductList = [];
  //             myProductList = value;
  //             debugPrint("SHOW LIST: $value");
  //             getFilterByDate();
  //           } else {
  //             myProductList = [];
  //           }
  //           loading = false;
  //         });
  //       }
  //     });
  //   } catch (e) {
  //     debugPrint("$e");
  //   }
  // }

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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
          width: ScreenSize.getScreenWidth(context),
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
                widget.title.toString(),
                style: zzBoldBlackTextStyle14,
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  AspectRatio(
                    aspectRatio: 0.90,
                    child: clampingList(),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                    left: 0,
                    right: 0,
                    height: 20.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                          myList.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: currentPage == index
                                      ? loginTextColor
                                      : white,
                                ),
                              )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget clampingList() {
    if (myList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return PageView.builder(
          itemCount: myList.length,
          physics: const ClampingScrollPhysics(),
          controller: _pageController,
          itemBuilder: (context, index) {
            var model = myList[index];
            String aImage = model.image!.isNotEmpty ? model.image!['src'] : "";
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: InkWell(
                    onTap: () {
                      String aProductType = model.productType!;
                      print(aProductType);
                      if (aProductType == "Audiology") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EarDetailScreen(id: model.id),
                            ));
                      } else if (aProductType == "Frame") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EyeDetailsScreen(
                                      id: model.id!,
                                      productHandle: "",
                                    )));
                      } else if (aProductType == "Oral Care") {
                        widget.detail == true
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OralDetailScreen(
                                          id: model.id!,
                                        )))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OralDetailScreen(
                                          id: model.id!,
                                        )));
                      } else if (aProductType == "Skin Care") {
                        print(aProductType);
                        widget.detail == true
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SkinDetailScreen(
                                          id: model.id!,
                                        )))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SkinDetailScreen(
                                          id: model.id!,
                                        )));
                      } else if (aProductType == "Nasal") {
                        print(aProductType);
                        widget.detail == true
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SleepDetailScreen(
                                          id: model.id!,
                                        )))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SleepDetailScreen(
                                          id: model.id!,
                                        )));
                      }
                    },
                    child: Container(
                      width: ScreenSize.getScreenWidth(context) * 0.90,
                      height: 320,
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
                          model.variantsList![j]['inventory_quantity'] == 0
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    color: Colors.black,
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Text(' Sold Out ',
                                        textAlign: TextAlign.center,
                                        style: zzBoldBlueDarkTextStyle10A1),
                                  ),
                                )
                              : const SizedBox(
                                  height: 20,
                                ),
                          aImage.isEmpty
                              ? Image.network(
                                  "https://my6senses.com/cdn/shopifycloud/shopify/assets/no-image-2048-5e88c1b20e087fb7bbe9a3771824e743c244f437e4f8ba93bbf7b11b53f7824c_600x.gif",
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  aImage,
                                  height: model.productType == "Oral Care"
                                      ? 120
                                      : 100,
                                  width: 100.0,
                                  fit: BoxFit.contain,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 28.0.w,
                                // height: 4.0.h,
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.only(left: 22.0),
                                decoration: BoxDecoration(
                                  color: loginBlue,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            style: zzBoldBlueDarkTextStyle10,
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
                                      style: zzBoldGrayDarkStrikeTextStyle10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }
}
