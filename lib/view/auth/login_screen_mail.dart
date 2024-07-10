import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite/control/auth_controller/login_mail_coltroller.dart';
import 'package:infinite/view/auth/forget_password.dart';

import '../../utils/packeages.dart';

class LoginScreenMail extends StatefulWidget {
  const LoginScreenMail({Key? key}) : super(key: key);

  @override
  State<LoginScreenMail> createState() => _LoginScreenMailState();
}

class _LoginScreenMailState extends State<LoginScreenMail> {
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
                              height: 2.0.h,
                            ),
                            Image.asset(
                              "assets/images/inf_logo_tm.png",
                              height: 120,
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
                                      "Hello there!",
                                      style: zzBoldBlackTextStyle16,
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      "Proceed with your login",
                                      style: zzRegularGrayTextStyle12,
                                    ),
                                    SizedBox(
                                      height: 4.0.h,
                                    ),
                                    SizedBox(
                                      height: 3.0.h,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 7.0.h,
                                      child: TextField(
                                        controller: mailCtrl.mailController,
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
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 7.0.h,
                                      child: TextField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(18)
                                        ],
                                        controller: mailCtrl.passwordController,
                                        
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        obscureText:
                                            !mailCtrl.passwordVisibility,
                                        style: zzRegularBlackTextStyle13,
                                        textAlignVertical:
                                            TextAlignVertical.center,
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
                                            suffixIcon: IconButton(
                                              color: Colors.black54,
                                              icon: mailCtrl.passwordSuffixIcon,
                                              onPressed: () =>
                                                  mailCtrl.changeVisibility(),
                                            ),
                                            hintText: "Password",
                                            hintStyle:
                                                zzRegularGrayTextStyle12),
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
                                              .performGraphQLPost(context),
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
                                     SizedBox(
                                      height: 2.0.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        mailCtrl.forgetEmailController.text="";
                                        Get.to(const ForgetPasswordscreen());
                                      },
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          "Forgot Password?",
                                          style: zzBoldBlueDarkTextStyle10,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    InkWell(
                                      onTap: () => Get.to(
                                          () => const CreateProfile(),
                                          arguments: [
                                            {
                                              "name": "",
                                              "email": '',
                                              "fromwhere": "normal"
                                            }
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "New to Infinite?",
                                            style: zzRegularBlackTextStyle12,
                                          ),
                                          SizedBox(
                                            width: 1.0.w,
                                          ),
                                          Text(
                                            "Sign Up",
                                            style: zzBoldBlueDarkTextStyle10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.0.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Expanded(
                                            child: Divider(
                                          color: black,
                                          indent: 70.0,
                                          thickness: 1.5,
                                        )),
                                        Text(
                                          "  OR  ",
                                          style: zzRegularBlackTextStyle12,
                                        ),
                                        const Expanded(
                                            child: Divider(
                                          color: black,
                                          endIndent: 70.0,
                                          thickness: 1.5,
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                               
                                Text(
                                  "By login you are accepting",
                                  style: zzRegularBlackTextStyle11,
                                ),
                                SizedBox(
                                  height: 1.0.h,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          launchURL(
                                              "https://my6senses.com/pages/term-of-use");
                                         
                                        },
                                        child: Text(
                                          "Terms and conditions",
                                          style: zzBoldBlueDarkTextStyle10,
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: black,
                                        thickness: 2,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launchURL(
                                              "https://my6senses.com/pages/privacy-policy");
                                         
                                        },
                                        child: Text(
                                          "Privacy Policy",
                                          style: zzBoldBlueDarkTextStyle10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                              ],
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
