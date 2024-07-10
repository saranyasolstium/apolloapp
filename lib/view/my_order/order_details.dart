import 'package:flutter/material.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/model/billing_address_model.dart';
import 'package:infinite/model/order_model.dart';
import 'package:infinite/model/shipping_address_model.dart';
import 'package:infinite/services/network/dio_client.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:infinite/view/home/ear_detail_screen.dart';
import 'package:infinite/view/home/eye_detail_screen.dart';
import 'package:infinite/view/home/oral_care/oralcare_detail.dart';
import 'package:infinite/view/home/skin_care/skincare_detail.dart';
import 'package:infinite/view/home/sleep_care/sleep_details.dart';
import 'package:infinite/view/my_order/order_return_dialog.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../res/colors.dart';
import '../../res/styles.dart';

class OrderDetails extends StatefulWidget {
  final String myOrderId;

  const OrderDetails(this.myOrderId, {Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int activeStep = 0; // Initial step set to 0.
  int dotCount = 4;
  int _currentStep = 0;
  bool moreInfo = false;

  StepperType stepperType = StepperType.vertical;
  List<LineItemModel> myProductList = [];
  bool myOrderConfirmed = false;
  String myOrderName = "",
      myProcessedAt = "0",
      mySubTotal = "0",
      myTax = "0",
      myDiscount = "0",
      myOrderTotal = "0",
      mySellerName = "";
  BillingAddressModel? myBillingAddressModel;
  ShippingAddressModel? myShippingAddressModel;

  @override
  void initState() {
    debugPrint('SHOW THE MY ORDER DETAILS PAGE WIDGET::${widget.myOrderId}');
    getOrderDetails();
    super.initState();
    loading = true;
  }

  void getOrderDetails() {
    try {
      DioClient(myUrl: "orders/${widget.myOrderId}.json")
          .getDetails()
          .then((value) {
        if (mounted) {
          setState(() {
            if (value.statusCode == 200 || value.statusCode == 201) {
              var aOrderData = value.data['order'];
              debugPrint('SHOW ORDER DETAILS SCREEN: $aOrderData');
              myOrderName = aOrderData['name'];
              debugPrint(
                  'SHOW ORDER DETAIL DATE : ${aOrderData['processed_at'].toString()}');
              myProcessedAt = aOrderData['processed_at'].toString().isEmpty
                  ? ''
                  : myDefaultTimeFormatForOrderTwo
                      .format(myDefaultTimeFormatForOrder
                          .parse(aOrderData['processed_at'].toString()))
                      .toString();
              debugPrint('SHOW ORDER DETAIL DATE ::$myProcessedAt');
              mySubTotal = aOrderData['current_subtotal_price'];
              myTax = aOrderData['current_total_tax'];
              myDiscount = aOrderData['current_total_discounts'];
              myOrderTotal = aOrderData['current_total_price'];
              mySellerName = aOrderData['subtotal_price'];
              myOrderConfirmed = aOrderData['confirmed'];
              if (aOrderData['billing_address'] != null) {
                myBillingAddressModel =
                    BillingAddressModel.fromJson(aOrderData['billing_address']);
              }
              if (aOrderData['shipping_address'] != null) {
                myShippingAddressModel = ShippingAddressModel.fromJson(
                    aOrderData['shipping_address']);
              }
              var itemList = aOrderData['line_items'] as List;
              if (itemList.isNotEmpty || itemList != null) {
                myProductList = [];
                for (var item in itemList) {
                  LineItemModel lineItem = LineItemModel.fromJson(item);
                  // Fetch product image for each line item
                  fetchProductDetails(lineItem.productId.toString())
                      .then((details) {
                    lineItem.imageUrl = details['imageUrl'];
                    lineItem.productType = details['productType'];
                    lineItem.productName = details['productName'];

                    setState(() {
                      myProductList.add(lineItem);
                    });
                  });
                }
              } else {
                myProductList = [];
              }
            } else {
              myOrderName = "";
              myProcessedAt = "";
              mySubTotal = "0";
              myTax = "0";
              myDiscount = "0";
              myOrderTotal = "0";
              mySellerName = "";
              myOrderConfirmed = false;
              myBillingAddressModel = null;
              myShippingAddressModel = null;
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

  Future<Map<String, dynamic>> fetchProductDetails(String productId) async {
    try {
      var response =
          await DioClient(myUrl: "products/$productId.json").getDetails();
      if (response.statusCode == 200) {
        var productData = response.data['product'];
        if (productData['image'] != null) {
          String productName = productData['title'];
          String imageUrl = productData['image']['src'];
          String productType = productData['product_type'];

          return {
            'productName': productName,
            'imageUrl': imageUrl,
            'productType': productType
          };
        }
      }
    } catch (e) {
      debugPrint("$e");
    }
    // Return default values if the product details couldn't be fetched
    return {
      'imageUrl':
          "https://my6senses.com/cdn/shopifycloud/shopify/assets/no-image-2048-5e88c1b20e087fb7bbe9a3771824e743c244f437e4f8ba93bbf7b11b53f7824c_600x.gif",
      'productType': "Unknown"
    };
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Order Details",
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
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order: $myOrderName',
                              style: zzBoldBlackTextStyle16,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('Delivery by $myProcessedAt')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: ScreenSize.getScreenHeight(context) * 0.50,
                        child: Column(
                          children: [
                            Expanded(
                              child: Theme(
                                data: ThemeData(
                                  colorScheme:
                                      ColorScheme.fromSwatch().copyWith(
                                    secondary: loginBlue2,
                                    primary: loginTextColor,
                                  ),
                                  primaryColor: loginTextColor,
                                  primaryColorLight: loginTextColor,
                                  primaryColorDark: loginTextColor,
                                  dividerColor: loginTextColor,
                                  indicatorColor: loginTextColor,
                                  hintColor: loginTextColor,
                                  hoverColor: loginTextColor,
                                  canvasColor: loginTextColor,
                                ),
                                child: Stepper(
                                  controlsBuilder: (context, controller) {
                                    return const SizedBox.shrink();
                                  },
                                  type: stepperType,
                                  // physics: const ScrollPhysics(),
                                  physics: const NeverScrollableScrollPhysics(),
                                  currentStep: _currentStep,
                                  onStepTapped: (step) => tapped(step),
                                  onStepContinue: continued,
                                  onStepCancel: cancel,

                                  steps: <Step>[
                                    Step(
                                      title: const Text('Order Placed'),
                                      // subtitle: const Text(
                                      //     'Placed on 2 march 2023'),
                                      content: Container(),
                                      isActive: _currentStep >= 0,
                                      state: _currentStep >= 0
                                          ? StepState.complete
                                          : StepState.disabled,
                                    ),
                                    Step(
                                      title:
                                          const Text('Preparing for dispatch'),
                                      // subtitle:
                                      // const Text('on 10 march 2023'),
                                      content: const Column(
                                        children: <Widget>[
                                          // TextFormField(
                                          //   decoration: InputDecoration(labelText: 'Home Address'),
                                          // ),
                                          // TextFormField(
                                          //   decoration: InputDecoration(labelText: 'Postcode'),
                                          // ),
                                        ],
                                      ),
                                      isActive: _currentStep >= 0,
                                      state: _currentStep >= 1
                                          ? StepState.complete
                                          : StepState.disabled,
                                    ),
                                    Step(
                                      title: const Text('On the way'),
                                      // subtitle:
                                      // const Text('on 14 march 2023'),
                                      content: const Column(
                                        children: <Widget>[
                                          // TextFormField(
                                          //   decoration: InputDecoration(labelText: 'Mobile Number'),
                                          // ),
                                        ],
                                      ),
                                      isActive: _currentStep >= 0,
                                      state: _currentStep >= 2
                                          ? StepState.complete
                                          : StepState.disabled,
                                    ),
                                    Step(
                                      title: const Text('Delivered'),
                                      // subtitle:
                                      // const Text('on 14 march 2023'),
                                      content: const Column(
                                        children: <Widget>[
                                          // TextFormField(
                                          //   decoration: InputDecoration(labelText: 'Mobile Number'),
                                          // ),
                                        ],
                                      ),
                                      isActive: _currentStep >= 0,
                                      state: _currentStep >= 2
                                          ? StepState.complete
                                          : StepState.disabled,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order details',
                            style: zzBoldBlackTextStyle16,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black26,
                          ),
                          ListView.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: myProductList.length,
                              itemBuilder: (BuildContext context, int i) {
                                LineItemModel lineItemModel = myProductList[i];
                                print(lineItemModel.imageUrl);
                                return GestureDetector(
                                    onTap: () {
                                      String aProductType =
                                          lineItemModel.productType!;
                                      print(aProductType);
                                      print(lineItemModel.name);
                                      print(lineItemModel.productId);
                                      if (aProductType == "Audiology") {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EarDetailScreen(
                                                      id: lineItemModel
                                                          .productId),
                                            ));
                                      } else if (aProductType == "Frame") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EyeDetailsScreen(
                                                      id: lineItemModel
                                                          .productId!,
                                                          productHandle: "",
                                                    )));
                                      } else if (aProductType == "Oral Care") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OralDetailScreen(
                                                      id: lineItemModel
                                                          .productId!,
                                                    )));
                                      } else if (aProductType == "Skin Care") {
                                        print(aProductType);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SkinDetailScreen(
                                                      id: lineItemModel
                                                          .productId!,
                                                    )));
                                      } else if (aProductType == "Nasal") {
                                        print(aProductType);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SleepDetailScreen(
                                                      id: lineItemModel
                                                          .productId!,
                                                    )));
                                      }
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          leading: Image.network(
                                            lineItemModel.imageUrl!,
                                            width: 70,
                                            height: 70,
                                          ),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  lineItemModel.name ==
                                                              "Trial Request Visit Store" ||
                                                          lineItemModel.name ==
                                                              "Trail Request In Home" ||
                                                          lineItemModel.name ==
                                                              "Trail Request Visit Store"
                                                      ? lineItemModel.name
                                                          .toString()
                                                      : lineItemModel.name
                                                          .toString(),
                                                  style: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 14.0)),
                                              SizedBox(height: 3.5.sp),
                                              Text(
                                                "Quantity :${lineItemModel.quantity}",
                                                // style:
                                                //     zzRegularBlackTextStyle10,
                                              ),
                                              SizedBox(height: 3.5.sp),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "₹${lineItemModel.price}",
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
                                                  ),
                                                  lineItemModel
                                                              .fulfillmentStatus ==
                                                          "fulfilled"
                                                      ? ElevatedButton(
                                                          onPressed: (() {
                                                            print(lineItemModel
                                                                .variantId);
                                                            print(widget
                                                                .myOrderId);
                                                            Get.to(
                                                                OrderReturnScreen(
                                                              varientId:
                                                                  lineItemModel
                                                                      .variantId!,
                                                              orderId: widget
                                                                  .myOrderId,
                                                            ));
                                                          }),
                                                          style: ElevatedButton.styleFrom(
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
                                                      : const SizedBox(),
                                                ],
                                              ),
                                              lineItemModel
                                                      .properties!.isNotEmpty
                                                  ? InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          moreInfo = !moreInfo;
                                                          showModalBottomSheet(
                                                            isDismissible: true,
                                                            backgroundColor:
                                                                loginBlue,
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20.0),
                                                              ),
                                                            ),
                                                            isScrollControlled:
                                                                true,
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    builder) {
                                                              return FractionallySizedBox(
                                                                widthFactor:
                                                                    1.0,
                                                                child:
                                                                    Container(
                                                                  constraints:
                                                                      BoxConstraints(
                                                                    maxHeight: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.6,
                                                                  ),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          20),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        for (var property
                                                                            in lineItemModel.properties!)
                                                                        property.value!.isEmpty
                                                                        ?const SizedBox()
                                                                         : Padding(
                                                                            padding:
                                                                                EdgeInsets.all(5.sp),
                                                                            child:
                                                                                Text(
                                                                              '${property.name}: ${property.value}',
                                                                              style: zzBoldBlackTextStyle10,
                                                                            ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text('more info ',
                                                              style: GoogleFonts.lato(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize:
                                                                      12.0)),
                                                          const Icon(Icons.add,
                                                              color:
                                                                  Colors.black,
                                                              size: 14)
                                                        ],
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: Colors.black26,
                                        ),
                                      ],
                                    ));
                              }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: myShippingAddressModel != null,
                    child: Card(
                      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Shipping address',
                              style: zzBoldBlackTextStyle16,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.black26,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${myShippingAddressModel?.address1} ${myShippingAddressModel?.address2 == null ? '' : "\n${myShippingAddressModel?.address2}"} \n${myShippingAddressModel?.zip == null ? '-' : myShippingAddressModel?.zip} ${myShippingAddressModel?.city == null ? '-' : myShippingAddressModel?.city}',
                              style: zzRegularBlackTextStyle12,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Name: ${myShippingAddressModel?.name} \nPh: ${myShippingAddressModel?.phone == null ? "" : myShippingAddressModel?.phone} \nCity: ${myShippingAddressModel?.city == null ? "-" : myShippingAddressModel?.city}',
                              style: zzRegularBlackTextStyle12,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: myShippingAddressModel != null,
                    child: const SizedBox(
                      height: 20,
                    ),
                  ),
                  Visibility(
                    visible: myBillingAddressModel != null,
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Billing details',
                              style: zzBoldBlackTextStyle16,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.black26,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${myBillingAddressModel?.address1}, ${myBillingAddressModel?.address2 == null ? '-' : "\n${myBillingAddressModel?.address2},"} \n${myBillingAddressModel?.zip == null ? '-' : myBillingAddressModel?.zip} ${myBillingAddressModel?.city == null ? '-' : myBillingAddressModel?.city}',
                              style: zzRegularBlackTextStyle12,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Name: ${myBillingAddressModel?.name} \nPh: ${myBillingAddressModel?.phone == null ? '-' : myBillingAddressModel?.phone} \nCity: ${myBillingAddressModel?.city == null ? '-' : myBillingAddressModel?.city}',
                              style: zzRegularBlackTextStyle12,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: myBillingAddressModel != null,
                    child: const SizedBox(
                      height: 20,
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Status',
                            style: zzBoldBlackTextStyle16,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black26,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Order ${myOrderConfirmed ? "Confirmed" : "Pending"}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Order payment details',
                            style: zzBoldBlackTextStyle16,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black26,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Sub total'),
                                  Text('₹$mySubTotal')
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [const Text('Tax'), Text('₹$myTax')],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Discount'),
                                  Text('₹$myDiscount')
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Order total',
                                      style: zzBoldBlackTextStyle12),
                                  Text(
                                    '₹$myOrderTotal',
                                    style: zzBoldBlackTextStyle12,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Card(
                  //   elevation: 4,
                  //   margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Text(
                  //           'Order policy',
                  //           style: zzBoldBlackTextStyle16,
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         const Divider(
                  //           thickness: 1,
                  //           color: Colors.black26,
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         const Text(
                  //             'Upto 1 year warranty on selected eyeglasses'),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         Text('Read more',
                  //             style: GoogleFonts.lato(
                  //                 fontSize: 17,
                  //                 decoration: TextDecoration.underline,
                  //                 color: loginTextColor,
                  //                 decorationColor: loginTextColor)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Need any help?',
                                style: zzBoldBlackTextStyle16),
                            InkWell(
                              onTap: () => Freshchat.showConversations(),
                              child: Text('Chat with us',
                                  style: GoogleFonts.lato(
                                      fontSize: 17,
                                      decoration: TextDecoration.underline,
                                      color: loginTextColor,
                                      decorationColor: loginTextColor)),
                            ),
                          ],
                        )),
                  ),
                  //   Step(title:Text('Return Requested'), content:Text('hell'))
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
