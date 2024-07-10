import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/services/network/dio_client.dart';
import 'package:infinite/services/network/endpoints.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/packeages.dart';

import '../model/address_model.dart';

class ManageAddress extends StatefulWidget {
  const ManageAddress({Key? key}) : super(key: key);

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  String radioButtonItem = 'ONE';
  String radioButtonDefault = 'Home';
  int id = 1;
  int defaultId = 0;
  int aId = 0;
  int tap = -1;
  bool? tapBool;
  bool absorbPointer = true;
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController pinController = TextEditingController();
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
  int? label = 0;
  int? back = 0;
  @override
  void initState() {
    super.initState();
    loading = true;
    aId = sharedPreferences!.getInt("id")!.toInt();

    debugPrint('CUSTOMER ID: $aId');
    getList();
    setState(() {
      addressList = [];
      getList();
      press = 0;
    });
  }

  void addAddress(Map<String, dynamic> data, BuildContext context) {
    try {
      DioClient(
              myUrl: '${EndPoints.createCustomerAddress}$aId/addresses.json',
              myMap: data)
          .post()
          .then((value) {
        debugPrint('ADDRESS: $value');
        debugPrint('STATUS CODE  ${value.statusCode}');
        if (value.statusCode == 201) {
          showSuccessSnackBar(context, 'Address added successfully');
          edit = 0;
          index1 = -1;
          press = 0;

          setState(() {
            loading = true;
            getList();
            address1Controller.text = '';
            address2Controller.text = '';
            pinController.text = '';
            debool2 = false;
            radioButtonDefault = 'Home';
          });
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
            addressControl1 = [];
            addressControl2 = [];
            pinControl = [];
            addressList = [];
            for (AddressModel model in value) {
              addressId = model.id!;
              if (model.address1 != null &&
                  model.address1!.isNotEmpty &&
                  model.address2 != null &&
                  model.address2!.isNotEmpty &&
                  model.pincode != null &&
                  model.pincode!.isNotEmpty) {
                addressList.add(model);

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
    return WillPopScope(
      onWillPop: () {
        debugPrint('BACK PRESS :: $press');
        if (press == 0) {
          setState(() {
            back = 0;
            Get.back();
          });
          debugPrint('BACK : $back');
        } else {
          setState(() {
            back = 1;
            press = 0;
            address1Controller.clear();
            address2Controller.clear();
            pinController.clear();
            radioButtonDefault = 'Home';
          });
        }
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Manage Address', style: zzRegularWhiteAppBarTextStyle14),
          backgroundColor: loginTextColor,
          leading: InkWell(
            onTap: (() {
              if (press == 0) {
                setState(() {
                  back = 0;
                  Get.back();
                });
              } else {
                setState(() {
                  back = 1;
                  press = 0;
                  address1Controller.clear();
                  address2Controller.clear();
                  pinController.clear();
                  radioButtonDefault = 'Home';
                });
              }
            }),
            child: const Icon(Icons.arrow_back_ios, size: 28.0),
          ),
        ),
        body: Column(
          children: [
            Visibility(
              visible: press == 0 ? true : false,
              child: Expanded(
                child: loading == true
                    ? const Center(child: CircularProgressIndicator())
                    : addressList.isEmpty
                        ? Center(
                            child: Text(
                            'No address added...',
                            style: zzBoldBlueDarkTextStyle14,
                          ))
                        : ListView.builder(
                            itemCount: addressList.length,
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            itemBuilder: (BuildContext context, int index) {
                              var model = addressList[index];
                              return Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: lightBlue,
                                    width: 3,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (index1 != index) {
                                                tapBool = model.defaultValue;
                                                listBool = !listBool;
                                                model.defaultValue =
                                                    !model.defaultValue!;
                                                Map<String, dynamic> data =
                                                    <String, dynamic>{};
                                                Map<String, dynamic>
                                                    aCustomerMap =
                                                    <String, dynamic>{};
                                                aCustomerMap[
                                                    'customer_address'] = data;

                                                data['default'] =
                                                    model.defaultValue;
                                                DioClient(
                                                        myUrl:
                                                            '${EndPoints.createCustomerAddress}$aId/addresses/${model.id}.json',
                                                        myMap: aCustomerMap)
                                                    .update()
                                                    .then((value) {
                                                  showSuccessSnackBar(context,
                                                      "Default address changed..!");
                                                  getList();
                                                });
                                              }
                                            });
                                          },
                                          child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: loginTextColor,
                                              child: CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: Colors.white,
                                                  child: CircleAvatar(
                                                      radius: 6,
                                                      backgroundColor:
                                                          model.defaultValue ==
                                                                  false
                                                              ? Colors.white
                                                              : loginTextColor))),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Default Address',
                                          style:
                                              GoogleFonts.lato(fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: 50,
                                      child: TextField(
                                        controller: addressControl1[index],
                                        readOnly:
                                            index1 == index ? false : true,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
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
                                        readOnly:
                                            index1 == index ? false : true,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          hintText:
                                              "Location (Apartment/Road/Area)",
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
                                        maxLength: 6,
                                        keyboardType: TextInputType.number,
                                        readOnly:
                                            index1 == index ? false : true,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          counterText: '',
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          hintText: "Pincode",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Label as:",
                                            style: GoogleFonts.lato(
                                                fontSize: 12.0),
                                          ),
                                          Visibility(
                                            visible: edit != 1 &&
                                                        model.company ==
                                                            'Home' ||
                                                    edit == 1 &&
                                                        index1 != index &&
                                                        model.company ==
                                                            'Home' ||
                                                    edit == 1 && index1 == index
                                                ? true
                                                : false,
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 'Home',
                                                  activeColor: loginTextColor,
                                                  fillColor: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          loginTextColor),
                                                  groupValue: model.company,
                                                  onChanged: index1 == index
                                                      ? (val) {
                                                          setState(() {
                                                            id = 1;
                                                            model.company =
                                                                'Home';
                                                          });
                                                        }
                                                      : null,
                                                ),
                                                Text(
                                                  'Home',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: edit != 1 &&
                                                        model.company ==
                                                            'Office' ||
                                                    edit == 1 &&
                                                        index1 != index &&
                                                        model.company ==
                                                            'Office' ||
                                                    edit == 1 && index1 == index
                                                ? true
                                                : false,
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 'Office',
                                                  activeColor: loginTextColor,
                                                  groupValue: model.company,
                                                  fillColor: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          loginTextColor),
                                                  onChanged: index1 == index
                                                      ? (val) {
                                                          setState(() {
                                                            id = 2;
                                                            model.company =
                                                                'Office';
                                                          });
                                                        }
                                                      : null,
                                                ),
                                                Text(
                                                  'Office',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: edit != 1 &&
                                                        model.company ==
                                                            'Other' ||
                                                    edit == 1 &&
                                                        index1 != index &&
                                                        model.company ==
                                                            'Other' ||
                                                    edit == 1 && index1 == index
                                                ? true
                                                : false,
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 'Other',
                                                  activeColor: loginTextColor,
                                                  groupValue: model.company,
                                                  fillColor: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          loginTextColor),
                                                  onChanged: index1 == index
                                                      ? (val) {
                                                          setState(() {
                                                            id = 3;
                                                            model.company =
                                                                'Other';
                                                          });
                                                        }
                                                      : null,
                                                ),
                                                Text(
                                                  'Other',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: index1 == index ? false : true,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              if (model.defaultValue == false) {
                                                showDeleteConfirmDialog(
                                                    context, model.id!);
                                              } else {
                                                showErrorSnackBar(context,
                                                    'Default address cannot be deleted');
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: loginTextColor),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                padding: const EdgeInsets.only(
                                                    right: 30,
                                                    left: 30,
                                                    top: 10,
                                                    bottom: 10)),
                                            child: Text(
                                              "Remove",
                                              style: (GoogleFonts.lato(
                                                  color: loginTextColor)),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                edit = 1;
                                                index1 = index;
                                              });

                                              debugPrint('EDIT  $edit');
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: loginTextColor),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                padding: const EdgeInsets.only(
                                                    right: 30,
                                                    left: 30,
                                                    top: 10,
                                                    bottom: 10)),
                                            child: Text(
                                              "Edit",
                                              style: (GoogleFonts.lato(
                                                  color: loginTextColor)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: index1 == index ? true : false,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  edit = 0;
                                                  index1 = -1;
                                                  getList();
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  side: const BorderSide(
                                                      width: 1,
                                                      color: loginTextColor),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30,
                                                          left: 30,
                                                          top: 10,
                                                          bottom: 10)),
                                              child: Text('Back',
                                                  style: (GoogleFonts.lato(
                                                      color: loginTextColor)))),
                                          ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (addressControl1[index]
                                                      .text
                                                      .isEmpty) {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    absorbPointer = true;
                                                    showErrorSnackBar(context,
                                                        "Enter house no");
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      absorbPointer = false;
                                                    });
                                                  } else if (addressControl2[
                                                          index]
                                                      .text
                                                      .isEmpty) {
                                                    absorbPointer = true;
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    showErrorSnackBar(context,
                                                        "Enter location");
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      absorbPointer = false;
                                                    });
                                                  } else if (pinControl[index]
                                                      .text
                                                      .isEmpty) {
                                                    absorbPointer = true;
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    showErrorSnackBar(context,
                                                        "Enter pincode");
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      absorbPointer = false;
                                                    });
                                                  } else if (pinControl[index]
                                                          .text
                                                          .length !=
                                                      6) {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    absorbPointer = true;
                                                    showErrorSnackBar(context,
                                                        "Enter 6 digit pincode");
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      absorbPointer = false;
                                                    });
                                                  } else {
                                                    Map<String, dynamic> data =
                                                        <String, dynamic>{};
                                                    data['address1'] =
                                                        addressControl1[index]
                                                            .text
                                                            .toString();
                                                    data['address2'] =
                                                        addressControl2[index]
                                                            .text
                                                            .toString();
                                                    data['zip'] =
                                                        pinControl[index]
                                                            .text
                                                            .toString();
                                                    data['company'] =
                                                        model.company;
                                                    data['default'] =
                                                        model.defaultValue;
                                                    Map<String, dynamic>
                                                        aCustomerMap =
                                                        <String, dynamic>{};
                                                    aCustomerMap[
                                                            'customer_address'] =
                                                        data;
                                                    setState(
                                                        () => loading = true);
                                                    debugPrint(
                                                        'ADDRESS UPDATE ID: ${model.id}');
                                                    debugPrint(
                                                        'ADDRESS DATA: $data');
                                                    debugPrint(
                                                        'ADDRESS DATA: $aCustomerMap');

                                                    DioClient(
                                                            myUrl:
                                                                '${EndPoints.createCustomerAddress}$aId/addresses/${model.id}.json',
                                                            myMap: aCustomerMap)
                                                        .update()
                                                        .then((value) {
                                                      showSuccessSnackBar(
                                                          context,
                                                          "Address updated successfully!");
                                                      edit = 0;
                                                      index1 = -1;
                                                      loading = true;
                                                      getList();
                                                    });
                                                  }
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  side: const BorderSide(
                                                      width: 1,
                                                      color: loginTextColor),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 30,
                                                          left: 30,
                                                          top: 10,
                                                          bottom: 10)),
                                              child: Text('Update',
                                                  style: (GoogleFonts.lato(
                                                      color: loginTextColor)))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ),
            Visibility(
              visible: press == 1 ? true : false,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            setState(() {
                              debool2 = !debool2;
                            });
                          },
                          child: CircleAvatar(
                              radius: 10,
                              backgroundColor: loginTextColor,
                              child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                      radius: 6,
                                      backgroundColor: debool2 == false
                                          ? Colors.white
                                          : loginTextColor))),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Default Address',
                          style: GoogleFonts.lato(fontSize: 15.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: address1Controller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grayTxt, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grayTxt, width: 1.0),
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
                        controller: address2Controller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grayTxt, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grayTxt, width: 1.0),
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
                        controller: pinController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: const InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grayTxt, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grayTxt, width: 1.0),
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
                        Radio(
                          value: 'Home',
                          activeColor: loginTextColor,
                          groupValue: radioButtonDefault,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => loginTextColor),
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
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => loginTextColor),
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
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => loginTextColor),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (address1Controller.text.isEmpty) {
                              FocusScope.of(context).unfocus();
                              absorbPointer = true;
                              showErrorSnackBar(context, "Enter house no");
                              Future.delayed(const Duration(seconds: 2), () {
                                absorbPointer = false;
                              });
                            } else if (address2Controller.text.isEmpty) {
                              absorbPointer = true;
                              FocusScope.of(context).unfocus();
                              showErrorSnackBar(context, "Enter location");
                              Future.delayed(const Duration(seconds: 2), () {
                                absorbPointer = false;
                              });
                            } else if (pinController.text.isEmpty) {
                              absorbPointer = true;
                              FocusScope.of(context).unfocus();
                              showErrorSnackBar(context, "Enter pincode");
                              Future.delayed(const Duration(seconds: 2), () {
                                absorbPointer = false;
                              });
                            } else if (pinController.text.length != 6) {
                              FocusScope.of(context).unfocus();
                              absorbPointer = true;
                              showErrorSnackBar(
                                  context, "Enter 6 digit pincode");
                              Future.delayed(const Duration(seconds: 2), () {
                                absorbPointer = false;
                              });
                            } else {
                              FocusScope.of(context).unfocus();
                              Map<String, dynamic> data = <String, dynamic>{};
                              Map<String, dynamic> aCustomerMap =
                                  <String, dynamic>{};

                              data['address1'] =
                                  address1Controller.text.toString();
                              data['address2'] =
                                  address2Controller.text.toString();
                              data['zip'] = pinController.text.toString();
                              data['company'] = radioButtonDefault;
                              data['default'] = debool2;
                              aCustomerMap['customer_address'] = data;

                              addAddress(aCustomerMap, context);
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
                                right: 30, left: 30, top: 10, bottom: 10)),
                        child: Text(
                          "Add",
                          style: (GoogleFonts.lato(color: loginTextColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: press == 0 ? true : false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      color: loginTextColor,
                      strokeWidth: 3,
                      dashPattern: const [10, 6],
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: lightBlue,
                            ),
                            height: 50,
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
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        press = 1;
                                      });
                                    },
                                    child: Text(
                                      "Add Address",
                                      style: GoogleFonts.lato(
                                          color: loginTextColor,
                                          fontSize: 20.0),
                                    ))
                              ],
                            )),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void createAddress(Map<String, dynamic> data, BuildContext context) {
    try {
      DioClient(myUrl: "customers/$aId/addresses.json", myMap: data)
          .post()
          .then((value) {
        debugPrint("SHOW ADDRESS: $value");
        debugPrint('SHOW ADDRESS STATUS CODE ${value.statusCode}');
        setState(() => loading = false);
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void showDeleteConfirmDialog(BuildContext context, int id) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text(
              'Are you sure want to remove this address?',
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
                      setState(() {
                        FocusScope.of(context).unfocus();
                        DioClient(
                                myUrl:
                                    '${EndPoints.createCustomerAddress}$aId/addresses/$id')
                            .deleteDetails()
                            .then((value) {
                          setState(() {
                            if (value.statusCode == 200 ||
                                value.statusCode == 201) {
                              showSuccessSnackBar(
                                  context, "Address deleted successfully!");
                              addressList = [];
                              edit = 0;
                              index1 = -1;
                              setState(() {
                                loading = true;
                                getList();
                              });
                            } else {
                              debugPrint('SOMETHING WENT WRONG');
                            }
                          });
                        });
                        Navigator.of(builderContext).pop();
                      });
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
        }).then((value) {});
  }
}
