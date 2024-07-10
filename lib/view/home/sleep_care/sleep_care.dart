import 'package:get/get.dart';
import 'package:infinite/utils/packeages.dart';

class SleepCareScreen extends StatefulWidget {
  const SleepCareScreen({super.key});

  @override
  State<SleepCareScreen> createState() => _SleepCareScreenState();
}

class _SleepCareScreenState extends State<SleepCareScreen> {
  bool isSelectedDevice = true;
  bool isSelectedMask = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBlue.withOpacity(0.30),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              width: ScreenSize.getScreenWidth(context),
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
                    "Explore our Sleep Care Solutions",
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
                            // Get.to(() =>
                            //     const ViewProductListScreen(411739422964,handle: "nasal",));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: loginBlue),
                                child: Image.asset(
                                  "assets/images/Sleepcare_Icons_Sleep_Screening.png",
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  "Sleep Screening",
                                  style: zzRegularBlackTextStyle11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Get.to(() =>
                            //     const ViewProductListScreen(411739422964,handle: "nasal"));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: loginBlue),
                                child: Image.asset(
                                  "assets/images/Sleepcare_Icons_Diagnosis.png",
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  "Diagnosis",
                                  style: zzRegularBlackTextStyle11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                            // Get.to(() =>
                            //     const ViewProductListScreen(411739422964,handle: "nasal",));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: loginBlue),
                                child: Image.asset(
                                  "assets/images/Sleepcare_Icons_Titration_Treatment.png",
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  "Titration & Treatment",
                                  style: zzRegularBlackTextStyle11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Get.to(() =>
                            //     const ViewProductListScreen(411739422964,handle: "nasal",));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: loginBlue),
                                child: Image.asset(
                                  "assets/images/Sleepcare_Icons_Lifestyle_Management.png",
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  "Lifestyle Management",
                                  style: zzRegularBlackTextStyle11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ShowOfferWidget(
                'New Arrivals of the Week', 'sleep', "new_arrival", false),
            const SizedBox(
              height: 20,
            ),
            Text(
              "LATEST PRODUCTS",
              style: zzBoldBlackTextStyle14,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Sleep your ways to Better Health. Shop Now!",
              style: zzBoldBlackTextStyle12,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSelectedDevice = true;
                      isSelectedMask = false;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: isSelectedDevice
                        ? loginTextColor
                        : Colors.grey.shade200,
                  ),
                  child: Text(
                    "Device Accessories",
                    style: TextStyle(
                      color: isSelectedDevice ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSelectedMask = true;
                      isSelectedDevice = false;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        isSelectedMask ? loginTextColor : Colors.grey.shade200,
                  ),
                  child: Text(
                    "Mask Accessories",
                    style: TextStyle(
                      color: isSelectedMask ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: isSelectedDevice == true,
              child: const ShowOfferWidget(
                'Device Accessories',
                'device',
                "new_arrival",
                false,
              ),
            ),
            Visibility(
              visible: isSelectedMask == true,
              child: const ShowOfferWidget(
                'Mask Accessories',
                'mask',
                "new_arrival",
                false,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            TextButton(
              onPressed: () {
                Get.to(() => const ViewProductListScreen(
                      411739422964,
                      handle: "nasal",
                    ));
              },
              style: TextButton.styleFrom(backgroundColor: loginTextColor),
              child: const Text(
                "View All Products",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ContactUsWidget(),
          ],
        ),
      ),
    );
  }
}
