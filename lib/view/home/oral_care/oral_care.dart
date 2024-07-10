import 'dart:async';

import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/view/book/book_appointment.dart';
import 'package:infinite/view/products/product_list_screen.dart';
import 'package:infinite/widgets/contact_us_widget.dart';
import 'package:infinite/widgets/show_offers_widget.dart';

class OralCareScreen extends StatefulWidget {
  const OralCareScreen({
    super.key,
  });

  @override
  State<OralCareScreen> createState() => _OralCareScreenState();
}

class _OralCareScreenState extends State<OralCareScreen> {
  late InfiniteScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = InfiniteScrollController(initialItem: _currentIndex);

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % 3;
        _scrollController.animateToItem(_currentIndex,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBlue.withOpacity(0.30),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => const BookAppointment());
              },
              child: Image.asset(
                'assets/images/Oral_Care_banner1.png',
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Shop Category',
              style: zzBoldBlackTextStyle14,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 250,
              child: InfiniteCarousel.builder(
                controller: _scrollController,
                itemCount: 3,
                itemExtent: MediaQuery.of(context).size.width,
                center: true,
                anchor: 0.0,
                velocityFactor: 0.2,
                onIndexChanged: (index) {},
                axisDirection: Axis.horizontal,
                loop: true,
                itemBuilder: (context, itemIndex, realIndex) {
                  List<String> imagePaths = [
                    'assets/images/Oral_Products.png',
                    'assets/images/3D_Oral_Scan.png',
                    'assets/images/Aligners.png',
                  ];

                  String imagePath = imagePaths[itemIndex % imagePaths.length];
                  return InkWell(
                    onTap: () {
                      if (itemIndex % imagePaths.length == 0) {
                        Get.to(() => const ViewProductListScreen(
                              412432498932,
                              handle: "oral",
                            ));
                      } else if (itemIndex % imagePaths.length == 1) {
                        Get.to(() => const BookAppointment());
                      } else if (itemIndex % imagePaths.length == 2) {
                        launchURL("https://my6senses.com/pages/aligners");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ShowOfferWidget(
                'New Arrivals of the Week', 'oral', "new_arrival", false),
            const SizedBox(
              height: 32,
            ),
            InkWell(
              onTap: () {
                Get.to(() =>
                    const ViewProductListScreen(412432498932, handle: "oral"));
              },
              child: Image.asset(
                'assets/images/Oral_Care_banner2.png',
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const ShowOfferWidget(
                'Bestseller of the Week', 'oral', "best_seller", false),
            const SizedBox(
              height: 20,
            ),
            const ContactUsWidget(),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
