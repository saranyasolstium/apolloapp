import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite/res/colors.dart';
import 'package:sizer/sizer.dart';

import '../../res/styles.dart';
import '../../utils/global.dart';

class EnquiryScreen extends StatefulWidget {
  final String productName;
  const EnquiryScreen({Key? key, required this.productName}) : super(key: key);

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _hearingController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _hearingController = TextEditingController();
    _messageController = TextEditingController();

    // Load values from SharedPreferences
    _nameController.text = sharedPreferences!.getString("firstName") ?? "";
    _emailController.text = sharedPreferences!.getString("mail") ?? "";
    _phoneController.text = sharedPreferences!.getString("mobileNumber") ?? "";
    _hearingController.text =widget.productName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _hearingController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: loginTextColor,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        actions: [
          GestureDetector(
            onTap: () {
              makeCallOrSendMessage("call", myDefaultLandLineNumber, "");
            },
            child: SvgPicture.asset(
              "assets/svg/call.svg",
              color: white,
              height: 20.0,
              width: 20.0,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          SizedBox(
            width: 6.w,
          ),
          SvgPicture.asset(
            "assets/svg/search.svg",
            color: white,
            height: 20.0,
            width: 20.0,
            allowDrawingOutsideViewBox: true,
          ),
          SizedBox(
            width: 6.w,
          ),
          SvgPicture.asset(
            "assets/svg/cart.svg",
            color: white,
            height: 20.0,
            width: 20.0,
            allowDrawingOutsideViewBox: true,
          ),
          SizedBox(
            width: 6.w,
          ),
          SvgPicture.asset(
            "assets/svg/left_menu.svg",
            color: white,
            height: 15.0,
            width: 15.0,
            allowDrawingOutsideViewBox: true,
          ),
          SizedBox(
            width: 3.w,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text('Enquiry For ${widget.productName}',
                    style: zzBlackTextStyle16),
                const SizedBox(height: 30),
                TextFormField(
                    controller: _hearingController,
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: lightBlue2,
                      counterText: '',
                      hintText: widget.productName,
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                    )),
                const SizedBox(height: 30),
                TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: 'Your Name',
                      fillColor: lightBlue2,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                    )),
                const SizedBox(height: 30),
                TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: 'Your EMail',
                      fillColor: lightBlue2,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                    )),
                const SizedBox(height: 30),
                TextFormField(
                    controller: _phoneController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: 'Your Phone',
                      fillColor: lightBlue2,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                    )),
                const SizedBox(height: 30),
                TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: 'Your Message',
                      fillColor: lightBlue2,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                    )),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.trim().toString().isEmpty ||
                            _emailController.text.trim().toString().isEmpty ||
                            _phoneController.text.trim().toString().isEmpty ||
                            _messageController.text.trim().toString().isEmpty) {
                          showErrorSnackBar(
                              context, "Please enter all input fileds");
                        } else {
                          showSuccessSnackBar(context,
                              "Thanks for contacting us. We'll get back to you as soon as possible");
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          backgroundColor: loginTextColor),
                      child: const Text(
                        'SEND MESSAGE',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
