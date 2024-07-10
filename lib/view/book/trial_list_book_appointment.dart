import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../model/product_model.dart';
import '../../res/colors.dart';
import '../../res/styles.dart';
import '../../services/network/dio_client.dart';
import '../../services/network/endpoints.dart';
import '../../utils/global.dart';
import '../../widgets/default_navigation_widget.dart';
import '../home/ear_detail_screen.dart';

class TrialListBookAppointment extends StatefulWidget {
  final String? type;
  final int? myCollectionId;
  const TrialListBookAppointment(this.myCollectionId, {Key? key, this.type})
      : super(key: key);

  @override
  State<TrialListBookAppointment> createState() =>
      _TrialListBookAppointmentState();
}

class _TrialListBookAppointmentState extends State<TrialListBookAppointment> {
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
  int index2 = -1;
  late int variantId;
  late int inventory_quantity;
  late String colorTitle;
  late String price;
  int productId = -1;
  String productName = '';
  late String selectedColor;
  int selectedIndexColor = 0;
  int radio = 0;
  int variantId3 = 0;
  String color3 = '';
  String price3 = '';
  String src3 = '';
  int mySelectAppointmentType = 1;
  int myVariantId = 0;
  int k = 0;
  @override
  void initState() {
    loading = true;
    getProductList();
    super.initState();
  }

  void getProductList() {
    try {
      DioClient(myUrl: "${EndPoints.allProductsList}?product_type=Audiology")
          .getProductList()
          .then((value) {
        debugPrint("TRIAL REQUEST VALUE: $value");
        if (mounted) {
          setState(() {
            if (value.isNotEmpty) {
              myProductList = [];
              for (var m in value) {
                if (!m.tags
                    .toString()
                    .toLowerCase()
                    .contains('enquiry'.toLowerCase())) {
                  myProductList.add(m);
                }
              }
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

  void filterSearchResults(String query) {
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
        title: "Trial Request",
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: myProductList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                        childAspectRatio: 2 / 3.5,
                      ),
                      shrinkWrap: true,
                      itemCount: myProductList.length,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      itemBuilder: (BuildContext context, int index) {
                        final item = myProductList[index];
                        index2 = index;
                        var model = myProductList[index];
                        String aImage =
                            model.image!.isNotEmpty ? model.image!['src'] : "";
                        return InkWell(
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                productId = model.id!;
                                productName = model.title!;
                                tap = model.id!;
                              });
                            }
                            int aSelectedIndex = 0;
                            for (int i = 0;
                                i < model.variantColorList.length;
                                i++) {
                              if (model.variantColorList[i]['index'] != -1) {
                                aSelectedIndex =
                                    model.variantColorList[i]['index'];
                              }
                            }
                            Get.to(() => EarDetailScreen(
                                id: model.id!, fromWhere: 'BOOK'));
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
                                                  backgroundColor:
                                                      loginTextColor,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "₹${model.variantsList![k]['price']}",
                                        style: zzRegularBlackTextStyle10,
                                      ),
                                      SizedBox(
                                        width: 1.0.w,
                                      ),
                                      Visibility(
                                        visible: model.variantsList![k]
                                                    ['compare_at_price']
                                                .toString() !=
                                            "null",
                                        child: Text(
                                          '₹${model.variantsList![k]['compare_at_price']}',
                                          style: zzRegularBlackTextStyle10_,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                      addAutomaticKeepAlives: false,
                                      addRepaintBoundaries: false,
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: model.variantColorList.length,
                                      itemBuilder:
                                          (BuildContext context, int index1) {
                                        String aColor = model
                                            .variantColorList[index1]['color'];
                                        return Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: InkWell(
                                                onTap: () {
                                                  if (mounted) {
                                                    setState(() {
                                                      k = index1;
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
                                                          selectedIndexColor =
                                                              i;
                                                        } else {
                                                          model.variantColorList[
                                                              i]['index'] = -1;
                                                        }
                                                      }
                                                      selectedColor = aColor;
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
                                                    radius: 14.0,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 12.0,
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
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
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                                SizedBox(height: 0.5.h),
                              ],
                            ),
                          ),
                        );
                      }))
        ]));
  }
}
