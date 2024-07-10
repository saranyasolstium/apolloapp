import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../../utils/packeages.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String? type;
  final int? productId;
  final int? variantId;
  final String? productName;
  final double? price;

  const BookAppointmentScreen(
      {Key? key,
      this.type,
      this.productId,
      this.variantId,
      this.productName,
      this.price})
      : super(key: key);

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  int activeStep = 0;
  int dotCount = 3;

  // YOUR DETAILS
  String myCountryCode = "+91";
  String radioButtonItem = 'ONE';
  int id = 1;
  String addressType = '';

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
  int? checkedIndex;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateTimeForManipulation = DateTime.now();
  String mySelectedDate = "", mySelectedDateForBooking = "";
  int myDefaultDateForIncAndDec = 0;
  String clinicAddress = '';
  String address = '';
  bool addressSelected = false;
  int aId = 0;
  int button = 0;
  String radioButtonDefault = 'Home';
  late List<AddressModel> addressList = [];
  List<int> slotList = [];
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
  bool absorbPointer = false;
  bool absorbPointer2 = false;
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
  String? selectedSlot;
  String aName = "", aMobile = "", aMail = "", aLastN = '';

  int radioValue = 1;
  String dropDownValue3 = '0';


  @override
  void initState() {
    loading = true;
    mySelectedDate = myDefaultDateFormatOne.format(selectedDate).toString();
    mySelectedDateForBooking =
        myDefaultDateFormatForBooking.format(selectedDate).toString();
    super.initState();
    aId = sharedPreferences!.getInt("id")!.toInt();
    aMail = sharedPreferences!.getString("mail").toString();
    aName = sharedPreferences!.getString("firstName").toString();
    aLastN = sharedPreferences!.getString("lastName").toString();
    aMobile = sharedPreferences!.getString("mobileNumber").toString();
    nameController.text = aName.toString();
    // lastController.text = aLastN.toString();
    mailController.text = aMail.toString();
    mobileController.text = aMobile.toString();
    radioValue = 1;
    setState(() {
      getList();
    });
    press = 0;
    currentTime = DateTime.now();
    // dateTime();
  }

  void addAddress2(Map<String, dynamic> data, BuildContext context) {
    try {
      DioClient(
              myUrl: '${EndPoints.createCustomerAddress}$aId/addresses.json',
              myMap: data)
          .post()
          .then((value) {
        if (value.statusCode == 201) {
          showSuccessSnackBar(context, "Address added successfully!");
          setState(() {
            press = 0;
            getList();
            var aCustomerMap = value.data['customer_address'];
          });

          /* int aId = aCustomerMap['id'];
          String address1 = aCustomerMap['address1'] ?? '';
          String address2 = aCustomerMap['address2'] ?? '';*/
        } else {
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
        setState(() {
          if (value.isNotEmpty) {
            loading = true;
            addressList = [];
            for (AddressModel model in value) {
              if (model.address1 != null &&
                  model.address1!.isNotEmpty &&
                  model.address2 != null &&
                  model.address2!.isNotEmpty &&
                  model.pincode != null &&
                  model.pincode!.isNotEmpty) {
                addressId = model.id!;
                addressList.add(model);
              }
            }
            addressControl1 = [];
            addressControl2 = [];
            pinControl = [];
            for (int i = 0; i < addressList.length; i++) {
              AddressModel model = addressList[i];
              TextEditingController controllerF = TextEditingController();
              TextEditingController controllerF2 = TextEditingController();
              TextEditingController controllerP = TextEditingController();

              controllerF.text = model.address1!;
              controllerF2.text = model.address2!;
              controllerP.text = model.pincode!;

              addressControl1.add(controllerF);
              addressControl2.add(controllerF2);
              pinControl.add(controllerP);
            }
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
    return WillPopScope(
        onWillPop: () {
          Get.off(() => EarDetailScreen(id: widget.productId));

          return Future.value(true);
        },
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              endDrawer: const NavigationWidget(),
              appBar: AppBar(
                backgroundColor: loginTextColor,
                title: Text(
                  "Book Appointment",
                  style: zzRegularWhiteAppBarTextStyle14,
                ),
                leading: InkWell(
                  onTap: () {
                    Get.off(() => EarDetailScreen(id: widget.productId));
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
                  ),
                  //IconButton
                ], //
              ),
              body: Column(children: [
                Container(
                  color: loginBlue,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      activeStep == 0
                          ? SvgPicture.asset("assets/svg/profile_img2.svg")
                          : activeStep == 1
                              ? SvgPicture.asset("assets/svg/profile_img2.svg")
                              : SvgPicture.asset("assets/svg/radio_symbol.svg"),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        activeStep == 0
                            ? "Your Details"
                            : activeStep == 1
                                ? widget.type! == "In Home"
                                    ? "Address Details"
                                    : "Clinic Details"
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
                            dotCount: 3,
                            dotRadius: 12,
                            activeStep: activeStep,
                            shape: Shape.circle,
                            spacing: 40,
                            tappingEnabled: false,

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
                        ? showYourDetails(context)
                        : activeStep == 1
                            ? showAddressDetails(context)
                            : showSlotDetails(context))
              ])),
        ));
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            child: SizedBox(
              height: 160,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select from Image or Gallery',
                        textAlign: TextAlign.center),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              getImage(ImageSource.camera, context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: loginTextColor,
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0, 20.0, 0)),
                            child: const Text(
                              'Camera',
                              style: TextStyle(color: Colors.white),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              getImage(ImageSource.gallery, context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: loginTextColor,
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0, 20.0, 0)),
                            child: const Text(
                              'Gallery',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  /// YOUR DETAILS
  Widget showYourDetails(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  RichText(
                    text: TextSpan(
                        text: "Relationship Type",
                        style: zzBoldBlackTextStyle13,
                        children: const [
                          TextSpan(
                              text: ' *',
                              style: TextStyle(color: red, fontSize: 13))
                        ]),
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: 85,
                    height: 50,
                    child: RadioListTile(
                      value: 1,
                      groupValue: radioValue,
                      contentPadding: EdgeInsets.zero,
                      activeColor: loginTextColor,
                      onChanged: (int? value) {
                        setState(() {
                          radioValue = value!;
                          nameController.text = aName.toString();
                          mailController.text = aMail.toString();
                          mobileController.text = aMobile.toString();
                        });
                      },
                      title: Text("Self", style: zzBoldBlackTextStyle10),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: RadioListTile(
                      value: 2,
                      groupValue: radioValue,
                      contentPadding: EdgeInsets.zero,
                      activeColor: loginTextColor,
                      onChanged: (int? value) {
                        setState(() {
                          radioValue = value!;
                          nameController.text = aName.toString();
                          mailController.text = aMail.toString();
                          mobileController.text = aMobile.toString();
                        });
                      },
                      title: Text(
                        "Other",
                        style: zzBoldBlackTextStyle10,
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: radioValue == 2 ? 5 : 0,
              ),
              Visibility(
                visible: radioValue == 2,
                child: Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  height: 50,
                  child: InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(2.5.w, 0, 2.5.w, 0),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        )),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          isDense: true,
                          isExpanded: true,
                          value: dropDownValue3,
                          items: selectRelationShipTypes,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue3 = newValue!;
                              print(newValue);
                            });
                          }),
                    ),
                  ),
                ),
              ),
              SizedBox(height: radioValue == 2 ? 20 : 0),
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
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
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
                            },
                            initialSelection: 'IN',
                            favorite: const ['+91', 'IN'],
                            showCountryOnly: true,
                            enabled: false,
                            showFlag: false,
                            showDropDownButton: false,
                            showOnlyCountryWhenClosed: false,
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
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
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
                    controller: prisController,
                    readOnly: true,
                    onTap: () {
                      setState(() {
                        showAlert(context);
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        labelText: 'Priscription',
                        hintText: fileName == ''
                            ? 'Upload priscription (if any)'
                            : '',
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                showAlert(context);
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
                Visibility(
                    visible: widget.type! == "In Home",
                    child: const Text(
                        '* Rs. 50 will need to pay\n before request')),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (mounted) {
                      if (nameController.text.toString().isEmpty) {
                        showErrorSnackBar(context, "Enter your name");
                      } else if (mobileController.text.toString().isEmpty) {
                        showErrorSnackBar(context, "Enter mobile number");
                      } else if (mobileController.text.length <= 10) {
                        showErrorSnackBar(
                            context, "Enter 10 digits mobile number");
                      } else if (mailController.text.toString().isEmpty) {
                        showErrorSnackBar(context, "Enter email");
                      } else if (!(myMailRegex
                          .hasMatch(mailController.text.toString()))) {
                        showErrorSnackBar(
                            context, 'Please enter valid email address');
                      } else if (prisController.text.isEmpty) {
                        showErrorSnackBar(
                            context, "Please attach priscription");
                      } else if (radioValue == 2 && dropDownValue3 == '0') {
                        showErrorSnackBar(
                            context, "Please select relationship type");
                      }
                      
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
  Widget showAddressDetails(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(children: [
            Visibility(
                visible: widget.type == 'In Home' ? true : false,
                child: press == 0 ? addressList2() : showHomeDetails(context)),
            if (widget.type == 'Visit clinic' ? true : false)
              clinicDetails2(context),
          ]),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Visibility(
                visible: press == 0 ? true : false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0)),
                        color: loginBlue),
                    child: Row(
                        mainAxisAlignment: widget.type! == "In Home"
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.end,
                        children: [
                          Visibility(
                              visible: widget.type! == "In Home",
                              child: const Text(
                                  '* Rs. 50 will need to\n pay before request')),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (mounted) {
                                  setState(() {
                                    activeStep = 0;
                                  });
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: loginTextColor,
                                padding:
                                    const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0)),
                            child: Text(
                              'Previous',
                              style: zzBoldBlueDarkTextStyle10A1,
                            ),
                          ),
                          Visibility(
                            visible: widget.type == 'Visit clinic'
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
                                    padding: const EdgeInsets.fromLTRB(
                                        5.0, 0, 5.0, 0)),
                                child: Text('Add Address',
                                    style: zzBoldBlueDarkTextStyle10A1)),
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
                          Visibility(
                              visible: widget.type! == "In Home",
                              child: const Text(
                                  '* Rs. 50 will need to pay\n before request')),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (mounted) {
                                  setState(() {
                                    press = 0;
                                    address1Controller.clear();
                                    address2Controller.clear();
                                    pinController.clear();
                                    radioButtonDefault = 'Home';
                                  });
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: loginTextColor,
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0, 10.0, 0)),
                            child: Text(
                              'Previous',
                              style: zzBoldBlueDarkTextStyle10A1,
                            ),
                          ),
                        ]),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget showHomeDetails(BuildContext context) {
    return Visibility(
      visible: press == 1 ? true : false,
      child: Expanded(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: lightBlue,
                width: 3,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              children: [
                
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: pinController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: white,
                      hintText: 'Pincode',
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
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
                            FocusScope.of(context).unfocus();
                            showErrorSnackBar(context, "Enter house no");
                            
                          } else if (address2Controller.text
                              .toString()
                              .isEmpty) {
                            
                            FocusScope.of(context).unfocus();
                            showErrorSnackBar(context, "Enter location");
                            
                          } else if (pinController.text.toString().isEmpty) {
                            FocusScope.of(context).unfocus();
                            showErrorSnackBar(context, "Enter pincode");
                           
                          } else if (pinController.text.length != 6) {
                            FocusScope.of(context).unfocus();
                            showErrorSnackBar(context, "Enter 6 digit pincode");
                            
                          } else {
                            FocusScope.of(context).unfocus();
                            setState(() {

                              Map<String, dynamic> data = <String, dynamic>{};
                              Map<String, dynamic> aCustomerMap =
                                  <String, dynamic>{};

                              data['address1'] =
                                  address1Controller.text.toString();
                              data['address2'] =
                                  address2Controller.text.toString();
                              data['zip'] = pinController.text.toString();
                              data['company'] = radioButtonDefault;
                              data['default'] = false;
                              aCustomerMap['customer_address'] = data;
                              setState(() => loading = true);
                              setState(() {
                                addAddress2(aCustomerMap, context);
                              });
                              
                            });
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side:
                              const BorderSide(width: 1, color: loginTextColor),
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
        ),
      ),
    );
  }

  /// SLOT DETAILS
  Widget showSlotDetails(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AbsorbPointer(
              absorbing: absorbPointer2,
              child: CircleAvatar(
                radius: 17,
                backgroundColor: Colors.black26,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        checkedIndex = -1;
                        DateTime currentDate = DateTime.now();
                        DateTime now = DateTime.now();
                        String formattedDate = DateFormat.yMd().format(now);
                        String formattedDate2 =
                            DateFormat.yMd().format(selectedDate);

                        if (selectedDate.isBefore(now)) {
                          debugPrint('HELLO 1 IF');
                          absorbPointer2 = true;
                          showErrorSnackBar(
                              context, "You are not allowed to this..!");
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              absorbPointer2 = false;
                            });
                          });
                        } else {
                          debugPrint('HELLO 2 ELSE');

                          selectedDate = DateTime(selectedDate.year,
                              selectedDate.month, selectedDate.day - 1);
                          mySelectedDate =
                              myDefaultDateFormatOne.format(selectedDate);
                          mySelectedDateForBooking =
                              myDefaultDateFormatForBooking
                                  .format(selectedDate);
                        }
                        if (selectedDate.isAfter(currentDate)) {
                          debugPrint('HELLO 3 IF');
                          mySelectedDate =
                              myDefaultDateFormatOne.format(selectedDate);
                          mySelectedDateForBooking =
                              myDefaultDateFormatForBooking
                                  .format(selectedDate);
                        } else if (formattedDate == formattedDate2) {
                          debugPrint('HELLO 4 EQUAL');
                          mySelectedDate =
                              myDefaultDateFormatOne.format(selectedDate);
                          mySelectedDateForBooking =
                              myDefaultDateFormatForBooking
                                  .format(selectedDate);
                        }
                        
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => showDateSelectionDialog(context),
              child: Text(
                mySelectedDateForBooking,
                style: zzRegularBlackTextStyle13A,
              ),
            ),
            CircleAvatar(
              radius: 17,
              backgroundColor: Colors.black26,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: IconButton(
                  splashColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      checkedIndex = -1;
                      selectedDate = DateTime(selectedDate.year,
                          selectedDate.month, selectedDate.day + 1);
                      mySelectedDate =
                          myDefaultDateFormatOne.format(selectedDate);
                      mySelectedDateForBooking =
                          myDefaultDateFormatForBooking.format(selectedDate);
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Divider(
        color: Colors.black26,
        thickness: 3,
        indent: 1.5.w,
        endIndent: 1.5.w,
      ),
      const SizedBox(
        height: 10,
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
          child: GridView.builder(
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1.4,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 2 / 1),
              shrinkWrap: true,
              itemCount: 24,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              itemBuilder: (BuildContext context, int index) {
                int hours = (index + 16) ~/ 2;
                int minutes = ((index + 16) % 2) * 30;
                DateTime time = DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day, hours, minutes);

                String formattedTime =
                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                DateFormat.jm().format(time);
                debugPrint('${'SLOT NOW ::'}${DateFormat.jm().format(time)}');

                int hours2 = (index + 1 + 16) ~/ 2;
                debugPrint('SLOT INDEX2 $index');
                debugPrint('SLOT HOUR2 $hours');
                int minutes2 = ((index + 1 + 16) % 2) * 30;
                debugPrint('SLOT MINS $minutes2');
                DateTime time2 = DateTime(selectedDate.year, selectedDate.month,
                    selectedDate.day, hours2, minutes2);
                debugPrint(
                    '${'SLOT FINAL ::'}${DateFormat.jm().format(time)}${'-'}${DateFormat.jm().format(time2)}');

                var startTime = DateFormat.jm().format(time);
                var endTime = DateFormat.jm().format(time2);
                debugPrint('SLOT TIME 2:: $time2');
                final DateFormat formatter =
                    DateFormat('MMMM dd, yyyy AT h:mm a');
                final String formatted = formatter.format(selectedDate);

                return AbsorbPointer(
                  absorbing: absorbPointer,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        print('varshan');
                        DateTime currentDate = DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day);
                        DateTime selectedDateOnly = DateTime(selectedDate.year,
                            selectedDate.month, selectedDate.day);

                        print(selectedDate);
                        print(DateTime.now());
                        if (selectedDateOnly.isAtSameMomentAs(currentDate) ||
                            selectedDate.isAfter(DateTime.now())) {
                          DateTime twoHoursAhead =
                              DateTime.now().add(const Duration(hours: 2));

                          if (time2.isAfter(twoHoursAhead)) {
                            checkedIndex = index;
                            selectedSlot = '$startTime${'-'}$endTime';
                          } else {
                            absorbPointer = true;
                            checkedIndex = -1;
                            selectedSlot = '';
                            showErrorSnackBar(context,
                                "Please select a time slot at least two hours ahead");
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                absorbPointer = false;
                              });
                            });
                          }
                        } else {
                          absorbPointer = true;
                          checkedIndex = -1;
                          selectedSlot = '';
                          showErrorSnackBar(context,
                              "Please select a time slot at least two hours ahead");
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              absorbPointer = false;
                            });
                          });
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: (checkedIndex == index ? green1 : grayDark),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      padding: const EdgeInsets.all(1),
                      margin: const EdgeInsets.all(3),
                      
                      child: Center(
                          child: Text('$startTime${'-'}$endTime',
                              style: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: (checkedIndex == index
                                      ? Colors.white
                                      : Colors.black26)))),
                    ),
                  ),
                );
              }),
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
              Visibility(
                  visible: widget.type! == "In Home",
                  child:
                      const Text('* Rs.50 will need to\npay before request')),
              ElevatedButton(
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      activeStep = 1;
                      checkedIndex = -1;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: loginTextColor,
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0)),
                child: Text(
                  'Previous',
                  style: zzBoldBlueDarkTextStyle10A1,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint('SELECTED SLOT $selectedSlot');
                  debugPrint('SELECTED  CHECK INDEX  $checkedIndex');

                  if (checkedIndex == -1 || checkedIndex == null) {
                    showErrorSnackBar(context, 'Please select time slot');
                   
                  } else {
                    print(dropDownValue3);
                    insertData(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: loginTextColor,
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0)),
                child: Text(
                  'Add to cart',
                  style: zzBoldBlueDarkTextStyle10A1,
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  // SELECT DATE PICKER DIALOG
  void showDateSelectionDialog(BuildContext context) {
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

  void insertData(BuildContext context) {
    var data = <String, dynamic>{};

    debugPrint('BOOK APPOINTMENT SCREEN PRODUCT ID: ${widget.productId}');
    debugPrint('BOOK MOBILE NO: ${mobileController.text}');
    debugPrint('BOOK PINCODE NO: ${pinController.text}');
    debugPrint('BOOK PRICE: ${widget.price}');
    debugPrint('BOOK ID: $id');
    debugPrint('TRIAL REQUEST TYPE: ${widget.type}');
    debugPrint('BOOK ADDRESS TYPE: $addressType');
    debugPrint('BOOK ADDRESS TYPE (RADIO): $radioButtonDefault');

    data['product_id'] = widget.productId;
    data['variant_id'] = widget.variantId;
    
    data['name'] = widget.productName;
    data['trial_request_type'] = widget.type;

    data['client_name'] = nameController.text.toString();
    data['clinic_name'] = address;

    debugPrint('BOOK CLINIC ADDRESS: $address');

    data['mobile'] = mobileController.text.toString();
    data['mail'] = mailController.text.toString();
    data['house_no'] = address1New;
    data['location'] = address2New;
    data['pincode'] = pinNew;
    data['priscription'] = fileName;
    data['address_type'] = labelNew;
    data['appointment_time'] = selectedSlot;
    data['appointment_date'] = mySelectedDate;
    data['book_price'] = widget.type == "In Home" ? 50 : 0;
    data['book_qty'] = 1;
    data['book_total'] = widget.type == "In Home" ? 50 : 0;

    data['created_at'] = currentTime.toString();
    data['updated_at'] = currentTime.toString();
    data['relation'] = dropDownValue3;
    debugPrint('BOOK TOTAL: ${data['total']}');

    localDBHelper!.insertValuesIntoCartTable3(data).then((value) =>
        showSuccessSnackBar(context, "Product added to cart successfully!"));
    Get.off(() => Cart(
          fromBook: 1,
          fromWhere: 3,
          productId: widget.productId,
          routeType: "trial_request",
          productHandle: "",
          relation: dropDownValue3,
        ));
  }

  Future<void> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        debugPrint(
            "Address: ${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}");
      } else {
        debugPrint("No address found for the given coordinates.");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void launchMap(String address, double latitude, double longitude) async {
    String query = Uri.encodeComponent(address);
    getAddress(latitude, longitude);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  Widget clinicDetails2(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeight = MediaQuery.of(context).size.height * 0.27;
    return Expanded(
        child: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.075,
        margin: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: DropdownButtonFormField(
            dropdownColor: const Color(0xFFC8F8C8),
            iconDisabledColor: Colors.red,
            iconEnabledColor: colorPrimary,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
            items: selectTrialRequest),
      ),
      SizedBox(height: 3.5.sp),
      Visibility(
        visible: mySelectedStateId != "0",
        child: Container(
          height: MediaQuery.of(context).size.height * 0.075,
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: DropdownButtonFormField(
              dropdownColor: const Color(0xFFC8F8C8),
              iconDisabledColor: Colors.red,
              iconEnabledColor: colorPrimary,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                  ? selectCitiesInAndhraPradesh
                  : mySelectedStateId == "2"
                      ? selectCitiesInKarnataka
                      : mySelectedStateId == "3"
                          ? selectCitiesInMaharashtra
                          : mySelectedStateId == "4"
                              ? selectCitiesInMathyaPradesh
                              : mySelectedStateId == "5"
                                  ? selectCitiesInTamilNadu2
                                  : selectCitiesInTelangana),
        ),
      ),
      if (mySelectedStateId != "0" && mySelectedCityId != "0")
        Expanded(
          child: ListView.builder(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,

            itemCount: mySelectedStateId == "1" && mySelectedCityId == "1"
                ? andhraPradeshList.length
                : mySelectedStateId == "2" && mySelectedCityId == "1"
                    ? karnatakaList.length
                    : mySelectedStateId == "2" && mySelectedCityId == "2"
                        ? karnatakaList2.length
                        : mySelectedStateId == "3" && mySelectedCityId == "1"
                            ? maharastraMList.length
                            : mySelectedStateId == "3" &&
                                    mySelectedCityId == "2"
                                ? maharastraNList.length
                                : mySelectedStateId == "3" &&
                                        mySelectedCityId == "3"
                                    ? maharastraPList.length
                                    : mySelectedStateId == "4" &&
                                            mySelectedCityId == "1"
                                        ? mathyaPradeshList2.length
                                        : mySelectedStateId == "4" &&
                                                mySelectedCityId == "2"
                                            ? mathyaPradeshList3.length
                                            : mySelectedStateId == "4" &&
                                                    mySelectedCityId == "3"
                                                ? mathyaPradeshList.length
                                                : mySelectedStateId == "5" &&
                                                        mySelectedCityId == "1"
                                                    ? tamilList.length
                                                    : mySelectedStateId ==
                                                                "6" &&
                                                            mySelectedCityId ==
                                                                "1"
                                                        ? telunganaHList.length
                                                        : mySelectedStateId ==
                                                                    "6" &&
                                                                mySelectedCityId ==
                                                                    "2"
                                                            ? telunganaMList
                                                                .length
                                                            : mySelectedStateId ==
                                                                        "6" &&
                                                                    mySelectedCityId ==
                                                                        "3"
                                                                ? telunganaSList
                                                                    .length
                                                                : telunganaVList
                                                                    .length,

            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              ClinicModel model;

              //ANDHRA PRADESH
              if (mySelectedStateId == "1" && mySelectedCityId == "1") {
                model = andhraPradeshList[index];
              }
              //KARNATAKA
              else if (mySelectedStateId == "2" && mySelectedCityId == "1") {
                model = karnatakaList[index];
              } else if (mySelectedStateId == "2" && mySelectedCityId == "2") {
                model = karnatakaList2[index];
              }
              //MAHARASTRA

              else if (mySelectedStateId == "3" && mySelectedCityId == "1") {
                model = maharastraMList[index];
              } else if (mySelectedStateId == "3" && mySelectedCityId == "2") {
                model = maharastraNList[index];
              } else if (mySelectedStateId == "3" && mySelectedCityId == "3") {
                model = maharastraPList[index];
              }

              //MATHYA PRADESH

              else if (mySelectedStateId == "4" && mySelectedCityId == "1") {
                model = mathyaPradeshList2[index];
              } else if (mySelectedStateId == "4" && mySelectedCityId == "2") {
                model = mathyaPradeshList3[index];
              } else if (mySelectedStateId == "4" && mySelectedCityId == "3") {
                model = mathyaPradeshList[index];
              }

              //TAMIL NADU

              else if (mySelectedStateId == "5" && mySelectedCityId == "1") {
                model = tamilList[index];
              }
              //TELUNGANA

              else if (mySelectedStateId == "6" && mySelectedCityId == "1") {
                model = telunganaHList[index];
              } else if (mySelectedStateId == "6" && mySelectedCityId == "2") {
                model = telunganaMList[index];
              } else if (mySelectedStateId == "6" && mySelectedCityId == "3") {
                model = telunganaSList[index];
              } else {
                model = telunganaVList[index];
              }

              return InkWell(
                onTap: () {
                  debugPrint('TAMIL LIST SIZE:' + tamilList.length.toString());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      // height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.clinicName.toString(),
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              model.address!,
                              style: GoogleFonts.lato(
                                fontSize: 13,
                                letterSpacing: 0.5,
                              ),
                              overflow: TextOverflow.visible,
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (model.phone == 0) {
                                      makeCallOrSendMessage(
                                          "call", myDefaultLandLineNumber, "");
                                    } else {
                                      makeCallOrSendMessage(
                                          "call", model.phone.toString(), "");
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    "assets/svg/call_ayush_icon.svg",
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    debugPrint(
                                        "BOOK APPOINTMENT SCREEN VISIT CLINIC LNG: ${model.longitude} LAT: ${model.latitude}");
                                    // openMap(model.latitude!,model.longitude!);
                                    // launchMap(model.address!);
                                    launchMap(model.address!, model.latitude!,
                                        model.longitude!);
                                  },
                                  child: SvgPicture.asset(
                                    "assets/svg/arrow_ayush_icon.svg",
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    addressSelected = true;
                                    if (addressSelected == true) {
                                      setState(() {
                                        // addressList.add(model.address!);
                                        // addressList.add(model);
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
    ]));
  }

  Widget addressList2() {
    return Visibility(
      visible: press == 0 ? true : false,
      child: Expanded(
        child: addressList.isEmpty
            ? Center(
                child: Text(
                  "No addresses added.",
                  style: zzBoldBlueDarkTextStyle14,
                ),
              )
            : ListView.builder(
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                physics: const ClampingScrollPhysics(),
                itemCount: addressList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var model = addressList[index];
                  print('havish');
                  print(addressList.length);
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * 0.5,
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
                            controller:
                                TextEditingController(text: model.address1),
                            readOnly: index1 == index ? false : true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                            controller:
                                TextEditingController(text: model.address2),
                            readOnly: index1 == index ? false : true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                            controller:
                                TextEditingController(text: model.pincode),
                            readOnly: index1 == index ? false : true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                        Row(
                          children: [
                            Text(
                              "Label as:",
                              style: GoogleFonts.lato(fontSize: 14.0),
                            ),
                            Visibility(
                              visible: model.company == 'Home',
                              child: Radio(
                                value: 'Home',
                                activeColor: loginTextColor,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => loginTextColor),
                                groupValue: model.company,
                                onChanged: index1 == index
                                    ? (val) {
                                        setState(() {
                                          id = 1;
                                          model.company = 'Home';
                                        });
                                      }
                                    : null,
                              ),
                            ),
                            Visibility(
                              visible: model.company == 'Home',
                              child: Text(
                                'Home',
                                style: GoogleFonts.lato(fontSize: 14.0),
                              ),
                            ),
                            Visibility(
                              visible: model.company == 'Office',
                              child: Radio(
                                value: 'Office',
                                activeColor: loginTextColor,
                                groupValue: model.company,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => loginTextColor),
                                onChanged: index1 == index
                                    ? (val) {
                                        setState(() {
                                          id = 2;
                                          model.company = 'Office';
                                        });
                                      }
                                    : null,
                              ),
                            ),
                            Visibility(
                              visible: model.company == 'Office',
                              child: Text(
                                'Office',
                                style: GoogleFonts.lato(fontSize: 14.0),
                              ),
                            ),
                            Visibility(
                              visible: model.company == 'Other',
                              child: Radio(
                                value: 'Other',
                                activeColor: loginTextColor,
                                groupValue: model.company,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => loginTextColor),
                                onChanged: index1 == index
                                    ? (val) {
                                        setState(() {
                                          id = 3;
                                          model.company = 'Other';
                                        });
                                      }
                                    : null,
                              ),
                            ),
                            Visibility(
                              visible: model.company == 'Other',
                              child: Text(
                                'Other',
                                style: GoogleFonts.lato(fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  address1New =
                                      addressControl1[index].text.toString();
                                  address2New =
                                      addressControl2[index].text.toString();
                                  pinNew = pinControl[index].text.toString();

                                  labelNew = model.company!;
                                  if (address1New.isEmpty) {
                                    showErrorSnackBar(
                                        context, "Enter House No field");
                                  } else if (address2New.isEmpty) {
                                    showErrorSnackBar(
                                        context, "Enter Location field");
                                  } else if (pinNew.isEmpty) {
                                    showErrorSnackBar(
                                        context, "Enter Pincode field");
                                  } else {
                                    activeStep = 2;
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                      width: 1, color: loginTextColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  padding: const EdgeInsets.only(
                                      right: 30,
                                      left: 30,
                                      top: 10,
                                      bottom: 10)),
                              child: Text(
                                "Select",
                                style:
                                    (GoogleFonts.lato(color: loginTextColor)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future getImage(ImageSource img, BuildContext context) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          imgFile = XFile(pickedFile!.path);
          fileName = imgFile!.path.split('/').last;
          debugPrint('FILE: ${pickedFile.path}');
          debugPrint('FILE: $fileName');
          prisController.text = fileName;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
