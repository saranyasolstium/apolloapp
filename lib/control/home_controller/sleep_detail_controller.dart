import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:infinite/model/product_details_model.dart';
import 'package:infinite/services/remote_service.dart';
import 'package:infinite/view/book/book_appointment_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/packeages.dart';

class SleepDetailController extends GetxController {
  final PageController pageController5 = PageController();
  int currentPage5 = 0;
  PageController pageController = PageController(viewportFraction: 0.8);
  int currentPage = 1;

  List<ProductDetails> detailList = [];
  String? productTitle = '';
  String? productType = '';
  String? handle = '';
  List<String> imgList = [];
  List<Map<String, dynamic>> imgList2 = [];
  List<Map<String, dynamic>> variantList = [];
  TextEditingController controller = TextEditingController();
  List<ProductModel> prouductList = [];
  List<Map<String, dynamic>> variantList2 = [];
  String myTags = "";
  String imgPath = '';
  int mySelectedColorIndex = 0;
  List<String> myColorList = [];
  int indx = 0;
  late int variantId;
  late int inventory_quantity;

  int? productId = 0;
  int variantID = 0;
  int myCartCount = 0;
  int myBookCount = 0;
  int myFrameCount = 0;
  int myAddOnCount = 0;
  String prType = '';
  String bodyHtml = '';
  String? variantPrice;
  int clientMobileNumber = 8121012908;
  int mySelectAppointmentType = 1;
  int imageIndex = 0;
  var currentTime;
  int? sleepID = 0;
  String? fromWhere;
  String selectedStyle = "";
  String selectedPrice = "";
  String selectedQuantity = "";

  @override
  void onInit() {
    super.onInit();

    loading = true;
    pageController =
        PageController(initialPage: currentPage, viewportFraction: 0.8);
    pageController.addListener(() {
      currentPage = pageController.page!.toInt();
      update();
    });
    pageController5.addListener(() {
      currentPage5 = pageController5.page!.toInt();
      update();
    });
    currentTime = DateTime.now();
    getDetails();
    productId = sleepID!;
    debugPrint('EAR PRODUCT ID: $productId');
    update();
  }

  @override
  void dispose() {
    super.dispose();
    pageController5.dispose();
    update();
  }

  void getDetails() {
    try {
      variantList.clear();
      imgList2.clear();
      DioClient(myUrl: "products/$sleepID.json").getDetails().then((value) {
        debugPrint('PRODUCT DETAIL SCREEN:  $value');
        if (value.statusCode == 200) {
          var data = value.data['product'];
          productTitle = data['title'];
          productType = data['product_type'];

          bodyHtml = data['body_html'];
          handle = data['handle'];
          myTags = data['tags'] ?? '';
          debugPrint('DETAIL productTitle : $productTitle');

          debugPrint('DETAIL SCREEN TAG : $myTags');
          debugPrint('DETAIL SCREEN TYPE : $productType');
          debugPrint('DETAIL SCREEN  BODY HTML: $bodyHtml');

          if (myTags
              .toString()
              .toLowerCase()
              .contains('enquiry'.toLowerCase())) {
            debugPrint('DETAIL SCREEN TAG : $myTags');
          } else {
            debugPrint('DETAIL SCREEN NO TAG...');
          }

          if (data['images'] != null) {
            debugPrint('SHOW DETAIL: 1');
            var imgvar = data['images'] as List;
            if (imgvar.isNotEmpty) {
              for (var img in imgvar) {
                Map<String, dynamic> map = <String, dynamic>{};
                map['src'] = img['src'];
                map['product_id'] = img['product_id'];
                imgList2.add(map);
              }
            } else if (data['image'] != null) {
              debugPrint('SHOW DETAIL: 2');
              var aImageMap = data['image'];
              Map<String, dynamic> map = <String, dynamic>{};
              map['src'] = aImageMap['src'];
              map['product_id'] = aImageMap['product_id'];
              imgList2.add(map);
            } else {
              debugPrint('SHOW DETAIL: 3');
              Map<String, dynamic> map = <String, dynamic>{};
              map['src'] =
                  "https://my6senses.com/cdn/shopifycloud/shopify/assets/no-image-2048-5e88c1b20e087fb7bbe9a3771824e743c244f437e4f8ba93bbf7b11b53f7824c_600x.gif";
              map['product_id'] = data['id'];
              imgList2.add(map);
            }
          } else if (data['image'] != null) {
            debugPrint('SHOW DETAIL: 2');
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

            variantId = map['id'];
            inventory_quantity = map['inventory_quantity'];
            variantList.add(map);
          }

          variantPrice = variantList[0]['price'];
          debugPrint('DETAIL variantPrice : $variantPrice');

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
                  selectedStyle = myColorList.first;
                } else {
                  myColorList = [];
                }
              }
            }
          } else {
            myColorList = [];
          }
        } else {}
        loading = false;
        update();
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  void sendMessageToWhatsApp(
      String mobile, BuildContext context, String aContent) async {
    var whatsappUrl =
        "whatsapp://send?phone=+91$mobile&text=${Uri.encodeComponent(aContent)}";
    try {
      launch(whatsappUrl);
    } catch (e) {
      showErrorSnackBar(context, 'Whatsapp Not Installed in the Device');
    }
  }

  void shareProductOnSocial() async {
    try {
      await FlutterShare.share(
          title: productTitle!,
          text: 'Take a look at this $productTitle on Infinite',
          linkUrl: "https://my6senses.com/products/$handle",
          chooserTitle: 'Share');
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select appointment type'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        backgroundColor: loginTextColor,
                      ),
                      onPressed: (() {
                        mySelectAppointmentType = 1;
                        debugPrint('TYPE ::$mySelectAppointmentType');
                        debugPrint(
                            'IMAGE URL ::${imgList2[imageIndex]['src'].toString()}');
                        Navigator.pop(context);
                        gotoOrder();

                        update();
                      }),
                      child:
                          Text('In Home', style: zzRegularBlackTextStyle14A)),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        backgroundColor: loginTextColor,
                      ),
                      onPressed: (() {
                        mySelectAppointmentType = 2;
                        debugPrint('TYPE ::$mySelectAppointmentType');
                        debugPrint(
                            'IMAGE URL ::${imgList2[imageIndex]['src'].toString()}');
                        Navigator.pop(context);
                        gotoOrder();

                        update();
                      }),
                      child: Text('Visit Clinic',
                          style: zzRegularBlackTextStyle14A)),
                ],
              )
            ],
          );
        });
  }

  void gotoOrder() {
    String? type2;
    if (mySelectAppointmentType == 1) {
      type2 = 'In Home';
    } else if (mySelectAppointmentType == 2) {
      type2 = 'Visit clinic';
    }

    Get.to(() => BookAppointmentScreen(
        type: type2,
        productId: productId,
        variantId: variantList[mySelectedColorIndex]['id'],
        productName: productTitle.toString(),
        price: double.parse(variantList[mySelectedColorIndex]['price'])));

    debugPrint('UNIT PRICE ::: ${variantList[mySelectedColorIndex]['price']}');
  }

  void gotoCart(BuildContext context, String price, bool rent, String startDate,
      String endDate) {
    //NEWLY COMMENTED
    localDBHelper!
        .getParticularCartAddedOrNot(variantList[mySelectedColorIndex]['id'])
        .then((value) {
      if (value.isNotEmpty) {
        showErrorSnackBar(context, "Product already added to cart");
      } else if (variantList[mySelectedColorIndex]['inventory_quantity'] <= 0 &&
          !rent) {
        showErrorSnackBar(context, "Selected variant out of stock");
      } else {
        var data = <String, dynamic>{};
        data['product_id'] = sleepID;
        data['variant_id'] = variantList[mySelectedColorIndex]['id'];
        data['product_name'] = productTitle.toString();
        data['product_type'] = productType.toString();
        data['variant_name'] = rent ? "Rent" : "Sale";
        data['unit_price'] = price;
        data['quantity'] = 1;
        data['total'] = double.parse(price) * 1;
        data['image_url'] = imgList2[0]['src'].toString();
        data['inventory_quantity'] =
            variantList[mySelectedColorIndex]['inventory_quantity'];
        data['created_at'] = startDate.toString();
        data['updated_at'] = endDate.toString();
        localDBHelper!.insertValuesIntoCartTable(data).then((value) =>
            showSuccessSnackBar(
                context, "Product added to cart successfully!"));
        Get.off(() => Cart(
              fromWhere: 4,
              productId: sleepID,
              routeType: "sleep",
              productHandle: "",
            ));
      }
    });
  }
}
