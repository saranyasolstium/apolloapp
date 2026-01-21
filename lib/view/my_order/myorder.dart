import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/utils/packeages.dart';
import 'package:infinite/view/my_order/order_details.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';
import 'package:intl/intl.dart';

import '../../model/order_model.dart';
import '../../utils/screen_size.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  late String dropdownvalue = 'All Order';
  bool isLoading1 = false;
  bool isLoading2 = false;
  bool isLoading3 = false;
  List<OrderModel> myOrderList = [];
  List<OrderModel> myOrderList1 = [];
  List<OrderModel> myOrderList2 = [];
  List<OrderModel> myOrderList3 = [];
  String mySelectedFilterOption = "1";
  int mySelect = 0;

  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  int _pageSize = 50;

  @override
  void initState() {
    super.initState();
    getList();
    loading = true;
    isLoading1 = true;
    isLoading2 = true;
    isLoading3 = true;
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_isLoading) {
        fetchNextPage();
      }
    }
  }

  void getFilter() {
    var date = DateTime.now();
    var lastMonth = DateTime(date.year, date.month, date.day - 30);
    var lastWeek = DateTime(date.year, date.month, date.day - 7);
    debugPrint("LAST MONTH:: $lastMonth");
    debugPrint("LAST WEEK::$lastWeek");
    debugPrint("DATE NOW:::$date");
  }

  void getList() {
    try {
      // int? customerId = sharedPreferences!.getInt("id");
      String? email = sharedPreferences!.getString('mail');
      String? customerName = sharedPreferences!.getString("firstName");
      debugPrint("CUSTOMER NAME:: $customerName");
      DioClient(myUrl: '${EndPoints.createOrder}/?email=$email&status=any')
          .getOrderList()
          .then((value) {
        setState(() {
          if (value.isNotEmpty) {
            loading = false;
            myOrderList = [];
            myOrderList = value;
            debugPrint("ORDER LIST  SIZE: ${myOrderList.length}");
          } else {
            myOrderList = [];
            // getFirstList();
          }
          loading = false;
        });
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void fetchNextPage() {
    try {
      setState(() {
        _isLoading = true;
        _pageSize = _pageSize + 50;
      });
      String? email = sharedPreferences!.getString('mail');
      DioClient(
              myUrl:
                  '${EndPoints.createOrder}/?email=$email&limit=$_pageSize&status=any')
          .getOrderList()
          .then((value) {
        setState(() {
          if (value.isNotEmpty) {
            myOrderList.addAll(value);
            debugPrint("ORDER LIST  SIZE: ${myOrderList.length}");
          } else {}
          _isLoading = false;
        });
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint("$e");
    }
  }

  void getLastWeek() {
    try {
      var today = DateTime.now();
      var lastSunday = today.subtract(Duration(days: today.weekday));
      var lastMonday = lastSunday.subtract(Duration(days: 7));

      List<OrderModel> lastWeekOrders = myOrderList.where((order) {
        if (order.processedAt != null) {
          debugPrint("Processed At: ${order.processedAt}");
          try {
            var processedDate =
                DateFormat("dd MMMM yyyy").parse(order.processedAt!);
            return processedDate.isAfter(lastMonday) &&
                processedDate.isBefore(lastSunday);
          } catch (e) {
            debugPrint("Error parsing processedAt: $e");
            return false;
          }
        }
        return false;
      }).toList();

      setState(() {
        isLoading1 = false;
        myOrderList1 = lastWeekOrders;
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

//   void getLastWeek() {
//   try {
//     // Get today's date
//     var today = DateTime.now();

//     // Calculate the start date of last week (previous Monday)
//     var lastMonday = today.subtract(Duration(days: today.weekday - 1 + 7));

//     // Calculate the end date of last week (current Sunday)
//     var lastSunday = lastMonday.add(Duration(days: 6));

//     // Format dates as ISO 8601 strings
//     String formattedLastMonday = DateTime(lastMonday.year, lastMonday.month, lastMonday.day).toIso8601String();
//     String formattedLastSunday = DateTime(lastSunday.year, lastSunday.month, lastSunday.day).toIso8601String();

//     String? email = sharedPreferences!.getString('mail');

//     DioClient(
//       myUrl: "${EndPoints.createOrder}?email=$email&updated_at_min=$formattedLastMonday&updated_at_max=$formattedLastSunday&status=any",
//     ).getOrderList().then((value) {
//       debugPrint("ORDER LIST WEEK RESPONSE: $value");
//       setState(() {
//         isLoading1 = false;
//         myOrderList1 = value.isNotEmpty ? value : [];
//       });
//     });
//   } catch (e) {
//     debugPrint("$e");
//   }
// }

  void getLastMonth() {
    try {
      var now = DateTime.now();
      var lastMonthStart = DateTime(now.year, now.month - 1, 1);
      var lastMonthEnd = DateTime(now.year, now.month, 0);

      // Format the dates to match the Shopify API format
      String formattedLastMonthStart =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(lastMonthStart);
      String formattedLastMonthEnd =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(lastMonthEnd);
      String? email = sharedPreferences!.getString('mail');

      DioClient(
              myUrl:
                  "${EndPoints.createOrder}?email=$email&status=any&updated_at_min=$formattedLastMonthStart&updated_at_max=$formattedLastMonthEnd")
          .getOrderList()
          .then((value) {
        debugPrint("ORDER LIST MONTH RESPONSE: $value");
        setState(() {
          isLoading2 = false;
          if (value.isNotEmpty) {
            myOrderList2 = value;
            debugPrint("ORDER LIST MONTH SIZE: ${myOrderList2.length}");
          } else {
            myOrderList2 = [];
          }
        });
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void getLastYear() {
    try {
      var now = DateTime.now();
      var lastYearStart = DateTime(now.year - 1, 1, 1);
      var lastYearEnd = DateTime(now.year - 1, 12, 31);

      // Format the dates to match the Shopify API format
      String formattedLastYearStart =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(lastYearStart);
      String formattedLastYearEnd =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(lastYearEnd);
      String? email = sharedPreferences!.getString('mail');

      DioClient(
              myUrl:
                  "${EndPoints.createOrder}?email=$email&status=any&updated_at_min=$formattedLastYearStart&updated_at_max=$formattedLastYearEnd")
          .getOrderList()
          .then((value) {
        debugPrint("ORDER LIST YEAR RESPONSE: $value");
        setState(() {
          isLoading3 = false;
          if (value.isNotEmpty) {
            myOrderList3 = value;
            debugPrint("ORDER LIST YEAR SIZE: ${myOrderList3.length}");
          } else {
            myOrderList3 = [];
          }
        });
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "My Orders",
      child: loading
          ? Center(
              child: Lottie.asset(
                animationLoading,
                repeat: true,
                reverse: true,
                animate: true,
                width: ScreenSize.getScreenWidth(context) * 0.40,
                height: ScreenSize.getScreenHeight(context) * 0.40,
              ),
            )
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 66,
                        width: 170,
                        child: DropdownButtonFormField(
                            dropdownColor: const Color(0xFFC8F8C8),
                            iconDisabledColor: black,
                            iconEnabledColor: black,
                            icon: SvgPicture.asset(
                              "assets/svg/down_arrow.svg",
                              width: 10.0,
                              height: 10.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              focusColor: colorPrimary,
                              fillColor: grayLight,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              counter: const SizedBox(height: 0.0),
                              labelStyle: GoogleFonts.lato(
                                fontSize: 15,
                                color: black,
                              ),
                            ),
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              color: black,
                            ),
                            value: mySelectedFilterOption,
                            onChanged: (String? newValue) {
                              setState(() {
                                mySelectedFilterOption = newValue!;
                                if (mySelectedFilterOption == "1") {
                                  mySelect = 1;
                                  debugPrint("FILTER 1 :$mySelect");
                                  getList();
                                } else if (mySelectedFilterOption == "2") {
                                  mySelect = 2;
                                  debugPrint("FILTER 2 :$mySelect");
                                  getLastWeek();
                                } else if (mySelectedFilterOption == "3") {
                                  mySelect = 3;
                                  debugPrint("FILTER 2:$mySelect");
                                  getLastMonth();
                                } else if (mySelectedFilterOption == "4") {
                                  mySelect = 4;
                                  debugPrint("FILTER 4:$mySelect");
                                  getLastYear();
                                }
                              });
                            },
                            items: selectOrderFilter),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: mySelect == 2
                      ? getWeekList()
                      : mySelect == 3
                          ? getMonthList()
                          : mySelect == 4
                              ? getYearList()
                              : getFirstList(),
                ),
              ],
            ),
    );
  }

  Widget getFirstList() {
    if (loading == true) {
      return Center(
        child: Lottie.asset(
          animationLoading,
          repeat: true,
          reverse: true,
          animate: true,
          width: ScreenSize.getScreenWidth(context) * 0.40,
          height: ScreenSize.getScreenHeight(context) * 0.40,
        ),
      );
      //  }
    } else {
      debugPrint("order error ");
      if (myOrderList.isEmpty) {
        debugPrint(" no order ");
        return Center(
            child: Text('No order..!',
                style: GoogleFonts.lato(color: Colors.black, fontSize: 18.0)));
      } else {
        return ListView.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: myOrderList.length,
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              var model = myOrderList[index];
              String productId = model.id.toString();
              debugPrint('DATE :${model.processedAt}');
              return InkWell(
                  onTap: () => Get.to(() => OrderDetails(productId)),
                  child: SizedBox(
                    width: ScreenSize.getScreenWidth(context),
                    height: ScreenSize.getScreenHeight(context) * 0.25,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      "Order: ${model.orderName}",
                                      style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Delivery by ${model.processedAt}",
                                      style: GoogleFonts.lato(
                                          color: green1, fontSize: 17.0),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 24,
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                            Expanded(
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: model.lineItemList!.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    LineItemModel lineItemModel =
                                        model.lineItemList![i];
                                    debugPrint('SKU :${lineItemModel.sku}');
                                    return ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Fulfillment Status : ${lineItemModel.fulfillmentStatus}",
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 14.0)),
                                          SizedBox(height: 3.5.sp),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "₹${model.getTotalAmount()}",
                                                    ),
                                                    const SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    // Visibility(
                                                    //   visible: lineItemModel
                                                    //           .totalDiscount !=
                                                    //       '0.00',
                                                    //   child: Text(
                                                    //     "₹${lineItemModel.totalDiscount}",
                                                    //     style:
                                                    //         zzRegularBlackTextStyle10_,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              lineItemModel.fulfillmentStatus ==
                                                      "fulfilled"
                                                  ? ElevatedButton(
                                                      onPressed: (() {
                                                        Get.to(() =>
                                                            OrderDetails(
                                                                productId));
                                                        print(productId);
                                                      }),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  loginTextColor,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      15,
                                                                      10,
                                                                      15,
                                                                      10)),
                                                      child: const Text(
                                                        'Return',
                                                        style: TextStyle(
                                                            color: white),
                                                      ))
                                                  : SizedBox(),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            });
      }
    }
  }

  Widget getWeekList() {
    if (isLoading1 == true) {
      return Center(
        child: Lottie.asset(
          animationLoading,
          repeat: true,
          reverse: true,
          animate: true,
          width: ScreenSize.getScreenWidth(context) * 0.40,
          height: ScreenSize.getScreenHeight(context) * 0.40,
        ),
      );
      //  }
    } else {
      if (myOrderList1.isEmpty) {
        return Center(
            child: Text('Last week no order..!',
                style: GoogleFonts.lato(color: Colors.black, fontSize: 18.0)));
      } else {
        return ListView.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: myOrderList1.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              var model = myOrderList1[index];
              return InkWell(
                  onTap: () => Get.to(() => OrderDetails(model.id.toString())),
                  child: SizedBox(
                    width: ScreenSize.getScreenWidth(context),
                    height: ScreenSize.getScreenHeight(context) * 0.31,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      "Order: ${model.orderName}",
                                      style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Delivery by ${model.processedAt}",
                                      style: GoogleFonts.lato(
                                          color: green1, fontSize: 17.0),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 24,
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                            Expanded(
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: model.lineItemList!.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    LineItemModel lineItemModel =
                                        model.lineItemList![i];
                                    return ListTile(
                                      // leading: Image.asset(
                                      //   "assets/images/eye_glass.png",
                                      //   width: 80,
                                      //   height: 80,
                                      // ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(lineItemModel.name.toString(),
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 14.0)),
                                          SizedBox(height: 3.5.sp),
                                          Row(
                                            children: [
                                              Text(
                                                "₹${lineItemModel.price}",
                                                // style:
                                                //     zzRegularBlackTextStyle10,
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Visibility(
                                                visible: lineItemModel
                                                        .totalDiscount !=
                                                    '0.00',
                                                child: Text(
                                                  "₹${lineItemModel.totalDiscount}",
                                                  style:
                                                      zzRegularBlackTextStyle10_,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // const Text("Frame size:medium"),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            });
      }
    }
  }

  Widget getMonthList() {
    if (isLoading2 == true) {
      // if(myOrderList2.isEmpty){
      //   return const Center(child: Text('Last month no order'));
      // } else {
      return Center(
        child: Lottie.asset(
          animationLoading,
          repeat: true,
          reverse: true,
          animate: true,
          width: ScreenSize.getScreenWidth(context) * 0.40,
          height: ScreenSize.getScreenHeight(context) * 0.40,
        ),
      );
      //  }
    } else {
      if (myOrderList2.isEmpty) {
        return Center(
            child: Text('Last month no order..!',
                style: GoogleFonts.lato(color: Colors.black, fontSize: 18.0)));
      } else {
        return ListView.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            physics: const AlwaysScrollableScrollPhysics(),

//  itemCount: mySelect==3?myOrderList3.length:mySelect==1?myOrderList1.length:mySelect==2?myOrderList2.length:myOrderList.length,
            itemCount: myOrderList2.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              var model = myOrderList2[index];
              return InkWell(
                  onTap: () => Get.to(() => OrderDetails(model.id.toString())),
                  child: SizedBox(
                    width: ScreenSize.getScreenWidth(context),
                    height: ScreenSize.getScreenHeight(context) * 0.31,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        //  margin: EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(16),
                        //   // border: BorderSide(width: 2, color: Colors.black12)
                        // ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      "Order: ${model.orderName}",
                                      style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Delivery by ${model.processedAt}",
                                      style: GoogleFonts.lato(
                                          color: green1, fontSize: 17.0),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 24,
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                            Expanded(
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: model.lineItemList!.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    LineItemModel lineItemModel =
                                        model.lineItemList![i];
                                    return ListTile(
                                      // leading: Image.asset(
                                      //   "assets/images/eye_glass.png",
                                      //   width: 80,
                                      //   height: 80,
                                      // ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(lineItemModel.name.toString(),
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 14.0)),
                                          SizedBox(height: 3.5.sp),
                                          Row(
                                            children: [
                                              Text(
                                                "₹${lineItemModel.price}",
                                                // style:
                                                //     zzRegularBlackTextStyle10,
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Visibility(
                                                visible: lineItemModel
                                                        .totalDiscount !=
                                                    '0.00',
                                                child: Text(
                                                  "₹${lineItemModel.totalDiscount}",
                                                  style:
                                                      zzRegularBlackTextStyle10_,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // const Text("Frame size:medium"),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            });
      }
    }
  }

  Widget getYearList() {
    if (isLoading3 == true) {
      return Center(
        child: Lottie.asset(
          animationLoading,
          repeat: true,
          reverse: true,
          animate: true,
          width: ScreenSize.getScreenWidth(context) * 0.40,
          height: ScreenSize.getScreenHeight(context) * 0.40,
        ),
      );
      // }
    } else {
      if (myOrderList3.isEmpty) {
        return Center(
            child: Text('Last year no order..!',
                style: GoogleFonts.lato(color: Colors.black, fontSize: 18.0)));
      } else {
        return ListView.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: myOrderList3.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              var model = myOrderList3[index];
              return InkWell(
                  onTap: () => Get.to(() => OrderDetails(model.id.toString())),
                  child: SizedBox(
                    width: ScreenSize.getScreenWidth(context),
                    height: ScreenSize.getScreenHeight(context) * 0.31,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      "Order: ${model.orderName}",
                                      style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Delivery by ${model.processedAt}",
                                      style: GoogleFonts.lato(
                                          color: green1, fontSize: 17.0),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 24,
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                            Expanded(
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: model.lineItemList!.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    LineItemModel lineItemModel =
                                        model.lineItemList![i];
                                    return ListTile(
                                      // leading: Image.asset(
                                      //   "assets/images/eye_glass.png",
                                      //   width: 100,
                                      //   height: 100,
                                      // ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(lineItemModel.name.toString(),
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 14.0)),
                                          SizedBox(height: 3.5.sp),
                                          Row(
                                            children: [
                                              Text(
                                                "₹${lineItemModel.price}",
                                                // style:
                                                //     zzRegularBlackTextStyle10,
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Visibility(
                                                visible: lineItemModel
                                                        .totalDiscount !=
                                                    '0.00',
                                                child: Text(
                                                  "₹${lineItemModel.totalDiscount}",
                                                  style:
                                                      zzRegularBlackTextStyle10_,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // const Text("Frame size:medium"),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            });
      }
    }
  }
}
