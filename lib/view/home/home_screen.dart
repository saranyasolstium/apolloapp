import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:get/get.dart';

import 'package:infinite/control/home_controller/home_controller.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/view/book/book_appointment.dart';
import 'package:infinite/view/clinic/select_clinic_screen.dart';
import 'package:infinite/view/home/oral_care/oral_care.dart';
import 'package:infinite/view/home/skin_care/skincare_screen.dart';
import 'package:infinite/view/home/sleep_care/sleep_care.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/screen_size.dart';
import 'package:infinite/widgets/cart_icon.dart';
import 'package:infinite/widgets/navigation_widget.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  final int index;

  const HomeScreen({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: colorPrimaryDark));
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeCtrl) {
          return SafeArea(
            child: WillPopScope(
              onWillPop: homeCtrl.onWillPop,
              child: Scaffold(
                endDrawer: const NavigationWidget(),
                body: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: const SystemUiOverlayStyle(
                    systemNavigationBarColor: colorPrimaryDark,
                    statusBarColor: loginTextColor,
                    systemNavigationBarIconBrightness: Brightness.dark,
                    systemNavigationBarDividerColor: loginTextColor,
                    statusBarIconBrightness: Brightness.dark,
                    // statusBarBrightness: Brightness.dark,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: ScreenSize.getScreenWidth(context),
                        height: ScreenSize.getScreenHeight(context) * 0.07,
                        color: loginTextColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 2.w,
                            ),
                            Image.asset(
                              "assets/images/inf_logo_white.png",
                              height: 100.0,
                              width: 100.0,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //  Get.to(()=>const BookAppointmentDetails());
                                      makeCallOrSendMessage(
                                          "call", myDefaultLandLineNumber, "");
                                      homeCtrl.update();
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
                                    width: 6.0.w,
                                  ),
                                  CartIcon(),
                                  SizedBox(
                                    width: 4.0.w,
                                  ),
                                  Builder(builder: (context) {
                                    return InkWell(
                                      onTap: () {
                                        Scaffold.maybeOf(context)!
                                            .openEndDrawer();
                                        homeCtrl.update();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/svg/left_menu.svg",
                                        color: white,
                                        height: 15.0,
                                        width: 15.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    );
                                  }),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              color: white,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  SizedBox(
                                    width: ScreenSize.getScreenWidth(context),
                                    height:
                                        ScreenSize.getScreenHeight(context) *
                                            0.10,
                                    child: ListView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        SizedBox(width: 5.w),
                                        InkWell(
                                          onTap: () {
                                            launchURL(
                                                "https://selftest.my6senses.com/");

                                            homeCtrl.update();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/svg/self_test.svg",
                                            width: 80.0,
                                            height: 80.0,
                                            allowDrawingOutsideViewBox: true,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                                () => const BookAppointment());
                                            homeCtrl.update();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/svg/book_appointment.svg",
                                            width: 80.0,
                                            height: 80.0,
                                            allowDrawingOutsideViewBox: true,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() =>
                                                const SelectClinicScreen());
                                            homeCtrl.update();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/svg/clinic_locator.svg",
                                            width: 80.0,
                                            height: 80.0,
                                            allowDrawingOutsideViewBox: true,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        InkWell(
                                          onTap: () {
                                            Freshchat.showConversations();
                                            // Get.to(() => ChatWithUsScreen());
                                            homeCtrl.update();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/svg/chat_with_us.svg",
                                            width: 80.0,
                                            height: 80.0,
                                            allowDrawingOutsideViewBox: true,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: homeCtrl.isCloseMemberShip,
                                    child: Container(
                                      margin: const EdgeInsets.all(15.0),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Color(0xFFffd9b6),
                                              Color(0xFFffebbc)
                                            ]),
                                      ),
                                      child: ListTile(
                                        // onTap: ()=> Get.to(()=> const AddLens2()),
                                        title: Text(
                                          "Get a Membership",
                                          style: zzBoldBlackTextStyle14,
                                        ),
                                        subtitle: Text(
                                          "Free delivery to many more offer included",
                                          style: zzRegularBlackTextStyle10,
                                        ),
                                        trailing: InkWell(
                                          onTap: () {
                                            // Get.to(()=> Wishlist());
                                            sharedPreferences!.setBool(
                                                "membership_close", true);
                                            homeCtrl.update();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/svg/close_circle_white.svg",
                                            width: 30.0,
                                            height: 30.0,
                                            allowDrawingOutsideViewBox: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.sp,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: DefaultTabController(
                                    length: 5,
                                    child: Column(children: [
                                      TabBar(
                                        isScrollable: true,
                                        labelColor: loginTextColor,
                                        unselectedLabelColor: Colors.grey,
                                        labelStyle: zzBoldBlueDarkTextStyle14,
                                        unselectedLabelStyle:
                                            zzBoldGrayTextStyle14,
                                        indicator: const UnderlineTabIndicator(
                                          borderSide: BorderSide(
                                              color: loginTextColor,
                                              width: 2.0),
                                        ),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        
                                        physics: const BouncingScrollPhysics(),
                                        onTap: (int index) {
                                          homeCtrl.update();
                                          index = homeCtrl.tabController.index;
                                          homeCtrl.tabController.index = index;
                                          homeCtrl.update();
                                        },
                                        controller: homeCtrl.tabController,
                                        tabs: const [
                                          Tab(text: "EYEWEAR"),
                                          Tab(text: "HEARING"),
                                          Tab(
                                            text: "SLEEP CARE",
                                          ),
                                          Tab(
                                            text: "ORAL CARE",
                                          ),
                                          Tab(
                                            text: "SKIN CARE",
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          controller: homeCtrl.tabController,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            homeCtrl.showEyeWidget(context),
                                            homeCtrl.showEarWidget(context),
                                            const SleepCareScreen(),
                                            const OralCareScreen(),
                                            const SkinCareScreen(),
                                          ],
                                        ),
                                      ),
                                    ])))
                          ],
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
