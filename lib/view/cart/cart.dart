import 'package:get/get.dart';
import 'package:infinite/control/cart_controller/cart_controller.dart';
import 'package:infinite/utils/packeages.dart';
import 'package:infinite/view/home/oral_care/oralcare_detail.dart';
import 'package:infinite/view/home/skin_care/skincare_detail.dart';
import 'package:infinite/view/home/sleep_care/sleep_details.dart';
import 'package:infinite/widgets/cart_icon.dart';

import '../../control/home_controller/home_controller.dart';

class Cart extends StatefulWidget {
  final int? fromWhere;
  final int? fromBook;
  final double? framePrice;
  final String? lensType;
  final int? productId;
  final String? routeType;
  final String productHandle;
  final String? productTitle;
  final String? relation;

  const Cart({
    this.fromWhere,
    this.framePrice,
    this.lensType,
    this.fromBook,
    this.productId,
    this.routeType,
    this.productTitle,
    required this.productHandle,
    this.relation,
    Key? key,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
  bool isShipping = true;
  String productTitle = "";

  int? orderCount;
  int? frameCount;
  int? bookCount;
  int? addOnCount;
  int totalCount = 0;
  final homeCtrl = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());

  BadgeController badgeController = BadgeController();

  String? firstName, lastName, country, city, address1, address2, phone, zip;
  String? billingFirstName,
      billingLastName,
      billingCountry,
      billingCity,
      billingAddress1,
      billingAddress2,
      billingPhone,
      billingzip;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    myMail = sharedPreferences!.getString("mail") ?? "";
    myFirstName = sharedPreferences!.getString("firstName") ?? "";
    myLastName = sharedPreferences!.getString("lastName") ?? "";
    myMobile = sharedPreferences!.getString("mobileNumber") ?? "";
    print("saranya1111111${widget.relation}");

    createCheckout();
    loading = true;
    getFromDB1();
    getFrameDetailsFromDB();
    getBookAppointmentList2();
  }

  void createCheckout() {
    try {
      String aMail = sharedPreferences!.getString("mail").toString();
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
      secondMap['email'] = aMail;
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
      if (mounted) {
        setState(() {
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
              debugPrint(
                  'CART INVENTORY QUANTITY  :: ${model.inventoryQuantity}');

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
            // myCartList4.sort((a, b) {
            //   //sorting in ascending order
            //   return DateTime.parse(b.createdAt.toString())
            //       .compareTo(DateTime.parse(a.createdAt.toString()));
            // });
          }
          loading = false;
        });

        getTotalOfAllProduct();
        //  getAddOnDetails();
      }
    });
  }

  void getAddOnDetails() {
    debugPrint('FROM DB 4 .....');
    localDBHelper!.getCartList4().then((value) {
      if (mounted) {
        setState(() {
          debugPrint('FROM DB 4 VALUE .. $value');
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
        });

        getAddonTotal();
      }
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
        if (mounted) {
          setState(() {
            if (value == null || value.toString().isEmpty) {
              addOnPrice = 0.0;
              debugPrint('SUB ADD ON TOTAL IF  ::: $addOnPrice');
            } else {
              addOnPrice = double.parse(value.toString());

              debugPrint('SUB ADD ON TOTAL  ELSE  ::: $addOnPrice');
            }
          });
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void getTotalOfAllProduct() {
    try {
      localDBHelper!.getTotal().then((value) {
        debugPrint('Havish ::: $value');
        if (mounted) {
          setState(() {
            if (value == null || value.toString().isEmpty) {
              mySum = 0.0;
              debugPrint('SUB TOTAL IF  ::: $mySum');
            } else {
              mySum = double.parse(value.toString());
              print('SUB TOTAL  ELSE  ::: $mySum');
            }
          });
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void getBookTotal() {
    try {
      localDBHelper!.getTotal3().then((value) {
        debugPrint('TOTAL VALUE ::: $value');
        if (mounted) {
          setState(() {
            if (value == null || value.toString().isEmpty) {
              myBookTotal = 0.0;
              debugPrint('BOOK TOTAL  ::: $myBookTotal');
            } else {
              myBookTotal = double.parse(value.toString());
              debugPrint('BOOK TOTAL   ::: $myBookTotal');
            }
          });
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void getFrameTotal() {
    try {
      localDBHelper!.getTotal2().then((value) {
        debugPrint('FRAME TOTAL VALUE ::: $value');
        if (mounted) {
          setState(() {
            if (value == null || value.toString().isEmpty) {
              framePrice2 = 0.0;
              debugPrint('SUB FRAME TOTAL IF  ::: $framePrice2');
            } else {
              framePrice2 = double.parse(value.toString());

              debugPrint('SUB FRAME TOTAL  ELSE  ::: $framePrice2');
            }
          });
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  Widget buildShippingAddressForm(CartController ctrl) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: ctrl.countryController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Country/Region',
                  labelText: 'Country/Region',
                  counterText: '',
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: ctrl.firstNameController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'First name',
                  labelText: 'First name',
                  counterText: '',
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: ctrl.lastNameController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Last name',
                  labelText: 'last name',
                  counterText: '',
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: ctrl.addressController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Address',
                  labelText: 'Address',
                  counterText: '',
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: ctrl.appartmentController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Appartment.suite.etc(optional)',
                  labelText: 'Appartment.suite.etc(optional)',
                  counterText: '',
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: ctrl.cityController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'City',
                  labelText: 'City',
                  counterText: '',
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: ctrl.pinController,
                keyboardType: TextInputType.number,
                maxLength: 50,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Pincode',
                  labelText: 'Pincode',
                  counterText: '',
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: ctrl.mobileController,
                keyboardType: TextInputType.number,
                maxLength: 50,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Mobile No',
                  labelText: 'Mobile No',
                  counterText: '',
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: isShipping,
                  onChanged: (bool? newValue) {
                    setState(() {
                      isShipping = newValue ?? false;
                      Navigator.pop(context);
                      _showShippingAddressBottomSheet(context, ctrl);
                    });
                  },
                ),
                Flexible(
                  child: Text('Use shipping address as billing address',
                      maxLines: 2, style: zzRegularBlackTextStyle12),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !isShipping,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Billing Address",
                    style: zzBoldBlueDarkTextStyle14,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: ctrl.billingCountryController,
                      keyboardType: TextInputType.text,
                      maxLength: 50,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Country/Region',
                        labelText: 'Country/Region',
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: ctrl.billingFirstNameController,
                      keyboardType: TextInputType.text,
                      maxLength: 50,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'First name',
                        labelText: 'First name',
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: ctrl.billingLastNameController,
                      keyboardType: TextInputType.text,
                      maxLength: 50,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Last name',
                        labelText: 'last name',
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: ctrl.billingAddressController,
                      keyboardType: TextInputType.text,
                      maxLength: 50,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Address',
                        labelText: 'Address',
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: ctrl.billingAppartmentController,
                      keyboardType: TextInputType.text,
                      maxLength: 50,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Appartment.suite.etc(optional)',
                        labelText: 'Appartment.suite.etc(optional)',
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: ctrl.billingCityController,
                      keyboardType: TextInputType.text,
                      maxLength: 50,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'City',
                        labelText: 'City',
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: ctrl.billingPinController,
                      keyboardType: TextInputType.number,
                      maxLength: 50,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Pincode',
                        labelText: 'Pincode',
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: ctrl.billingMobileController,
                      keyboardType: TextInputType.number,
                      maxLength: 50,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Mobile No',
                        labelText: 'Mobile No',
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Future<int?> statusCode =
                      ctrl.updateShippingAddress(ctrl.shippingAddressID!);
                  int? code = await statusCode;
                  if (code == 200) {
                    firstName = ctrl.firstNameController.text;
                    lastName = ctrl.lastNameController.text;
                    country = ctrl.countryController.text;
                    city = ctrl.cityController.text;
                    address1 = ctrl.addressController.text;
                    address2 = ctrl.appartmentController.text;
                    phone = ctrl.mobileController.text;
                    zip = ctrl.pinController.text;
                    if (isShipping) {
                      billingFirstName = ctrl.firstNameController.text;
                      billingLastName = ctrl.lastNameController.text;
                      billingCountry = ctrl.countryController.text;
                      billingCity = ctrl.cityController.text;
                      billingAddress1 = ctrl.addressController.text;
                      billingAddress2 = ctrl.appartmentController.text;
                      billingPhone = ctrl.mobileController.text;
                      billingzip = ctrl.pinController.text;
                    } else {
                      billingFirstName = ctrl.billingFirstNameController.text;
                      billingLastName = ctrl.billingLastNameController.text;
                      billingCountry = ctrl.billingCountryController.text;
                      billingCity = ctrl.billingCityController.text;
                      billingAddress1 = ctrl.billingAddressController.text;
                      billingAddress2 = ctrl.billingAppartmentController.text;
                      billingPhone = ctrl.billingMobileController.text;
                      billingzip = ctrl.billingMobileController.text;
                    }

                    openPaymentGateway();
                  } else {
                    print("Failed to update shipping address");
                  }
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: loginTextColor),
                child: const Text(
                  "Pay now",
                  style: TextStyle(color: white, fontSize: 16),
                )),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (cartCtrl) {
          return WillPopScope(
            onWillPop: () {
              homeCtrl.update();

              if (widget.routeType == "eye") {
                Get.off(EyeDetailsScreen(
                  id: widget.productId!,
                  productHandle: "",
                ));
              } else if (widget.routeType == "ear" ||
                  widget.routeType == "trial_request") {
                Get.off(EarDetailScreen(
                  id: widget.productId,
                ));
              } else if (widget.routeType == "sleep") {
                Get.off(SleepDetailScreen(
                  id: widget.productId,
                ));
              } else if (widget.routeType == "oral") {
                Get.off(OralDetailScreen(
                  id: widget.productId,
                ));
              } else if (widget.routeType == "skin") {
                Get.off(SkinDetailScreen(
                  id: widget.productId,
                ));
              } else if (widget.routeType == "product") {
                Get.off(ViewProductListScreen(
                  widget.productId,
                  handle: widget.productHandle,
                ));
              } else {
                Get.off(const HomeScreen(
                  index: 1,
                ));
              }

              cartCtrl.update();
              badgeController.applyCartCount();
              // Get.back();
              return Future.value(true);
            },
            child: SafeArea(
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  endDrawer: const NavigationWidget(),
                  appBar: AppBar(
                    backgroundColor: loginTextColor,
                    title: Text(
                      "Cart",
                      style: zzRegularWhiteAppBarTextStyle14,
                    ),
                    leading: InkWell(
                      onTap: () {
                        homeCtrl.update();

                        if (widget.routeType == "eye") {
                          Get.off(EyeDetailsScreen(
                            id: widget.productId!,
                            productHandle: "",
                          ));
                        } else if (widget.routeType == "ear" ||
                            widget.routeType == "trial_request") {
                          Get.off(EarDetailScreen(
                            id: widget.productId,
                          ));
                        } else if (widget.routeType == "sleep") {
                          Get.off(SleepDetailScreen(
                            id: widget.productId,
                          ));
                        } else if (widget.routeType == "oral") {
                          Get.off(OralDetailScreen(
                            id: widget.productId,
                          ));
                        } else if (widget.routeType == "skin") {
                          Get.off(SkinDetailScreen(
                            id: widget.productId,
                          ));
                        } else if (widget.routeType == "product") {
                          Get.off(ViewProductListScreen(
                            widget.productId,
                            handle: widget.productHandle,
                          ));
                        } else {
                          Get.off(const HomeScreen(
                            index: 1,
                          ));
                        }
                        cartCtrl.update();
                        badgeController.applyCartCount();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 28.0,
                      ),
                    ),
                    actions: <Widget>[
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
                      ), //IconButton
                    ], //
                  ),
                  body: loading
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
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(child: getCartList()),
                            Visibility(
                              visible: myCartList4.isNotEmpty,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 5, right: 2),
                                  decoration: const BoxDecoration(
                                      color: lightBlue,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0))),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Subtotal: ",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize:
                                                                      12)),
                                                      Text(
                                                          (mySum +
                                                                  framePrice2 +
                                                                  myBookTotal +
                                                                  addOnPrice)
                                                              .toStringAsFixed(
                                                                  2),
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize:
                                                                      12)),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Delivery is FREE on your order. ",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 12),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    if ((mySum +
                                                                framePrice2 +
                                                                myBookTotal +
                                                                addOnPrice)
                                                            .toStringAsFixed(
                                                                2) ==
                                                        "0.00") {
                                                      addOrderToCloud();
                                                      showWithoutPaymentDialog(
                                                          context);
                                                    } else {
                                                      _showShippingAddressBottomSheet(
                                                          context, cartCtrl);
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              loginTextColor),
                                                  child: const Text(
                                                    "Proceed to Checkout",
                                                    style:
                                                        TextStyle(color: white),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
            ),
          );
        });
  }

  void _showShippingAddressBottomSheet(
      BuildContext context, CartController cartCtrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delivery',
            style: TextStyle(color: loginTextColor),
          ),
          content: SingleChildScrollView(
            child: buildShippingAddressForm(cartCtrl),
          ),
        );
      },
    );
  }

  void openPaymentGateway() {
    try {
      Map<String, dynamic> orderMap = <String, dynamic>{};
      orderMap['amount'] = (mySum + framePrice2 + myBookTotal + addOnPrice);
      orderMap['currency'] = "INR";

      openRazorCheckout();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void openRazorCheckout() {
    try {
      var options = {
        "enable": "1",
        'key': EndPoints.myRazorpayKey,
        "razor_secret": EndPoints.myRazorpaySecret,
        'amount': (mySum + framePrice2 + myBookTotal + addOnPrice) * 100,
        'name': 'Infinite',
        "currency": "INR",
        "theme.color": "#2E478D",
        'description': '',
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

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
     */
    debugPrint(
        'SHOW CART PAGE RAZORPAY PAYMENT ERROR: ${response.error} CODE: ${response.code} MESSAGE: ${response.message}');
    showPaymentErrorDialog(
        context, "Payment Failed", "${response.message}", 'cancel');
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
     */
    debugPrint(
        'SHOW CART PAGE RAZORPAY PAYMENT SUCCESS: $response PAYMENT ID: ${response.paymentId} SIGNATURE ID: ${response.signature} ORDER ID: ${response.orderId}');
    DioClient(
            myUrl: "https://api.razorpay.com/v1/payments/${response.paymentId}")
        .getForPayment()
        .then((value) {
      debugPrint("SHOW CART PAGE RAZORPAY PAYMENT SUCCESS PAYMENT 1: $value");
      debugPrint(
          "SHOW CART PAGE RAZORPAY PAYMENT SUCCESS PAYMENT 2: ${value.statusCode}");
    });
    addOrderToCloud();
    showPaymentErrorDialog(
        context, "Payment Successful", "${response.paymentId}", 'success');
    // showSuccessSnackBar(context, "Payment Successful..!");
    // addOrderToCloud();
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    debugPrint(
        'SHOW CART PAGE RAZORPAY PAYMENT WALLET: $response WALLET NAME: ${response.walletName}');
    showPaymentErrorDialog(context, "External Wallet Selected",
        "${response.walletName}", 'wallet');
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
                if (mounted) {
                  setState(() {
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
                  });
                }
                badgeController.applyCartCount();

                // addOrderToCloud();
                Get.off(() => const HomeScreen(index: 0));
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

  void showWithoutPaymentDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "",
        style: zzBoldBlackTextStyle12,
      ),
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      actions: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/gif/checkCircle.gif"),
              Text(
                "Order Successful!",
                style: zzBoldBlackTextStyle14,
              ),
              SizedBox(height: 3.5.sp),
              const SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    backgroundColor: loginTextColor,
                  ),
                  onPressed: () {
                    Get.back();
                    if (mounted) {
                      setState(() {
                        if (myCartList1.isNotEmpty) {
                          for (int a = 0; a < myCartList1.length; a++) {
                            localDBHelper!
                                .deleteCart(myCartList1[a].productId!);
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
                            localDBHelper!
                                .deleteCart4(myAddOnCartList[a].addOnId!);
                          }
                        }
                      });

                      badgeController.applyCartCount();

                      // addOrderToCloud();
                      Get.off(() => const HomeScreen(index: 0));
                    }
                  },
                  child: Text(
                    "Go to Home",
                    style: zzRegularWhiteTextStyle12,
                  ),
                ),
              ),
            ],
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
  void addOrderToCloud() {
    try {
      int? customerId = sharedPreferences!.getInt("id");

      Map<String, dynamic> postMap = {
        'email': sharedPreferences!.getString('mail'),
        'billing_address': {
          'first_name': billingFirstName,
          'last_name': billingLastName,
          'country': billingCountry,
          'city': billingCity,
          'address1': billingAddress1,
          'address2': billingAddress2,
          'phone': billingPhone,
          'zip': billingzip,
        },
        'shipping_address': {
          'first_name': firstName,
          'last_name': lastName,
          'country': country,
          'city': city,
          'address1': address1,
          'address2': address2,
          'phone': phone,
          'zip': zip,
        },
        'customer_id': customerId,
        'send_receipt': true,
      };

      // Map<String, dynamic> postMap = {
      //   'email': sharedPreferences!.getString('mail'),
      // };

      List<Map<String, dynamic>> itemList = [];

      for (int i = 0; i < myCartList4.length; i++) {
        debugPrint(myCartList4[i].type!.toString());
        debugPrint(myCartList4[i].bookPrice!.toString());
        print('Havish1');
        print(myCartList4[i].type);
        var map = <String, dynamic>{};
        if (myCartList4[i].type == "BOOK") {
          map['product_id'] = myCartList4[i].productId;
          map['variant_id'] = myCartList4[i].variantId;
          map['quantity'] = myCartList4[i].quantity;
          map['price'] = myCartList4[i].bookPrice;
          map['name'] = myCartList4[i].trialRequestType! == "In Home"
              ? "Trial Request In Home"
              : "Trial Request Visit Store";
          map['title'] = myCartList4[i].trialRequestType! == "In Home"
              ? "Trial Request In Home"
              : "Trial Request Visit Store";
          print('saranayaaaaaa ${myCartList4[i].relation}');
          List<Map<String, dynamic>> properties = [
            {
              "name": "Trial request Type Store",
              "value": myCartList4[i].trialRequestType == "In Home"
                  ? "In Home"
                  : "Store"
            },
            {"name": "Product Name", "value": myCartList4[i].productName2},
            {"name": "Clinic Name", "value": myCartList4[i].clinicName},
            {
              "name": "Relationship Client Type",
              "value":
                  myCartList4[i].relation == "0" ? "" : myCartList4[i].relation
            },
            // {
            //   "name": "Relationship Client Other",
            //   "value":
            //       myCartList4[i].relation == "0" ? "" : myCartList4[i].relation
            // },
            {"name": "Client Name", "value": myCartList4[i].clientName},
            {"name": "Client Mobile", "value": myCartList4[i].mobile},
            {"name": "Client Email", "value": myCartList4[i].mail},
            {"name": "House No", "value": myCartList4[i].houseNo},
            {"name": "Location", "value": myCartList4[i].location},
            {"name": "Pincode", "value": myCartList4[i].pincode},
            {"name": "Address Type", "value": myCartList4[i].addressType},
            {
              "name": "Client Appointment Date",
              "value": myCartList4[i].appointmentDate!
            },
            {
              "name": "Client Appointment Time",
              "value": myCartList4[i].appointmentTime
            }
          ];
          map['properties'] = properties;
          itemList.add(map);
        } else if (myCartList4[i].type == "ORDER") {
          map['product_id'] = myCartList4[i].productId;
          map['variant_id'] = myCartList4[i].variantId;
          map['quantity'] = myCartList4[i].quantity;
          map['price'] = myCartList4[i].unitPrice;
          map['name'] = myCartList4[i].name;
          map['title'] = myCartList4[i].name;
          map['requires_shipping'] = true;

          if (myCartList4[i].variantName == "Rent") {
            List<Map<String, dynamic>> properties = [
              {"name": "Type", "value": myCartList4[i].variantName},
              {"name": "Start Date", "value": myCartList4[i].createdAt},
              {"name": "End Date", "value": myCartList4[i].updatedAt},
            ];
            map['properties'] = properties;
          }

          itemList.add(map);
        } else if (myCartList4[i].type == "ADDON") {
          map['product_id'] = myCartList4[i].addOnId;
          map['quantity'] = myCartList4[i].addOnQty;
          map['price'] = myCartList4[i].addOnPrice;
          map['name'] = myCartList4[i].addOnTitle;
          map['title'] = myCartList4[i].addOnTitle;
          map['requires_shipping'] = true;
          itemList.add(map);
        } else {
          map['product_id'] = myCartList4[i].frameId;
          map['quantity'] = myCartList4[i].frame_qty;
          map['price'] = myCartList4[i].frame_price;
          map['name'] = myCartList4[i].frame_name;
          map['title'] = myCartList4[i].frame_name;
          map['requires_shipping'] = true;
          List<Map<String, dynamic>> properties = [
            {"name": "Lens Type", "value": myCartList4[i].lens_type},
            {"name": "Product Name", "value": myCartList4[i].product_title},
            {
              "name": "Right Eye Distance SPH Vision",
              "value": myCartList4[i].rdSph
            },
            {
              "name": "Right Eye Distance CYL Vision",
              "value": myCartList4[i].rdCyl
            },
            {
              "name": "Right Eye Distance AXIS Vision",
              "value": myCartList4[i].rdAxis
            },
            {
              "name": "Right Eye Distance BCVA Vision",
              "value": myCartList4[i].rdBcva
            },
            {"name": "Right Eye Add SPH Vision", "value": myCartList4[i].raSph},
            {"name": "Right Eye Add CYL Vision", "value": myCartList4[i].raCyl},
            {
              "name": "Right Eye Add AXIS Vision",
              "value": myCartList4[i].raAxis
            },
            {
              "name": "Right Eye Add BCVA Vision",
              "value": myCartList4[i].raBcva
            },
            {
              "name": "Left Eye Distance SPH Vision",
              "value": myCartList4[i].laSph
            },
            {
              "name": "Left Eye Distance CYL Vision",
              "value": myCartList4[i].laCyl
            },
            {
              "name": "Left Eye Distance AXIS Vision",
              "value": myCartList4[i].laAxis
            },
            {
              "name": "Left Eye Distance BCVA Vision",
              "value": myCartList4[i].laBcva
            },
            {"name": "Left Eye Add SPH Vision", "value": myCartList4[i].laSph},
            {"name": "Left Eye Add CYL Vision", "value": myCartList4[i].laCyl},
            {
              "name": "Left Eye Add AXIS Vision",
              "value": myCartList4[i].laAxis
            },
            {
              "name": "Left Eye Add BCVA Vision",
              "value": myCartList4[i].laBcva
            },
            {"name": "PD Right Eye Vision", "value": myCartList4[i].re},
            {"name": "PD Left Eye Vision", "value": myCartList4[i].le},
            // {"name": "Prescription File", "value": "URL here"},
          ];
          map['properties'] = properties;

          itemList.add(map);
          print(itemList);
        }

        // Print the values for verification
        print('Product ID: ${map['product_id']}');
        print('Variant ID: ${map['variant_id']}');
        print('Quantity: ${map['quantity']}');
        print('Price: ${map['price']}');
        print('Name: ${map['name']}');
        print('Title: ${map['title']}');
      }

      postMap['line_items'] = itemList;
      debugPrint('CART CHECKOUT POST :$itemList');
      debugPrint('CART CHECKOUT POST :$postMap');

      Map<String, dynamic> orderMap = {'order': postMap};
      debugPrint('CART CHECKOUT POST :$orderMap');

      loading = true;
      if (itemList.isNotEmpty) {
        placeOrder(orderMap, context);
      } else {}
    } catch (e) {
      debugPrint("$e");
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
                        badgeController.applyCartCount();
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
                        badgeController.applyCartCount();
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
                        badgeController.applyCartCount();
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
                        badgeController.applyCartCount();
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
      DioClient(myUrl: EndPoints.createOrder, myMap: data).post().then((value) {
        debugPrint('PLACE ORDER URL: ${EndPoints.createOrder}');
        debugPrint('PLACE ORDER: $value');
        debugPrint('ORDER STATUS CODE  ${value.statusCode}');
        if (value.statusCode == 201) {
          showSuccessSnackBar(context, "Order placed successfully");
          setState(() {
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
            badgeController.applyCartCount();
          });
        } else {
          if (mounted) {
            setState(() => loading = false);
          }
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
      if (mounted) {
        setState(() {
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
              model.product_title = val['product_title'];
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
              debugPrint(
                  'CART INVENTORY QUANTITY  :: ${model.inventoryQuantity}');

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
          myCartList4.sort((a, b) {
            //sorting in ascending order
            return DateTime.parse(b.createdAt.toString())
                .compareTo(DateTime.parse(a.createdAt.toString()));
          });
          loading = false;
        });
        getFrameTotal();
        getAddOnDetails();
      }
    });
  }

  void getBookAppointmentList2() {
    localDBHelper!.getCartList3().then((value) {
      debugPrint("BOOK APPOINTMENT CART VALUE:: $value");
      if (mounted) {
        setState(() {
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
                txtType = 'Ear Audiology Visit Home Test';
              }
              model.clinicName = data['clinic_name'];
              model.clientName = data['client_name'];
              model.relation = data['relation'];
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
              model.product_title = "";
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

              debugPrint(
                  "BOOK APPOINTMENT CART SIZE END : ${myBookList.length}");
              debugPrint(
                  "BOOK APPOINTMENT CART SIZE END : ${myCartList4.length}");
              debugPrint(
                  "BOOK APPOINTMENT CART CREATED TIME : ${model.createdAt}");
              debugPrint(
                  "BOOK APPOINTMENT CART UPDATED TIME : ${model.updatedAt}");
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
        });

        getBookTotal();
      }
    });
  }

  Widget getCartList() {
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
              print(mySum);
              print(framePrice2);
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
                                    child: Text('Type: ${model.variantName}',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 11.0),
                                        overflow: TextOverflow.visible),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  model.variantName == "Rent"
                                      ? Text('Start Date: ${model.createdAt}',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 11.0),
                                          overflow: TextOverflow.visible)
                                      : const SizedBox(),
                                  model.variantName == "Rent"
                                      ? const SizedBox(
                                          height: 10,
                                        )
                                      : const SizedBox(),
                                  model.variantName == "Rent"
                                      ? Text('End Date: ${model.updatedAt}',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 11.0),
                                          overflow: TextOverflow.visible)
                                      : const SizedBox(),
                                  model.variantName == "Rent"
                                      ? const SizedBox(
                                          height: 10,
                                        )
                                      : const SizedBox(),
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

                                  //const Text("Frame size:medium"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (mounted) {
                                            setState(() {
                                              if (model.quantity != 1) {
                                                model.quantity =
                                                    model.quantity! - 1;
                                              }
                                            });
                                            localDBHelper!
                                                .updateQuantityOfProductInCart(
                                                    model.quantity!,
                                                    model.productId!,
                                                    model.unitPrice!);
                                            getTotalOfAllProduct();
                                          }
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
                                          if (mounted) {
                                            setState(() {
                                              if (model.inventoryQuantity! >
                                                  model.quantity!) {
                                                model.quantity =
                                                    model.quantity! + 1;
                                              } else {
                                                debugPrint(
                                                    'MAXIMUM REACHED :::');
                                                showErrorSnackBar(context,
                                                    'Maximum quantity reached');
                                              }
                                            });
                                            localDBHelper!
                                                .updateQuantityOfProductInCart(
                                                    model.quantity!,
                                                    model.productId!,
                                                    model.unitPrice!);
                                            getTotalOfAllProduct();
                                          }
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
                                            if (mounted) {
                                              setState(() {
                                                if (model.addOnQty != 1) {
                                                  model.addOnQty =
                                                      model.addOnQty! - 1;
                                                }

                                                localDBHelper!
                                                    .updateQuantityOfProductInCart4(
                                                        model.addOnQty!,
                                                        model.addOnId!,
                                                        model.addOnPrice!,
                                                        model.productId!);
                                                getAddonTotal();
                                              });
                                            }
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
                                            if (mounted) {
                                              setState(() {
                                                model.addOnQty =
                                                    model.addOnQty! + 1;

                                                localDBHelper!
                                                    .updateQuantityOfProductInCart4(
                                                        model.addOnQty!,
                                                        model.addOnId!,
                                                        model.addOnPrice!,
                                                        model.productId!);
                                                getAddonTotal();
                                              });
                                            }
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
                                            if (mounted) {
                                              setState(() {
                                                if (model.frame_qty != 1) {
                                                  model.frame_qty =
                                                      model.frame_qty! - 1;
                                                }
                                              });
                                              localDBHelper!
                                                  .updateQuantityOfProductInCart2(
                                                      model.frame_qty!,
                                                      model.frameId!,
                                                      model.frame_price!,
                                                      model.productId!);
                                              getFrameTotal();
                                              //});
                                            }
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
                                            if (mounted) {
                                              setState(() {
                                                // if(model.inventoryQuantity! > model.quantity!){
                                                model.frame_qty =
                                                    model.frame_qty! + 1;

                                                // }
                                                // else{
                                                //   showErrorSnackBar(context,'Maximum quantity reached');
                                                // }
                                              });
                                              localDBHelper!
                                                  .updateQuantityOfProductInCart2(
                                                      model.frame_qty!,
                                                      model.frameId!,
                                                      model.frame_price!,
                                                      model.productId!);
                                              // ).then((value){
                                              getFrameTotal();
                                              //  });
                                            }
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
                                        setState(() {
                                          moreInfo = !moreInfo;
                                          debugPrint('MORE INFO: $moreInfo');

                                          showModalBottomSheet(
                                              isDismissible: true,
                                              backgroundColor: loginBlue,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.0),
                                                  topRight:
                                                      Radius.circular(20.0),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
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
                                                                fontSize:
                                                                    12.0)),
                                                        const SizedBox(
                                                            height: 20),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        });
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
                                          if (mounted) {
                                            setState(() {
                                              if (model.bookQty != 1) {
                                                model.bookQty =
                                                    model.bookQty! - 1;
                                                model.bookPrice =
                                                    model.bookQty! *
                                                        model.bookPrice!;
                                              }
                                            });
                                            localDBHelper!
                                                .updateQuantityOfProductInCart3(
                                                    model.bookQty!,
                                                    model.bookId!,
                                                    model.bookPrice!,
                                                    model.productId!);
                                            getBookTotal();
                                          }
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
                                          if (mounted) {
                                            setState(() {
                                              model.bookQty =
                                                  model.bookQty! + 1;
                                            });
                                            localDBHelper!
                                                .updateQuantityOfProductInCart3(
                                                    model.bookQty!,
                                                    model.bookId!,
                                                    model.bookPrice!,
                                                    model.productId!);
                                            getBookTotal();
                                          }
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

                                  Text('price: ${model.bookPrice!}',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12.0)),
                                  const SizedBox(height: 10),

                                  Text('Client Name: ${model.clientName!}',
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                          fontSize: 12.0)),
                                  model.relation != "0"
                                      ? SizedBox(height: 10)
                                      : SizedBox(),
                                  model.relation != "0"
                                      ? Text('Relation Ship: ${model.relation}',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: 12.0))
                                      : SizedBox(),
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
