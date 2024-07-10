import 'package:get/get.dart';

import '../../utils/packeages.dart';

class CartController extends GetxController {
  List<CartModel> myCartList = [];
  List<CartModel> dateFilterList = [];
  List<FrameModel> myFrameList = [];
  List<CartModel> myCartList1 = [];
  List<CartModel> myCartList2 = [];
  List<CartModel> myCartList3 = [];
  List<CartModel> myCartList4 = [];
  List<CartModel> myAddOnCartList = [];
  List<CartModel> myBookList = [];
  List<BookCartModel> myBookCartList = [];
  int quantity = 1;
  double mySum = 0.0;
  double myBookTotal = 0.0;
  String lens = '';
  double framePrice2 = 0.0;
  double addOnPrice = 0.0;
  double total2 = 0.0;
  double? total3;
  double total5 = 0.0;
  String productName = '';
  String txtType = '';
  String myMail = "", myFirstName = "", myLastName = "", myMobile = "";
  late Razorpay razorpay;
  bool moreInfo = false;
  final DateTime currentDate2 = DateTime.now();
  late DateTime previousDate;

  int? orderCount;
  int? frameCount;
  int? bookCount;
  int? addOnCount;
  int totalCount = 0;

  final TextEditingController countryController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController appartmentController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final TextEditingController billingCountryController = TextEditingController();
  final TextEditingController billingFirstNameController = TextEditingController();
  final TextEditingController billingLastNameController = TextEditingController();
  final TextEditingController billingAddressController = TextEditingController();
  final TextEditingController billingAppartmentController = TextEditingController();
  final TextEditingController billingCityController = TextEditingController();
  final TextEditingController billingStateController = TextEditingController();
  final TextEditingController billingPinController = TextEditingController();
  final TextEditingController billingMobileController = TextEditingController();
  int? customerId;
  int? shippingAddressID;


  @override
  void onInit() {
    super.onInit();
    razorpay = Razorpay();
    customerId = sharedPreferences!.getInt("id");

    myMail = sharedPreferences!.getString("mail") ?? "";
    myFirstName = sharedPreferences!.getString("firstName") ?? "";
    myLastName = sharedPreferences!.getString("lastName") ?? "";
    myMobile = sharedPreferences!.getString("mobileNumber") ?? "";

    createCheckout();
    loading = true;
    getFromDB1();
    getFrameDetailsFromDB();
    getBookAppointmentList2();
    checkIfCustomerExistsByMail(customerId!);
  }

  void checkIfCustomerExistsByMail(int customerId) {
    try {
      DioClient(myUrl: "${EndPoints.updateCustomer}$customerId/addresses.json")
          .getDetails()
          .then((value) {
        print("${EndPoints.updateCustomer}$customerId/addresses.json");
        debugPrint("SHOW CUSTOMER EXISTS CHECK STATUS EMAIL: $value");
        if (value.statusCode == 200) {
          if ((value.data['addresses'] as List).isNotEmpty) {
            var addresses = value.data['addresses'];
            var defaultAddress = addresses.firstWhere(
              (address) => address['default'] == true,
              orElse: () => null,
            );
            if (defaultAddress != null) {
              print(defaultAddress);
              shippingAddressID = defaultAddress['id'] ?? 0;
              firstNameController.text = defaultAddress['first_name'] ?? '';
              lastNameController.text = defaultAddress['last_name'] ?? '';
              countryController.text = defaultAddress['country'] ?? 'India';
              cityController.text = defaultAddress['city'] ?? '';
              addressController.text = defaultAddress['address1'] ?? '';
              appartmentController.text = defaultAddress['address2'] ?? '';
              pinController.text = defaultAddress['zip'] ?? '';
              mobileController.text = defaultAddress['phone'] ?? "";
              update();
            } else {}
          }
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<int?> updateShippingAddress(int shippingAddressID) async {
    try {
      String updateUrl =
          "${EndPoints.baseUrl}${EndPoints.updateCustomer}$customerId/addresses/${shippingAddressID}.json";

      Map<String, dynamic> updatedAddressData = {
        "address": {
          "id": customerId,
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "country": countryController.text,
          "city": cityController.text,
          "address1": addressController.text,
          "address2": appartmentController.text,
          "phone": mobileController.text,
          "zip": pinController.text,
        }
      };

      final response =
          await DioClient(myUrl: updateUrl, myMap: updatedAddressData).update();

      return response.statusCode;
    } catch (e) {
      print("Exception while updating shipping address: $e");
      return 500;
    }
  }

  void createCheckout() {
    try {
      DioClient(myUrl: EndPoints.createCheckoutNew).post().then((value) {
        debugPrint('SHOW CART PAGE CHECKOUT RESULT 1: ${value.data}');
        debugPrint('SHOW CART PAGE CHECKOUT RESULT 2: ${value.statusCode}');
      });
      Map<String, dynamic> mainMap = <String, dynamic>{};
      Map<String, dynamic> secondMap = <String, dynamic>{};
      List<Map<String, dynamic>> itemList = [];
      itemList.add({
        "variant_id": 8150732767476,
        "quantity": 2,
      });
      secondMap['email'] = "sathasivam@cloudi5.com";
      secondMap['line_items'] = itemList;
      mainMap['checkout'] = secondMap;
      debugPrint('SHOW CART PAGE CHECKOUT MAP: $mainMap');
      DioClient(myUrl: EndPoints.createCheckout, myMap: mainMap)
          .post()
          .then((value) {
        debugPrint('SHOW CART PAGE CHECKOUT RESULT 1: ${value.data}');
        debugPrint('SHOW CART PAGE CHECKOUT RESULT 2: ${value.statusCode}');
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void getFromDB1() {
    debugPrint('FROM DB .....');
    localDBHelper!.getCartList().then((value) {
      if (value.isNotEmpty) {
        myCartList1 = [];
        debugPrint('FROM DB 1 :: $value');
        for (var val in value) {
          debugPrint('FROM DB 1 LENGTH START  : ${myCartList1.length}');

          CartModel model = CartModel();

          model.productId = int.parse(val['product_id'].toString());
          model.frameId = 0;
          model.bookId = 0;
          model.addOnId = 0;
          model.name = val['product_name'];
          model.lens_type = val['lens_type'];
          model.priscription = val['priscription'];
          model.frame_name = val['frame_name'];
          model.frame_price = val['frame_price'];
          model.frame_qty = val['frame_qty'];
          model.frame_total = val['frame_total'];

          model.variantId = int.parse(val['variant_id'].toString());
          // model.variantId =val['variant_id'];
          model.productType = val['product_type'];
          model.variantName = val['variant_name'];
          model.unitPrice = double.parse(val['unit_price'].toString());

          model.total = double.parse(val['total'].toString());
          //   model.total =val['total'];
          model.quantity = int.parse(val['quantity'].toString());
          model.imageUrl = val['image_url'].toString();
          model.inventoryQuantity =
              int.parse(val['inventory_quantity'].toString());
          model.bookQty = 0;
          model.bookPrice = 0.0;
          model.bookTotal = 0.0;
          debugPrint('IMAGE URL  :: ${model.imageUrl}');
          debugPrint('PRICE  :: ${model.unitPrice}');
          debugPrint('TOTAL  :: ${model.total}');
          debugPrint('VARIANT ID  :: ${model.variantId}');
          debugPrint('CART INVENTORY QUANTITY  :: ${model.inventoryQuantity}');

          model.trialRequestType = '';
          model.clinicName = '';
          model.clientName = '';
          model.mail = '';
          model.mobile = '';
          model.pincode = '';
          model.appointmentTime = '';
          model.appointmentDate = '';
          model.location = '';
          model.addressType = '';
          model.houseNo = '';
          model.type = 'ORDER';
          //model.type = '';

          model.rdSph = val['rd_sph'];
          model.rdCyl = val['rd_cyl'];
          model.rdAxis = val['rd_axis'];
          model.rdBcva = val['rd_bcva'];

          model.raSph = val['ra_sph'];
          model.raCyl = val['ra_cyl'];
          model.raAxis = val['ra_axis'];
          model.raBcva = val['ra_bcva'];

          model.ldSph = val['ld_sph'];
          model.ldCyl = val['ld_cyl'];
          model.ldAxis = val['ld_axis'];
          model.ldBcva = val['ld_bcva'];

          model.laSph = val['la_sph'];
          model.laCyl = val['la_cyl'];
          model.laAxis = val['la_axis'];
          model.laBcva = val['la_bcva'];

          model.re = val['re'];
          model.le = val['le'];
          model.addOnTitle = '';
          model.addOnPrice = 0.0;
          model.addOnQty = 0;
          model.addOnTotal = 0.0;

          model.createdAt = val['created_at'];
          model.updatedAt = val['updated_at'];

          myCartList1.add(model);
          myCartList4.add(model);

          debugPrint('FROM DB 3 LENGTH END : ${myCartList1.length}');
          debugPrint('FROM DB 3 CURRENT TIME : ${model.createdAt}');
          debugPrint('FROM DB 3 UPDATE TIME : ${model.updatedAt}');
        }
        myCartList4.sort((a, b) {
          //sorting in ascending order
          return DateTime.parse(b.createdAt.toString())
              .compareTo(DateTime.parse(a.createdAt.toString()));
        });
      }
      loading = false;
      getTotalOfAllProduct();
      //  getAddOnDetails();
      update();
    });
  }

  void getAddOnDetails() {
    debugPrint('FROM DB 4 .....');
    localDBHelper!.getCartList4().then((value) {
      if (value.isNotEmpty) {
        myAddOnCartList = [];
        debugPrint('FROM DB 4 :: $value');
        for (var val in value) {
          debugPrint('FROM DB 4 LENGTH START  : ${myAddOnCartList.length}');

          CartModel model = CartModel();

          model.productId = int.parse(val['product_id'].toString());
          model.frameId = 0;
          model.bookId = 0;
          model.type = 'ADDON';

          model.addOnId = int.parse(val['addon_id'].toString());
          model.addOnTitle = val['addon_title'];
          model.addOnPrice = double.parse(val['addon_price'].toString());
          model.addOnQty = int.parse(val['addon_qty'].toString());
          model.addOnTotal = double.parse(val['addon_total'].toString());

          model.imageUrl = '';
          model.lens_type = '';
          model.priscription = '';

          model.frame_name = '';
          model.frame_price = 0.0;
          model.frame_qty = 0;
          model.frame_total = 0.0;

          model.variantId = 0;
          model.productType = '';
          model.variantName = '';

          model.name = '';
          model.unitPrice = 0.0;

          model.total = 0.0;
          model.quantity = 0;

          model.inventoryQuantity = 0;
          model.bookQty = 0;
          model.bookPrice = 0.0;
          model.bookTotal = 0.0;

          model.trialRequestType = '';
          model.clinicName = '';
          model.clientName = '';
          model.mail = '';
          model.mobile = '';
          model.pincode = '';
          model.appointmentTime = '';
          model.appointmentDate = '';
          model.location = '';
          model.addressType = '';
          model.houseNo = '';

          model.rdSph = '';
          model.rdCyl = '';
          model.rdAxis = '';
          model.rdBcva = '';

          model.raSph = '';
          model.raCyl = '';
          model.raAxis = '';
          model.raBcva = '';

          model.ldSph = '';
          model.ldCyl = '';
          model.ldAxis = '';
          model.ldBcva = '';

          model.laSph = '';
          model.laCyl = '';
          model.laAxis = '';
          model.laBcva = '';

          model.re = '';
          model.le = '';

          model.createdAt = val['created_at'];
          model.updatedAt = val['updated_at'];

          myAddOnCartList.add(model);
          myCartList4.add(model);

          debugPrint('FROM DB 4 LENGTH END : ${myAddOnCartList.length}');
          debugPrint('FROM DB 4 CURRENT TIME : ${model.createdAt}');
          debugPrint('FROM DB 4 UPDATE TIME : ${model.updatedAt}');

          // localDBHelper!.updateQuantityOfProductInCart4(
          //     model.addOnQty!,
          //     model.addOnId!,
          //     model.addOnPrice!,
          //     model.productId!);
        }
        myCartList4.sort((a, b) {
          //sorting in ascending order
          return DateTime.parse(b.createdAt.toString())
              .compareTo(DateTime.parse(a.createdAt.toString()));
        });
      }
      loading = false;
      getAddonTotal();
      update();
    });
  }

  void getFilterByDate() {
    for (CartModel model in myCartList4) {
      String prevDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(currentDate2);
      String prevDate2 = DateFormat('MMMM d, y', 'en_US').format(currentDate2);
      String prevDate3 = DateFormat('yyyy-MM-dd').format(currentDate2);
      debugPrint('FILTER DATE ::$prevDate');
      debugPrint('FILTER DATE2 ::$prevDate2');
      debugPrint('FILTER DATE3 ::$prevDate3');
      debugPrint('FILTER CURRENT  ::$currentDate2');
      previousDate = DateFormat('yyyy-MM-dd').parse(model.createdAt.toString());

      debugPrint('PREVIOUS DATE 1:: $previousDate');

      if (previousDate.isBefore(currentDate2)) {
        dateFilterList.add(model);
      }
    }
  }

  void getAddonTotal() {
    try {
      localDBHelper!.getTotal4().then((value) {
        debugPrint('ADD ON TOTAL VALUE ::: $value');
        if (value == null || value.toString().isEmpty) {
          addOnPrice = 0.0;
          debugPrint('SUB ADD ON TOTAL IF  ::: $addOnPrice');
        } else {
          addOnPrice = double.parse(value.toString());
        }
        update();
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void getTotalOfAllProduct() {
    try {
      localDBHelper!.getTotal().then((value) {
        debugPrint('TOTAL VALUE ::: $value');
        if (value == null || value.toString().isEmpty) {
          mySum = 0.0;
          debugPrint('SUB TOTAL IF  ::: $mySum');
        } else {
          mySum = double.parse(value.toString());
          debugPrint('SUB TOTAL  ELSE  ::: $mySum');
        }
        update();
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void getBookTotal() {
    try {
      localDBHelper!.getTotal3().then((value) {
        debugPrint('TOTAL VALUE ::: $value');
        if (value == null || value.toString().isEmpty) {
          myBookTotal = 0.0;
          debugPrint('BOOK TOTAL  ::: $myBookTotal');
        } else {
          myBookTotal = double.parse(value.toString());
          debugPrint('BOOK TOTAL   ::: $myBookTotal');
        }
        update();
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void getFrameTotal() {
    try {
      localDBHelper!.getTotal2().then((value) {
        debugPrint('FRAME TOTAL VALUE ::: $value');
        if (value == null || value.toString().isEmpty) {
          framePrice2 = 0.0;
          debugPrint('SUB FRAME TOTAL IF  ::: $framePrice2');
        } else {
          framePrice2 = double.parse(value.toString());
        }
        update();
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  // OPEN RAZORPAY PAYMENT GATEWAY
  void openPaymentGateway() {
    try {
      Map<String, dynamic> orderMap = <String, dynamic>{};
      orderMap['amount'] = (mySum + framePrice2 + myBookTotal + addOnPrice);
      orderMap['currency'] = "INR";
      // DioClient(myUrl: "https://api.razorpay.com/v1/orders",myMap: orderMap).postForPayment().then((value) {
      //   if(value.statusCode == 200) {
      //     String aRazorOrderId = value.data['id'];
      //     int aOrderAmount = value.data['amount'] ?? 0;
      openRazorCheckout(/*aRazorOrderId,aOrderAmount*/);
      // } else {
      //
      // }
      // });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void openRazorCheckout(/*String aRazorOrderId, int aOrderAmount*/) {
    try {
      var options = {
        "enable": "1",
        'key': EndPoints.myRazorpayKey,
        "razor_secret": EndPoints.myRazorpaySecret,
        'amount': (mySum + framePrice2 + myBookTotal + addOnPrice) * 100,
        'name': 'Infinite',
        // "order_id": aRazorOrderId,
        "currency": "INR",
        // "timeout": 60 * 15, // session time out duration
        "theme.color": "#2E478D",
        'description': '', // show product names
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'prefill': {'contact': myMobile, 'email': myMail, 'name': myFirstName},
        'external': {
          'wallets': ['paytm']
        }
      };
      razorpay.open(options);
    } catch (e) {
      debugPrint("$e");
    }
  }

  void showPaymentErrorDialog(
      BuildContext context, String title, String message, String fromWhere) {
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: zzBoldBlackTextStyle12,
      ),
      content: fromWhere == "cancel"
          ? Text(
              message,
              style: zzRegularBlackTextStyle10,
            )
          : Text(
              "",
              style: zzRegularBlackTextStyle10,
            ),
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      actions: [
        if (fromWhere == "success")
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/gif/checkCircle.gif"),
              Text(
                "Order Successful!",
                style: zzBoldBlackTextStyle14,
              ),
              SizedBox(height: 3.5.sp),
              Text(
                "Payment is successfully",
                // "Payment is successfully processed and your Payment ID is on the way.",
                style: zzRegularBlackTextStyle13B,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Your Payment ID is: $message",
                style: zzRegularBlackTextStyle13B,
              ),
            ],
          ),
        const SizedBox(
          height: 10.0,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              backgroundColor: loginTextColor,
            ),
            onPressed: () {
              Get.back();
              if (fromWhere == "success") {
                if (myCartList1.isNotEmpty) {
                  for (int a = 0; a < myCartList1.length; a++) {
                    localDBHelper!.deleteCart(myCartList1[a].productId!);
                  }
                }
                if (myCartList2.isNotEmpty) {
                  for (int a = 0; a < myCartList2.length; a++) {
                    localDBHelper!.deleteCart2(myCartList2[a].frameId!);
                  }
                }

                if (myBookList.isNotEmpty) {
                  for (int a = 0; a < myBookList.length; a++) {
                    localDBHelper!.deleteCart3(myBookList[a].bookId!);
                  }
                }

                if (myAddOnCartList.isNotEmpty) {
                  for (int a = 0; a < myAddOnCartList.length; a++) {
                    localDBHelper!.deleteCart4(myAddOnCartList[a].addOnId!);
                  }
                }
                update();
                // addOrderToCloud();
                Get.off(() => HomeScreen(index: 0));
              }
            },
            child: Text(
              fromWhere == "cancel" ? "Back" : "Go to Home",
              style: zzRegularWhiteTextStyle12,
            ),
          ),
        ),
      ],
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ADD RECORD TO CLOUD
  addOrderToCloud(BuildContext context) {
    try {
      if (myCartList4.isEmpty) {
        // No items in the cart
        return;
      }

      Map<String, dynamic> postMap = {
        'order': {
          'email': sharedPreferences!.getString('mail'),
          'fulfillment_status': 'fulfilled',
          'line_items': myCartList4
              .map((item) => {
                    'variant_id': item.variantId,
                    'quantity': item.quantity,
                    'price': item.unitPrice,
                    'name': item.name,
                    'title': item.variantName,
                  })
              .toList(),
        }
      };

      print('order');
      debugPrint('CART CHECKOUT :$postMap');

      placeOrder(postMap, context);
    } catch (e) {
      debugPrint("$e");
      // Handle error
    }
  }

  // DELETE CONFIRM DIALOG
  void showDeleteConfirmDialog(BuildContext context, int id, int index) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text(
              'Are you sure want to remove this product from cart?',
              textAlign: TextAlign.start,
              style: GoogleFonts.lato(
                color: black,
                fontSize: 15.0,
              ),
            ),
            actions: [
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      backgroundColor: redLight,
                    ),
                    onPressed: () => Navigator.of(builderContext).pop(),
                    child: Text('Cancel',
                        style: GoogleFonts.lato(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      backgroundColor: colorPrimary,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      localDBHelper!.deleteCart(id).then((value) {
                        showSuccessSnackBar(
                            context, "Product has been removed from cart!");
                        //myCartList4.removeAt(index);
                        myCartList4 = [];

                        getFromDB1();
                        getFrameDetailsFromDB();
                        getBookAppointmentList2();
                        getAddOnDetails();
                      });
                      //  }

                      Navigator.of(builderContext).pop();
                    },
                    child: Text('Delete',
                        style: GoogleFonts.lato(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
            ],
          );
        }).then((value) {
      // setState(() {
      //   loading = false;
      // });
    });
  }

  void showDeleteConfirmDialog2(BuildContext context, int id, int index) {
    debugPrint('FRAME ID : $id');
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text(
              'Are you sure want to remove this product from cart?',
              textAlign: TextAlign.start,
              style: GoogleFonts.lato(
                color: black,
                fontSize: 15.0,
              ),
            ),
            actions: [
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      backgroundColor: redLight,
                    ),
                    onPressed: () => Navigator.of(builderContext).pop(),
                    child: Text('Cancel',
                        style: GoogleFonts.lato(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      backgroundColor: colorPrimary,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      // myCartList4.clear();

                      localDBHelper!.deleteCart2(id).then((value) {
                        showSuccessSnackBar(
                            context, "Product has been removed from cart!");

                        // myCartList4.removeAt(index);
                        myCartList4 = [];
                        getFromDB1();
                        getFrameDetailsFromDB();
                        getBookAppointmentList2();
                        getAddOnDetails();
                      });
                      //  }

                      Navigator.of(builderContext).pop();
                    },
                    child: Text('Delete',
                        style: GoogleFonts.lato(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
            ],
          );
        }).then((value) {
      // setState(() {
      //   loading = false;
      // });
    });
  }

  void showDeleteConfirmDialog3(BuildContext context, int id, int index) {
    debugPrint('BOOK APPOINTMENT ID : $id');
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text(
              'Are you sure want to remove this product from cart?',
              textAlign: TextAlign.start,
              style: GoogleFonts.lato(
                color: black,
                fontSize: 15.0,
              ),
            ),
            actions: [
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      backgroundColor: redLight,
                    ),
                    onPressed: () => Navigator.of(builderContext).pop(),
                    child: Text('Cancel',
                        style: GoogleFonts.lato(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      backgroundColor: colorPrimary,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      // myCartList4.clear();

                      localDBHelper!.deleteCart3(id).then((value) {
                        showSuccessSnackBar(
                            context, "Product has been removed from cart!");

                        // myCartList4.removeAt(index);
                        myCartList4 = [];
                        getFromDB1();
                        getFrameDetailsFromDB();
                        getBookAppointmentList2();
                        getAddOnDetails();
                      });
                      //  }

                      Navigator.of(builderContext).pop();
                    },
                    child: Text('Delete',
                        style: GoogleFonts.lato(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
            ],
          );
        }).then((value) {
      // setState(() {
      //   loading = false;
      // });
    });
  }

  void showDeleteConfirmDialog4(BuildContext context, int id, int index) {
    debugPrint('ADD ON ID : $id');
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text(
              'Are you sure want to remove this product from cart?',
              textAlign: TextAlign.start,
              style: GoogleFonts.lato(
                color: black,
                fontSize: 15.0,
              ),
            ),
            actions: [
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      backgroundColor: redLight,
                    ),
                    onPressed: () => Navigator.of(builderContext).pop(),
                    child: Text('Cancel',
                        style: GoogleFonts.lato(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      backgroundColor: colorPrimary,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      localDBHelper!.deleteCart4(id).then((value) {
                        showSuccessSnackBar(
                            context, "Product has been removed from cart!");

                        myCartList4 = [];

                        getFromDB1();
                        getFrameDetailsFromDB();
                        getBookAppointmentList2();
                        getAddOnDetails();
                      });
                      //  }

                      Navigator.of(builderContext).pop();
                    },
                    child: Text('Delete',
                        style: GoogleFonts.lato(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
            ],
          );
        }).then((value) {
      // setState(() {
      //   loading = false;
      // });
    });
  }

  void placeOrder(Map<String, dynamic> data, BuildContext context) {
    try {
      DioClient(myUrl: EndPoints.placeOrder, myMap: data).post().then((value) {
        debugPrint('PLACE ORDER URL: ${EndPoints.placeOrder}');
        debugPrint(
            'Request Payload: $data'); // Print the request payload (myMap)

        debugPrint('PLACE ORDER: $value');
        debugPrint('ORDER STATUS CODE  ${value.statusCode}');
        if (value.statusCode == 201) {
          showSuccessSnackBar(context, "Order placed successfully");
          for (int a = 0; a < myCartList1.length; a++) {
            localDBHelper!.deleteCart(myCartList1[a].productId!);
          }

          for (int a = 0; a < myCartList2.length; a++) {
            localDBHelper!.deleteCart2(myCartList2[a].frameId!);
          }

          for (int a = 0; a < myBookList.length; a++) {
            localDBHelper!.deleteCart3(myBookList[a].bookId!);
          }

          for (int a = 0; a < myAddOnCartList.length; a++) {
            localDBHelper!.deleteCart4(myAddOnCartList[a].addOnId!);
          }

          //getCartListFromDB();
          getFromDB1();
          getFrameDetailsFromDB();
          getBookAppointmentList2();
          getAddOnDetails();
          update();
          // Get.offAll(() => const HomeScreen());
        } else {
          loading = false;
          debugPrint('ERROR STATUS CODE  ${value.statusCode}');
          if (value.data['errors'] != null) {
            Map<String, dynamic> aErrMap = value.data['errors'];
            debugPrint('ORDER ERROR: $aErrMap');
          }
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void getFrameDetailsFromDB() {
    localDBHelper!.getCartList2().then((value) {
      debugPrint('FRAME DB VALUE: $value');
      debugPrint('FRAME LIST SIZE START ::  ${myFrameList.length}');
      if (value.isNotEmpty) {
        myFrameList = [];
        myCartList2 = [];
        for (var val in value) {
          //  FrameModel model = FrameModel();
          CartModel model = CartModel();
          //  model.id = int.parse(val['id'].toString());
          model.productId = int.parse(val['product_id'].toString());
          model.frameId = int.parse(val['frame_id'].toString());
          model.bookId = 0;
          model.addOnId = 0;
          model.lens_type = val['lens_type'];
          model.type = 'FRAME';

          model.frame_name = val['frame_name'];
          model.frame_price = double.parse(val['frame_price'].toString());
          model.frame_qty = int.parse(val['frame_qty'].toString());
          model.frame_total = double.parse(val['frame_total'].toString());

          model.name = '';
          model.lens_type = val['lens_type'];
          model.priscription = val['priscription'];

          model.variantId = 0;
          // model.variantId =val['variant_id'];
          model.productType = '';
          model.variantName = '';
          model.unitPrice = 0.0;

          model.total = 0.0;
          //   model.total =val['total'];
          model.quantity = 0;
          model.imageUrl = '';
          model.inventoryQuantity = 0;
          model.bookQty = 0;
          model.bookPrice = 0.0;
          model.bookTotal = 0.0;
          debugPrint('IMAGE URL  :: ${model.imageUrl}');
          debugPrint('PRICE  :: ${model.unitPrice}');
          debugPrint('TOTAL  :: ${model.total}');
          debugPrint('FRAME NAME  :: ${model.frame_name}');
          debugPrint('VARIANT ID  :: ${model.variantId}');
          debugPrint('CART INVENTORY QUANTITY  :: ${model.inventoryQuantity}');

          model.trialRequestType = '';
          model.clinicName = '';
          model.clientName = '';
          model.mail = '';
          model.mobile = '';
          model.pincode = '';
          model.appointmentTime = '';
          model.appointmentDate = '';
          model.location = '';
          model.addressType = '';
          model.houseNo = '';

          model.rdSph = val['rd_sph'];
          model.rdCyl = val['rd_cyl'];
          model.rdAxis = val['rd_axis'];
          model.rdBcva = val['rd_bcva'];

          model.raSph = val['ra_sph'];
          model.raCyl = val['ra_cyl'];
          model.raAxis = val['ra_axis'];
          model.raBcva = val['ra_bcva'];

          model.ldSph = val['ld_sph'];
          model.ldCyl = val['ld_cyl'];
          model.ldAxis = val['ld_axis'];
          model.ldBcva = val['ld_bcva'];

          model.laSph = val['la_sph'];
          model.laCyl = val['la_cyl'];
          model.laAxis = val['la_axis'];
          model.laBcva = val['la_bcva'];

          model.re = val['re'];
          model.le = val['le'];
          model.addOnTitle = '';
          model.addOnPrice = 0.0;
          model.addOnQty = 0;
          model.addOnTotal = 0.0;

          model.createdAt = val['created_at'];
          model.updatedAt = val['updated_at'];

          // myFrameList.add(model);
          myCartList2.add(model);
          myCartList4.add(model);
          debugPrint('GET LIST FRAME PRICE ::  ${model.frame_price}');
          debugPrint('FRAME LIST SIZE::  ${myFrameList.length}');
        }
      } else {
        // CircularProgressIndicator();
        myFrameList = [];
        myCartList2 = [];
      }
      update();
      myCartList4.sort((a, b) {
        //sorting in ascending order
        return DateTime.parse(b.createdAt.toString())
            .compareTo(DateTime.parse(a.createdAt.toString()));
      });
      loading = false;
      getFrameTotal();
      getAddOnDetails();
      update();
    });
  }

  void getBookAppointmentList2() {
    localDBHelper!.getCartList3().then((value) {
      debugPrint("BOOK APPOINTMENT CART VALUE:: $value");
      if (value.isNotEmpty) {
        debugPrint("BOOK APPOINTMENT CART VALUE:: $value");
        debugPrint("BOOK APPOINTMENT CART SIZE:: ${myBookList.length}");
        myBookList = [];

        for (var data in value) {
          CartModel model = CartModel();
          model.type = 'BOOK';
          model.productId = int.parse(data['product_id'].toString());
          model.frameId = 0;
          model.addOnId = 0;
          // model.productId = 0;
          debugPrint("BOOK PRODUCT ID:: ${model.productId}");
          model.bookId = int.parse(data['book_id'].toString());
          model.productName2 = data['name'];
          model.trialRequestType = data['trial_request_type'];

          if (model.trialRequestType == 'In Home') {
            txtType = 'Ear Audiology Trial At Home Test';
          } else {
            txtType = 'Ear Audiology Trail at Visit Home Test';
          }
          model.clinicName = data['clinic_name'];
          model.clientName = data['client_name'];
          model.mobile = data['mobile'];
          model.pincode = data['pincode'];
          model.mail = data['mail'];
          model.houseNo = data['house_no'];
          model.location = data['location'];
          model.appointmentTime = data['appointment_time'];
          model.appointmentDate = data['appointment_date'];
          model.addressType = data['address_type'];

          model.unitPrice = 0.0;
          model.total = 0.0;
          model.quantity = 1;

          model.bookQty = int.parse(data['book_qty'].toString());
          model.bookPrice = double.parse(data['book_price'].toString());
          model.bookTotal = double.parse(data['book_total'].toString());

          debugPrint('BOOK PRICE  :: ${model.bookPrice}');
          debugPrint('BOOK TOTAL  :: ${model.bookTotal}');
          debugPrint('BOOK ADDRESS TYPE  :: ${model.addressType}');

          model.imageUrl = '';
          model.lens_type = '';
          // model.priscription = data['priscription'];
          model.priscription = '';
          model.frame_name = '';
          model.frame_price = 0.0;
          model.frame_qty = 0;
          model.frame_total = 0.0;

          model.variantId = 0;
          model.productType = '';
          model.variantName = '';

          model.addOnPrice = 0.0;
          model.addOnTitle = '';
          model.addOnQty = 0;
          model.addOnTotal = 0.0;

          model.rdSph = '';
          model.rdCyl = '';
          model.rdAxis = '';
          model.rdBcva = '';

          model.raSph = '';
          model.raCyl = '';
          model.raAxis = '';
          model.raBcva = '';

          model.ldSph = '';
          model.ldCyl = '';
          model.ldAxis = '';
          model.ldBcva = '';

          model.laSph = '';
          model.laCyl = '';
          model.laAxis = '';
          model.laBcva = '';

          model.re = '';
          model.le = '';

          model.createdAt = data['created_at'];
          model.updatedAt = data['updated_at'];

          myBookList.add(model);

          previousDate = DateTime.parse(model.createdAt.toString());
          debugPrint('PREVIOUS DATE :: $previousDate');
          debugPrint('CURRENT  DATE :: $currentDate2');

          //  if(previousDate.isBefore(currentDate2)){
          myCartList4.add(model);
          // }
          //  myCartList4.add(model);

          debugPrint("BOOK TRIAL REQUEST :: ${model.productId}");
          debugPrint("BOOK TRIAL REQUEST :: ${model.trialRequestType}");
          debugPrint("BOOK TRIAL REQUEST :: ${model.pincode}");
          debugPrint("BOOK TRIAL REQUEST :: ${model.pincode}");

          debugPrint("BOOK APPOINTMENT CART SIZE END : ${myBookList.length}");
          debugPrint("BOOK APPOINTMENT CART SIZE END : ${myCartList4.length}");
          debugPrint("BOOK APPOINTMENT CART CREATED TIME : ${model.createdAt}");
          debugPrint("BOOK APPOINTMENT CART UPDATED TIME : ${model.updatedAt}");
        }
        myCartList4.sort((a, b) {
          //sorting in ascending order
          return DateTime.parse(b.createdAt.toString())
              .compareTo(DateTime.parse(a.createdAt.toString()));
        });
      } else {
        //  myBookList = [];
      }
      loading = false;

      getBookTotal();
      update();
    });
  }

  Widget getCartList(BuildContext context) {
    debugPrint("IS LOADING:: $loading");

    if (myCartList4.isEmpty) {
      if (loading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        //return const Center(child: Text('No data'));
        return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("assets/images/no_data_cart.png",
              width: MediaQuery.of(context).size.width * 0.85),
          const SizedBox(height: 10),
          Text('Whoops !! Cart is Empty', style: zzBoldBlackTextStyle14),
          const SizedBox(height: 5),
          Text(
              'Looks like you haven’t added anything to your cart yet.\nGo Home Screen and select desired category',
              style: zzRegularBlackTextStyle13B)
        ]));
      }
    } else {
      return ListView.builder(
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          itemCount: myCartList4.isNotEmpty ? myCartList4.length : 0,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (myCartList4.isEmpty) {
              return const Center(child: Text('No data'));
            } else {
              var model = myCartList4[index];
              debugPrint("TOTAL3:: ${mySum + framePrice2}");
              debugPrint("LIST IMAGE URL:: ${model.imageUrl}");
              debugPrint("LIST PRODUCT ID:: ${model.productId}");
              debugPrint("LIST TYPE:::: ${model.type}");
              debugPrint("LIST AUTO INCREMENT ID :: ${model.id}");
              String lensType2;
              if (model.lens_type == "Bifocal") {
                lensType2 = "Bifocal: ";
              } else if (model.lens_type == "Progressive") {
                lensType2 = "Progressive: ";
              } else {
                lensType2 = "Single Vision: ";
              }

              return Column(children: [
                Visibility(
                  visible: model.type == 'ORDER' ? true : false,
                  //visible: model.type == 'ORDER' && model.productType != 'Frame'? true : false,
                  child: InkWell(
                    onTap: () {
                      String aProductType = model.productType!;
                      debugPrint("CART PRODUCT TYPE (ORDER): $aProductType");
                      debugPrint(
                          "CART PRODUCT TYPE (ORDER) ID: ${model.productId!}");

                      if (aProductType == "Audiology") {
                        Get.to(
                            () => EarDetailScreen(
                                id: model.productId!, fromWhere: 'CART'),
                            arguments: [
                              {"earID": model.productId!, "fromwhere": "CART"}
                            ]);
                      } else {
                        Get.to(() => EyeDetailsScreen(
                              id: model.productId!,
                              fromWhere: 'CART',
                              productHandle: "",
                            ));
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(model.productType.toString()),
                                  PopupMenuButton(
                                    elevation: 7,
                                    padding: EdgeInsets.zero,
                                    offset: const Offset(0, 45),
                                    constraints: const BoxConstraints(),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        showDeleteConfirmDialog(
                                            context, model.productId!, index);
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    itemBuilder: ((context) => [
                                          const PopupMenuItem(
                                              value: 1,
                                              child: Text(
                                                'Delete',
                                              )),
                                        ]),
                                    icon: const Icon(Icons.more_vert_outlined,
                                        color: black),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                            Row(children: [
                              model.imageUrl!.isEmpty
                                  ? Image.asset(
                                      "assets/images/eye_glass.png",
                                      width: 130,
                                      height: 130,
                                    )
                                  : Image.network(
                                      model.imageUrl.toString(),
                                      width: 130,
                                      height: 130,
                                    ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: Text(model.name.toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 11.0),
                                        overflow: TextOverflow.visible,
                                        maxLines: 5),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible:
                                        model.variantName != 'Default Title',
                                    child: Text('Color: ${model.variantName}',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 11.0),
                                        overflow: TextOverflow.visible),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        model.unitPrice.toString(),
                                        style: zzRegularBlackTextStyle10,
                                      ),
                                      SizedBox(
                                        width: 1.0.w,
                                      ),
                                      // Text(
                                      //   "₹1500",
                                      //   style: zzRegularBlackTextStyle10_,
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //const Text("Frame size:medium"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (model.quantity != 1) {
                                            model.quantity =
                                                model.quantity! - 1;
                                          }
                                          update();
                                          localDBHelper!
                                              .updateQuantityOfProductInCart(
                                                  model.quantity!,
                                                  model.productId!,
                                                  model.unitPrice!);
                                          getTotalOfAllProduct();
                                          update();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: lightBlue3
                                              // border: BorderSide(width: 2, color: Colors.black12)
                                              ),
                                          child: Image.asset(
                                            "assets/images/minus.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(model.quantity.toString()),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (model.inventoryQuantity! >
                                              model.quantity!) {
                                            model.quantity =
                                                model.quantity! + 1;
                                          } else {
                                            showErrorSnackBar(context,
                                                'Maximum quantity reached');
                                          }
                                          update();
                                          localDBHelper!
                                              .updateQuantityOfProductInCart(
                                                  model.quantity!,
                                                  model.productId!,
                                                  model.unitPrice!);
                                          getTotalOfAllProduct();
                                          update();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: lightBlue3
                                              // border: BorderSide(width: 2, color: Colors.black12)
                                              ),
                                          child: Image.asset(
                                              "assets/images/plus.png",
                                              width: 10,
                                              height: 10),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ])
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: model.type == 'ADDON' ? true : false,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Add on'),
                                  PopupMenuButton(
                                    elevation: 7,
                                    padding: EdgeInsets.zero,
                                    offset: const Offset(0, 45),
                                    constraints: const BoxConstraints(),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        showDeleteConfirmDialog4(
                                            context, model.addOnId!, index);
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    itemBuilder: ((context) => [
                                          const PopupMenuItem(
                                              value: 1,
                                              child: Text(
                                                'Delete',
                                              )),
                                        ]),
                                    icon: const Icon(Icons.more_vert_outlined,
                                        color: black),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                Image.asset("assets/images/inf_logo_tm.png",
                                    width: 90, height: 130),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(model.addOnTitle!,
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 12.0)),
                                    const SizedBox(height: 10),
                                    Text(model.addOnPrice!.toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 12.0)),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (model.addOnQty != 1) {
                                              model.addOnQty =
                                                  model.addOnQty! - 1;
                                            }
                                            update();
                                            localDBHelper!
                                                .updateQuantityOfProductInCart4(
                                                    model.addOnQty!,
                                                    model.addOnId!,
                                                    model.addOnPrice!,
                                                    model.productId!);
                                            getAddonTotal();
                                            update();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: lightBlue3
                                                // border: BorderSide(width: 2, color: Colors.black12)
                                                ),
                                            child: Image.asset(
                                              "assets/images/minus.png",
                                              width: 10,
                                              height: 10,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(model.addOnQty.toString()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            model.addOnQty =
                                                model.addOnQty! + 1;
                                            update();
                                            localDBHelper!
                                                .updateQuantityOfProductInCart4(
                                                    model.addOnQty!,
                                                    model.addOnId!,
                                                    model.addOnPrice!,
                                                    model.productId!);
                                            getAddonTotal();
                                            update();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: lightBlue3
                                                // border: BorderSide(width: 2, color: Colors.black12)
                                                ),
                                            child: Image.asset(
                                                "assets/images/plus.png",
                                                width: 10,
                                                height: 10),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
                Visibility(
                  // visible: model.type == 'ORDER' && model.frame_name != ''
                  visible: model.type == 'FRAME' ? true : false,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: PopupMenuButton(
                                elevation: 7,
                                padding: EdgeInsets.zero,
                                offset: const Offset(0, 45),
                                constraints: const BoxConstraints(),
                                onSelected: (value) {
                                  if (value == 1) {
                                    showDeleteConfirmDialog2(
                                        context, model.frameId!, index);
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                itemBuilder: ((context) => [
                                      const PopupMenuItem(
                                          value: 1,
                                          child: Text(
                                            'Delete',
                                          )),
                                    ]),
                                icon: const Icon(Icons.more_vert_outlined,
                                    color: black),
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/inf_logo_tm.png",
                                    width: 90, height: 130),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //model.frame_name!
                                    Text(model.frame_name.toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 12.0)),
                                    const SizedBox(height: 10),
                                    Text(model.frame_price.toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 12.0)),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (model.frame_qty != 1) {
                                              model.frame_qty =
                                                  model.frame_qty! - 1;
                                            }
                                            update();
                                            localDBHelper!
                                                .updateQuantityOfProductInCart2(
                                                    model.frame_qty!,
                                                    model.frameId!,
                                                    model.frame_price!,
                                                    model.productId!);
                                            getFrameTotal();
                                            update();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: lightBlue3
                                                // border: BorderSide(width: 2, color: Colors.black12)
                                                ),
                                            child: Image.asset(
                                              "assets/images/minus.png",
                                              width: 10,
                                              height: 10,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(model.frame_qty.toString()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // if(model.inventoryQuantity! > model.quantity!){
                                            model.frame_qty =
                                                model.frame_qty! + 1;
                                            update();
                                            // }
                                            // else{
                                            //   showErrorSnackBar(context,'Maximum quantity reached');
                                            // }
                                            localDBHelper!
                                                .updateQuantityOfProductInCart2(
                                                    model.frame_qty!,
                                                    model.frameId!,
                                                    model.frame_price!,
                                                    model.productId!);
                                            // ).then((value){
                                            getFrameTotal();
                                            //  });
                                            update();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: lightBlue3
                                                // border: BorderSide(width: 2, color: Colors.black12)
                                                ),
                                            child: Image.asset(
                                                "assets/images/plus.png",
                                                width: 10,
                                                height: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {
                                        moreInfo = !moreInfo;
                                        debugPrint('MORE INFO: $moreInfo');

                                        showModalBottomSheet(
                                            isDismissible: true,
                                            backgroundColor: loginBlue,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                topRight: Radius.circular(20.0),
                                              ),
                                            ),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (BuildContext builder) {
                                              return Container(
                                                // margin: EdgeInsets.all(20),
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16.0))),
                                                // color: Colors.green,
                                                // height: 100,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                          height: 20),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            'Lens Type:  ${model.lens_type}',
                                                            style: GoogleFonts.lato(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black54,
                                                                fontSize:
                                                                    13.0)),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Text(
                                                          'Right Eye Distance SPH $lensType2 ${model.rdSph!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Right Eye Distance CYL $lensType2 ${model.rdCyl!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Right Eye Distance AXIS $lensType2 ${model.rdAxis!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Right Eye Distance BCVA $lensType2 ${model.rdBcva!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Right Eye Add SPH $lensType2 ${model.raSph!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Right Eye Add CYL $lensType2 ${model.raCyl!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Right Eye Add AXIS $lensType2 ${model.raAxis!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Right Eye Add BCVA $lensType2 ${model.raBcva!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Left Eye Distance SPH $lensType2 ${model.ldSph!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Left Eye Distance CYL $lensType2 ${model.ldCyl!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Left Eye Distance AXIS $lensType2 ${model.ldAxis!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Left Eye Distance BCVA $lensType2 ${model.ldBcva!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Left Eye Add SPH $lensType2 ${model.laSph!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Left Eye Add CYL $lensType2 ${model.laCyl!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Left Eye Add AXIS $lensType2 ${model.laAxis!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'Left Eye Add BCVA $lensType2 ${model.laBcva!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'PD Right Eye $lensType2 ${model.re!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                          'PD Left Eye $lensType2 ${model.le!}',
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12.0)),
                                                      const SizedBox(
                                                          height: 20),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                        update();
                                      },
                                      child: Row(
                                        children: [
                                          Text('more info ',
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                  fontSize: 12.0)),
                                          const Icon(Icons.add,
                                              color: Colors.black, size: 14)
                                          //  moreInfo==false?Icons.add:Icons.minimize_rounded,color: Colors.black,size: 14)
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
                Visibility(
                    visible: model.type == 'BOOK' ? true : false,
                    child: InkWell(
                      onTap: () {
                        String aProductType = model.productType!;
                        debugPrint("CART PRODUCT TYPE (BOOK): $aProductType");
                        debugPrint(
                            "CART PRODUCT TYPE (BOOK) ID: ${model.productId!}");
                        if (aProductType == "Audiology") {
                          Get.to(
                              () => EarDetailScreen(
                                  id: model.productId!, fromWhere: 'CART'),
                              arguments: [
                                {"earID": model.productId!, "fromwhere": "Cart"}
                              ]);
                        } else {
                          Get.to(() => EyeDetailsScreen(
                                id: model.productId!,
                                fromWhere: 'CART',
                                productHandle: "",
                              ));
                        }
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp)),
                          margin: EdgeInsets.only(
                              left: 20.sp,
                              right: 20.sp,
                              top: 10.sp,
                              bottom: 10.sp),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20.sp, 0, 20.sp, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(model.trialRequestType == 'In Home'
                                          ? 'Ear Audiology Trial At Home Test'
                                          : model.trialRequestType ==
                                                  'Visit clinic'
                                              ? 'Ear Audiology Trial at Visit Clinic Test'
                                              : ''),
                                      PopupMenuButton(
                                        elevation: 7,
                                        padding: EdgeInsets.zero,
                                        offset: const Offset(0, 45),
                                        constraints: const BoxConstraints(),
                                        onSelected: (value) {
                                          if (value == 1) {
                                            showDeleteConfirmDialog3(
                                                context, model.bookId!, index);
                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        itemBuilder: ((context) => [
                                              const PopupMenuItem(
                                                  value: 1,
                                                  child: Text(
                                                    'Delete',
                                                  )),
                                            ]),
                                        icon: const Icon(
                                            Icons.more_vert_outlined,
                                            color: black),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black12,
                                    thickness: 1,
                                  ),
                                  Text(
                                      'Trial Request Type: ${model.trialRequestType!}',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12.0)),
                                  const SizedBox(height: 10),
                                  Text('Product Name: ${model.productName2}',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12.0)),
                                  const SizedBox(height: 10),

                                  // Text(
                                  //     'Total: ${(model.bookQty! * model.bookPrice!).toStringAsFixed(2)}',
                                  //     style: GoogleFonts.lato(
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.black54,
                                  //         fontSize: 12.0)),
                                  // const SizedBox(height: 10),

                                  Visibility(
                                    visible: model.trialRequestType == 'In Home'
                                        ? false
                                        : true,
                                    child: Text(
                                        'Clinic Name: ${model.clinicName!}',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 12.0)),
                                  ),
                                  Visibility(
                                      visible:
                                          model.trialRequestType == 'In Home'
                                              ? false
                                              : true,
                                      child: const SizedBox(height: 10)),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (model.bookQty != 1) {
                                            model.bookQty = model.bookQty! - 1;
                                          }
                                          update();
                                          localDBHelper!
                                              .updateQuantityOfProductInCart3(
                                                  model.bookQty!,
                                                  model.bookId!,
                                                  model.bookPrice!,
                                                  model.productId!);
                                          getBookTotal();
                                          update();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: lightBlue3
                                              // border: BorderSide(width: 2, color: Colors.black12)
                                              ),
                                          child: Image.asset(
                                            "assets/images/minus.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(model.bookQty.toString()),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          model.bookQty = model.bookQty! + 1;
                                          update();
                                          localDBHelper!
                                              .updateQuantityOfProductInCart3(
                                                  model.bookQty!,
                                                  model.bookId!,
                                                  model.bookPrice!,
                                                  model.productId!);
                                          getBookTotal();
                                          update();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: lightBlue3
                                              // border: BorderSide(width: 2, color: Colors.black12)
                                              ),
                                          child: Image.asset(
                                              "assets/images/plus.png",
                                              width: 10,
                                              height: 10),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Text('Client Name: ${model.clientName!}',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12.0)),
                                  const SizedBox(height: 10),
                                  Text('Mobile: ${model.mobile!}',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12.0)),
                                  const SizedBox(height: 10),
                                  Text('Mail: ${model.mail}',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12.0)),
                                  const SizedBox(height: 10),
                                  Visibility(
                                    visible: model.trialRequestType == 'In Home'
                                        ? true
                                        : false,
                                    child: Text('House No: ${model.houseNo}',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 12.0)),
                                  ),
                                  Visibility(
                                      visible:
                                          model.trialRequestType == 'In Home'
                                              ? true
                                              : false,
                                      child: const SizedBox(height: 10)),
                                  Visibility(
                                    visible: model.trialRequestType == 'In Home'
                                        ? true
                                        : false,
                                    child: Text('Location: ${model.location}',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 12.0)),
                                  ),
                                  Visibility(
                                      visible:
                                          model.trialRequestType == 'In Home'
                                              ? true
                                              : false,
                                      child: const SizedBox(height: 10)),
                                  Visibility(
                                    visible: model.trialRequestType == 'In Home'
                                        ? true
                                        : false,
                                    child: Text('Pincode: ${model.pincode}',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 12.0)),
                                  ),
                                  Visibility(
                                      visible:
                                          model.trialRequestType == 'In Home'
                                              ? true
                                              : false,
                                      child: const SizedBox(height: 10)),
                                  Visibility(
                                    visible: model.trialRequestType == 'In Home'
                                        ? true
                                        : false,
                                    child: Text(
                                        'Address Type: ${model.addressType}',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 12.0)),
                                  ),
                                  Visibility(
                                      visible:
                                          model.trialRequestType == 'In Home'
                                              ? true
                                              : false,
                                      child: const SizedBox(height: 10)),
                                  Text(
                                      'Appointment Date: ${model.appointmentDate}',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12.0)),
                                  const SizedBox(height: 10),
                                  Text(
                                      'Appointment Time: ${model.appointmentTime}',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12.0)),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          )),
                    ))
              ]);
            }
          });
    }
  }
}
