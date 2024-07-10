import 'package:get/get.dart';
import 'package:infinite/utils/packeages.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
   return GetBuilder<LoginControl>(
       init: LoginControl(),
       builder: (logCtrl){
     return SafeArea(
       child: Scaffold(
         resizeToAvoidBottomInset: false,
         backgroundColor: splashWhite,
         body:ScrollConfiguration(
           behavior: MyBehavior(),
           child: SingleChildScrollView(
             // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
             // physics: const AlwaysScrollableScrollPhysics(),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: [
                   SizedBox(
                     height: 17.0.h,
                   ),
                   Image.asset(
                     "assets/images/inf_logo_tm.png",
                   ),
                   SizedBox(
                     height: 4.0.h,
                   ),
                   Container(
                     margin: const EdgeInsets.all(25.0),
                     width: 100.0.w,
                     height: ScreenSize.getScreenHeight(context) * 0.38,

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
                           "Proceed with your login using",
                           style: zzRegularGrayTextStyle12,
                         ),
                         SizedBox(
                           height: 4.0.h,
                         ),
                         // SizedBox(
                         //   width: 70.0.w,
                         //   height: 6.0.h,
                         //   child: ElevatedButton(
                         //     // onPressed: () => Get.to(() => const OtpVerificationScreen()),
                         //     onPressed: () => Get.to(() => const LoginScreen()),
                         //     style: ButtonStyle(
                         //       backgroundColor:
                         //       MaterialStateProperty.all<Color>(
                         //           loginTextColor),
                         //       shape: MaterialStateProperty.all<
                         //           RoundedRectangleBorder>(
                         //         RoundedRectangleBorder(
                         //           borderRadius: BorderRadius.circular(7.0),
                         //         ),
                         //       ),
                         //     ),
                         //     child: Text(
                         //       "Mobile",
                         //       style: zzBoldWhiteTextStyle14,
                         //     ),
                         //   ),
                         // ),
                         SizedBox(
                           height: 3.0.h,
                         ),
                         // Row(
                         //   mainAxisAlignment: MainAxisAlignment.center,
                         //   children: [
                         //     const Expanded(
                         //         child: Divider(
                         //           color: black,
                         //           indent: 70.0,
                         //           thickness: 1.5,
                         //         )),
                         //     Text(
                         //       "  OR  ",
                         //       style: zzRegularBlackTextStyle12,
                         //     ),
                         //     const Expanded(
                         //         child: Divider(
                         //           color: black,
                         //           endIndent: 70.0,
                         //           thickness: 1.5,
                         //         )),
                         //   ],
                         // ),
                         SizedBox(
                           height: 3.0.h,
                         ),
                         SizedBox(
                           width: 70.0.w,
                           height: 6.0.h,
                           child: ElevatedButton(
                             // onPressed: () => Get.to(() => const OtpVerificationScreen()),
                             onPressed: () => Get.to(() => const LoginScreenMail()),
                             style: ButtonStyle(
                               backgroundColor:
                               MaterialStateProperty.all<Color>(
                                   loginTextColor),
                               shape: MaterialStateProperty.all<
                                   RoundedRectangleBorder>(
                                 RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(7.0),
                                 ),
                               ),
                             ),
                             child: Text(
                               "Email",
                               style: zzBoldWhiteTextStyle14,
                             ),
                           ),
                         ),
                         SizedBox(
                           height: 3.0.h,
                         ),

                       ],
                     ),
                   ),

                 ],
               ),
             ),
           ),
         ),
       ),
     );
   });
  }
}

