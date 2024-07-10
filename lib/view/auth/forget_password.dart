import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite/control/auth_controller/login_mail_coltroller.dart';

import '../../utils/packeages.dart';

class ForgetPasswordscreen extends StatefulWidget {
  const ForgetPasswordscreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordscreen> createState() => _ForgetPasswordscreenState();
}

class _ForgetPasswordscreenState extends State<ForgetPasswordscreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginMailController>(
        init: LoginMailController(),
        builder: (mailCtrl) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: splashWhite,
              body: loading
                  ? Center(
                      child: Lottie.asset(animationLoading,
                          repeat: true,
                          reverse: true,
                          animate: true,
                          width: ScreenSize.getScreenWidth(context) * 0.40,
                          height: ScreenSize.getScreenHeight(context) * 0.40))
                  : ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 4.0.h,
                            ),
                            Image.asset(
                              "assets/images/inf_logo_tm.png",
                              height: 120,
                            ),
                            SizedBox(
                              height: 50.sp,
                            ),
                            Container(
                              margin: const EdgeInsets.all(25.0),
                              width: 100.0.w,
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
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.sp, right: 10.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(
                                      "Reset Password",
                                      style: zzBoldBlackTextStyle16,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "We will send you an email to reset your password",
                                        style: zzRegularGrayTextStyle12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.0.h,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 7.0.h,
                                      child: TextField(
                                        controller: mailCtrl.forgetEmailController,
                                        style: zzRegularBlackTextStyle13,
                                        decoration: InputDecoration(
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: grayTxt, width: 1.0),
                                          ),
                                          hintText: "Email Address",
                                          hintStyle: zzRegularGrayTextStyle12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    AbsorbPointer(
                                      absorbing: mailCtrl.absorbPointer,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 7.0.h,
                                        child: ElevatedButton(
                                          onPressed: () => mailCtrl
                                              .performGraphQLForget(context),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(loginTextColor),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "Proceed",
                                            style: zzBoldWhiteTextStyle14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        });
  }
}
