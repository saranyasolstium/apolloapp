import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite/view/trial_request/trial_request_address_details.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';

import '../../res/colors.dart';
import '../../res/styles.dart';

class TrialRequestDetails extends StatefulWidget {
  final int id;
  final String title;
  final int variantId;
  final String productType;
  final String variantName;
  final String unitPrice;
  final String src;
  final int invenQty;

  const TrialRequestDetails(
      {Key? key,
      required this.id,
      required this.title,
      required this.variantId,
      required this.productType,
      required this.variantName,
      required this.unitPrice,
      required this.src,
      required this.invenQty})
      : super(key: key);

  @override
  State<TrialRequestDetails> createState() => _TrialRequestDetailsState();
}

class _TrialRequestDetailsState extends State<TrialRequestDetails> {
  int activeStep = 0;

  int dotCount = 3;
  String myCountryCode = "+91";

  int productId = 0;
  String productTitle = '';
  String productType = '';
  String variantName = '';
  String imgSrc = '';
  String unitPrice = '';

  XFile? imgFile = XFile('');
  final picker = ImagePicker();
  String fileName = '';

  @override
  void initState() {
    super.initState();

    debugPrint('TRIAL LIST DETAIL ID:${widget.id}');
    debugPrint('TRIAL LIST DETAIL TITLE: ${widget.title}');
    debugPrint('TRIAL LIST DETAIL COLOR: ${widget.variantName}');
    debugPrint('TRIAL LIST DETAIL TYPE: ${widget.productType}');
    debugPrint('TRIAL LIST DETAIL  SRC: ${widget.src}');
    debugPrint('TRIAL LIST DETAIL PRICE: ${widget.unitPrice}');

    productId = widget.id;
    productTitle = widget.title;
    productType = widget.productType;
    variantName = widget.variantName;
    imgSrc = widget.src;
    unitPrice = widget.unitPrice;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Trial Request",
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                width: ScreenSize.getScreenWidth(context),
                height: ScreenSize.getScreenHeight(context),
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset("assets/svg/profile_img2.svg"),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Your Details",
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
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: white,
                          hintText: 'Your Name',
                          labelText: 'Name',
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CountryCodePicker(
                                onChanged: (CountryCode countryCode) {
                                  myCountryCode = countryCode.toString();
                                  debugPrint(
                                      "New Country selected: $countryCode == $myCountryCode");
                                },
                                initialSelection: 'IN',
                                favorite: const ['+91', 'IN'],
                                showCountryOnly: false,
                                showFlag: true,
                                enabled: false,
                                showDropDownButton: false,
                              ),
                              const VerticalDivider(
                                endIndent: 5.0,
                                indent: 5.0,
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Expanded(
                                child: TextFormField(
                                  autofocus: false,
                                  style: zzRegularBlackTextStyle13,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    counter: const SizedBox(height: 0.0),
                                    border: InputBorder.none,
                                    hintText: 'Enter mobile number',
                                    hintStyle: zzRegularGrayTextStyle10,
                                    filled: true,
                                    fillColor: white,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          labelText: 'Email',
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            hintText: 'Upload priscription (if any)',
                            labelText:
                                fileName == '' ? 'Priscription' : fileName,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                            suffixIcon: InkWell(
                                onTap: () {
                                  getImage(ImageSource.gallery);
                                },
                                child: const Icon(
                                  Icons.upgrade,
                                  size: 30,
                                  color: loginTextColor,
                                ))),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('1 product selected for trial request'),
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
                        Get.to(() => TrialRequestAddress(
                              id: productId,
                              title: productTitle.toString(),
                              variantId: widget.variantId,
                              productType: productType.toString(),
                              variantName: variantName,
                              unitPrice: unitPrice.toString(),
                              src: imgSrc,
                              invQty: widget.invenQty,
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: loginTextColor,
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)),
                      child: Text('Next', style: zzBoldWhiteTextStyle14A))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showDialog2({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: loginTextColor),
                    child: Text(
                      'Choose From Gallery',
                      style: zzBoldWhiteTextStyle14A,
                    )),
              )
            ],
          );
        });
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
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
