import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../utils/packeages.dart';

class SelectLens extends StatefulWidget {
  final int id;
  final String title;
  final int variantId;
  final String productType;
  final String variantName;
  final String unitPrice;
  final String src;
  final int invQty;
  final String lensType;
  final String? fromWhere2;
  final String? productTitle;
  const SelectLens(
      {Key? key,
      required this.id,
      required this.title,
      required this.variantId,
      required this.productType,
      required this.variantName,
      required this.unitPrice,
      required this.src,
      required this.invQty,
      required this.lensType,
      required this.productTitle,
      this.fromWhere2})
      : super(key: key);

  @override
  State<SelectLens> createState() => _SelectLensState();
}

class _SelectLensState extends State<SelectLens> {
  int activeStep = 0;

  int dotCount = 3;
  List<ProductModel> myProductList = [];
  void initState() {
    loading = true;
    setState(() {
      getProductList();
    });
    super.initState();
  }

  void getProductList() {
    try {
      int? collectionId;
      if (widget.lensType == "Single Vision") {
        collectionId = 410368835828;
      } else if (widget.lensType == "Bifocal") {
        collectionId = 410380435700;
      } else if (widget.lensType == "Progressive") {
        collectionId = 410799669492;
      } else if (widget.lensType == "Zero Power") {
        collectionId = 410382860532;
      }

      DioClient(
              myUrl: "${EndPoints.allProductsList}?collection_id=$collectionId")
          .getProductList()
          .then((value) {
        debugPrint("LENS LIST VALUE: $value");
        if (mounted) {
          setState(() {
            if (value.isNotEmpty) {
              myProductList = [];
              myProductList = value;
            } else {
              myProductList = [];
            }
            loading = false;
          });
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Add Lens",
      child: Column(
        children: [
          Container(
            color: loginBlue,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset("assets/svg/lens1.svg"),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Select Lens",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DotStepper(
                      dotCount: dotCount,
                      dotRadius: 12,
                      activeStep: activeStep,
                      shape: Shape.circle,
                      spacing: 40,
                      lineConnectorsEnabled: true,
                      indicator: Indicator.blink,
                      tappingEnabled: false,
                      onDotTapped: (tappedDotIndex) {
                        setState(() {
                          activeStep = tappedDotIndex;
                        });
                      },
                      fixedDotDecoration: const FixedDotDecoration(
                        color: lightBlue3,
                      ),
                      indicatorDecoration: const IndicatorDecoration(
                        color: loginTextColor,
                      ),
                      lineConnectorDecoration: const LineConnectorDecoration(
                        color: lightBlue3,
                        strokeWidth: 0,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          FrameList()
        ],
      ),
    );
  }

  Widget FrameList() {
    if (loading == true) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    } else {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: myProductList.length,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              itemBuilder: (BuildContext context, int index) {
                var model = myProductList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            gradient: LinearGradient(
                                colors: [
                                  sandal2,
                                  Colors.white,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  model.title!,
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text("₹${model.variantsList![0]['price']}"),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print(widget.productTitle);
                                Get.to(() => EyePower(
                                      id: widget.id,
                                      title: widget.title,
                                      variantId: widget.variantId,
                                      productType: widget.productType,
                                      variantName: widget.variantName,
                                      unitPrice: widget.unitPrice,
                                      src: widget.src,
                                      invQty: widget.invQty,
                                      frameName: model.title!,
                                      framePrice: model.variantsList![0]
                                          ['price'],
                                      lensType: widget.lensType,
                                      productTitle: widget.productTitle,
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: loginTextColor,
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20)),
                              child: const Text(
                                'Select',
                                style: TextStyle(color: white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Html(data: model.bodyHtml!)],
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      );
    }
  }
}
