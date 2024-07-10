import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite/control/home_controller/ear_detail_controller.dart';
import 'package:infinite/model/review_model.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/utils/packeages.dart';
import 'package:infinite/view/home/ear_detail_screen.dart';
import 'package:infinite/view/home/eye_detail_screen.dart';
import 'package:infinite/view/home/oral_care/oralcare_detail.dart';
import 'package:infinite/view/home/skin_care/skincare_detail.dart';
import 'package:infinite/view/home/sleep_care/sleep_details.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../services/remote_service.dart';

class ReviewScreen extends StatefulWidget {
  final int productId;
  final String routeType;
  const ReviewScreen(
      {Key? key, required this.productId, required this.routeType})
      : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController reviewCtrl = TextEditingController();
  double currentRating = 0;
  int? customerId;
  String? email, aName;
  late List<Review> reviewList = [];

  @override
  void initState() {
    super.initState();
    email = sharedPreferences!.getString('mail');
    customerId = sharedPreferences!.getInt("id");
    aName = sharedPreferences!.getString("firstName").toString();
    fetchReview();
  }

  Future<void> fetchReview() async {
    try {
      List<Review> myReviewList =
          await RemoteServices().fetchReview(widget.productId);
      setState(() {
        reviewList = myReviewList;
      });
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  Future<void> postReview() async {
    try {
      final response = await RemoteServices().addReview(
        customerId: customerId!,
        productId: widget.productId,
        email: email!,
        name: aName!,
        rating: currentRating.toString(),
        review: reviewCtrl.text.trim(),
      );

      final responseData = jsonDecode(response.body);
      final status = responseData['status'];
      final message = responseData['message'];

      if (status == 'Success') {
        showSuccessSnackBar(context, message);
        setState(() {
          currentRating = 0;
          reviewCtrl.clear();
          fetchReview();
        });
      } else if (status == 'Error') {
        showErrorSnackBar(context, message);
      } else {
        print('Unknown response status: $status');
      }
    } catch (error) {
      print('Error adding review: $error');
      showErrorSnackBar(context, "Failed to add review!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (widget.routeType == "eye") {
            Get.off(EyeDetailsScreen(
              id: widget.productId,
              productHandle: "",
            ));
          } else if (widget.routeType == "ear" ||
              widget.routeType == "trial_request") {
            Get.off(EarDetailScreen(
              id: widget.productId,
            ));
          } else if (widget.routeType == "sleep") {
            Get.off(SleepDetailScreen(
              id: widget.productId,
            ));
          } else if (widget.routeType == "oral") {
            Get.off(OralDetailScreen(
              id: widget.productId,
            ));
          } else if (widget.routeType == "skin") {
            Get.off(SkinDetailScreen(
              id: widget.productId,
            ));
          } else {
            Navigator.pop(context);
          }
          return Future.value(true);
        },
        child: SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: true,
          endDrawer: const NavigationWidget(),
          appBar: AppBar(
            backgroundColor: loginTextColor,
            title: Text(
              "Review",
              style: zzRegularWhiteAppBarTextStyle14,
            ),
            leading: InkWell(
              onTap: () {
                if (widget.routeType == "eye") {
                  Get.off(EyeDetailsScreen(
                    id: widget.productId,
                    productHandle: "",
                  ));
                } else if (widget.routeType == "ear" ||
                    widget.routeType == "trial_request") {
                  Get.off(EarDetailScreen(
                    id: widget.productId,
                  ));
                } else if (widget.routeType == "sleep") {
                  Get.off(SleepDetailScreen(
                    id: widget.productId,
                  ));
                } else if (widget.routeType == "oral") {
                  Get.off(OralDetailScreen(
                    id: widget.productId,
                  ));
                } else if (widget.routeType == "skin") {
                  Get.off(SkinDetailScreen(
                    id: widget.productId,
                  ));
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 28.0,
              ),
            ),
            actions: <Widget>[
              Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset(
                      "assets/svg/left_menu.svg",
                      color: white,
                      height: 15.0,
                      width: 15.0,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                );
              }),
              SizedBox(
                width: 3.w,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Card(
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "Write a Review",
                              style: zzBoldBlackTextStyle12,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RatingBar.builder(
                              initialRating: currentRating,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 30,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  currentRating = rating;
                                });
                                print(currentRating);
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                              ),
                              child: TextField(
                                controller: reviewCtrl,
                                maxLines: 5,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: const InputDecoration(
                                  labelText: 'Write a Review',
                                  hintText: 'Write a Review...',
                                  border: InputBorder.none,
                                ),
                                textInputAction: TextInputAction.done,
                                onChanged: (text) => setState(() {}),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print(currentRating);
                                if (reviewCtrl.text.toString().isEmpty) {
                                  showErrorSnackBar(
                                      context, "Please enter review");
                                } else {
                                  postReview();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    right: 50, left: 50, top: 10, bottom: 10),
                                backgroundColor: loginTextColor,
                              ),
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "All Review (${reviewList.length})",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black12,
                          height: 1,
                        ),
                      ],
                    )),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: reviewList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final review = reviewList[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(review.name,
                                        style: zzBoldBlackTextStyle14),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Text(
                                            review.reviewedAt,
                                            style: zzRegularBlackTextStyle10,
                                          ),
                                          const VerticalDivider(
                                            color: Colors.black12,
                                            thickness: 2,
                                          ),
                                          buildReadOnlyRatingBar(
                                              review.rating.toDouble()),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  review.review,
                                  style: zzRegularBlackTextStyle12,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              height: 1,
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        )));
  }
}
