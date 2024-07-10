

import 'package:get/get.dart';
import 'package:infinite/control/auth_controller/otp_controller.dart';

import '../../utils/packeages.dart';

class OtpVerificationScreen extends StatefulWidget {
  final Map<String, dynamic>? myOtpMap;
  final Map<String, dynamic>? myCustomerMap;

  const OtpVerificationScreen(this.myOtpMap, this.myCustomerMap, {Key? key})
      : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
  return GetBuilder<OTPController>(
      init: OTPController(),
      builder: (otpCtrl){
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: splashWhite,
        body: loading
            ? Center(
          child: Lottie.asset(
            animationLoading,
            repeat: true,
            reverse: true,
            animate: true,
            width: ScreenSize.getScreenWidth(context) * 0.40,
            height: ScreenSize.getScreenHeight(context) * 0.40,
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 1.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: black,
                  ),
                  color: black,
                ),
                SizedBox(
                  width: 0.2.w,
                ),
                Text(
                  'OTP Verification',
                  style: zzBoldBlackTextStyle14,
                ),
              ],
            ),
            Image.asset(
              "assets/images/inf_logo_tm.png",
              width: 100.w,
            ),
            Container(
              margin: const EdgeInsets.all(25.0),
              width: 100.w,
              decoration: BoxDecoration(
                color: loginBlue,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Text(
                    "Enter OTP",
                    style: zzBoldBlackTextStyle16,
                  ),
                  SizedBox(
                    height: 1.0.h,
                  ),
                  Text(
                    "OTP send to ${widget.myOtpMap!['country_code']}${widget.myOtpMap!['phone']}",
                    style: zzRegularGrayTextStyle12,
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    autoFocus: false,
                    fieldWidth: 42.0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    margin: const EdgeInsets.all(4.0),
                    borderColor: gray,
                    filled: true,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    fillColor: white,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      if (code.length == 6) {
                        if (mounted) {
                          setState(() => otpCtrl.myOtp = code);
                        }
                      }
                    },
                    onSubmit: (String verificationCode) {
                      if (verificationCode.length != 6) {
                        otpCtrl.absorbPointer = true;
                        showErrorSnackBar(
                            context, 'Please enter valid OTP');
                        Future.delayed(const Duration(seconds: 2), () {
                          otpCtrl.absorbPointer = false;
                        });
                      } else {
                        if (mounted) {
                          setState(() => otpCtrl.myOtp = verificationCode);
                        }
                      }
                    }, 
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  AbsorbPointer(
                    absorbing: otpCtrl.absorbPointer,
                    child: SizedBox(
                      width: 80.0.w,
                      height: 6.0.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if(otpCtrl.myOtp.isNotEmpty) {

                            Map<String, dynamic> otpMap = <String, dynamic>{};

                            otpMap['email'] = widget.myOtpMap!['email'];
                            otpMap['phone'] = widget.myOtpMap!['phone'];
                            otpMap['country_code'] = widget.myOtpMap!['country_code'];
                            otpMap['country'] = "IN";
                            otpMap['validated_otp'] = otpCtrl.myOtp;

                            setState(() => loading = true);
                            otpCtrl.submitOTP(otpMap, context);
                          }
                          else {
                            otpCtrl.absorbPointer = true;
                            showErrorSnackBar(
                                context, 'Please enter valid OTP');
                            Future.delayed(const Duration(seconds: 2), () {
                              otpCtrl.absorbPointer = false;
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              loginTextColor),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "Verify",
                          style: zzBoldWhiteTextStyle14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Visibility(
                      visible: otpCtrl.startTime > 0 && otpCtrl.startTime < 31 ,
                      child: Text('seconds remaining : ${otpCtrl.startTime}')),
                  Visibility(
                      visible:  otpCtrl.reSendTime > 0 && otpCtrl.reSendTime < 31 ,
                      child: Text('seconds remaining : ${otpCtrl.reSendTime}')),
                 
                  Visibility(
                    visible: otpCtrl.startTime == 0 || otpCtrl.reSendTime == 0 ,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          otpCtrl.reSendSuccess=true;
                          otpCtrl.reSendTime = 31;
                          otpCtrl.startTime=31;
                          otpCtrl.createOTP(widget.myOtpMap!,context);
                        });
                      },
                      child: Text(
                        "Resend OTP",
                        style: zzBoldBlueDarkTextStyle10,
                      ),
                    ),
                  ),
                  Visibility(
                      visible: otpCtrl.reSendSuccess,
                      child: const CircularProgressIndicator()),
                  SizedBox(
                    height: 2.0.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  });
  }

}
