import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite/res/colors.dart';
import 'package:infinite/utils/global.dart';
import 'dart:convert';

import '../../res/styles.dart';

class OrderReturnScreen extends StatefulWidget {
  final String orderId;
  final int varientId;
  const OrderReturnScreen(
      {Key? key, required this.orderId, required this.varientId})
      : super(key: key);

  @override
  State<OrderReturnScreen> createState() => _OrderReturnScreenState();
}

class _OrderReturnScreenState extends State<OrderReturnScreen> {
  String dropdownValue = 'Select a return reason';
  String selectedDropdown = "";
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  Future<void> submitOrderReturn() async {
    const String url =
        'https://eaglecrm.solstium.net/api/salesreturn/centrahub';
    const String token = 'Apollo12345';
    const int userId = 42926;

    String orderId = widget.orderId;
    String variantId = widget.varientId.toString();
    final String returnReason =
        dropdownValue == 'Other' ? reasonController.text : dropdownValue;
    final int quantity = int.tryParse(quantityController.text) ?? 0;
    final String customerNote = noteController.text;

    final Map<String, dynamic> data = {
      "orderId": orderId,
      "variantId": variantId,
      "quantity": quantity,
      "returnReason": selectedDropdown,
      "customerNote": customerNote,
    };

    print('sarnya  ${data}');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Token': token,
      'User_Id': userId.toString()
    };
    print(data);
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // Check if the response body contains the status and message
      if (response.body != null) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        String status = responseBody['status'];
        String message = responseBody['message'];

        if (status == 'success') {
          showSuccessSnackBar(context, message);
          Navigator.pop(context);
        } else if (status == 'error') {
          showErrorSnackBar(context, message);
          // Handle the error case accordingly
        }
      }
    } else {
      // Handle other status codes (e.g., display error message)
    }
  }

  @override
  void initState() {
    super.initState();
    quantityController.text = "1";
  }

  @override
  void dispose() {
    quantityController.dispose();
    noteController.dispose();
    reasonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: loginTextColor,
          title: const Text("Order Return"),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text('Return Reason', style: zzBlackTextStyle16),
                const SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    fillColor: lightBlue2,
                    hintText: 'Select a return reason',
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      print(newValue);
                      dropdownValue = newValue!;
                      if (newValue == "Unknow") {
                        selectedDropdown = "UNKNOWN";
                      } else if (newValue == "Size was too small") {
                        selectedDropdown = "SIZE_TOO_SMALL";
                      } else if (newValue == "Size was too large") {
                        selectedDropdown = "SIZE_TOO_LARGE";
                      } else if (newValue == "Customer changed their mind") {
                        selectedDropdown = "UNWANTED";
                      } else if (newValue == "Item not described") {
                        selectedDropdown = "NOT_AS_DESCRIBED";
                      } else if (newValue == "Received wrong item") {
                        selectedDropdown = "WRONG_ITEM";
                      } else if (newValue == "Damaged or defective") {
                        selectedDropdown = "DEFECTIVE";
                      } else if (newValue == "Other") {
                        selectedDropdown = "OTHER";
                      }
                    });
                  },
                  items: <String>[
                    'Select a return reason',
                    'Unknow',
                    'Size was too small',
                    'Size was too large',
                    'Customer changed their mind',
                    'Item not described',
                    'Received wrong item',
                    'Damaged or defective',
                    'Other'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                dropdownValue == "Other"
                    ? const SizedBox(height: 30)
                    : const SizedBox(),
                dropdownValue == "Other"
                    ? TextFormField(
                        controller: reasonController,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: 'Reason',
                          fillColor: lightBlue2,
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a reason';
                          }
                          return null;
                        },
                      )
                    : const SizedBox(),
                const SizedBox(height: 30),
                TextFormField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: 'Quantity for return',
                    fillColor: lightBlue2,
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter quantity for return';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: noteController,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: 'Customer Note',
                    fillColor: lightBlue2,
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a customer note';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      int quantity = int.tryParse(quantityController.text) ?? 0;

                      if (dropdownValue == 'Select a return reason') {
                        showErrorSnackBar(
                            context, "please select return reason");
                      } else if (dropdownValue == 'Other' &&
                          reasonController.text.isEmpty) {
                        showErrorSnackBar(context, "please enter reason");
                      } else if (quantity > 1) {
                        showErrorSnackBar(context, "Quantity should be 1");
                      } else if (noteController.text.isEmpty) {
                        showErrorSnackBar(
                            context, "Please enter customer note");
                      } else {
                        submitOrderReturn();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(color: Colors.white),
                      backgroundColor: loginTextColor,
                    ),
                    child: const Text('Submit Request',
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
