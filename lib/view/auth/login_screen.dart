import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:infinite/control/auth_controller/login_controller.dart';
import 'package:infinite/main.dart';

import '../../utils/packeages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (loginCtrl) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
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
                    ))
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
                            ),
                            Container(
                              margin: const EdgeInsets.all(25.0),
                              padding:
                                  EdgeInsets.only(left: 10.sp, right: 10.sp),
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
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0, color: grayTxt),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6.0)),
                                        color: Colors.white),
                                    height: 7.0.h,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        CountryCodePicker(
                                          onChanged: (CountryCode countryCode) {
                                            loginCtrl.myCountryCode =
                                                countryCode.toString();
                                            loginCtrl.update();
                                          },
                                          initialSelection: 'IN',
                                          favorite: const ['+91', 'IN'],
                                          showCountryOnly: false,
                                          showFlag: true,
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
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            autofocus: false,
                                            obscureText: false,
                                            controller:
                                                loginCtrl.myMobileController,
                                            style: zzRegularBlackTextStyle13,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            keyboardType: TextInputType.number,
                                            maxLength: 10,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter mobile number',
                                              hintStyle:
                                                  zzRegularGrayTextStyle12A,
                                              counter:
                                                  const SizedBox(height: 0.0),
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
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 7.0.h,
                                    child: TextField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(18)
                                      ],
                                      controller: loginCtrl.myPswdController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      obscureText: !loginCtrl.passwordVisibilit,
                                      style: zzRegularBlackTextStyle13,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: grayTxt, width: 1.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: grayTxt, width: 1.0),
                                        ),
                                        suffixIcon: IconButton(
                                          color: Colors.black54,
                                          icon: loginCtrl.passwordIcon,
                                          onPressed: () =>
                                              loginCtrl.changeVisibility(),
                                        ),
                                        hintText: "Password",
                                        hintStyle: zzRegularGrayTextStyle12A,
                                        filled: true,
                                        fillColor: white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.0.h,
                                  ),
                                  AbsorbPointer(
                                    absorbing: loginCtrl.absorbPointer,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 7.0.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          loginCtrl.checkValidation(context);
                                          loginCtrl.performGraphQLPost(context);
                                          loginCtrl.update();
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  loginTextColor),
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
                                    height: 4.0.h,
                                  ),
                                  InkWell(
                                    onTap: () => Get.to(
                                        () => const CreateProfile(),
                                        arguments: [
                                          {
                                            "name": "",
                                            "email": "",
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showSuccessSnackBar(
                                              context, 'Coming soon...');
                                        },
                                        child: Image.asset(
                                          "assets/images/whatsapp_logo.png",
                                          height: 50.0,
                                          width: 50.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          sharedPreferences!.clear();
                                          loginCtrl.goToGoogleSignIn(context);
                                        },
                                        child: Image.asset(
                                          "assets/images/google_logo.png",
                                          height: 46.0,
                                          width: 46.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                ],
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
                                        onTap: () =>
                                            Get.to(() => LegalWebViewScreen(
                                                  fromWhere: 'login',
                                                  myContent:
                                                      "Terms & Conditions",
                                                )),
                                        child: Text(
                                          "Terms and condition",
                                          style: zzBoldBlueDarkTextStyle10,
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: black,
                                        thickness: 2,
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            Get.to(() => LegalWebViewScreen(
                                                  fromWhere: 'login',
                                                  myContent: "Privacy Policy",
                                                )),
                                        child: Text(
                                          "Privacy Policy",
                                          style: zzBoldBlueDarkTextStyle10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0.h,
                                )
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
