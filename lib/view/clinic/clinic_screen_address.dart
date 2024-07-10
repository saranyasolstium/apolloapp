import 'package:country_code_picker/country_code_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../model/address_model.dart';
import '../../res/colors.dart';
import '../../res/styles.dart';
import '../../res/texts.dart';
import '../../services/network/dio_client.dart';
import '../../services/network/endpoints.dart';
import '../../utils/global.dart';
import '../../utils/screen_size.dart';
import '../../widgets/default_navigation_widget.dart';
import '../cart/cart.dart';

class ClinicScreenAddress extends StatefulWidget {
  final int? type;
  final int? id;
  final String? title;
  final int? variantId;
  final String? productType;
  final String? variantName;
  final String? unitPrice;
  final String? src;
  final int? invenQty;
  final String? address;

  const ClinicScreenAddress(
      {Key? key,
      this.type,
      this.id,
      this.title,
      this.variantId,
      this.productType,
      this.variantName,
      this.unitPrice,
      this.src,
      this.invenQty,
      this.address})
      : super(key: key);

  @override
  State<ClinicScreenAddress> createState() => _ClinicScreenAddressState();
}

class _ClinicScreenAddressState extends State<ClinicScreenAddress> {
  int activeStep = 0;
  int dotCount = 2;

  // YOUR DETAILS
  String myCountryCode = "+91";

  // ADDRESS DETAILS
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController prisController = TextEditingController();
  TextEditingController clinicAddressController = TextEditingController();
  String mySelectedStateId = "0", mySelectedCityId = "0";

  // SLOT DETAILS
  int checkedIndex = 2;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateTimeForManipulation = DateTime.now();
  String mySelectedDate = "", mySelectedDateForBooking = "";
  int myDefaultDateForIncAndDec = 0;
  String address = '';
  bool addressSelected = false;

  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp? regExp;
  int aId = 0;
  int button = 0;
  String radioButtonDefault = 'Home';
  late List<AddressModel> addressList = [];
  List<TextEditingController> addressControl1 = [];
  List<TextEditingController> addressControl2 = [];
  List<TextEditingController> pinControl = [];
  int addressId = 0;
  String address1 = '';
  String address2 = '';
  int press = 0;
  bool defaultValue = true;
  bool debool = false;
  bool debool2 = false;
  bool listBool = false;
  int edit = 0;
  int index1 = -1;
  String address1New = '';
  String address2New = '';
  String pinNew = '';
  String labelNew = '';
  final mailNode = FocusNode();
  final prisNode = FocusNode();
  String fileName = '';
  XFile? imgFile = XFile('');
  final picker = ImagePicker();
  var currentTime;
  @override
  void initState() {
    loading = true;
    mySelectedDate = myDefaultDateFormatOne.format(selectedDate).toString();
    mySelectedDateForBooking =
        myDefaultDateFormatForBooking.format(selectedDate).toString();
    super.initState();
    regExp = RegExp(pattern);
    aId = sharedPreferences!.getInt("id")!.toInt();
    getList();

    debugPrint('SELECTION WIDGET TYPE: ${widget.type}');
    debugPrint('SELECTION WIDGET TITLE: ${widget.title}');
    debugPrint('SELECTION WIDGET VARIANT NAME: ${widget.variantName}');
    debugPrint('SELECTION WIDGET ADDRESS: ${widget.address}');
    press = 0;
    currentTime = DateTime.now();
  }

  void addAddress2(Map<String, dynamic> data, BuildContext context) {
    try {
      DioClient(
              myUrl: '${EndPoints.createCustomerAddress}$aId/addresses.json',
              myMap: data)
          .post()
          .then((value) {
        debugPrint('ADDRESS: $value');
        debugPrint('STATUS CODE  ${value.statusCode}');
        if (value.statusCode == 201) {
          // showSuccessSnackBar(
          //     context, "Your profile has been successfully created");
          var aCustomerMap = value.data['customer_address'];

          /*int aId = aCustomerMap['id'];
          String address1 = aCustomerMap['address1'] ?? '';
          String address2 = aCustomerMap['address2'] ?? '';*/
        } else {
          debugPrint('ERROR STATUS CODE  ${value.statusCode}');
          if (value.data['errors'] != null) {
            Map<String, dynamic> aErrMap = value.data['errors'];
            debugPrint('ADDRESS ERROR: $aErrMap');
          }
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void getList() {
    try {
      debugPrint("ADDRESS LIST RESPONSE::: ");
      DioClient(myUrl: '${EndPoints.createCustomerAddress}$aId/addresses.json')
          .getAddressList()
          .then((value) {
        debugPrint("ADDRESS LIST RESPONSE: $value");
        setState(() {
          if (value.isNotEmpty) {
            loading = true;
            addressList = [];
            for (AddressModel model in value) {
              addressId = model.id!;
              addressList.add(model);
            }

            //
            for (int i = 0; addressList.length > i; i++) {
              TextEditingController controllerF = TextEditingController();
              TextEditingController controllerF2 = TextEditingController();
              TextEditingController controllerP = TextEditingController();

              controllerF.text = addressList[i].address1!;
              controllerF2.text = addressList[i].address2!;
              controllerP.text = addressList[i].pincode!;

              addressControl1.add(controllerF);
              addressControl2.add(controllerF2);
              pinControl.add(controllerP);
            }
            debugPrint("ADDRESS LIST  SIZE FFF: ${addressControl1.length}");
            debugPrint("ADDRESS LIST  SIZE: ${addressList.length}");
          } else {
            addressList = [];
          }
          loading = false;
        });
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
        title: "Book Home Test",
        child: SizedBox(
          width: ScreenSize.getScreenWidth(context),
          height: ScreenSize.getScreenHeight(context),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: loginBlue,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    activeStep == 0
                        ? SvgPicture.asset("assets/svg/profile_img2.svg")
                        // : activeStep == 1
                        // ? SvgPicture.asset("assets/svg/profile_img2.svg")
                        : SvgPicture.asset("assets/svg/radio_symbol.svg"),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      activeStep == 0
                          ? "Your Details"
                          // : activeStep == 1
                          // ? widget.type == 1
                          // ? "Address Details"
                          // : "Clinic Details"
                          : "Book Slot",
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
                          dotCount: 2,
                          dotRadius: 12,

                          /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
                          activeStep: activeStep,
                          shape: Shape.circle,
                          spacing: 40,
                          tappingEnabled: false,

                          /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
                          // onDotTapped: (tappedDotIndex) {
                          //   if (mounted) {
                          //     setState(() {
                          //       activeStep = tappedDotIndex;
                          //     });
                          //   }
                          // },
                          lineConnectorsEnabled: true,
                          indicator: Indicator.jump,
                          // DOT-STEPPER DECORATIONS
                          fixedDotDecoration: const FixedDotDecoration(
                            color: lightBlue3,
                          ),
                          indicatorDecoration: const IndicatorDecoration(
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
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: activeStep == 0
                      ? showYourDetails()
                      // : activeStep == 1
                      // ? showAddressDetails()
                      : showSlotDetails())
            ],
          ),
        ));
  }

  /// YOUR DETAILS
  Widget showYourDetails() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              //   height: ScreenSize.getScreenHeight(context),
              width: ScreenSize.getScreenWidth(context),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: nameController,
                      maxLength: 60,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        counterText: '',
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: SizedBox(
                    width: double.infinity,
                    //height: 8.5.h,
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
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'IN',
                              favorite: const ['+91', 'IN'],
                              showCountryOnly: true,
                              showFlag: false,
                              enabled: false,
                              showDropDownButton: false,
                            ),
                            const VerticalDivider(
                              endIndent: 10.0,
                              indent: 10.0,
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: mobileController,
                                autofocus: false,
                                style: zzRegularBlackTextStyle13,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                                maxLength: 20,
                                decoration: InputDecoration(
                                  counter: const SizedBox(height: 0.0),
                                  border: InputBorder.none,
                                  hintText: 'Enter mobile number',
                                  hintStyle: zzRegularGrayTextStyle10,
                                  filled: true,
                                  fillColor: white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  // focusedBorder: OutlineInputBorder(
                                  //   borderSide: const BorderSide(color: Colors.grey),
                                  //   borderRadius: BorderRadius.circular(7.0),
                                  // ),
                                  // enabledBorder: OutlineInputBorder(
                                  //   borderSide: const BorderSide(color: Colors.grey),
                                  //   borderRadius: BorderRadius.circular(7.0),
                                  // ),
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
                      controller: mailController,
                      focusNode: mailNode,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        mailNode.requestFocus();
                        FocusScope.of(context).nextFocus();
                      },
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
                // Padding(
                //   padding: const EdgeInsets.only(right: 20, left: 20),
                //   child: SizedBox(
                //     height: 50,
                //     child: TextFormField(
                //       controller: prisController,
                //       focusNode: prisNode,
                //       textInputAction: TextInputAction.done,
                //       textAlignVertical: TextAlignVertical.center,
                //       // onFieldSubmitted: (value){
                //       //   prisNode.requestFocus();
                //       //   FocusScope.of(context).nextFocus();
                //       // },
                //       decoration: const InputDecoration(
                //         hintText: 'Upload priscription (if any)',
                //         labelText: 'Priscription',
                //         contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //         enabledBorder: OutlineInputBorder(
                //             borderSide:
                //                 BorderSide(width: 1, color: Colors.grey)),
                //         focusedBorder: OutlineInputBorder(
                //             borderSide:
                //                 BorderSide(width: 1, color: Colors.grey)),
                //         suffixIcon: Icon(
                //           Icons.upgrade_sharp,
                //           size: 30,
                //           color: loginTextColor,
                //         ),
                //         // suffix:SvgPicture.asset('assets/svg/upload_arrow.svg',width: 30.0,height: 30.0,
                //         //   fit: BoxFit.scaleDown,)
                //       ),
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: prisController,
                      readOnly: true,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                //this right here
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
                          // hintText: 'Upload priscription (if any)',
                          //labelText: fileName == ''? 'Priscription' : fileName,
                          labelText: 'Priscription',
                          hintText: fileName == ''
                              ? 'Upload priscription (if any)'
                              : fileName,
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
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        //this right here
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Visibility(
                //     visible: widget.type == 1,
                //     child: const Text(
                //         '* Rs.50 will need to pay\n before request')),
                ElevatedButton(
                  onPressed: () {
                    if (mounted) {
                      if (nameController.text.toString().isEmpty) {
                        showErrorSnackBar(context, "Enter your name");
                      } else if (mobileController.text.toString().isEmpty) {
                        showErrorSnackBar(context, "Enter mobile number");
                      }

                      // else if(myCountryCode=="+91"){
                      //   if (mobileController.text.length != 10) {
                      //     showErrorSnackBar(context, "Enter 10 digits mobile number");
                      //   }
                      // }

                      // else if (mobileController.text.length != 10) {
                      //   showErrorSnackBar(
                      //       context, "Enter 10 digits mobile number");
                      // }

                      //New Commment

                      else if (mailController.text.toString().isEmpty) {
                        showErrorSnackBar(context, "Enter email");
                      } else if (!(myMailRegex
                          .hasMatch(mailController.text.toString()))) {
                        showErrorSnackBar(
                            context, 'Please enter valid email address');
                      }
                      //
                      else {
                        setState(() {
                          activeStep = 1;
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: loginTextColor,
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0)),
                  child: Text(
                    'Next',
                    style: zzBoldWhiteTextStyle14A,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  /// ADDRESS DETAILS
  Widget showAddressDetails() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: ScreenSize.getScreenHeight(context),
              width: ScreenSize.getScreenWidth(context),
              child: Column(
                children: [
                  Visibility(
                      visible: widget.type == 2 ? true : false,
                      child: press == 0 ? AddressList2() : showHomeDetails()),
                  // Visibility(
                  //     visible: widget.type == 2 ? true : false,
                  //     child: clinicDetails2())
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: press == 0 ? true : false,
          child: Align(
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
                    // Visibility(
                    //     visible: widget.type == 2,
                    //     child: const Text(
                    //         '* Rs.50 will need to pay\n before request')),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (mounted) {
                            //  if(press==0){
                            setState(() {
                              activeStep = 0;
                              // press=0;
                            });
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: loginTextColor,
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0)),
                      child: Text(
                        'Previous',
                        style: zzBoldWhiteTextStyle14A,
                      ),
                    ),
                    Visibility(
                      //visible:press==0?true:false,
                      visible: widget.type == 2
                          ? false
                          : press == 0
                              ? true
                              : false,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              press = 1;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: loginTextColor,
                              padding:
                                  const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0)),
                          child: const Text('Add Address')),
                    )
                  ]),
            ),
          ),
        ),
        Visibility(
          visible: press == 1 ? true : false,
          child: Align(
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
                    // const Text('* Rs. 50 will need to pay\n before request'),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (mounted) {
                            setState(() {
                              press = 0;
                              activeStep = 0;
                            });
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: loginTextColor,
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0)),
                      child: Text(
                        'Previous',
                        style: zzBoldWhiteTextStyle14A,
                      ),
                    ),
                  ]),
            ),
          ),
        )
      ],
    );
  }

  Widget showHomeDetails() {
    return Visibility(
      visible: press == 1 ? true : false,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          border: Border.all(
            color: lightBlue,
            width: 3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: address1Controller,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: white,
                  hintText: 'House no. / Floor no.',
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grayTxt, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  // hintText: "Your Name",hintStyle:GoogleFonts.lato( color: grayTxt, fontSize: 19.0,),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: address2Controller,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: white,
                  hintText: 'Location (Apartment / Road / Area)',
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grayTxt, width: 1.0),
                  ),
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
              child: TextField(
                keyboardType: TextInputType.number,
                controller: pinController,
                maxLength: 6,
                decoration: const InputDecoration(
                  counterText: "",
                  filled: true,
                  fillColor: white,
                  hintText: '160001',
                  contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grayTxt, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  // hintText: "Your Name",hintStyle:GoogleFonts.lato( color: grayTxt, fontSize: 19.0,),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Label as:",
                  style: GoogleFonts.lato(fontSize: 14.0),
                ),
                Radio(
                  value: 'Home',
                  activeColor: loginTextColor,
                  groupValue: radioButtonDefault,
                  onChanged: (val) {
                    setState(() {
                      radioButtonDefault = 'Home';
                    });
                  },
                ),
                Text(
                  'Home',
                  style: GoogleFonts.lato(fontSize: 14.0),
                ),
                Radio(
                  value: 'Office',
                  activeColor: loginTextColor,
                  groupValue: radioButtonDefault,
                  onChanged: (val) {
                    setState(() {
                      radioButtonDefault = 'Office';
                    });
                  },
                ),
                Text(
                  'Office',
                  style: GoogleFonts.lato(fontSize: 14.0),
                ),
                Radio(
                  value: 'Other',
                  activeColor: loginTextColor,
                  groupValue: radioButtonDefault,
                  onChanged: (val) {
                    setState(() {
                      radioButtonDefault = 'Other';
                    });
                  },
                ),
                Text(
                  'Other',
                  style: GoogleFonts.lato(fontSize: 14.0),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (address1Controller.text.toString().isEmpty) {
                        showErrorSnackBar(context, "Enter house no");
                      } else if (address2Controller.text.toString().isEmpty) {
                        showErrorSnackBar(context, "Enter location");
                      } else if (pinController.text.toString().isEmpty) {
                        showErrorSnackBar(context, "Enter pincode");
                      } else if (pinController.text.length != 6) {
                        showErrorSnackBar(context, "Enter 6 digit pincode");
                      } else {
                        setState(() {
                          //  activeStep = 2;

                          Map<String, dynamic> data = <String, dynamic>{};
                          Map<String, dynamic> aCustomerMap =
                              <String, dynamic>{};

                          data['address1'] = address1Controller.text.toString();
                          data['address2'] = address2Controller.text.toString();
                          data['zip'] = pinController.text.toString();
                          data['company'] = radioButtonDefault;
                          data['default'] = false;
                          //  data['customer_id'] ="207119554";
                          aCustomerMap['customer_address'] = data;
                          setState(() => loading = true);
                          setState(() {
                            addAddress2(aCustomerMap, context);
                            showSuccessSnackBar(
                                context, "Address added successfully!");
                          });

                          address1New = address1Controller.text.toString();
                          address2New = address2Controller.text.toString();
                          pinNew = pinController.text.toString();
                          labelNew = radioButtonDefault;

                          debugPrint('LIST ADDRESS $address1New');
                          debugPrint('LIST ADDRESS PIN $pinNew');
                          debugPrint('LIST ADDRESS LABEL $labelNew');
                          activeStep = 2;
                        });
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(width: 1, color: loginTextColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.only(
                          right: 30, left: 30, top: 10, bottom: 10)),
                  child: Text("Add",
                      style: (GoogleFonts.lato(color: loginTextColor))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget addAddress() {
    return InkWell(
      onTap: () {
        if (address1Controller.text.isEmpty) {
          showErrorSnackBar(context, "Enter address one");
        } else if (address2Controller.text.isEmpty) {
          showErrorSnackBar(context, "Enter address two");
        } else if (pinController.text.isEmpty) {
          showErrorSnackBar(context, "Enter city");
        } else {
          Map<String, dynamic> data = <String, dynamic>{};
          Map<String, dynamic> aCustomerMap = <String, dynamic>{};

          data['address1'] = address1Controller.text.toString();
          data['address2'] = address2Controller.text.toString();
          data['zip'] = pinController.text.toString();
          data['company'] = radioButtonDefault;
          data['default'] = false;
          //  data['customer_id'] ="207119554";
          aCustomerMap['customer_address'] = data;
          setState(() => loading = true);
          addAddress2(aCustomerMap, context);
          //createAddress(aCustomerMap, context);
          showSuccessSnackBar(context, "Address added successfully!");
        }
      },
      child: Container(
          padding: const EdgeInsets.all(20),
          //padding of outer Container
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            color: loginTextColor,
            //color of dotted/dash line
            strokeWidth: 3,
            //thickness of dash/dots
            dashPattern: const [10, 6],
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: lightBlue,
                  ),
                  //inner container
                  height: 50,
                  //height of inner container
                  width: double.infinity,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.add,
                        color: loginTextColor,
                        size: 32,
                      ),
                      Text(
                        "Add Address",
                        style: GoogleFonts.lato(
                            color: loginTextColor, fontSize: 20.0),
                      )
                    ],
                  )),
            ),
          )),
    );
  }

  /// SLOT DETAILS
  Widget showSlotDetails() {
    return Column(children: [
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
                splashColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () {
                  DateTime currentDate = DateTime.now();
                  selectedDate = DateTime(selectedDate.year, selectedDate.month,
                      selectedDate.day - 1);
                  if (selectedDate != currentDate) {
                    setState(() {
                      debugPrint(
                          'SHOW BOOK APPOINTMENT DECREASE: ${selectedDate.isBefore(currentDate)} === ${selectedDate.isAfter(currentDate)}');
                      debugPrint(
                          'SHOW BOOK APPOINTMENT DECREASE 1: $currentDate === $selectedDate');
                      if (selectedDate.isAfter(currentDate)) {
                        mySelectedDate =
                            myDefaultDateFormatOne.format(selectedDate);
                        mySelectedDateForBooking =
                            myDefaultDateFormatForBooking.format(selectedDate);
                      } else {
                        showErrorSnackBar(
                            context, "You are not allowed to this..!");
                      }
                    });
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18.0,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () => showDateSelectionDialog(),
            child: Text(
              mySelectedDateForBooking,
              style: zzRegularBlackTextStyle13A,
            ),
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.black26,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: IconButton(
                splashColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () {
                  selectedDate = DateTime(selectedDate.year, selectedDate.month,
                      selectedDate.day + 1);
                  setState(() {
                    mySelectedDate =
                        myDefaultDateFormatOne.format(selectedDate);
                    mySelectedDateForBooking =
                        myDefaultDateFormatForBooking.format(selectedDate);
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
      Container(
        margin: const EdgeInsets.only(left: 10, right: 10.0),
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
              // childAspectRatio: MediaQuery.of(context).size.width*.5 /
              //     (MediaQuery.of(context).size.height*.5)
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
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(4),
                  // width: 70,
                  // height: 180,
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
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
              color: loginBlue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Visibility(
              //     visible: widget.type == 2,
              //     child:
              //     const Text('* Rs.50 will need to pay\n before request')),
              ElevatedButton(
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      activeStep = 0;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: loginTextColor,
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0)),
                child: Text(
                  'Previous',
                  style: zzBoldWhiteTextStyle14A,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  insertData();

                  Get.to(() => const Cart(fromWhere: 4,productHandle: "",));
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
    ]);
  }

  void insertData() {
    var data = <String, dynamic>{};

    debugPrint('BOOK APPOINTMENT SCREEN PRODUCT ID: ${widget.id}');
    debugPrint('BOOK MOBILE NO: ${mobileController.text}');
    debugPrint('BOOK PINCODE NO: ${pinController.text}');
    debugPrint('BOOK PRICE: ${widget.unitPrice}');
    debugPrint('BOOK ID: $id');
    debugPrint('TRIAL REQUEST TYPE: ${widget.type}');
    debugPrint('BOOK ADDRESS TYPE (RADIO): $radioButtonDefault');

    data['product_id'] = widget.id;
    data['variant_id'] = widget.variantId;
    data['name'] = widget.title;
    data['trial_request_type'] = widget.type;

    data['client_name'] = nameController.text.toString();
    data['clinic_name'] = widget.address;

    debugPrint('BOOK CLINIC ADDRESS: $address');

    data['mobile'] = mobileController.text.toString();
    data['mail'] = mailController.text.toString();
    data['priscription'] = prisController.text.toString();
    data['house_no'] = address1New;

    data['location'] = address2New;

    data['pincode'] = pinNew;
    data['relation']="";
    // data['address_type']=addressType;
    // data['address_type']=radioButtonDefault;

    data['address_type'] = labelNew;
    data['appointment_time'] = "8:00 AM- 8:30 AM";
    data['appointment_date'] = mySelectedDate;
    data['book_price'] = 0;
    data['book_qty'] = 1;
    data['book_total'] = 0;

    // data['pr_type'] = 'book';

    data['created_at'] = currentTime.toString();
    data['updated_at'] = currentTime.toString();

    debugPrint('BOOK TOTAL: ${data['book_total']}');

    localDBHelper!.insertValuesIntoCartTable3(data).then((value) =>
        showSuccessSnackBar(context, "Product added to cart successfully!"));
  }

  // SELECT DATE PICKER DIALOG
  void showDateSelectionDialog() {
    try {
      FocusScope.of(context).unfocus();
      showDatePickerDialog(context, selectedDate, 'future').then((value) {
        if (value != null) {
          if (mounted) {
            setState(() {
              selectedDate = value;
              mySelectedDate = myDefaultDateFormatOne.format(value);
              mySelectedDateForBooking =
                  myDefaultDateFormatForBooking.format(value);
              debugPrint(
                  "SHOW BOOK APPOINTMENT SLOT DATE PICKER: $mySelectedDate === $mySelectedDateForBooking");
            });
          }
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void insertData2(BuildContext context) {
    debugPrint('SLOT INVENTORY QTY: ${widget.invenQty}');
    if (widget.invenQty == 0) {
      showErrorSnackBar(context, "Product is out of stock");
    } else {
      localDBHelper!
          .getParticularCartAddedOrNot(widget.variantId!)
          .then((value) {
        if (value.isNotEmpty) {
          showErrorSnackBar(context, "Product already added to cart");
        } else {
          var data = <String, dynamic>{};
          data['product_id'] = widget.id;
          //  data['pr_type'] = 'order';
          data['variant_id'] = widget.variantId;
          data['product_name'] = widget.title;
          data['product_type'] = widget.productType;
          data['variant_name'] = widget.variantName;
          data['unit_price'] = widget.unitPrice;
          data['quantity'] = 1;
          data['total'] = double.parse(widget.unitPrice!) * 1;

          data['image_url'] = widget.src;
          data['inventory_quantity'] = widget.invenQty;
          data['created_at'] = currentTime.toString();
          data['updated_at'] = currentTime.toString();
          localDBHelper!.insertValuesIntoCartTable(data).then((value) =>
              showSuccessSnackBar(
                  context, "Product added to cart successfully!"));
          getDetails2();
          Get.to(() => const Cart(
                fromWhere: 4,
                productHandle: "",
              ));
        }
      });
    }
  }

  void getDetails2() async {
    Map<String, dynamic> map = <String, dynamic>{};
    map['product_id'] = widget.id;

    map['lens_type'] = '';
    map['priscription'] = '';

    map['frame_name'] = '';
    map['frame_price'] = 0;
    map['frame_qty'] = 1;
    map['frame_total'] = 0;

    map['rd_sph'] = '';
    map['rd_cyl'] = '';
    map['rd_axis'] = '';
    map['rd_bcva'] = '';

    map['ra_sph'] = '';
    map['ra_cyl'] = '';
    map['ra_axis'] = '';
    map['ra_bcva'] = '';

    map['ld_sph'] = '';
    map['ld_cyl'] = '';
    map['ld_axis'] = '';
    map['ld_bcva'] = '';

    map['la_sph'] = '';
    map['la_cyl'] = '';
    map['la_axis'] = '';
    map['la_bcva'] = '';

    map['re'] = '';
    map['le'] = '';

    map['addon_title'] = '';
    map['addon_price'] = 0;
    map['addon_qty'] = 1;
    map['addon_total'] = 0;

    await localDBHelper!.insertValuesIntoCartTable2(map);
  }

  Widget clinicDetails2() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: DropdownButtonFormField(
              dropdownColor: const Color(0xFFC8F8C8),
              iconDisabledColor: Colors.red,
              iconEnabledColor: colorPrimary,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                labelText: "Select State",
                alignLabelWithHint: true,
                filled: true,
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
              value: mySelectedStateId,
              onChanged: (String? newValue) {
                setState(() {
                  mySelectedStateId = newValue!;
                  mySelectedCityId = "0";
                });
              },
              items: selectStates2),
        ),
        SizedBox(height: 3.5.sp),
        Visibility(
          visible: mySelectedStateId != "0",
          child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: DropdownButtonFormField(
                dropdownColor: const Color(0xFFC8F8C8),
                iconDisabledColor: Colors.red,
                iconEnabledColor: colorPrimary,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  labelText: "Select City",
                  alignLabelWithHint: true,
                  filled: true,
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
                value: mySelectedCityId,
                onChanged: (String? newValue) {
                  setState(() {
                    mySelectedCityId = newValue!;
                  });
                },
                items: mySelectedStateId == "1"
                    ? selectCitiesInTamilNadu2
                    : mySelectedStateId == "2"
                        ? selectCitiesInKarnataka
                        : mySelectedStateId == "3"
                            ? selectCitiesInTelangana
                            : mySelectedStateId == "4"
                                ? selectCitiesInMaharashtra
                                : mySelectedStateId == "5"
                                    ? selectCitiesInMathyaPradesh
                                    : selectCitiesInAndhraPradesh),
          ),
        ),
        Visibility(
          visible: mySelectedStateId != "0",
          child: SizedBox(height: 3.5.sp),
        ),
        Expanded(
          child: Visibility(
            visible: mySelectedStateId != "0" && mySelectedCityId != "0",
            child: Container(
              margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.45,
              child: ListView.builder(
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                //itemCount: mySelectedCityId=='1'? karnatakaAddress.length:0,

                itemCount: mySelectedStateId == "1" && mySelectedCityId == "1"
                    ? tamilList.length
                    : mySelectedStateId == "2" && mySelectedCityId == "1"
                        ? karnatakaList.length
                        : mySelectedStateId == "2" && mySelectedCityId == "2"
                            ? karnatakaList2.length
                            : mySelectedStateId == "3" &&
                                    mySelectedCityId == "1"
                                ? telunganaHList.length
                                : mySelectedStateId == "3" &&
                                        mySelectedCityId == "2"
                                    ? telunganaMList.length
                                    : mySelectedStateId == "3" &&
                                            mySelectedCityId == "3"
                                        ? telunganaSList.length
                                        : mySelectedStateId == "3" &&
                                                mySelectedCityId == "4"
                                            ? telunganaVList.length
                                            : mySelectedStateId == "4" &&
                                                    mySelectedCityId == "1"
                                                ? maharastraPList.length
                                                : mySelectedStateId == "4" &&
                                                        mySelectedCityId == "2"
                                                    ? maharastraNList.length
                                                    : mySelectedStateId ==
                                                                "4" &&
                                                            mySelectedCityId ==
                                                                "3"
                                                        ? maharastraMList.length
                                                        : mySelectedStateId ==
                                                                    "5" &&
                                                                mySelectedCityId ==
                                                                    "1"
                                                            ? mathyaPradeshList
                                                                .length
                                                            : mySelectedStateId ==
                                                                        "5" &&
                                                                    mySelectedCityId ==
                                                                        "2"
                                                                ? mathyaPradeshList2
                                                                    .length
                                                                : mySelectedStateId ==
                                                                            "5" &&
                                                                        mySelectedCityId ==
                                                                            "3"
                                                                    ? mathyaPradeshList3
                                                                        .length
                                                                    : andhraPradeshList
                                                                        .length,

                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var model;

                  //TAMILNADU
                  if (mySelectedStateId == "1" && mySelectedCityId == "1") {
                    model = tamilList[index];
                  }
                  //KARNATAKA
                  else if (mySelectedStateId == "2" &&
                      mySelectedCityId == "1") {
                    model = karnatakaList[index];
                  } else if (mySelectedStateId == "2" &&
                      mySelectedCityId == "2") {
                    model = karnatakaList2[index];
                  }
                  //TELUNGANA

                  else if (mySelectedStateId == "3" &&
                      mySelectedCityId == "1") {
                    model = telunganaHList[index];
                  } else if (mySelectedStateId == "3" &&
                      mySelectedCityId == "2") {
                    model = telunganaMList[index];
                  } else if (mySelectedStateId == "3" &&
                      mySelectedCityId == "3") {
                    model = telunganaSList[index];
                  } else if (mySelectedStateId == "3" &&
                      mySelectedCityId == "4") {
                    model = telunganaVList[index];
                  }

                  // MAHARASTRA

                  else if (mySelectedStateId == "4" &&
                      mySelectedCityId == "1") {
                    model = maharastraPList[index];
                  } else if (mySelectedStateId == "4" &&
                      mySelectedCityId == "2") {
                    model = maharastraNList[index];
                  } else if (mySelectedStateId == "4" &&
                      mySelectedCityId == "3") {
                    model = maharastraMList[index];
                  }

                  //MATHYA PRADESH

                  else if (mySelectedStateId == "5" &&
                      mySelectedCityId == "1") {
                    model = mathyaPradeshList[index];
                  } else if (mySelectedStateId == "5" &&
                      mySelectedCityId == "2") {
                    model = mathyaPradeshList2[index];
                  } else if (mySelectedStateId == "5" &&
                      mySelectedCityId == "3") {
                    model = mathyaPradeshList3[index];
                  } else {
                    model = andhraPradeshList[index];
                  }

                  return InkWell(
                    onTap: () {
                      debugPrint('TAMIL LIST SIZE:${tamilList.length}');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          // height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Expanded(
                              //     child: Padding(
                              //         padding: const EdgeInsets.only(
                              //             right: 10),
                              //         child: Image.asset(
                              //             "assets/images/skyblue_glass.png"))),
                              SizedBox(
                                  height: 140,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                        "assets/images/skyblue_glass.png"),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    model.clinicName.toString(),
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.8,
                                    //  height: MediaQuery.of(context).size.height/3,
                                    child: Text(
                                      //  karnatakaAddress[index],
                                      //  mySelectedCityId=='1'? "#123, Lorem ipsum address, \nground floor, New delhi, 110001": keralaAddress[1],
                                      //   mySelectedStateId == "1" && mySelectedCityId == "1"? tamilAddress[index]: mySelectedStateId == "2" && mySelectedCityId == "1"? karnatakaAddress[index]:
                                      //   mySelectedStateId == "2" && mySelectedCityId == "2"? karnatakaAddress2[index]: mySelectedStateId == "3" && mySelectedCityId == "1"? telunganaAddress[index]:
                                      //   mySelectedStateId == "3" && mySelectedCityId == "2"? telunganaAddress2[index]: mySelectedStateId == "3" && mySelectedCityId == "3"? telunganaAddress3[index]:'',

                                      model.address!,
                                      //clinicAddress,
                                      style: GoogleFonts.lato(
                                        fontSize: 13,
                                        letterSpacing: 0.5,
                                      ),
                                      overflow: TextOverflow.visible,
                                      maxLines: 5,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Open ",
                                        style: zzRegularGreenTextStyle12,
                                      ),
                                      Text(
                                        "8:00 AM to 9:00 PM",
                                        style: zzRegularBlackTextStyle10,
                                      ),
                                    ],
                                  ),
                                  // Text('Latitude: ${model.latitude}'),
                                  // Text('Longitude: ${model.longitude}'),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (model.phone == 0) {
                                                makeCallOrSendMessage(
                                                    "call",
                                                    myDefaultLandLineNumber,
                                                    "");
                                              } else {
                                                makeCallOrSendMessage("call",
                                                    model.phone.toString(), "");
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              "assets/svg/call_ayush_icon.svg",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          SvgPicture.asset(
                                            "assets/svg/arrow_ayush_icon.svg",
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          addressSelected = true;
                                          if (addressSelected == true) {
                                            setState(() {
                                              // addressList.add(model.address!);
                                              address = model.address!;
                                              debugPrint(
                                                  'ADDRESS LIST SIZE: ${addressList.length}');
                                              debugPrint('ADDRESS : $address');
                                            });
                                          }
                                          setState(() {
                                            activeStep = 2;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: loginTextColor,
                                            padding: const EdgeInsets.only(
                                                right: 20, left: 20)),
                                        child: Text(
                                          "Select",
                                          style: zzRegularWhiteTextStyle14,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    ));
  }

  Widget AddressList2() {
    return Visibility(
      visible: press == 0 ? true : false,
      child: Column(
        children: [
          addressList.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: addressList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var model = addressList[index];
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: lightBlue,
                            width: 3,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),

                            SizedBox(
                              height: 50,
                              child: TextField(
                                controller: addressControl1[index],
                                // readOnly: edit==0?true:false,
                                readOnly: index1 == index ? false : true,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: grayTxt, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: grayTxt, width: 1.0),
                                  ),
                                  hintText: "House No. / Floor No.",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              child: TextField(
                                controller: addressControl2[index],
                                // readOnly: edit==0?true:false,
                                readOnly: index1 == index ? false : true,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: grayTxt, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: grayTxt, width: 1.0),
                                  ),
                                  hintText: "Location (Apartment/Road/Area)",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              child: TextField(
                                controller: pinControl[index],
                                // readOnly: edit==0?true:false,
                                readOnly: index1 == index ? false : true,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: grayTxt, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: grayTxt, width: 1.0),
                                  ),
                                  hintText: "Pincode",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            // TextFormField(
                            //   decoration: const InputDecoration(
                            //     border:  OutlineInputBorder(),
                            //    // hintText: 'Enter Experience',
                            //     //labelText: 'Experience',
                            //   ),
                            // ),
                            Row(
                              children: [
                                Text(
                                  "Label as:",
                                  style: GoogleFonts.lato(fontSize: 14.0),
                                ),
                                Radio(
                                  value: 'Home',
                                  activeColor: loginTextColor,
                                  //  hoverColor: loginTextColor,
                                  //focusColor: loginTextColor,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => loginTextColor),
                                  groupValue: model.company,
                                  onChanged: index1 == index
                                      ? (val) {
                                          //onChanged:edit==1?(val) {
                                          setState(() {
                                            // radioButtonItem = 'ONE';
                                            id = 1;
                                            //  radioButtonDefault='Home';
                                            model.company = 'Home';
                                          });
                                        }
                                      : null,
                                ),
                                Text(
                                  'Home',
                                  style: GoogleFonts.lato(fontSize: 14.0),
                                ),
                                Radio(
                                  value: 'Office',
                                  activeColor: loginTextColor,
                                  groupValue: model.company,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => loginTextColor),
                                  onChanged: index1 == index
                                      ? (val) {
                                          setState(() {
                                            // radioButtonItem = 'TWO';
                                            id = 2;
                                            // radioButtonDefault='Office';
                                            model.company = 'Office';
                                          });
                                        }
                                      : null,
                                ),
                                Text(
                                  'Office',
                                  style: GoogleFonts.lato(fontSize: 14.0),
                                ),
                                Radio(
                                  value: 'Other',
                                  activeColor: loginTextColor,
                                  groupValue: model.company,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => loginTextColor),
                                  onChanged: index1 == index
                                      ? (val) {
                                          setState(() {
                                            // radioButtonItem = 'THREE';
                                            id = 3;
                                            //   radioButtonDefault='Other';
                                            model.company = 'Other';
                                          });
                                        }
                                      : null,
                                ),
                                Text(
                                  'Other',
                                  style: GoogleFonts.lato(fontSize: 14.0),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    debugPrint('LIST ADDRESS ');
                                    setState(() {
                                      address1New = addressControl1[index]
                                          .text
                                          .toString();
                                      address2New = addressControl2[index]
                                          .text
                                          .toString();
                                      pinNew =
                                          pinControl[index].text.toString();
                                      debugPrint('LIST ADDRESS PIN $pinNew');
                                      debugPrint(
                                          'LIST ADDRESS LABEL $labelNew');
                                      labelNew = model.company!;
                                      debugPrint('LIST ADDRESS $address1New');
                                      activeStep = 2;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                          width: 1, color: loginTextColor),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      padding: const EdgeInsets.only(
                                          right: 30,
                                          left: 30,
                                          top: 10,
                                          bottom: 10)),
                                  child: Text(
                                    "Select",
                                    style: (GoogleFonts.lato(
                                        color: loginTextColor)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text(
                  'You have not added any addres kindly add one by clicking Add Address button',
                )),
        ],
      ),
    );
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
