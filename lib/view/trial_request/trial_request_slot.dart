import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';

import '../cart/cart.dart';
import '../../model/product_model.dart';
import '../../model/product_details_model.dart';
import '../../res/colors.dart';
import '../../res/styles.dart';
import '../../utils/global.dart';

class TrialRequestSlot extends StatefulWidget {
  final int id;
  final String title;
  final int variantId;
  final String productType;
  final String variantName;
  final String unitPrice;
  final String src;
  final int invQty;

  const TrialRequestSlot(
      {Key? key,
      required this.id,
      required this.title,
      required this.variantId,
      required this.productType,
      required this.variantName,
      required this.unitPrice,
      required this.src,
      required this.invQty})
      : super(key: key);

  @override
  State<TrialRequestSlot> createState() => _TrialRequestSlotState();
}

class _TrialRequestSlotState extends State<TrialRequestSlot> {
  int activeStep = 0;
  int dotCount = 3;
  int checkedIndex = 0;
  List<ProductDetails> detailList = [];
  String? productTitle = '';
  String? productType = '';
  List<String> imgList = [];
  List<Map<String, dynamic>> imgList2 = [];
  List<Map<String, dynamic>> variantList = [];

  List<ProductModel> prouductList = [];
  List<Map<String, dynamic>> variantList2 = [];
  String imgPath = '';
  int mySelectedColorIndex = 0;
  List<String> myColorList = [];
  int indx = 0;
  late int variantId;
  late int inventory_quantity;

  int productId = 0;
  int variantID = 0;
  var currentTime;
  @override
  void initState() {
    super.initState();
    debugPrint('TRIAL SLOT DETAIL ID:${widget.id}');
    debugPrint('TRIAL SLOT DETAIL TITLE: ${widget.title}');
    debugPrint('TRIAL SLOT DETAIL COLOR: ${widget.variantName}');
    debugPrint('TRIAL SLOT DETAIL TYPE: ${widget.productType}');
    debugPrint('TRIAL SLOT DETAIL  SRC: ${widget.src}');
    debugPrint('TRIAL SLOT DETAIL PRICE: ${widget.unitPrice}');
    currentTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Trial Request",
      child: Column(children: [
        Container(
          color: loginBlue,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset("assets/svg/radio_symbol.svg"),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Book Slot",
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DotStepper(
                    dotCount: dotCount,
                    dotRadius: 12,
                    activeStep: activeStep,
                    shape: Shape.circle,
                    spacing: 40,
                    tappingEnabled: false,
                    lineConnectorsEnabled: true,
                    indicator: Indicator.blink,
                    onDotTapped: (tappedDotIndex) {
                      setState(() {
                        activeStep = tappedDotIndex;
                      });
                    },
                    fixedDotDecoration: const FixedDotDecoration(
                      color: lightBlue3,
                    ),
                    indicatorDecoration: const IndicatorDecoration(
                      color: loginTextColor,
                    ),
                    lineConnectorDecoration: const LineConnectorDecoration(
                      color: lightBlue3,
                      strokeWidth: 0,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black26,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
            ),
            Text(
              '12 March 2023 (Tuesday)',
              style: zzRegularBlackTextStyle13A,
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black26,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: const Divider(
            color: Colors.black26,
            thickness: 3,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: GridView.builder(
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                childAspectRatio: 2.5,
              ),
              shrinkWrap: true,
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      checkedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: (checkedIndex == index ? loginBlue2 : loginBlue),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(4),
                    child: Center(
                        child: Text('8:00 AM - 8:30 AM',
                            style: GoogleFonts.lato(
                                fontSize: 12,
                                color: (checkedIndex == index
                                    ? Colors.black
                                    : Colors.black26)))),
                  ),
                );
              }),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0)),
                color: loginBlue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('10 product selected for trial request'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Edit products',
                      style: GoogleFonts.lato(
                          color: loginTextColor,
                          decoration: TextDecoration.underline,
                          decorationColor: loginTextColor),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    insertData2(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: loginTextColor,
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0)),
                  child: Text(
                    'Add to cart',
                    style: zzBoldWhiteTextStyle14A,
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  void insertData2(BuildContext context) {
    debugPrint('SLOT INVENTORY QTY: ${widget.invQty}');
    if (widget.invQty == 0) {
      showErrorSnackBar(context, "Product is out of stock");
    } else {
      localDBHelper!.getParticularCartAddedOrNot(widget.id).then((value) {
        if (value.isNotEmpty) {
          showErrorSnackBar(context, "Product already added to cart");
        } else {
          var data = <String, dynamic>{};
          data['product_id'] = widget.id;
          data['variant_id'] = widget.variantId;
          data['product_name'] = widget.title;
          data['product_type'] = widget.productType;
          data['variant_name'] = widget.variantName;
          data['unit_price'] = widget.unitPrice;
          data['quantity'] = 1;
          data['total'] = double.parse(widget.unitPrice) * 1;
          debugPrint('SLOT TOTAL:${double.parse(widget.unitPrice) * 1}');

          data['image_url'] = widget.src;
          data['inventory_quantity'] = widget.invQty;
          data['created_at'] = currentTime.toString();
          data['updated_at'] = currentTime.toString();
          localDBHelper!.insertValuesIntoCartTable(data).then((value) =>
              showSuccessSnackBar(
                  context, "Product added to cart successfully!"));
          Get.to(() => const Cart(
                productHandle: "",
              ));
        }
      });
    }
  }
}
