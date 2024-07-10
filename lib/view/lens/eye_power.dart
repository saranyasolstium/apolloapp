import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../model/product_model.dart';
import '../../services/network/dio_client.dart';
import '../../services/network/endpoints.dart';
import '../cart/cart.dart';
import '../../res/colors.dart';
import '../../res/styles.dart';
import '../../utils/global.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalPlaces;

  DecimalTextInputFormatter({this.decimalPlaces = 3});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value is empty, if so, return the new value directly
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Split the text into parts before and after the decimal point
    List<String> parts = newValue.text.split('.');
    if (parts.length > 1) {
      // If there are decimal places, limit the digits
      if (parts[1].length > decimalPlaces) {
        return oldValue;
      }
    }

    // If everything is okay, return the new value
    return newValue;
  }
}

class EyePower extends StatefulWidget {
  final int id;
  final String title;
  final int variantId;
  final String productType;
  final String variantName;
  final String unitPrice;
  final String src;
  final int invQty;
  final String frameName;
  final String framePrice;
  final String lensType;
  final String? productTitle;

  EyePower(
      {Key? key,
      required this.id,
      required this.title,
      required this.variantId,
      required this.productType,
      required this.variantName,
      required this.unitPrice,
      required this.src,
      required this.invQty,
      required this.frameName,
      required this.framePrice,
      required this.lensType,
      required this.productTitle})
      : super(key: key);

  @override
  State<EyePower> createState() => _EyePowerState();
}

class _EyePowerState extends State<EyePower> {
  int activeStep = 0;
  int dotCount = 2;
  TextEditingController rdSphCr = TextEditingController();
  TextEditingController rdCylCr = TextEditingController();
  TextEditingController rdAxisCr = TextEditingController();
  TextEditingController rdBcvaCr = TextEditingController();

  TextEditingController raSphCr = TextEditingController();
  TextEditingController raCylCr = TextEditingController();
  TextEditingController raAxisCr = TextEditingController();
  TextEditingController raBcvaCr = TextEditingController();

  TextEditingController ldSphCr = TextEditingController();
  TextEditingController ldCylCr = TextEditingController();
  TextEditingController ldAxisCr = TextEditingController();
  TextEditingController ldBcvaCr = TextEditingController();

  TextEditingController laSphCr = TextEditingController();
  TextEditingController laCylCr = TextEditingController();
  TextEditingController laAxisCr = TextEditingController();
  TextEditingController laBcvaCr = TextEditingController();

  TextEditingController reCr = TextEditingController();
  TextEditingController leCr = TextEditingController();

  double total = 0.00;
  double lensRate = 3000;
  String fileName = '';
  XFile? imgFile = XFile('');
  final picker = ImagePicker();
  List<ProductModel> myProductList = [];
  String? productTitle = '';
  double? addonPrice = 0.0;
  bool checkValue = false;
  bool? addOn;
  var currentTime;
  int a = 0;
  int b = 0;
  @override
  void initState() {
    loading = true;
    setState(() {
      getProductList();
    });
    super.initState();
    total = double.parse(widget.unitPrice.toString()) +
        double.parse(widget.framePrice.toString());
    currentTime = DateTime.now();
    debugPrint('CURRENT TIME $currentTime');
  }

  void getProductList() {
    try {
      DioClient(myUrl: "${EndPoints.singleProduct}8159992414452.json")
          .getDetails()
          .then((value) {
        setState(() {
          debugPrint("PHOTO CHRONIC VALUE: $value");
          if (value.statusCode == 200) {
            var data = value.data['product'];
            productTitle = data['title'];
            var varData = data['variants'] as List;
            Map<String, dynamic> map = <String, dynamic>{};
            map['price'] = varData[0]['price'];
            debugPrint('PHOTO CHRONIC PRICE:: ${varData[0]['price']}');
            addonPrice = double.parse(varData[0]['price']);
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
        resizeToAvoidBottomInset: true,
        title: "Add Lens",
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  color: loginBlue,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SvgPicture.asset("assets/svg/eye_power.svg"),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Eye Power",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 14),
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

                            /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
                            activeStep: activeStep,
                            shape: Shape.circle,
                            spacing: 40,
                            lineConnectorsEnabled: true,
                            indicator: Indicator.blink,
                            tappingEnabled: false,

                            /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
                            onDotTapped: (tappedDotIndex) {
                              setState(() {
                                activeStep = tappedDotIndex;
                              });
                            },

                            // DOT-STEPPER DECORATIONS
                            fixedDotDecoration: const FixedDotDecoration(
                              color: lightBlue3,
                            ),

                            indicatorDecoration: const IndicatorDecoration(
                              // style: PaintingStyle.stroke,
                              // strokeWidth: 8,
                              color: loginTextColor,
                            ),
                            lineConnectorDecoration:
                                const LineConnectorDecoration(
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
                Container(
                    child: Row(
                  children: [
                    Checkbox(
                        value: checkValue,
                        onChanged: (val) {
                          setState(() {
                            checkValue = val!;
                            addOn = val;
                            debugPrint('CHECK BOX $checkValue');
                            debugPrint('CHECK BOX (addOn) $addOn');
                          });
                        }),
                    Text('Please Check for Add On: $productTitle')
                  ],
                )),
                const SizedBox(height: 20),
                Card(
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      //  margin: EdgeInsets.all(10),
                      //height: 100,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            'Right Eye',
                            style: zzBlackTextStyle16,
                          ),
                          const SizedBox(height: 20),
                          Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text('Distance', style: zzBlackTextStyle16)),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: rdSphCr,
                                    // keyboardType: TextInputType.number,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    // maxLength: 3,
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'SPH',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: rdCylCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'CYL',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: rdAxisCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'AXIS',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: rdBcvaCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'BCVA',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Add', style: zzBlackTextStyle16)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: raSphCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'SPH',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: raCylCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'CYL',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: raAxisCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'AXIS',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: raBcvaCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'BCVA',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                Card(
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      //  margin: EdgeInsets.all(10),
                      //height: 100,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            'Left Eye',
                            style: zzBlackTextStyle16,
                          ),
                          const SizedBox(height: 20),
                          Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text('Distance', style: zzBlackTextStyle16)),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: ldSphCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'SPH',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: ldCylCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'CYL',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: ldAxisCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'AXIS',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: ldBcvaCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'BCVA',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Add', style: zzBlackTextStyle16)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: laSphCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'SPH',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: laCylCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'CYL',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: laAxisCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'AXIS',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: laBcvaCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'BCVA',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                Card(
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      //  margin: EdgeInsets.all(10),
                      //height: 100,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('PD', style: zzBlackTextStyle16)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: reCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'RE',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              ),
                              SizedBox(
                                width: 20.w,
                                child: TextFormField(
                                    controller: leCr,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,3}')),
                                    ],
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: 'LE',
                                      //  labelText: 'Left eye',
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey)),
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(height: 20)
                          //  Text('Add your eye power. Normal vision is 6/6',style: zzRegularBlackTextStyle13,),
                          //   SizedBox(
                          //     height: 10,
                          //   ),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0)), //this right here
                                child: SizedBox(
                                  height: 160,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                            'Select from Image or Gallery',
                                            textAlign: TextAlign.center),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  getImage(ImageSource.camera);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        loginTextColor,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        20.0, 0, 20.0, 0)),
                                                child: const Text('Camera',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  getImage(ImageSource.gallery);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        loginTextColor,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        20.0, 0, 20.0, 0)),
                                                child: const Text('Gallery',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          hintText: 'Upload priscription (if any)',
                          labelText: fileName == '' ? 'Priscription' : fileName,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey)),
                          //suffixIcon: Image.asset('assets/images/call.png',width: 30.0,height: 30.0,
                          suffixIcon: InkWell(
                              onTap: () {
                                //showDialog2(context: context);
                                //getImage(ImageSource.gallery);
                                // Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0)), //this right here
                                        child: SizedBox(
                                          height: 160,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                    'Select from Image or Gallery',
                                                    textAlign:
                                                        TextAlign.center),
                                                const SizedBox(height: 30),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          getImage(ImageSource
                                                              .camera);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                loginTextColor,
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    20.0,
                                                                    0,
                                                                    20.0,
                                                                    0)),
                                                        child: const Text(
                                                            'Camera',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white))),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          getImage(ImageSource
                                                              .gallery);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                loginTextColor,
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    20.0,
                                                                    0,
                                                                    20.0,
                                                                    0)),
                                                        child: const Text(
                                                            'Gallery',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white))),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: const Icon(
                                Icons.upgrade,
                                size: 30,
                                color: loginTextColor,
                              ))),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ]),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0)),
                      color: loginBlue),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal (Frame + Lens): \n₹$total'),
                        ElevatedButton(
                            onPressed: () async {
                              //  localDBHelper!.getParticularCartAddedOrNot(widget.id,'order').then((value) {

                              if (rdSphCr.text.isEmpty) {
                                showErrorSnackBar(
                                    context, "Enter right eye distance SPH");
                                FocusScope.of(context).unfocus();
                              } else if (rdCylCr.text.isEmpty) {
                                showErrorSnackBar(
                                    context, "Enter right eye distance CYL");
                                FocusScope.of(context).unfocus();
                              } else if (rdAxisCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter right eye distance AXIS");
                              } else if (rdBcvaCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter right eye distance BCVA");
                              } else if (raSphCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter right eye add SPH");
                              } else if (raCylCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter right eye add CYL");
                              } else if (raAxisCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter right eye add AXIS");
                              } else if (raBcvaCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter right eye add BCVA");
                              } else if (ldSphCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter left eye distance SPH");
                              } else if (ldCylCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter left eye distance CYL");
                              } else if (ldAxisCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter left eye distance AXIS");
                              } else if (ldBcvaCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter left eye distance BCVA");
                              } else if (laSphCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter left eye add SPH");
                              } else if (laCylCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter left eye add CYL");
                              } else if (laAxisCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter left eye add AXIS");
                              } else if (laBcvaCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter left eye add BCVA");
                              } else if (reCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(
                                    context, "Enter right eye PD");
                              } else if (leCr.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showErrorSnackBar(context, "Enter left eye PD");
                              }

                              // else if (value.isNotEmpty) {
                              //   showErrorSnackBar(context, "Product already added to cart");
                              // }
                              else {
                                FocusScope.of(context).unfocus();

                                localDBHelper!
                                    .getParticularCartAddedOrNot(
                                        widget.variantId)
                                    .then((value) {
                                  if (value.isNotEmpty) {
                                    // showErrorSnackBar(context, "Product already added to cart");
                                    getDetails2();

                                    Get.to(() => const Cart(
                                          fromWhere: 5,
                                          productHandle: "",
                                        ));
                                  } else {
                                    var data = <String, dynamic>{};
                                    data['product_id'] = widget.id;
                                    // data['pr_type'] = 'order';
                                    data['variant_id'] = widget.variantId;
                                    data['product_name'] = widget.title;
                                    data['product_type'] = widget.productType;
                                    data['variant_name'] = widget.variantName;
                                    data['unit_price'] = widget.unitPrice;
                                    data['quantity'] = 1;
                                    data['total'] = widget.unitPrice * 1;
                                    data['image_url'] = widget.src;
                                    data['inventory_quantity'] = widget.invQty;
                                    data['created_at'] = currentTime.toString();
                                    data['updated_at'] = currentTime.toString();

                                    getDetails2();
                                    // if(addOn==true){
                                    //
                                    //   localDBHelper!.getCartList5().then((value) {
                                    //     debugPrint('ADD ON VALUE (SECOND) : $value');
                                    //     if (value.isNotEmpty) {
                                    //       b=value.length;
                                    //       for(var val in value){
                                    //         int id= int.parse(val['addon_id'].toString());
                                    //         int qty= int.parse(val['addon_qty'].toString());
                                    //         double price = double.parse(val['addon_price'].toString());
                                    //
                                    //         localDBHelper!.updateAddOn(id,qty+1);
                                    //         localDBHelper!.updateAddOnTotal(qty+1,id,price);
                                    //       }
                                    //
                                    //       debugPrint('UPDATE ADD ON VALUE (SECOND) :: $value');
                                    //       debugPrint('UPDATE ADD ON QTY ');
                                    //
                                    //     }
                                    //     else{
                                    //       debugPrint('NEW ADD ON QTY ');
                                    //
                                    //      // localDBHelper!.updateAddOnNew(1);
                                    //     }
                                    //   });
                                    //   debugPrint('HELLO WORLD LENGTH (SECOND) :: $b');
                                    //   if(b==0){
                                    //     addOnMethod();
                                    //   }
                                    // }

                                    localDBHelper!
                                        .insertValuesIntoCartTable(data)
                                        .then((value) => showSuccessSnackBar(
                                            context,
                                            "Product added to cart successfully!"));
                                    Get.to(() => const Cart(
                                          fromWhere: 5,
                                          productHandle: "",
                                        ));
                                  }

                                  if (addOn == true) {
                                    localDBHelper!.getCartList4().then((value) {
                                      debugPrint('ADD ON VALUE : $value');
                                      if (value.isNotEmpty) {
                                        a = value.length;

                                        for (var val in value) {
                                          int id = int.parse(
                                              val['addon_id'].toString());
                                          int qty = int.parse(
                                              val['addon_qty'].toString());
                                          double price = double.parse(
                                              val['addon_price'].toString());

                                          localDBHelper!
                                              .updateAddOn(id, qty + 1);
                                          localDBHelper!.updateAddOnTotal(
                                              qty + 1, id, price);
                                        }

                                        debugPrint(
                                            'UPDATE ADD ON VALUE (FIRST):: $value');
                                        debugPrint('UPDATE ADD ON QTY ');

                                        localDBHelper!
                                            .getCartList4()
                                            .then((value) {
                                          if (mounted) {
                                            setState(() {
                                              debugPrint(
                                                  'FROM DB 4 (INSTANT ALREADY ) .. $value');
                                            });
                                          }
                                        });
                                      } else {
                                        addOnMethod();
                                      }
                                    });
                                    debugPrint(
                                        'HELLO WORLD LENGTH (FIRST) :: $a');
                                  }
                                });
                                await Get.to(() => Cart(
                                      fromWhere: 5,
                                      productHandle: "",
                                      productTitle: widget.productTitle,
                                    ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: loginTextColor,
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0, 20.0, 0)),
                            child: Text('Add to cart',
                                style: zzBoldWhiteTextStyle14A))
                      ])))
        ]));
  }

  void getDetails2() async {
    Map<String, dynamic> map = <String, dynamic>{};

    map['product_id'] = widget.id;
    map['product_title']=widget.productTitle;
    map['lens_type'] = widget.lensType;
    map['rd_sph'] = rdSphCr.text;
    map['rd_cyl'] = rdCylCr.text;
    map['rd_axis'] = rdAxisCr.text;
    map['rd_bcva'] = rdBcvaCr.text;

    map['ra_sph'] = raSphCr.text;
    map['ra_cyl'] = raCylCr.text;
    map['ra_axis'] = raAxisCr.text;
    map['ra_bcva'] = raBcvaCr.text;

    map['ld_sph'] = ldSphCr.text;
    map['ld_cyl'] = ldCylCr.text;
    map['ld_axis'] = ldAxisCr.text;
    map['ld_bcva'] = ldBcvaCr.text;

    map['la_sph'] = laSphCr.text;
    map['la_cyl'] = laCylCr.text;
    map['la_axis'] = laAxisCr.text;
    map['la_bcva'] = laBcvaCr.text;

    map['re'] = reCr.text;
    map['le'] = leCr.text;

    map['priscription'] = '';
    map['frame_name'] = widget.frameName;
    map['frame_price'] = double.parse(widget.framePrice);
    map['frame_qty'] = 1;
    map['frame_total'] = double.parse(widget.framePrice);

    map['created_at'] = currentTime.toString();
    map['updated_at'] = currentTime.toString();

    debugPrint('FRAME : ${widget.frameName}');
    await localDBHelper!.insertValuesIntoCartTable2(map);
    //.then((value) =>
    //showSuccessSnackBar(context, "Frame Details: "+ value.toString()));
  }

  void addOnMethod() async {
    Map<String, dynamic> map = <String, dynamic>{};
    map['product_id'] = widget.id;

    map['addon_title'] = productTitle;
    map['addon_price'] = addonPrice;
    map['addon_total'] = addonPrice;
    map['addon_qty'] = 1;
    map['created_at'] = currentTime.toString();
    map['updated_at'] = currentTime.toString();

    localDBHelper!.insertValuesIntoCartTable4(map);

    localDBHelper!.getCartList4().then((value) {
      if (mounted) {
        setState(() {
          debugPrint('FROM DB 4 (INSTANT) .. $value');
        });
      }
    });
    //  await Get.to(()=>const Cart(fromWhere: 5));
  }

  Future getImage(ImageSource img) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          imgFile = XFile(pickedFile!.path);
          fileName = imgFile!.path.split('/').last;
          debugPrint('FILE: ${pickedFile.path}');
          debugPrint('FILE: $fileName');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
