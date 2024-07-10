import 'package:get/get.dart';
import 'package:infinite/utils/packeages.dart';

class CreateProfileController extends GetxController {
  dynamic name = Get.arguments[0]['name'];
  dynamic email = Get.arguments[0]['email'];
  dynamic fromwhere = Get.arguments[0]['fromwhere'];
  File? imageFile;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final passwordNode = FocusNode();
  String myCountryCode = "+91";
  bool passwordVisibility = false;
  Icon passwordSuffixIcon = const Icon(Icons.visibility_off);
  String imageurlNew =
      'https://img.freepik.com/free-photo/pink-tree-nami-island-korea_335224-522.jpg?'
      'size=626&ext=jpg&ga=GA1.2.264828152.1660711929&semt=sph';

  final ImagePicker picker = ImagePicker();
  XFile? photo = XFile('');
  bool absorbPointer = false;
  void changeVisibility() {
    passwordVisibility = !passwordVisibility;
    passwordSuffixIcon =
        Icon(!passwordVisibility ? Icons.visibility_off : Icons.visibility);
    update();
  }

  @override
  void onInit() {
    if (fromwhere! == "mobile") {
      phoneController.text = email.toString();
    } else if (fromwhere! == "mail") {
      mailController.text = email.toString();
      nameController.text = name.toString();
    } else if (fromwhere! == "google_mail") {
      
      mailController.text = email.toString();
      nameController.text = name.toString();
    }
    super.onInit();
  }

  /// Upload Shop Proof
  XFile? imageXFile1;
  final ImagePicker _picker1 = ImagePicker();
  String uploadProfileImg1 = '';
  Future<void> _getImage(int i) async {
    try {
      if (i == 0) {
        var status = await Permission.camera.status;
        if (!status.isGranted) {
          await Permission.camera.request();
        } else {
          if (await Permission.camera.request().isGranted) {
            imageXFile1 = (await _picker1.pickImage(
                source: ImageSource.camera, maxWidth: 600))!;
            uploadProfileImg1 = imageXFile1!.path;
            update();
          }
        }
      } else if (i == 1) {
        try {
          var status = await Permission.storage.status;
          if (status.isPermanentlyDenied) {
            openAppSettings();
          } else if (status.isDenied) {
            openAppSettings();
          } else if (status.isGranted) {
            if (i == 1) {
              imageXFile1 =
                  (await _picker1.pickImage(source: ImageSource.gallery))!;
              uploadProfileImg1 = imageXFile1!.path;
              update();
            }
          } else {
            await Permission.storage.request();
          }
        } catch (e) {
          debugPrint('$e');
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  // CHECK CUSTOMER EXISTS BY MOBILE NUMBER
  void checkIfCustomerExistByMobileNumber(BuildContext context) {
    try {
      DioClient(
              myUrl:
                  "${EndPoints.checkCustomerAvailabilityByPhone}$myCountryCode${phoneController.text.toString()}")
          .getDetails()
          .then((value) {
        loading = false;
        debugPrint("SHOW CUSTOMER EXISTS CHECK STATUS MOBILE NUMBER: $value");

        if (value.statusCode == 200) {
          if ((value.data['customers'] as List).isNotEmpty) {
            print(value.data['customers'][0]['phone'].toString());
            print(myCountryCode + phoneController.text.toString());
            if (value.data['customers'][0]['phone'].toString() ==
                myCountryCode + phoneController.text.toString()) {
              showErrorSnackBar(
                  context, "This mobile number has already been taken");
            } else {
              loading = false;
              // ACCOUNT NOT EXITS
              print('saranya');
              checkIfCustomerExistsByMail(context);
            }
          } else {
            loading = false;
            // ACCOUNT NOT EXITS
            checkIfCustomerExistsByMail(context);
          }
        } else {
          loading = false;
          // ACCOUNT NOT EXITS
          checkIfCustomerExistsByMail(context);
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  // CHECK CUSTOMER EXISTS BY EMAIL
  void checkIfCustomerExistsByMail(BuildContext context) {
    try {
      DioClient(
              myUrl:
                  "${EndPoints.checkCustomerAvailabilityByMail}${mailController.text.toString()}")
          .getDetails()
          .then((value) {
        loading = false;
        debugPrint("SHOW CUSTOMER EXISTS CHECK STATUS EMAIL: $value");
        if (value.statusCode == 200) {
          if ((value.data['customers'] as List).isNotEmpty) {
            // ACCOUNT EXITS
            var aCustomerMap = value.data['customers'][0];
            print(aCustomerMap['email']);

            print(mailController.text.toString());
            String customerEmail = aCustomerMap['email'];

            if (customerEmail == mailController.text.toString()) {
              showErrorSnackBar(context, "This emailId has already been taken");
            }
          } else {
            loading = false;
            // ACCOUNT NOT EXITS
            addFieldsToMakeOTP(context);
          }
        } else {
          loading = false;
          // ACCOUNT NOT EXITS
          addFieldsToMakeOTP(context);
        }
        update();
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  // ADDING FIELDS TO TRIGGER THE OTP
  void addFieldsToMakeOTP(BuildContext context) {
    try {
      Map<String, dynamic> data = <String, dynamic>{};
      Map<String, dynamic> aCustomerMap = <String, dynamic>{};
      data['first_name'] = nameController.text.toString();
      data['last_name'] = lastNameController.text.toString();
      data['email'] = mailController.text.toString();
      data['password'] = passwordController.text.toString();
      data['password_confirmation'] = passwordController.text.toString();
      data['phone'] = "$myCountryCode${phoneController.text.toString()}";
      data['send_email_welcome'] = true;
      data['verified_email'] = true;
      aCustomerMap['customer'] = data;
      loading = true;

      Map<String, dynamic> otpMap = <String, dynamic>{};
      otpMap['first_name'] = nameController.text.toString();
      otpMap['last_name'] = lastNameController.text.toString();
      otpMap['email'] = mailController.text.toString();
      otpMap['phone'] = phoneController.text.toString();
      otpMap['country_code'] = myCountryCode;
      otpMap['password'] = passwordController.text.toString();

      createOTP(otpMap, context, aCustomerMap);
      // addProfile(aCustomerMap, context);
      update();
    } catch (e) {
      debugPrint("$e");
    }
  }

  // PROCESS FOR TRIGGERING OTP
  void createOTP(Map<String, dynamic> otpMap, BuildContext context,
      Map<String, dynamic> aCustomerMap) {
    try {
      DioClient(myUrl: EndPoints.createOtp, myMap: otpMap)
          .post2()
          .then((value) {
        loading = false;
        if (value.statusCode == 200) {
          showSuccessSnackBar(context,
              "OTP has been successfully sent to this ${otpMap['country_code']}${otpMap['phone']} mobile number");
          Get.to(() => OtpVerificationScreen(otpMap, aCustomerMap), arguments: [
            {"otpMap": otpMap, "customerMap": aCustomerMap}
          ]);
        }
        update();
      });
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
            title: const Text('Select anyone'),
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
                        Navigator.pop(context);
                        _getImage(0);
                        update();
                      }),
                      child: Text('Camera', style: zzRegularBlackTextStyle14A)),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        backgroundColor: loginTextColor,
                      ),
                      onPressed: (() {
                        Navigator.pop(context);
                        _getImage(1);
                        update();
                      }),
                      child:
                          Text('Gallery', style: zzRegularBlackTextStyle14A)),
                ],
              )
            ],
          );
        });
  }
}
