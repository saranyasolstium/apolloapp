import 'package:get/get.dart';

import '../../utils/packeages.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  final PageController pageController2 = PageController();
  final PageController pageController3 = PageController();
  final PageController pageController4 = PageController();
  // final PageController pageController5 = PageController();

  late TabController tabController;
  int currentPage = 0;
  int currentPage2 = 0;
  int currentPage3 = 0;
  int currentPage4 = 0;
  int myCartCount = 0;
  int myBookCount = 0;
  int myFrameCount = 0;
  int myAddOnCount = 0;

  bool isCloseMemberShip = false;
  int totalBadgeCount = 0;
  DateTime? backButtonPressTime;

  @override
  void onInit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    isCloseMemberShip = sharedPreferences!.getBool("membership_close") ?? false;
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);

    applyPageCartCount();

    update();
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose(); // dispose the PageController
    pageController.dispose(); // dispose the PageController
    pageController2.dispose(); // dispose the PageController
    pageController3.dispose(); // dispose the PageController
    pageController4.dispose();
    super.onClose();
  }

  void applyPageCartCount() {
    pageController.addListener(() {
      currentPage = pageController.page!.toInt();
      update();
      Get.forceAppUpdate();
    });
    pageController2.addListener(() {
      currentPage2 = pageController2.page!.toInt();
      update();
      Get.forceAppUpdate();
    });
    pageController3.addListener(() {
      currentPage3 = pageController3.page!.toInt();
      update();
      Get.forceAppUpdate();
    });
    pageController4.addListener(() {
      currentPage4 = pageController4.page!.toInt();
      myCartCount;
      myBookCount;
      myFrameCount;
      myAddOnCount;
      update();
      Get.forceAppUpdate();
    });
  }

  Future<bool> onWillPop() async {
    return false;
  }

  Widget showEyeWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBlue.withOpacity(0.30),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                width: ScreenSize.getScreenWidth(context),
                // height: ScreenSize.getScreenHeight(context) * 0.45,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10.0),
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
                      height: 4.0.h,
                    ),
                    Text(
                      "Explore Eyewear Collections",
                      style: zzBoldBlackTextStyle14,
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(const ViewProductListScreen(411246690548,
                                  handle: "eyeglasses", fromWhere2: 'EYE'));
                            },
                            child: SvgPicture.asset(
                              "assets/svg/eyeglass.svg",
                              width: 50.0,
                              height: 50.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.to(() =>
                                const ViewProductListScreen(411261567220,
                                    handle: "computer-glasses",
                                    fromWhere2: 'EYE')),
                            child: SvgPicture.asset(
                              "assets/svg/computer_glass.svg",
                              width: 50.0,
                              height: 50.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.to(() =>
                                const ViewProductListScreen(411258028276,
                                    handle: "reading-glasses",
                                    fromWhere2: 'EYE')),
                            child: SvgPicture.asset(
                              "assets/svg/reading_glass.svg",
                              width: 50.0,
                              height: 50.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.to(() =>
                                const ViewProductListScreen(411246690548,
                                    handle: "eyeglasses", fromWhere2: 'EYE')),
                            child: Center(
                              child: Text(
                                "Eyeglasses",
                                style: zzRegularBlackTextStyle11,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.to(() =>
                                const ViewProductListScreen(411261567220,
                                    handle: "computer-glasses",
                                    fromWhere2: 'EYE')),
                            child: Center(
                              child: Text(
                                "Computer\nGlasses",
                                textAlign: TextAlign.center,
                                style: zzRegularBlackTextStyle11,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Get.to(() =>
                                const ViewProductListScreen(411258028276,
                                    handle: "reading-glasses",
                                    fromWhere2: 'EYE')),
                            child: Center(
                              child: Text(
                                "Reading\nGlasses",
                                style: zzRegularBlackTextStyle11,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Get.to(() =>
                                      const ViewProductListScreen(411228373236,
                                          handle: "sunglasses",
                                          fromWhere2: 'EYE')),
                                  child: SvgPicture.asset(
                                    "assets/svg/eyeglass.svg",
                                    width: 50.0,
                                    height: 50.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Get.to(() =>
                                      const ViewProductListScreen(411258093812,
                                          handle: "smart-glasses",
                                          fromWhere2: 'EYE')),
                                  child: SvgPicture.asset(
                                    "assets/svg/eyeglass.svg",
                                    width: 50.0,
                                    height: 50.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Get.to(() =>
                                      const ViewProductListScreen(411257929972,
                                          handle: "cataract",
                                          fromWhere2: 'EYE')),
                                  child: SvgPicture.asset(
                                    "assets/svg/contact_lens.svg",
                                    width: 50.0,
                                    height: 50.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Get.to(() =>
                                      const ViewProductListScreen(411228995828,
                                          handle: "accessories",
                                          fromWhere2: 'EYE')),
                                  child: SvgPicture.asset(
                                    "assets/svg/accessories.svg",
                                    width: 50.0,
                                    height: 50.0,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Get.to(() =>
                                      const ViewProductListScreen(411228373236,
                                          handle: "sunglasses",
                                          fromWhere2: 'EYE')),
                                  child: Center(
                                    child: Text(
                                      "Sun\nGlasses",
                                      textAlign: TextAlign.center,
                                      style: zzRegularBlackTextStyle11,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Get.to(() =>
                                      const ViewProductListScreen(411258093812,
                                          handle: "smart-glasses",
                                          fromWhere2: 'EYE')),
                                  child: Center(
                                    child: Text(
                                      "Smart\nGlasses",
                                      textAlign: TextAlign.center,
                                      style: zzRegularBlackTextStyle11,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Get.to(() =>
                                      const ViewProductListScreen(411257929972,
                                          handle: "contact-lenses",
                                          fromWhere2: 'EYE')),
                                  child: Center(
                                    child: Text(
                                      "Contact\nLens",
                                      textAlign: TextAlign.center,
                                      style: zzRegularBlackTextStyle11,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Get.to(() =>
                                      const ViewProductListScreen(411228995828,
                                          handle: "accessories",
                                          fromWhere2: 'EYE')),
                                  child: Center(
                                    child: Text(
                                      "Accessories",
                                      style: zzRegularBlackTextStyle11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                // margin: const EdgeInsets.all(20.0),
                width: ScreenSize.getScreenWidth(context),
                height: ScreenSize.getScreenHeight(context) * 0.55,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    PageView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: 4,
                        onPageChanged: (int index) {
                          currentPage = index;
                          update();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Stack(children: [
                              Image.asset(
                                "assets/images/deals_on_glass.png",
                              ),
                              Positioned(
//                                top: 70.0,
                                top: MediaQuery.of(context).size.height * 0.08,
                                left: 0,
                                right: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Big Deals on Eyeglasses",
                                      style: zzRegularWhiteTextStyle14,
                                    ),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    GestureDetector(
                                      onTap: () => Get.to(() =>
                                          const ViewProductListScreen(
                                              411246690548,
                                              handle: "eyeglasses")),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          bottom:
                                              5, // Space between underline and text
                                        ),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                          color: white,
                                          width: 1.0, // Underline thickness
                                        ))),
                                        child: Text(
                                          "Shop Now",
                                          style: zzRegularWhiteTextStyle12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          );
                        }),
                    Positioned(
                      //bottom: 60,
                      // bottom: MediaQuery.of(context).size.height / 13,
                      bottom: MediaQuery.of(context).size.height * 0.10,
                      left: 0,
                      right: 0,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                            4,
                            (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    onTap: () {
                                      pageController.animateToPage(index,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn);
                                    },
                                    child: CircleAvatar(
                                      radius: 5,
                                      // check if a dot is connected to the current page
                                      // if true, give it a different color
                                      backgroundColor: currentPage == index
                                          ? loginTextColor
                                          : loginBlue2,
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.5.sp),
              const ShowOfferWidget(
                  'Bestseller of the Week', 'eye', "best_seller", false),
              SizedBox(
                height: 4.0.h,
              ),
              Text(
                "Specifications of Infinite Lens",
                style: zzBoldBlackTextStyle14,
              ),
              SizedBox(
                height: 6.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/anti_glare.svg",
                          width: 50.0,
                          height: 50.0,
                          allowDrawingOutsideViewBox: true,
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "Double-Side\nAni-Glare",
                          textAlign: TextAlign.center,
                          style: zzRegularBlackTextStyle10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/uv_protection.svg",
                          width: 50.0,
                          height: 50.0,
                          allowDrawingOutsideViewBox: true,
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "UV 420\nProtection",
                          textAlign: TextAlign.center,
                          style: zzRegularBlackTextStyle10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/light_weight.svg",
                          width: 50.0,
                          height: 50.0,
                          allowDrawingOutsideViewBox: true,
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "Light Weight",
                          style: zzRegularBlackTextStyle10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.0.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 55.0, right: 55.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/water_dust.svg",
                            width: 50.0,
                            height: 50.0,
                            allowDrawingOutsideViewBox: true,
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Text(
                            "Water & Dust\nRepellent",
                            textAlign: TextAlign.center,
                            style: zzRegularBlackTextStyle10,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/crack_scratch.svg",
                            width: 50.0,
                            height: 50.0,
                            allowDrawingOutsideViewBox: true,
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Text(
                            "Crack & Scratch\nResistant",
                            textAlign: TextAlign.center,
                            style: zzRegularBlackTextStyle10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.0.h,
              ),
              SizedBox(
                width: ScreenSize.getScreenWidth(context) * 0.40,
                height: ScreenSize.getScreenHeight(context) * 0.07,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const ViewProductListScreen(
                      411246690548,
                      handle: "eyeglasses")),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(loginTextColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "View Frame",
                    style: zzRegularWhiteTextStyle14,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                width: ScreenSize.getScreenWidth(context),
                height: ScreenSize.getScreenHeight(context) * 0.55,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    PageView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: 4,
                        onPageChanged: (int index) {
                          currentPage2 = index;
                          update();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Get.to(() =>
                                const ViewProductListScreen(411246690548,
                                    handle: "eyeglasses")),
                            child: Stack(children: [
                              Center(
                                child: Image.asset(
                                    "assets/images/deals_on_glass_2.png"),
                              ),
                              Positioned(
                                // top: 70.0,
                                top: MediaQuery.of(context).size.height / 12,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Big Deals on Eyeglasses",
                                        style: zzRegularBlackTextStyle14,
                                      ),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                      Text(
                                        "Buy one get one free",
                                        style: zzRegularBlackTextStyle12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          );
                        }),
                    Positioned(
                      // bottom: 40,
                      bottom: MediaQuery.of(context).size.height / 16,
                      left: 0,
                      right: 0,
                      height: 20,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                              4,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: InkWell(
                                      onTap: () {
                                        pageController2.animateToPage(index,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeIn);
                                        update();
                                      },
                                      child: CircleAvatar(
                                        radius: 5,
                                        // check if a dot is connected to the current page
                                        // if true, give it a different color
                                        backgroundColor: currentPage2 == index
                                            ? loginTextColor
                                            : loginBlue2,
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              const ShowOfferWidget(
                  'New Arrivals of the Week', 'eye', "new_arrival", false),
              SizedBox(
                height: 6.0.h,
              ),
              Text(
                "Offer of the day",
                style: zzBoldBlackTextStyle14,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                width: ScreenSize.getScreenWidth(context),
                height: ScreenSize.getScreenHeight(context) * 0.55,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    PageView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: 4,
                        onPageChanged: (int index) {
                          currentPage3 = index;
                          update();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Get.to(() =>
                                const ViewProductListScreen(411246690548,
                                    handle: "eyeglasses")),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Image.asset(
                                  "assets/images/offer_of_day_1.png"),
                            ),
                          );
                        }),
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      height: 20,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                              4,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: InkWell(
                                      onTap: () {
                                        pageController3.animateToPage(index,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeIn);
                                      },
                                      child: CircleAvatar(
                                        radius: 5,
                                        // check if a dot is connected to the current page
                                        // if true, give it a different color
                                        backgroundColor: currentPage3 == index
                                            ? loginTextColor
                                            : loginBlue2,
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                width: ScreenSize.getScreenWidth(context),
                decoration: BoxDecoration(
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
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/take_online_test.png",
                    ),
                    Positioned(
                      top: 40,
                      left: 10,
                      right: 0,
                      child: SizedBox(
                        width: ScreenSize.getScreenWidth(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Take an online test",
                              style: zzBoldBlackTextStyle13A,
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            Text(
                              "Check your vision with the test",
                              style: zzRegularBlackTextStyle9,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const ContactUsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  bool selectedTile = false;
  bool selectedTile1 = false;
  bool selectedTile2 = false;
  bool selectedTile3 = false;
  bool selectedTile4 = false;
  bool selectedTile5 = false;
  bool selectedTile6 = false;
  bool selectedTile7 = false;
  bool selectedTile8 = false;
  bool selectedTile9 = false;
  bool selectedTile10 = false;
  bool selectedTile11 = false;
  bool selectedTile12 = false;

  Widget showEarWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBlue.withOpacity(0.30),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              width: ScreenSize.getScreenWidth(context),
              // height: ScreenSize.getScreenHeight(context) * 0.50,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset("assets/images/want_trail.png"),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 60.0.w,
                        // height: 25.0.h,
                        decoration: BoxDecoration(
                          color: loginBlue,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 3.0.h,
                              ),
                              Text(
                                "Want a trail request?",
                                style: zzBoldBlackTextStyle14,
                              ),
                              SizedBox(
                                height: 2.0.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 32.0, right: 32.0),
                                child: Text(
                                  "Try our wide range of hearing aid collection at the comfort of your home.",
                                  style: zzRegularBlackTextStyle10,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 2.0.h,
                              ),
                              Container(
                                // width: 30.0.w,
                                // height: 5.0.h,
                                decoration: BoxDecoration(
                                  color: loginBlue,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ElevatedButton(
                                  onPressed: (() {
                                    tabController.index = 1;
                                    //Get.to(()=>TrialRequestProductList(411751645428))!.then((value) => _tabController!.index=1);
                                    Get.to(() => TrialRequestProductList(
                                        411751645428,
                                        myTab: tabController.index));
                                    update();
                                  }),
                                  // onPressed: () => Get.to(
                                  //     () => const TrialRequestProductList(411751645428)),
                                  // onPressed: () =>
                                  //     Get.to(() => const EarDetailScreen()),
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
                              SizedBox(
                                height: 1.0.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              width: ScreenSize.getScreenWidth(context),
              // height: ScreenSize.getScreenHeight(context) * 0.30,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10.0),
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
                    height: 5.0.h,
                  ),
                  Text(
                    "Ear Category We Offer",
                    style: zzBoldBlackTextStyle14,
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        // onTap: () => Get.to(() => const ViewProductListScreen(411858239732)),
                        onTap: (() {
                          tabController.index = 1;
                          Get.to(() => ViewProductListScreen(411858239732,
                              handle: "affordable-hearing-aids",
                              myTab: tabController.index,
                              fromWhere2: 'EAR'));
                          update();
                        }),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/behind_the_ear.svg",
                              width: 50.0,
                              height: 50.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              "Affordable\nHearing Aids",
                              textAlign: TextAlign.center,
                              style: zzRegularBlackTextStyle10,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          tabController.index = 1;
                          Get.to(() => ViewProductListScreen(411858272500,
                              handle: "accessibility-hearing-aids",
                              myTab: tabController.index,
                              fromWhere2: 'EAR'));
                          update();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/in_the_ear.svg",
                              width: 50.0,
                              height: 50.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "Accessibility\nHearing Aids",
                              style: zzRegularBlackTextStyle10,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          tabController.index = 1;
                          Get.to(() => ViewProductListScreen(411858305268,
                              handle: "bluetooth-hearing-aids",
                              myTab: tabController.index,
                              fromWhere2: 'EAR'));
                          update();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/in_the_canal.svg",
                              width: 50.0,
                              height: 50.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              "Bluetooth\nHearing Aids",
                              textAlign: TextAlign.center,
                              style: zzRegularBlackTextStyle10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => ViewProductListScreen(411858338036,
                              handle: "rechargeable-hearing-aids",
                              myTab: tabController.index,
                              fromWhere2: 'EAR'));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/behind_the_ear.svg",
                              width: 50.0,
                              height: 50.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              "Rechargeable\nHearing Aids",
                              textAlign: TextAlign.center,
                              style: zzRegularBlackTextStyle10,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => ViewProductListScreen(411858370804,
                              handle: "invisible-hearing-aids",
                              myTab: tabController.index,
                              fromWhere2: 'EAR'));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/in_the_ear.svg",
                              width: 50.0,
                              height: 50.0,
                              allowDrawingOutsideViewBox: true,
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              "Invisible \nHearing Aids",
                              textAlign: TextAlign.center,
                              style: zzRegularBlackTextStyle10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              width: ScreenSize.getScreenWidth(context),
              height: ScreenSize.getScreenHeight(context) * 0.50,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                        "assets/images/hearing_aids_case_arrangement.png"),
                  ),
                  Positioned(
                    top: 70.0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "Buy What Suits Your Style",
                        style: zzBoldWhiteTextStyle14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Text(
              "Why Infinite Hearing Aids?",
              style: zzBoldBlackTextStyle14,
            ),
            SizedBox(
              height: 1.0.h,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              width: ScreenSize.getScreenWidth(context),
              height: ScreenSize.getScreenHeight(context) * 0.50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/unnoticeble.svg",
                        width: 50.0,
                        height: 50.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      Text(
                        "Unnoticeble",
                        style: zzBoldBlackTextStyle9,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/battery.svg",
                        width: 50.0,
                        height: 50.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      Text(
                        "Long Battery Life",
                        style: zzBoldBlackTextStyle9,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/within_budget.svg",
                        width: 50.0,
                        height: 50.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      Text(
                        "Within Budget",
                        style: zzBoldBlackTextStyle9,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/expert_review.svg",
                        width: 50.0,
                        height: 50.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      Text(
                        "Reviewed by expert",
                        style: zzBoldBlackTextStyle9,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    height: 5.0.h,
                    decoration: BoxDecoration(
                      color: loginBlue,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.to(() => const MapView1());
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(loginTextColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "View Now",
                        style: zzRegularWhiteTextStyle12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const ShowOfferWidget(
                'Bestseller of the Week', 'ear', "best_seller", false),
            SizedBox(
              height: 5.0.h,
            ),
            Text(
              "Offer of the day",
              style: zzBoldBlackTextStyle14,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              width: ScreenSize.getScreenWidth(context),
              height: ScreenSize.getScreenHeight(context) * 0.50,
              child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: 4,
                  onPageChanged: (int index) {
                    currentPage4 = index;
                    update();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Get.to(() => const ViewProductListScreen(
                          411858239732,
                          handle: "affordable-hearing-aids")),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/audio_kit.png"),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            const ShowOfferWidget(
                'New Arrivals of the Week', 'ear', 'new_arrival', false),
            SizedBox(
              height: 4.0.h,
            ),
            Text(
              "Have any question?",
              style: zzBoldBlackTextStyle14,
            ),
            // SizedBox(
            //   height: 2.0.h,
            // ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                children: [
                  ExpansionTile(
                    initiallyExpanded: selectedTile,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "What is the warranty period for hearing aids?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile = !selectedTile;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Infinite My6Senses offers high-quality hearing aids with a minimum of 2 years - 4 years based on the product selected. Our warranty covers manufacturing defects and functional defects excluding damage from misuse or unauthorized repairs. For detailed terms, review the provided documentation or contact our customer support team for assistance and information. Experience satisfaction with My6Senses.',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile1,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "Can I connect my hearing aids to other devices, like my smartphone?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile1 = !selectedTile1;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'We offer Bluetooth hearing aids that connect seamlessly with smartphones. Follow the simple steps in the user manual or contact support to pair your hearing aids. Customize settings through dedicated apps for volume control, program settings, and more. For assistance, contact our customer support team.',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile2,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "Are Hearing aids difficult to use?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile2 = !selectedTile2;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Not at all! We offer hearing aids which are user-friendly and easy to use. They come with simple setup instructions, intuitive controls, and customization options. Additionally, connectivity features like Bluetooth and user-friendly mobile apps enhance convenience.',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile3,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "How to identify if someone/myself have any hearing issue?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile3 = !selectedTile3;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '''There are several signs that may indicate a hearing problem in yourself or a family member. Some common signs include:

Difficulty understanding speech, especially in noisy environments.
Frequently asking others to repeat themselves or speak more slowly.
Turning up the volume on the TV or radio louder than normal.
Withdrawal from social situations or avoiding conversations due to difficulty hearing.
Ringing or buzzing in the ears (tinnitus).
Struggling to hear high-pitched sounds like birds singing or the phone ringing.
Difficulty hearing consonant sounds like "s", "t", and "f".
If you or a family member are experiencing any of these symptoms, it is important to schedule a hearing test with our team of experienced audiologist. Early detection and treatment of hearing loss can help prevent further damage and improve quality of life.''',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile4,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "How to confirm that I may need a hearing aid ?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile4 = !selectedTile4;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '''The best way to confirm whether you may need a hearing aid is to schedule an appointment with our team of experienced & skilled audiologist. They will conduct a comprehensive hearing evaluation to determine the degree and type of hearing loss you have.

During the hearing evaluation, the audiologist may ask you questions about your hearing history and any symptoms you are experiencing. They may also conduct a series of tests, including pure-tone audiometry and/or middle ear testing, to evaluate your hearing abilities.

Based on the results of the hearing evaluation, the audiologist will be able to determine whether you have hearing loss and, if so, the degree and type of hearing loss. They may recommend hearing aids as a treatment option if they determine that your hearing loss can be improved with the use of hearing aids.

It is important to note that hearing aids are not appropriate for everyone with hearing loss, and the decision to use hearing aids should be made in consultation with a audiologist only based on individual needs and preferences.''',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile5,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "What are the most common causes of hearing loss?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile5 = !selectedTile5;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '''There are several common causes of hearing loss, including:

Age-related hearing loss (presbycusis): This is the most common type of hearing loss, and it occurs gradually over time as a result of natural aging processes.

Noise-induced hearing loss: Exposure to loud noises, such as machinery, music, or firearms, can cause damage to the delicate hair cells in the inner ear, leading to hearing loss.

Genetics: In some cases, hearing loss may be inherited from one or both parents.

Ototoxic medications: Certain medications, such as some antibiotics and chemotherapy drugs, can damage the inner ear and lead to hearing loss.

Trauma or injury to the head or ear: Trauma or injury to the head or ear can damage the delicate structures of the ear, leading to hearing loss.

Infections or diseases: Infections or diseases that affect the ear, such as otitis media, meningitis, or mumps, can cause hearing loss.

Wax buildup: Excessive earwax can block the ear canal and cause hearing loss.

Malformations of the ear: Some people are born with malformations of the ear that can lead to hearing loss.

It is important to identify the cause of hearing loss in order to determine the most appropriate treatment options. If you are experiencing hearing loss, it is recommended that you schedule an appointment with INFINITE for a comprehensive hearing evaluation.''',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile6,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "What is a hearing aid ? How does it function and help me ?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile6 = !selectedTile6;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '''A hearing aid is a small electronic device that is worn in or behind the ear and is designed to amplify sound for individuals with hearing loss. The basic components of a hearing aid include a microphone, amplifier, and speaker.

Modern hearing aids are designed with a range of advanced features, including directional microphones, noise reduction technology, and Bluetooth connectivity. These features help to further improve the listening experience and make it easier for individuals with hearing loss to navigate challenging listening environments, such as crowded restaurants or noisy work settings.

It is important to note that hearing aids are not a cure for hearing loss and may not be appropriate for everyone. The decision to use hearing aids should be made in consultation with an audiologist only based on individual needs and preferences.''',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile7,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "What is the life span of a hearing aid ?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile7 = !selectedTile7;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '''The lifespan of a hearing aid can vary depending on several factors, including the type and quality of the hearing aid, how well it is maintained and cared for, and how frequently it is used.

On average, hearing aids can last anywhere from five to seven years. However, some hearing aids may last longer, while others may need to be replaced sooner.

The lifespan of the hearing aid's battery also plays a role in its overall lifespan. Most hearing aid batteries need to be replaced every few days to a couple of weeks, depending on usage and battery type.

To extend the life of your hearing aid, it is important to follow the manufacturer's recommendations for cleaning and maintenance. Regular cleaning and maintenance can help prevent damage and keep your hearing aid working properly.''',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile8,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "Does hearing aid needs special kind of batteries ?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile8 = !selectedTile8;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '''Yes, most hearing aids require special batteries that are designed specifically for hearing aid use. These batteries are typically smaller than standard batteries and come in a variety of sizes, including 10, 13, 312, and 675.

The type of battery you need will depend on the specific make and model of your hearing aid, as well as the size of the battery compartment. It is important to follow the manufacturer's recommendations for battery type and size to ensure optimal performance and longevity of your hearing aid.

Hearing aid batteries are also designed to provide consistent power output over time, which is important for maintaining the performance and sound quality of your hearing aid. Some hearing aids may require disposable batteries that need to be replaced every few days to a couple of weeks, while others may use rechargeable batteries that can be recharged daily or every few days.

It is important to use high-quality batteries and to follow the manufacturer's recommendations for battery use and replacement to ensure the best possible performance and lifespan of your hearing aid.''',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile9,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "Is there any kind of screening test for hearing assessment?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile9 = !selectedTile9;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '''Screening tests, are designed to quickly and efficiently identify individuals who may have hearing loss and require further evaluation. Examples of hearing screening tests include the whispered voice test, the finger rub test, and the audiometer out of the booth test.

The screening tests provide a quick and easy way to identify potential hearing problems, they are not a substitute for a comprehensive hearing evaluation conducted by a licensed audiologist. If you suspect that you or a family member may have hearing loss, it is important to schedule an appointment with a licensed audiologist of INFINITE team for a comprehensive evaluation.''',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile10,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "Is it necessary to wear hearing aids in both ears ? Why can’t one hearing aid suffice the need?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile10 = !selectedTile10;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '''First, wearing hearing aids in both ears helps to provide a more natural and balanced listening experience. This is because the brain relies on input from both ears to accurately locate the source of sound and to filter out background noise. When only one ear is amplified with a hearing aid, the brain struggles to accurately process and localize sounds, which may lead to difficulty understanding speech and navigating noisy environments.

Secondly, wearing two hearing aids can help to reduce the risk of further hearing loss. When only one ear is amplified with a hearing aid, the other ear may be exposed to higher levels of noise and may be at increased risk for further damage.''',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile11,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "How do I choose a hearing aid for me?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile11 = !selectedTile11;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '''Choosing a hearing aid can be a complex and personal decision that depends on several factors, including the degree and type of hearing loss, lifestyle and communication needs, budget, and personal preferences. Here are some steps to a simple way forward:

Schedule a hearing evaluation with a licensed audiologist from INFINITE. This will help you & the audiologist determine the type and degree of hearing loss you have and identify any other medical conditions that may be contributing to your hearing loss.

Discuss your communication needs and lifestyle with the assigned INFINITE team audiologist. This will help them recommend hearing aid options that are best suited to your individual needs and preferences.

Consider the type of hearing aid that is best for you. There are several types of hearing aids available, including behind-the-ear (BTE), in-the-ear (ITE), and receiver-in-the-canal (RIC) hearing aids. Your audiologist can help you determine which type of hearing aid is best for you based on your degree of hearing loss and personal preferences.

Consider the features that are important to you. Modern hearing aids come with a range of features, including directional microphones, noise reduction technology, and Bluetooth connectivity. Consider which features are most important to you and which will best meet your communication needs.

Consider the cost of the hearing aid. Hearing aids can range in price from a few thousand rupees to several thousand rupees. Consider your budget and/or financial assistance that may be available to you from INFINITE.

Discuss with your audiologist to ensure proper fit and adjustment of the chosen hearing aid. Your INFINITE audiologist will also provide ongoing support and maintenance to ensure that your hearing aid continues to work properly over time.''',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    initiallyExpanded: selectedTile12,
                    collapsedIconColor: black,
                    iconColor: black,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    textColor: black,
                    collapsedTextColor: black,
                    controlAffinity: ListTileControlAffinity.trailing,
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      "How long does it take to adjust to the new hearing aid ?",
                      style: zzRegularBlackTextStyle14,
                    ),
                    onExpansionChanged: ((newState) {
                      if (newState) {
                        selectedTile12 = !selectedTile12;
                      }
                      update();
                    }),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '''The length of time it takes to adjust to a new hearing aid can vary depending on several factors, including the type and severity of hearing loss, the specific hearing aid model, and the individual's personal preferences and lifestyle.

In general, it can take few weeks to fully adjust to a new hearing aid. During this time, you may experience some initial discomfort or adjustment issues as your brain adapts to the new sounds and the hearing aid settings are fine-tuned for optimal performance.

It is important to work closely with your audiologist during the adjustment period to ensure that your hearing aid is properly fitted and adjusted for your individual needs.''',
                          style: zzRegularBlackTextStyle14,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              width: ScreenSize.getScreenWidth(context),
              decoration: BoxDecoration(
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
              child: Stack(
                children: [
                  Image.asset("assets/images/take_online_test.png"),
                  Positioned(
                    top: 40,
                    left: 10,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Take an online test",
                          style: zzBoldBlackTextStyle13,
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Text(
                          "Check your hearing with the test",
                          style: zzRegularBlackTextStyle9,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const ContactUsWidget(),
          ],
        ),
      ),
    );
  }

  // testing
  Widget showSleepWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBlue.withOpacity(0.30),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Different content for the third tab
            Text('This is the third tab content'),
          ],
        ),
      ),
    );
  }

  Widget showAlignerWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBlue.withOpacity(0.30),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        physics: const AlwaysScrollableScrollPhysics(),
        child: const Column(
          children: [
            ContactUsWidget(),
          ],
        ),
      ),
    );
  }

  Widget showSkinWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBlue.withOpacity(0.30),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        physics: const AlwaysScrollableScrollPhysics(),
        child: const Column(
          children: [
            ContactUsWidget(),
          ],
        ),
      ),
    );
  }
}
