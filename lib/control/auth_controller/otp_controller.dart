import 'package:get/get.dart';

import '../../utils/packeages.dart';

class OTPController extends GetxController {
  dynamic otp = Get.arguments;
  dynamic cusMap = Get.arguments;
  String myOtp = "";
  bool absorbPointer = false;
  bool resendEnabled = false;
  Timer? timer;
  Timer? reTimer;
  int startTime = 30;
  int reSendTime = 32;
  bool aLoader = false;
  bool reSendSuccess = false;
  int reSendBtn = 0;

  @override
  void onInit() {
    disableMethod();
    startTimer();
    super.onInit();
  }

  void startTimer() {
    const duration = Duration(seconds: 1);
    timer = Timer.periodic(duration, (timer) {
      if (startTime == 0) {
        timer.cancel();
        update();
      } else {
        startTime--;
        update();
      }
    });
  }

  void reSendTimer() {
    const duration = Duration(seconds: 1);
    reTimer = Timer.periodic(duration, (timer) {
      if (reSendTime == 0) {
        timer.cancel();
        update();
      } else {
        reSendTime--;
        update();
      }
    });
  }

  void disableMethod() {
    resendEnabled = false;
    Timer(const Duration(seconds: 30), () => resendEnabled = true);
  }

  // PROCESS FOR TRIGGERING OTP
  void createOTP(Map<String, dynamic> data, BuildContext context) {
    try {
      DioClient(myUrl: EndPoints.createOtp, myMap: data).post2().then((value) {
        debugPrint("SHOW CREATE PROFILE CREATE OTP RESPONSE: $value");
        debugPrint(
            'SHOW CREATE PROFILE CREATE OTP STATUS CODE ${value.statusCode}');

        loading = false;
        reSendTime = 0;
        if (value.statusCode == 200) {
          String aStatus = value.data['status'];
          if (aStatus == "success") {
            reSendSuccess = false;
            reSendBtn = 1;
            reSendTime = 30;
            reSendTimer();
            showSuccessSnackBar(context,
                "OTP has been successfully resent to this ${data['country_code']}${data['phone']} mobile number");
          } else {
            absorbPointer = true;
            String aMsg = value.data['message'];
            showErrorSnackBar(context, aMsg);
            Future.delayed(const Duration(seconds: 2), () {
              absorbPointer = false;
            });
          }
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  // SUBMIT & VALIDATE OTP
  void submitOTP(Map<String, dynamic> data, BuildContext context) {
    try {
      DioClient(myUrl: EndPoints.submitOtp, myMap: data).post2().then((value) {
        loading = false;
        if (value.statusCode == 200) {
          loading = false;
          final responseData = value.data;

          if (responseData['status'] == 'error') {
            showErrorSnackBar(context, responseData['message']);
          } else {
            showSuccessSnackBar(context, "OTP has been successfully verified");
            Get.offAll(() => const LoginScreenMail());
          }
        } else {
          absorbPointer = true;
          String aMsg = value.data['message'];
          showErrorSnackBar(context, aMsg);
          Future.delayed(const Duration(seconds: 2), () {
            absorbPointer = false;
          });
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  // ADD PROFILE
  void addProfile(BuildContext context) {
    try {
      DioClient(
              myUrl: EndPoints.createCustomer, myMap: cusMap[0]['customerMap'])
          .post()
          .then((value) {
        debugPrint("SHOW OTP VERIFICATION PAGE ADD PROFILE RESPONSE: $value");
        debugPrint(
            'SHOW OTP VERIFICATION PAGE SUBMIT ADD PROFILE STATUS CODE ${value.statusCode}');
        loading = false;
        if (value.statusCode == 201) {
          var aCustomerMap = value.data['customer'];
          int aId = aCustomerMap['id'];
          String aMail = aCustomerMap['email'] ?? '';
          String aFirstName = aCustomerMap['first_name'];
          String aLastName = aCustomerMap['last_name'] ?? '';
          String aMobile = aCustomerMap['phone'] ?? '';
          String aPassword = aCustomerMap['password'] ?? '';

          sharedPreferences!.setInt("id", aId);
          sharedPreferences!.setString("mail", aMail);
          sharedPreferences!.setString("firstName", aFirstName);
          sharedPreferences!.setString("lastName", aLastName);
          sharedPreferences!.setString("mobileNumber", aMobile);
          sharedPreferences!.setString("password", aPassword);
          showSuccessSnackBar(
              context, "Your profile has been successfully created");

          Get.offAll(() => const HomeScreen(index: 0));
        } else {
          if (value.data['errors'] != null) {
            Map<String, dynamic> aErrMap = value.data['errors'];
            if (aErrMap.containsKey('email')) {
              absorbPointer = true;
              String aErrMsg = aErrMap['email'].cast<String>()[0];
              showErrorSnackBar(context, "This mail id has already been taken");
              Future.delayed(const Duration(seconds: 2), () {
                absorbPointer = false;
              });
            } else if (aErrMap.containsKey('phone')) {
              absorbPointer = true;
              String aErrMsg = aErrMap['phone'].cast<String>()[0];
              showErrorSnackBar(
                  context, "This mobile number has already been taken");
              Future.delayed(const Duration(seconds: 2), () {
                absorbPointer = false;
              });
            }
          }
          debugPrint('ERROR STATUS CODE  ${value.statusCode}');
        }
      });
    } catch (e) {
      debugPrint('$e');
    }
  }
}
