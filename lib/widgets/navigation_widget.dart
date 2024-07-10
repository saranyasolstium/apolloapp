import 'package:get/get.dart';
import 'package:infinite/view/wishlist.dart';

import '../utils/packeages.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  String aName = "", aMobile = "", aMail = "";
  bool myHearingMain = false,
      myHearingMainCategory = false,
      myHearingSubCategory = false,
      mySkinCareMain = false,
      mySkinSubCategory = false,
      mySkinLaserSubCategory = false,
      mySkinHydraSubCategory = false,
      mySkinRFSubCategory = false,
      myEyeMain = false,
      myEyeGlassSubCategory = false,
      mySunGlassSubCategory = false,
      myContactLensSubCategory = false,
      myContaractSubCategory = false,
      mySleepCareMain = false,
      mySleepCareSub = false,
      myOralCare = false,
      myOralCareSubCategory = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  void initState() {
    aMail = sharedPreferences!.getString("mail").toString();
    aName = sharedPreferences!.getString("firstName").toString();
    aMobile = sharedPreferences!.getString("mobileNumber").toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5.sp,
      shadowColor: lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp),
            bottomLeft: Radius.circular(20.sp)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 4.0.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 2.0.w,
                ),
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: 'assets/svg/profile_img2.svg',
                    // height: 100.0,
                    // width: 100.0,
                    fit: BoxFit.contain,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => Center(
                        child: SvgPicture.asset(
                      'assets/svg/profile_img2.svg',
                      height: 10.5.h,
                      width: 10.5.w,
                    )),
                  ),
                ),
                SizedBox(
                  width: 2.0.w,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi, $aName", style: zzBoldBlackTextStyle12),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        aMobile,
                        style: zzRegularGrayTextStyle8,
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        aMail,
                        style: zzRegularGrayTextStyle8,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Get.back();
                        Get.to(() => const UpdateProfile());
                      });
                    },
                    child: SvgPicture.asset(
                      "assets/svg/edit_icon.svg",
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
              child: const Divider(
                thickness: 2,
                color: lightBlue,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: white,
                                backgroundColor: loginTextColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                              ),
                              onPressed: () {
                                Get.back();
                                Get.to(() => const MyOrder());
                              },
                              child: Text(
                                "My Orders",
                                style: zzBoldWhiteTextStyle19,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: white,
                                backgroundColor: loginTextColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                              ),
                              onPressed: () {
                                Get.back();
                                Get.to(() => const Wishlist());
                              },
                              child: Text(
                                "Wishlist",
                                style: zzBoldWhiteTextStyle19,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: white,
                                backgroundColor: loginTextColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                              ),
                              onPressed: () {
                                Get.back();
                                //Get.to(() => const Notification1());
                              },
                              child: Text(
                                "Notification",
                                style: zzBoldWhiteTextStyle19,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: white,
                                backgroundColor: loginTextColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                              ),
                              //   onPressed: () {
                              onPressed: () {
                                setState(() {
                                  Get.back();
                                  Freshchat.showConversations();
                                });
                              },
                              // },
                              child: Text(
                                "Chat with us",
                                style: zzBoldWhiteTextStyle19,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0),
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: loginTextColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            Get.to(() => const HomeScreen(index: 0));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/home.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 15.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(" Home",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: white,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() => myEyeMain = !myEyeMain);
                          },
                          // onTap: ()=>Get.to(()=>const BookAppointment())
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/eye_wear.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 10.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Eyewear",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: myEyeMain,
                          child: Column(
                            children: [
                              // EYE GLASS
                              Card(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 5, right: 5),
                                  color: menuSubCategoryTabColor,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() =>
                                                myEyeGlassSubCategory =
                                                    !myEyeGlassSubCategory);
                                          },
                                          child: Container(
                                            width: ScreenSize.getScreenWidth(
                                                context),
                                            height: ScreenSize.getScreenHeight(
                                                    context) *
                                                0.04,
                                            color: menuCategoryTabColor,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Text(
                                                    "Eyeglasses",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Center(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      myEyeGlassSubCategory
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      color: white,
                                                      size: 20.0,
                                                    ),
                                                    onPressed: () {
                                                      setState(() =>
                                                          myEyeGlassSubCategory =
                                                              !myEyeGlassSubCategory);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: myEyeGlassSubCategory,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20.0),
                                                          child: Text(
                                                            "Gender",
                                                            style: GoogleFonts.lato(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                        411246756084,
                                                        handle:
                                                            "eyeglasses-gender-women",
                                                      )),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Women",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                        411246821620,
                                                        handle:
                                                            "eyeglasses-gender-women",
                                                      )),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Men",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                        411246887156,
                                                        handle:
                                                            "eyeglasses-gender-Unisex",
                                                      )),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Unisex",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411246919924,
                                                          handle:
                                                              "eyeglasses-gender-kids")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Kids",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411246690548,
                                                          handle:
                                                              "eyeglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20.0),
                                                          child: Text(
                                                            "Material",
                                                            style: GoogleFonts.lato(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                        411247083764,
                                                        handle:
                                                            "eyeglasses-material-acetate",
                                                      )),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Acetate",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411247116532,
                                                          handle:
                                                              "eyeglasses-material-metal")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Metal",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411246985460,
                                                          handle:
                                                              "eyeglasses-material-tr")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "TR",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411866497268,
                                                          handle:
                                                              "eyeglasses-material-injected")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Injected",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411811053812,
                                                          handle:
                                                              "eyeglasses-material-mix")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Mix",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411246690548,
                                                          handle:
                                                              "eyeglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Style",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                        411247280372,
                                                        handle:
                                                            "eyeglasses-style-full-rim",
                                                      )),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Full rim",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411247313140,
                                                          handle:
                                                              "eyeglasses-style-half-rim")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Half rim",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411247345908,
                                                          handle:
                                                              "eyeglasses-style-rimless")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Rimless",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411884650740,
                                                          handle:
                                                              "eyeglasses-style-3-pieces")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "3 Pieces",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411884781812,
                                                          handle:
                                                              "eyeglasses-style-Nylon-semi-rimless")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Nylon (semi-Rimless)",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411246690548,
                                                          handle:
                                                              "eyeglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Shape",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411247411444,
                                                          handle:
                                                              "eyeglasses-shape-rectangle")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Rectangle",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        const ViewProductListScreen(
                                                            411247444212,
                                                            handle:
                                                                "eyeglasses-shape-square"));
                                                  },
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Square",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411247476980,
                                                          handle:
                                                              "eyeglasses-shape-round")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Round",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411247542516,
                                                          handle:
                                                              "eyeglasses-shape-oval")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Oval",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411247575284,
                                                          handle:
                                                              "eyeglasses-shape-cateye")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Cateye",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411246690548,
                                                          handle:
                                                              "eyeglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Brand",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411248066804,
                                                          handle:
                                                              "eyeglasses-brand-infinite")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Infinite",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411248328948,
                                                          handle:
                                                              "eyeglasses-brand-vogue")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Vogue",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411248263412,
                                                          handle:
                                                              "eyeglasses-brand-rayban")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Ray Ban",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411248427252,
                                                          handle:
                                                              "eyeglasses-brand-calvin")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Calvin Klein",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411808202996,
                                                          handle:
                                                              "eyeglasses-brand-tommy-hilfiger")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Tommy Hilfiger",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411246690548,
                                                          handle:
                                                              "eyeglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  // onTap: () => Get.to(() =>
                                                  //     const ViewProductListScreen(
                                                  //         411246690548)),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Colors",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411248525556,
                                                          handle:
                                                              "eyeglasses-colors-black")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Black",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411248689396,
                                                          handle:
                                                              "eyeglasses-colors-blue")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Blue",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411248591092,
                                                          handle:
                                                              "eyeglasses-colors-brown")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Brown",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411261436148,
                                                          handle:
                                                              "eyeglasses-colors-gold")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Gold",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411248820468,
                                                          handle:
                                                              "eyeglasses-colors-grey")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Grey",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411246690548,
                                                          handle:
                                                              "eyeglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ])),
                              // SUN GLASS
                              Card(
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  color: menuSubCategoryTabColor,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () => setState(() =>
                                              mySunGlassSubCategory =
                                                  !mySunGlassSubCategory),
                                          child: Container(
                                            width: ScreenSize.getScreenWidth(
                                                context),
                                            height: ScreenSize.getScreenHeight(
                                                    context) *
                                                0.04,
                                            color: menuCategoryTabColor,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Text(
                                                    "Sunglasses",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Center(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      mySunGlassSubCategory
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      color: white,
                                                      size: 20.0,
                                                    ),
                                                    onPressed: () {
                                                      setState(() =>
                                                          mySunGlassSubCategory =
                                                              !mySunGlassSubCategory);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: mySunGlassSubCategory,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20.0),
                                                          child: Text(
                                                            "Gender",
                                                            style: GoogleFonts.lato(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411249049844,
                                                          handle:
                                                              "sunglasses-gender-women")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Women",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411249082612,
                                                          handle:
                                                              "sunglasses-gender-men")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Men",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411249115380,
                                                          handle:
                                                              "sunglasses-gender-unisex")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Unisex",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411228373236,
                                                          handle:
                                                              "sunglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  // onTap: () => Get.to(() =>
                                                  //     const ViewProductListScreen(
                                                  //         411246690548)),
                                                  onTap: (() {}),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Material",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411249311988,
                                                          handle:
                                                              "sunglasses-material-metal")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Metal",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411249279220,
                                                          handle:
                                                              "sunglasses-material-acetate")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Acetate",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411806302452,
                                                          handle:
                                                              "sunglasses-material-mix")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Mix",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411896643828,
                                                          handle:
                                                              "sunglasses-material-injected")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Injected",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411897004276,
                                                          handle:
                                                              "sunglasses-material-nylon")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Nylon",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411228373236,
                                                          handle:
                                                              "sunglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  // onTap: () => Get.to(() =>
                                                  //     const ViewProductListScreen(
                                                  //         411246690548)),
                                                  onTap: (() {}),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Style",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411249443060,
                                                          handle:
                                                              "sunglasses-Style-full-rim")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Full rim",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411884323060,
                                                          handle:
                                                              "sunglasses-Style-Bar-Without-Circles")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Bar Without Circles",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  // onTap: () => Get.to(() =>
                                                  //     const ViewProductListScreen(
                                                  //         411246690548)),
                                                  onTap: (() {}),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Shield w/o Bar",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411884847348,
                                                          handle:
                                                              "sunglasses-Style-Nylon-semi-rimless")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Nylon(Semi-Rimless)",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411228373236,
                                                          handle:
                                                              "sunglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  // onTap: () => Get.to(() =>
                                                  //     const ViewProductListScreen(
                                                  //         411246690548)),
                                                  onTap: (() {}),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Shape",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411256357108,
                                                          handle:
                                                              "sunglasses-shape-square")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Square",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411256324340,
                                                          handle:
                                                              "sunglasses-shape-rectangle")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Rectangle",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411256389876,
                                                          handle:
                                                              "sunglasses-shape-round")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Round",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411256652020,
                                                          handle:
                                                              "sunglasses-shape-butterfly")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Butterfly",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411897692404,
                                                          handle:
                                                              "sunglasses-shape-irregular")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Irregular",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411228373236,
                                                          handle:
                                                              "sunglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  // onTap: () => Get.to(() =>
                                                  //     const ViewProductListScreen(
                                                  //         411246690548)),
                                                  onTap: (() {}),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Brand",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411257176308,
                                                          handle:
                                                              "sunglasses-brand-oakley")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Oakley",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411257209076,
                                                          handle:
                                                              "sunglasses-brand-vogue")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Vogue",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411805974772,
                                                          handle:
                                                              "sunglasses-brand-tommy-hilfiger")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Tommy Hilfiger",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411257110772,
                                                          handle:
                                                              "sunglasses-brand-rayban")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Ray Ban",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411228373236,
                                                          handle:
                                                              "sunglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  // onTap: () => Get.to(() =>
                                                  //     const ViewProductListScreen(
                                                  //         411246690548)),
                                                  onTap: (() {}),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            bottom: 5.0,
                                                            top: 5.0),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Colors",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411257766132,
                                                          handle:
                                                              "sunglasses-colors-black")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Black",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411262419188,
                                                          handle:
                                                              "sunglasses-colors-gold")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Gold",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411806367988,
                                                          handle:
                                                              "sunglasses-colors-havana")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Havana",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411262124276,
                                                          handle:
                                                              "sunglasses-colors-grey")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Grey",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411262353652,
                                                          handle:
                                                              "sunglasses-colors-silver")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Silver",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411228373236,
                                                          handle:
                                                              "sunglasses")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "More..",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ])),
                              // CONTACT LENS
                              Card(
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  color: menuSubCategoryTabColor,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () => setState(() =>
                                              myContactLensSubCategory =
                                                  !myContactLensSubCategory),
                                          child: Container(
                                            width: ScreenSize.getScreenWidth(
                                                context),
                                            height: ScreenSize.getScreenHeight(
                                                    context) *
                                                0.04,
                                            color: menuCategoryTabColor,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Text(
                                                    "Contact lenses",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Center(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      myContactLensSubCategory
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      color: white,
                                                      size: 20.0,
                                                    ),
                                                    onPressed: () {
                                                      setState(() =>
                                                          myContactLensSubCategory =
                                                              !myContactLensSubCategory);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: myContactLensSubCategory,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20.0),
                                                          child: Text(
                                                            "Brand",
                                                            style: GoogleFonts.lato(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411257995508,
                                                          handle:
                                                              "contact-lenses-alcon")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Alcon",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411257962740,
                                                          handle:
                                                              "contact-lenses-brand-bausch-and-lomb")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Bausch and Lomb",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ])),
                              // READING GLASS
                              Card(
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  color: menuSubCategoryTabColor,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          // onTap: () => setState(() =>
                                          //     myEyeGlassSubCategory =
                                          //         !myEyeGlassSubCategory),

                                          onTap: () => Get.to(() =>
                                              const ViewProductListScreen(
                                                  411258028276,
                                                  handle:"reading-glasses")),
                                          child: Container(
                                            width: ScreenSize.getScreenWidth(
                                                context),
                                            height: ScreenSize.getScreenHeight(
                                                    context) *
                                                0.04,
                                            color: menuCategoryTabColor,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0, top: 5.0),
                                              child: Text(
                                                "Reading glasses",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                              // COMPUTER GLASS
                              Card(
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  color: menuSubCategoryTabColor,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          // onTap: () => setState(() =>
                                          //     myEyeGlassSubCategory =
                                          //         !myEyeGlassSubCategory),
                                          onTap: () => Get.to(() =>
                                              const ViewProductListScreen(
                                                  411261567220,
                                                  handle:"computer-glasses")),
                                          child: Container(
                                            width: ScreenSize.getScreenWidth(
                                                context),
                                            height: ScreenSize.getScreenHeight(
                                                    context) *
                                                0.04,
                                            color: menuCategoryTabColor,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0, top: 5.0),
                                              child: Text(
                                                "Computer glasses",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                              // SMART GLASS
                              Card(
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  color: menuSubCategoryTabColor,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () => Get.to(() =>
                                              const ViewProductListScreen(
                                                  411258093812,
                                                  handle:"smart-glasses")),
                                          child: Container(
                                            width: ScreenSize.getScreenWidth(
                                                context),
                                            height: ScreenSize.getScreenHeight(
                                                    context) *
                                                0.04,
                                            color: menuCategoryTabColor,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0, top: 5.0),
                                              child: Text(
                                                "Smart glasses",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                              // CATARACT
                              Card(
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  color: menuSubCategoryTabColor,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () => setState(() =>
                                              myContaractSubCategory =
                                                  !myContaractSubCategory),
                                          child: Container(
                                            width: ScreenSize.getScreenWidth(
                                                context),
                                            height: ScreenSize.getScreenHeight(
                                                    context) *
                                                0.04,
                                            color: menuCategoryTabColor,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Text(
                                                    "Cataract",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Center(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      myContaractSubCategory
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      color: white,
                                                      size: 20.0,
                                                    ),
                                                    onPressed: () {
                                                      setState(() =>
                                                          myContaractSubCategory =
                                                              !myContaractSubCategory);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: myContaractSubCategory,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20.0),
                                                          child: Text(
                                                            "Cataract",
                                                            style: GoogleFonts.lato(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411258126580,
                                                          handle:"cataract-black")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Black",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const ViewProductListScreen(
                                                          411258126580,
                                                          handle:"cataract-white")),
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20.0,
                                                    ),
                                                    child: Center(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "White",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ])),
                              // ACCESSORIES
                              Card(
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  color: menuSubCategoryTabColor,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () => Get.to(() =>
                                              const ViewProductListScreen(
                                                  411228995828,
                                                  handle:"accessories")),
                                          child: Container(
                                            width: ScreenSize.getScreenWidth(
                                                context),
                                            height: ScreenSize.getScreenHeight(
                                                    context) *
                                                0.04,
                                            color: menuCategoryTabColor,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0, top: 5.0),
                                              child: Text(
                                                "Accessories",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: white,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() => myHearingMain = !myHearingMain);
                            // Get.to(() => const ViewProductListScreen(411751645428));
                            // showCategoryDialog(
                            //     context, mainHearingSubCategory(), "Hearing");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/hearing.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 15.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Hearing",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: myHearingMain,
                          child: Card(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 5, right: 5),
                              color: menuSubCategoryTabColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () => Get.to(() =>
                                          const ViewProductListScreen(
                                              411858239732,
                                              handle:"affordable-hearing-aids")),
                                      child: Container(
                                        width:
                                            ScreenSize.getScreenWidth(context),
                                        height: ScreenSize.getScreenHeight(
                                                context) *
                                            0.04,
                                        color: menuCategoryTabColor,
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 5.0, top: 5.0),
                                        child: Center(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Affordable Hearing Aids",
                                              style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      //onTap:(){},
                                      onTap: () => Get.to(() =>
                                          const ViewProductListScreen(
                                              411858272500,
                                              handle:"accessibility-hearing-aids")),
                                      child: Container(
                                        width:
                                            ScreenSize.getScreenWidth(context),
                                        height: ScreenSize.getScreenHeight(
                                                context) *
                                            0.04,
                                        color: menuCategoryTabColor,
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 5.0, top: 5.0),
                                        child: Center(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Accessibility Hearing Aids",
                                              style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      // onTap:(){},
                                      onTap: () => Get.to(() =>
                                          const ViewProductListScreen(
                                              411858305268,
                                              handle:"bluetooth-hearing-aids")),
                                      child: Container(
                                        width:
                                            ScreenSize.getScreenWidth(context),
                                        height: ScreenSize.getScreenHeight(
                                                context) *
                                            0.04,
                                        color: menuCategoryTabColor,
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 5.0, top: 5.0),
                                        child: Center(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Bluetooth Hearing Aids",
                                              style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => Get.to(() =>
                                          const ViewProductListScreen(
                                              411858338036,
                                              handle:"rechargeable-hearing-aids")),
                                      child: Container(
                                        width:
                                            ScreenSize.getScreenWidth(context),
                                        height: ScreenSize.getScreenHeight(
                                                context) *
                                            0.04,
                                        color: menuCategoryTabColor,
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 5.0, top: 5.0),
                                        child: Center(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Rechargeable Hearing Aids",
                                              style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => Get.to(() =>
                                          const ViewProductListScreen(
                                              411858370804,
                                              handle:"invisible-hearing-aids")),
                                      child: Container(
                                        width:
                                            ScreenSize.getScreenWidth(context),
                                        height: ScreenSize.getScreenHeight(
                                                context) *
                                            0.04,
                                        color: menuCategoryTabColor,
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 5.0, top: 5.0),
                                        child: Center(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Invisible Hearing Aids",
                                              style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])),
                        ),
                        const Divider(
                          thickness: 1,
                          color: white,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() => mySleepCareMain = !mySleepCareMain);
                            // Get.to(() => const SelectClinicScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/sleep_care.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 10.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(width: 10),
                                  Text("Sleep Care",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: mySleepCareMain,
                          child: Card(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 5, right: 5),
                              color: menuSubCategoryTabColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () => setState(() =>
                                          mySleepCareSub = !mySleepCareSub),
                                      child: Container(
                                        width:
                                            ScreenSize.getScreenWidth(context),
                                        height: ScreenSize.getScreenHeight(
                                                context) *
                                            0.04,
                                        color: menuCategoryTabColor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411739422964,
                                                        handle:"nasal"));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Text(
                                                  "Nasal",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: IconButton(
                                                icon: Icon(
                                                  mySleepCareSub
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons
                                                          .keyboard_arrow_down,
                                                  color: white,
                                                  size: 20.0,
                                                ),
                                                onPressed: () {
                                                  setState(() =>
                                                      mySleepCareSub =
                                                          !mySleepCareSub);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible: mySleepCareSub,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Text(
                                                        "Category",
                                                        style: GoogleFonts.lato(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              indent: 15.0,
                                              endIndent: 15.0,
                                              color: white,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411739554036,
                                                        handle:"nasal-accessories"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Accessories",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411739947252,
                                                        handle:"nasal-bipap-rental"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "BIPAP Rental",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740078324,
                                                        handle:"nasal-combo"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Combo",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740373236,
                                                        handle:"nasal-cpap"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "CPAP",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740438772,
                                                        handle:"nasal-cpap-rental"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "CPAP Rental",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740569844,
                                                        handle:"nasal-life-style-modification"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Lifestyle Modification",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740635380,handle:"nasal-mask"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Mask",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740733684,
                                                        handle:"ost-device"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "OST Device",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411741356276,
                                                        handle:"nasal-oxygen-concentrator-10-ltrs-rental"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.05,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Oxygen Concentrator-10 ltrs Rental",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740864756,
                                                        handle:"nasal-sleep-test"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.05,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Sleep Test",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Text(
                                                        "Sub Category",
                                                        style: GoogleFonts.lato(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              indent: 15.0,
                                              endIndent: 15.0,
                                              color: white,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411739586804,handle:"naa-accessories"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Accessories",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740340468,
                                                        handle:"nc-auto-cpap"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Auto CPAP",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740176628,
                                                        handle:"nc-auto-cpap-with-disposable"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Auto CPAP with Disposable",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740045556,
                                                        handle:"nc-auto-cpap-with-reusable-mask"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Auto CPAP with Reusable Mask",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411741257972,
                                                        handle:"bipap-rental"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "BIPAP Rental",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740111092,
                                                        handle:"nc-bipap-with-diposable-mask"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "BIPAP with Disposable Mask",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740242164,
                                                        handle:"nc-bipap-with-reusable-mask"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "BIPAP with Reusable Mask",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740668148,
                                                        handle:"nm-disposable-mask"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Disposable Mask",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411740930292,
                                                        handle:"ns-sleep-test"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Sleep Test",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Text(
                                                        "Brand",
                                                        style: GoogleFonts.lato(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              indent: 15.0,
                                              endIndent: 15.0,
                                              color: white,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411739652340,
                                                        handle:"nasal-resmed"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Resmed",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ViewProductListScreen(
                                                        411739717876,
                                                        handle:"nasal-oxymed"));
                                              },
                                              child: Container(
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        context),
                                                height:
                                                    ScreenSize.getScreenHeight(
                                                            context) *
                                                        0.04,
                                                color: menuSubCategoryTabColor,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                ),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Oxymed",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ])),
                        ),
                        const Divider(
                          thickness: 1,
                          color: white,
                        ),
                        InkWell(
                          // onTap: () => Get.to(() =>  const ViewProductListScreen(411246690548)),
                          onTap: () {
                            setState(() {
                              myOralCare = !myOralCare;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/sleep_care.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 10.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(width: 10),
                                  Text("Oral Care",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                            visible: myOralCare,
                            child: Card(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 5, right: 5),
                                color: menuSubCategoryTabColor,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          launchURL(
                                              "https://my6senses.com/pages/aligners");
                                        },
                                        child: Container(
                                            width: ScreenSize.getScreenWidth(
                                                context),
                                            height: ScreenSize.getScreenHeight(
                                                    context) *
                                                0.04,
                                            color: menuCategoryTabColor,
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                bottom: 5.0,
                                                top: 5.0),
                                            child: Center(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Aligners",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() => myOralCareSubCategory =
                                              !myOralCareSubCategory);
                                          Get.to(() =>
                                              const ViewProductListScreen(
                                                  411858501876,handle:"oral"));
                                        },
                                        child: Container(
                                          width: ScreenSize.getScreenWidth(
                                              context),
                                          height: ScreenSize.getScreenHeight(
                                                  context) *
                                              0.04,
                                          color: menuCategoryTabColor,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Text(
                                                  "Products",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Center(
                                                child: IconButton(
                                                  icon: Icon(
                                                    myOralCareSubCategory
                                                        ? Icons
                                                            .keyboard_arrow_up
                                                        : Icons
                                                            .keyboard_arrow_down,
                                                    color: white,
                                                    size: 20.0,
                                                  ),
                                                  onPressed: () {
                                                    setState(() =>
                                                        myOralCareSubCategory =
                                                            !myOralCareSubCategory);
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              const ViewProductListScreen(
                                                  412674294004,
                                                  handle:"teeth-whitening"));
                                        },
                                        child: Visibility(
                                          visible: myOralCareSubCategory,
                                          child: Container(
                                              width: ScreenSize.getScreenWidth(
                                                  context),
                                              height:
                                                  ScreenSize.getScreenHeight(
                                                          context) *
                                                      0.04,
                                              color: menuSubCategoryTabColor,
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  bottom: 5.0,
                                                  top: 5.0),
                                              child: Center(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Teeth Whitening",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              const ViewProductListScreen(
                                                  412674326772,handle:"electric-toothbrush"));
                                        },
                                        child: Visibility(
                                          visible: myOralCareSubCategory,
                                          child: Container(
                                              width: ScreenSize.getScreenWidth(
                                                  context),
                                              height:
                                                  ScreenSize.getScreenHeight(
                                                          context) *
                                                      0.04,
                                              color: menuSubCategoryTabColor,
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  bottom: 5.0,
                                                  top: 5.0),
                                              child: Center(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Electric Toothbrush",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              const ViewProductListScreen(
                                                  412674359540,handle:"tooth-paste"));
                                        },
                                        child: Visibility(
                                          visible: myOralCareSubCategory,
                                          child: Container(
                                              width: ScreenSize.getScreenWidth(
                                                  context),
                                              height:
                                                  ScreenSize.getScreenHeight(
                                                          context) *
                                                      0.04,
                                              color: menuSubCategoryTabColor,
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  bottom: 5.0,
                                                  top: 5.0),
                                              child: Center(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Tooth Paste",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              const ViewProductListScreen(
                                                  412674392308,handle:"mouth-wash"));
                                        },
                                        child: Visibility(
                                          visible: myOralCareSubCategory,
                                          child: Container(
                                              width: ScreenSize.getScreenWidth(
                                                  context),
                                              height:
                                                  ScreenSize.getScreenHeight(
                                                          context) *
                                                      0.04,
                                              color: menuSubCategoryTabColor,
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  bottom: 5.0,
                                                  top: 5.0),
                                              child: Center(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Mouth wash",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              const ViewProductListScreen(
                                                  412674425076,handle:"dental-flosser"));
                                        },
                                        child: Visibility(
                                          visible: myOralCareSubCategory,
                                          child: Container(
                                              width: ScreenSize.getScreenWidth(
                                                  context),
                                              height:
                                                  ScreenSize.getScreenHeight(
                                                          context) *
                                                      0.04,
                                              color: menuSubCategoryTabColor,
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  bottom: 5.0,
                                                  top: 5.0),
                                              child: Center(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Dental Flosser",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ]))),
                        const Divider(
                          thickness: 1,
                          color: white,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() => mySkinCareMain = !mySkinCareMain);
                            // Get.to(() => const SelectClinicScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/sleep_care.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 10.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(width: 10),
                                  Text("Skin Care",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: mySkinCareMain,
                          child: Card(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 5, right: 5),
                              color: menuSubCategoryTabColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () => setState(
                                        () => mySkinSubCategory =
                                            !mySkinSubCategory,
                                      ),
                                      child: Container(
                                        width:
                                            ScreenSize.getScreenWidth(context),
                                        height: ScreenSize.getScreenHeight(
                                                context) *
                                            0.04,
                                        color: menuCategoryTabColor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text(
                                                "Services",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Center(
                                              child: IconButton(
                                                icon: Icon(
                                                  mySkinSubCategory
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons
                                                          .keyboard_arrow_down,
                                                  color: white,
                                                  size: 20.0,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    mySkinSubCategory =
                                                        !mySkinSubCategory;
                                                    mySkinLaserSubCategory ==
                                                        false;
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible: mySkinSubCategory,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  launchURL(
                                                      "https://my6senses.com/pages/laser-hair-reduction");
                                                },
                                                child: Container(
                                                  width:
                                                      ScreenSize.getScreenWidth(
                                                          context),
                                                  height: ScreenSize
                                                          .getScreenHeight(
                                                              context) *
                                                      0.04,
                                                  color:
                                                      menuSubCategoryTabColor,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20.0),
                                                        child: Text(
                                                          "Laser Hair Reduction",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: IconButton(
                                                          icon: Icon(
                                                            mySkinLaserSubCategory
                                                                ? Icons
                                                                    .keyboard_arrow_up
                                                                : Icons
                                                                    .keyboard_arrow_down,
                                                            color: white,
                                                            size: 20.0,
                                                          ),
                                                          onPressed: () {
                                                            setState(() =>
                                                                mySkinLaserSubCategory =
                                                                    !mySkinLaserSubCategory);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: mySkinLaserSubCategory,
                                                child: const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                              ),
                                              Visibility(
                                                visible: mySkinLaserSubCategory,
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        const ViewProductListScreen(
                                                            412659450100,handle:"laser-hair-reduction"));
                                                  },
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20.0),
                                                          child: Text(
                                                            "Package",
                                                            style: GoogleFonts.lato(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launchURL(
                                                      "https://my6senses.com/pages/hydra-facial");
                                                },
                                                child: Container(
                                                  width:
                                                      ScreenSize.getScreenWidth(
                                                          context),
                                                  height: ScreenSize
                                                          .getScreenHeight(
                                                              context) *
                                                      0.04,
                                                  color:
                                                      menuSubCategoryTabColor,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20.0),
                                                        child: Text(
                                                          "Hydra Facial",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: IconButton(
                                                          icon: Icon(
                                                            mySkinHydraSubCategory
                                                                ? Icons
                                                                    .keyboard_arrow_up
                                                                : Icons
                                                                    .keyboard_arrow_down,
                                                            color: white,
                                                            size: 20.0,
                                                          ),
                                                          onPressed: () {
                                                            setState(() =>
                                                                mySkinHydraSubCategory =
                                                                    !mySkinHydraSubCategory);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: mySkinHydraSubCategory,
                                                child: const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                              ),
                                              Visibility(
                                                visible: mySkinHydraSubCategory,
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        const ViewProductListScreen(
                                                            412661252340,handle:"hydra-facial"));
                                                  },
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20.0),
                                                          child: Text(
                                                            "Package",
                                                            style: GoogleFonts.lato(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launchURL(
                                                      "https://my6senses.com/pages/rf-skin-rejuvenation");
                                                },
                                                child: Container(
                                                  width:
                                                      ScreenSize.getScreenWidth(
                                                          context),
                                                  height: ScreenSize
                                                          .getScreenHeight(
                                                              context) *
                                                      0.04,
                                                  color:
                                                      menuSubCategoryTabColor,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20.0),
                                                        child: Text(
                                                          "RF Skin Rejuvenation",
                                                          style:
                                                              GoogleFonts.lato(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: IconButton(
                                                          icon: Icon(
                                                            mySkinRFSubCategory
                                                                ? Icons
                                                                    .keyboard_arrow_up
                                                                : Icons
                                                                    .keyboard_arrow_down,
                                                            color: white,
                                                            size: 20.0,
                                                          ),
                                                          onPressed: () {
                                                            setState(() =>
                                                                mySkinRFSubCategory =
                                                                    !mySkinRFSubCategory);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: mySkinRFSubCategory,
                                                child: const Divider(
                                                  thickness: 1,
                                                  indent: 15.0,
                                                  endIndent: 15.0,
                                                  color: white,
                                                ),
                                              ),
                                              Visibility(
                                                visible: mySkinRFSubCategory,
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        const ViewProductListScreen(
                                                            412661317876,handle:"rf-skin-rejuvenation"));
                                                  },
                                                  child: Container(
                                                    width: ScreenSize
                                                        .getScreenWidth(
                                                            context),
                                                    height: ScreenSize
                                                            .getScreenHeight(
                                                                context) *
                                                        0.04,
                                                    color:
                                                        menuSubCategoryTabColor,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20.0),
                                                          child: Text(
                                                            "Package",
                                                            style: GoogleFonts.lato(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ])),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() =>
                                            const ViewProductListScreen(
                                                411832320244,handle:"skin"));
                                      },
                                      child: Container(
                                        width:
                                            ScreenSize.getScreenWidth(context),
                                        height: ScreenSize.getScreenHeight(
                                                context) *
                                            0.04,
                                        color: menuCategoryTabColor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text(
                                                "Products",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ])),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0),
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: loginTextColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              Get.back();
                              Get.to(() => const TalkToDoctor());
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/talk_doctor.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 15.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Talk to Doctor",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: white,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              launchURL("https://selftest.my6senses.com/");
                              // Get.back();
                              // showSuccessSnackBar(context, 'Coming soon...');
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/self_test_icon.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 15.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Self Test",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: white,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Get.back();
                              Get.to(() => const BookAppointment());
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/book_appointment_icon.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 15.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(" Book Home Test",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: white,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Get.back();
                              Get.to(() => const SelectClinicScreen());
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/clinic_locator_icon.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 15.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(" Store Locator",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 20.0),
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: loginTextColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              Get.back();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/get_membership.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 15.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Get Membership",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: white,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              Get.back();
                              Get.to(() => const ManageAddress());
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/manage_address.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 15.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("   Manage Addresses",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/offers_for_you.svg",
                                  color: white,
                                  height: 15.0,
                                  width: 15.0,
                                  allowDrawingOutsideViewBox: true,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Offers for you",
                                    style: GoogleFonts.lato(
                                        fontSize: 14, color: Colors.white)),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 20.0),
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: loginTextColor),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Get.back();
                                  Get.to(() => const LegalHomeScreen());
                                });
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/legal.svg",
                                    color: white,
                                    height: 15.0,
                                    width: 15.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(" Legal",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              ),
                            ),
                            const Visibility(
                              visible: true,
                              child: Divider(
                                thickness: 1,
                                color: white,
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: InkWell(
                                onTap: () => logout(),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/login_icon.svg",
                                      color: white,
                                      height: 15.0,
                                      width: 15.0,
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("Logout",
                                        style: GoogleFonts.lato(
                                            fontSize: 14, color: Colors.white)),
                                  ],
                                ),
                              ),
                            )
                          ])),
                  const SizedBox(
                    height: 30.0,
                  ),
                ]),
              ),
            ),
            SizedBox(height: 10.sp),
            Center(
              child: Text("Version 1.0.0", style: zzBoldBlackTextStyle13),
            ),
            SizedBox(height: 10.sp),
          ],
        ),
      ),
    );
  }

  Widget mainHearingSubCategory(BuildContext context) => Column(
        children: [
          ListTile(
            onTap: () {
              showCategoryDialog(
                  context, hearingAidSubCategory(), "Hearing Aid");
            },
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Hearing Aid",
              style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 15.0,
            ),
          ),
          ListTile(
            onTap: () => Get.to(() => const BookAppointment()),
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Accessories",
              style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 15.0,
            ),
          ),
        ],
      );

  Widget hearingAidSubCategory() => Column(
        children: [
          ListTile(
            onTap: () => Get.to(() => const BookAppointment()),
            dense: true,
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            title: Text(
              "Behind The Ear (BTE)",
              style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 15.0,
            ),
          ),
          ListTile(
            onTap: () => Get.to(() => const BookAppointment()),
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Receiver In The Canal (RIC)",
              style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 15.0,
            ),
          ),
          ListTile(
            onTap: () => Get.to(() => const BookAppointment()),
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Completely In Canal (CIC)",
              style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 15.0,
            ),
          ),
          ListTile(
            onTap: () => Get.to(() => const BookAppointment()),
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "In The Ear (ITE)",
              style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 15.0,
            ),
          ),
          ListTile(
            onTap: () => Get.to(() => const BookAppointment()),
            dense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "In The Canal (ITC)",
              style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 15.0,
            ),
          ),
        ],
      );

  logout() {
    try {
      sharedPreferences!.clear();
      _googleSignIn.signOut();
      //Get.offAll(() => const LoginScreen());
      Get.offAll(() => const LoginScreenMail());
    } catch (e) {
      debugPrint('$e');
    }
  }
}
