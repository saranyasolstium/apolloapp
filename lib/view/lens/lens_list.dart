import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite/view/select_lens.dart';
import 'package:infinite/widgets/default_navigation_widget.dart';

import '../cart/cart.dart';
import '../../res/styles.dart';
import '../../utils/global.dart';

class LensList extends StatefulWidget {
  final int id;
  final String title;
  final int variantId;
  final String productType;
  final String variantName;
  final String unitPrice;
  final String src;
  final int invQty;
  final int? fromWhere;
  final String productTitle;
  const LensList(
      {Key? key,
      required this.id,
      required this.title,
      required this.variantId,
      required this.productType,
      required this.variantName,
      required this.unitPrice,
      required this.src,
      required this.invQty,
      required this.productTitle,
      this.fromWhere})
      : super(key: key);

  @override
  State<LensList> createState() => _LensListState();
}

class _LensListState extends State<LensList> {
  var currentTime;

  @override
  void initState() {
    super.initState();
    currentTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarWidget(
      title: "Add Lens",
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'Choose lens option according to ',
              style: zzRegularBlackTextStyle13A,
            ),
            Text(
              'your needs',
              style: zzRegularBlackTextStyle13A,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  print(widget.productTitle);
                  Get.to(() => SelectLens(
                        id: widget.id,
                        title: widget.title,
                        variantId: widget.variantId,
                        productType: widget.productType,
                        variantName: widget.variantName,
                        unitPrice: widget.unitPrice,
                        src: widget.src,
                        invQty: widget.invQty,
                        lensType: "Single Vision",
                        productTitle: widget.productTitle,
                      ));
                },
                child: Card(
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15.0),
                      leading: SvgPicture.asset("assets/svg/glass1.svg"),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Single Vision',
                            style: zzRegularBlackTextStyle13A,
                          ),
                          const Text(
                              'For distance or near vision\n(Thin, anti-glare options)')
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    ))),
            InkWell(
              onTap: () {
                Get.to(() => SelectLens(
                      id: widget.id,
                      title: widget.title,
                      variantId: widget.variantId,
                      productType: widget.productType,
                      variantName: widget.variantName,
                      unitPrice: widget.unitPrice,
                      src: widget.src,
                      invQty: widget.invQty,
                      lensType: 'Bifocal',
                      productTitle: widget.productTitle,
                    ));
              },
              child: Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15.0),
                  leading: SvgPicture.asset("assets/svg/bifocal.svg"),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bifocal',
                        style: zzRegularBlackTextStyle13A,
                      ),
                      const Text('Bifocal\n(For two power in same lenses)')
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => SelectLens(
                      id: widget.id,
                      title: widget.title,
                      variantId: widget.variantId,
                      productType: widget.productType,
                      variantName: widget.variantName,
                      unitPrice: widget.unitPrice,
                      src: widget.src,
                      invQty: widget.invQty,
                      lensType: 'Progressive',
                      productTitle: widget.productTitle,
                    ));
              },
              child: Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15.0),
                  leading: SvgPicture.asset("assets/svg/bifocal.svg"),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progressive',
                        style: zzRegularBlackTextStyle13A,
                      ),
                      const Text('Progressives\n(For two power in same lenses)')
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // localDBHelper!
                //     .getParticularCartAddedOrNot(widget.variantId)
                //     .then((value) {
                //   if (value.isNotEmpty) {
                //     showErrorSnackBar(context, "Product already added to cart");
                //   } else {
                //     var data = <String, dynamic>{};
                //     data['product_id'] = widget.id;
                //     //   data['pr_type'] = 'order';
                //     data['variant_id'] = widget.variantId;
                //     data['product_name'] = widget.title;
                //     data['product_type'] = widget.productType;

                //     data['variant_name'] = widget.variantName;
                //     data['unit_price'] = widget.unitPrice;
                //     data['quantity'] = 1;
                //     data['total'] = widget.unitPrice * 1;

                //     // data['is_sync'] = 0;
                //     data['image_url'] = widget.src;
                //     data['inventory_quantity'] = widget.invQty;
                //     data['created_at'] = currentTime.toString();
                //     data['updated_at'] = currentTime.toString();
                //     // getDetails2();
                //     localDBHelper!.insertValuesIntoCartTable(data).then(
                //         (value) => showSuccessSnackBar(
                //             context, "Product added to cart successfully!"));
                //     Get.to(() => const Cart(fromWhere: 5,productHandle: "",));
                //   }
                // });
                Get.to(() => SelectLens(
                      id: widget.id,
                      title: widget.title,
                      variantId: widget.variantId,
                      productType: widget.productType,
                      variantName: widget.variantName,
                      unitPrice: widget.unitPrice,
                      src: widget.src,
                      invQty: widget.invQty,
                      lensType: "Zero Power",
                      productTitle: widget.productTitle,
                    ));
              },
              child: Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15.0),
                  leading: SvgPicture.asset("assets/svg/zero_power.svg"),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Zero Power',
                        style: zzRegularBlackTextStyle13A,
                      ),
                      const Text(
                          'Block 98% of harmful rays \n(Anti-glare options)')
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                localDBHelper!
                    .getParticularCartAddedOrNot(widget.variantId)
                    .then((value) {
                  if (value.isNotEmpty) {
                    showErrorSnackBar(context, "Product already added to cart");
                  } else {
                    var data = <String, dynamic>{};
                    data['product_id'] = widget.id;
                    //  data['pr_type'] = 'order';
                    data['variant_id'] = widget.variantId;
                    data['product_name'] = widget.title;
                    data['product_type'] = widget.productType;

                    data['variant_name'] = widget.variantName;
                    data['unit_price'] = widget.unitPrice;
                    data['quantity'] = 1;
                    data['total'] = widget.unitPrice * 1;

                    //  data['is_sync'] = 0;
                    data['image_url'] = widget.src;
                    data['inventory_quantity'] = widget.invQty;
                    data['created_at'] = currentTime.toString();
                    data['updated_at'] = currentTime.toString();
                    //  getDetails2();
                    localDBHelper!.insertValuesIntoCartTable(data).then(
                        (value) => showSuccessSnackBar(
                            context, "Product added to cart successfully!"));
                    Get.to(() => const Cart(
                          fromWhere: 5,
                          productHandle: "",
                        ));
                  }
                });
              },
              child: Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15.0),
                  leading: SvgPicture.asset("assets/svg/frame_only.svg"),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Frame Only',
                        style: zzRegularBlackTextStyle13A,
                      ),
                      const Text('Buy Frame only')
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getDetails2() async {
    Map<String, dynamic> map = <String, dynamic>{};

    map['product_id2'] = widget.id;
    map['lens_type'] = '';
    map['priscription'] = '';
    map['frame_name'] = '';
    map['frame_price'] = 0;
    map['frame_qty'] = 1;
    map['frame_total'] = 0;

    map['rd_sph'] = '';
    map['rd_cyl'] = '';
    map['rd_axis'] = '';
    map['rd_bcva'] = '';

    map['ra_sph'] = '';
    map['ra_cyl'] = '';
    map['ra_axis'] = '';
    map['ra_bcva'] = '';

    map['ld_sph'] = '';
    map['ld_cyl'] = '';
    map['ld_axis'] = '';
    map['ld_bcva'] = '';

    map['la_sph'] = '';
    map['la_cyl'] = '';
    map['la_axis'] = '';
    map['la_bcva'] = '';

    map['re'] = '';
    map['le'] = '';
    map['addon_title'] = '';
    map['addon_price'] = 0.0;
    map['addon_qty'] = 1;
    map['addon_total'] = 0.0;

    await localDBHelper!.insertValuesIntoCartTable2(map);
  }
}
