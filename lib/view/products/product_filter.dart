import 'package:get/get.dart';
import 'package:infinite/model/filter_model.dart';
import 'package:infinite/utils/packeages.dart';

class ProductFilter extends StatefulWidget {
  final int? myCollectionId;
  final bool? navigationTrailRequset;
  final List<String> brandList;
  final List<String> shapeList;
  final List<String> materialList;
  final List<String> gender;
  final List<String> styleList;
  final List<String> productTypeList;
  final List<String> colorList;
  final String? endPrice;
  const ProductFilter(
      {Key? key,
      required this.brandList,
      required this.shapeList,
      required this.materialList,
      required this.styleList,
      required this.productTypeList,
      required this.colorList,
      required this.gender,
      required this.endPrice,
      required this.navigationTrailRequset,
      this.myCollectionId})
      : super(key: key);

  @override
  State<ProductFilter> createState() => _FilterState();
}

class _FilterState extends State<ProductFilter> {
  List<bool> boolBrandList = [];

  List<String> myBrandList = [];

  List<bool> boolMaterialList = [];
  List<String> myMaterialList = [];

  List<bool> boolShapeList = [];
  List<String> myShapeList = [];

  List<bool> boolStyleList = [];
  List<String> myStyleList = [];

  List<bool> boolGenderList = [];
  List<String> myGenderList = [];

  List<bool> boolAvailList = [];
  List<String> myAvailList = [];

  List<bool> boolProductTypeList = [];
  List<String> myProductTypeList = [];

  List<bool> boolColorList = [];
  List<String> myColorList = [];

  bool myPrice = false;

  double startValue = 0.0;
  double endValue = 1000000.0;
  int startPrice = 0;
  int endPrice = 0;

  TextEditingController startPriceController = TextEditingController(text: "0");
  TextEditingController endPriceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    boolBrandList = List.generate(widget.brandList.length, (index) => false);
    boolMaterialList =
        List.generate(widget.materialList.length, (index) => false);
    boolShapeList = List.generate(widget.shapeList.length, (index) => false);
    boolStyleList = List.generate(widget.styleList.length, (index) => false);
    boolColorList = List.generate(widget.colorList.length, (index) => false);

    boolGenderList = List.generate(widget.gender.length, (index) => false);
    boolAvailList =
        List.generate(FilterModel.eyeAvailability.length, (index) => false);
    boolProductTypeList =
        List.generate(widget.productTypeList.length, (index) => false);
    endPriceController.text = widget.endPrice!;
    endPrice = int.parse(widget.endPrice!);
    endValue = double.parse(widget.endPrice!);
  }

  void updateTextField(String value) {
    double parsedValue = double.tryParse(value) ?? 0.0;
    setState(() {
      startValue = parsedValue;
    });
  }

  void updateTextField2(String value) {
    double parsedValue = double.tryParse(value) ?? 0.0;
    setState(() {
      endValue = parsedValue;
    });
  }

  void updateSlider(double value) {
    setState(() {
      startValue = value;
      startPriceController.text = value.toStringAsFixed(1);
    });
  }

  void updateSlider2(double value) {
    setState(() {
      endValue = value;
      endPriceController.text = value.toStringAsFixed(1);
    });
  }

  Future<void> simulateSlowTransaction() async {
    await Future.delayed(const Duration(microseconds: 5000));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          // Get.back();
          Get.to(() => ViewProductListScreen(widget.myCollectionId,
              handle: "", fromWhere2: ''));
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: loginTextColor,
            title: Text(
              "Filter",
              style: zzRegularWhiteAppBarTextStyle14,
            ),
            leading: IconButton(
                onPressed: () {
                  Get.to(() => ViewProductListScreen(widget.myCollectionId,
                      handle: "", fromWhere2: ''));
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.sp, 0, 10.sp, 0),
                      child: Column(
                        children: [
                          widget.brandList.isNotEmpty
                              ? ExpansionTile(
                                  maintainState: true,
                                  collapsedIconColor: Colors.black,
                                  iconColor: Colors.black,
                                  tilePadding: EdgeInsets.all(0.sp),
                                  childrenPadding: EdgeInsets.all(0.sp),
                                  textColor: Colors.black,
                                  collapsedTextColor: Colors.black,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  expandedAlignment: Alignment.centerLeft,
                                  shape: Border.all(color: Colors.transparent),
                                  title: Text(
                                    "Brand",
                                    style: zzRegularBlackTextStyle13B,
                                  ),
                                  onExpansionChanged: ((newState) {
                                    setState(() {
                                      if (newState) {
                                        //myBrand = !myBrand;
                                      }

                                      // Get.to(()=>ExpansionPanelRadioSample());
                                      // Get.to(() => Steps());
                                    });
                                  }),
                                  children: <Widget>[
                                    SizedBox(
                                      width: Get.width,
                                      child: FutureBuilder(
                                        future: simulateSlowTransaction(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return Scrollbar(
                                              thickness: 3.sp,
                                              child: ListView.builder(
                                                itemCount:
                                                    widget.brandList.length,
                                                addAutomaticKeepAlives: false,
                                                addRepaintBoundaries: false,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return CheckboxListTile(
                                                    title: Text(widget
                                                        .brandList[index]),
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    activeColor: loginTextColor,
                                                    checkColor: Colors.white,
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    dense: true,
                                                    value: boolBrandList[index],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        boolBrandList[index] =
                                                            value!;
                                                        if (value == true) {
                                                          myBrandList.add(
                                                              widget.brandList[
                                                                  index]);
                                                        } else {
                                                          myBrandList.remove(
                                                              widget.brandList[
                                                                  index]);
                                                        }
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          widget.brandList.isNotEmpty
                              ? const Divider(
                                  thickness: 2,
                                  color: Colors.black12,
                                )
                              : const SizedBox(),
                          widget.materialList.isNotEmpty
                              ? ExpansionTile(
                                  maintainState: true,
                                  collapsedIconColor: Colors.black,
                                  iconColor: Colors.black,
                                  tilePadding: EdgeInsets.all(0.sp),
                                  childrenPadding: EdgeInsets.all(0.sp),
                                  textColor: Colors.black,
                                  collapsedTextColor: Colors.black,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  expandedAlignment: Alignment.centerLeft,
                                  shape: Border.all(color: Colors.transparent),
                                  title: Text(
                                    "Material",
                                    style: zzRegularBlackTextStyle13B,
                                  ),
                                  onExpansionChanged: ((newState) {
                                    setState(() {
                                      if (newState) {
                                        //myBrand = !myBrand;
                                      }

                                      // Get.to(()=>ExpansionPanelRadioSample());
                                      // Get.to(() => Steps());
                                    });
                                  }),
                                  children: <Widget>[
                                    SizedBox(
                                      width: Get.width,
                                      child: FutureBuilder(
                                        future: simulateSlowTransaction(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return Scrollbar(
                                              thickness: 3.sp,
                                              child: ListView.builder(
                                                itemCount:
                                                    widget.materialList.length,
                                                addAutomaticKeepAlives: false,
                                                addRepaintBoundaries: false,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return CheckboxListTile(
                                                    title: Text(widget
                                                        .materialList[index]),
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    activeColor: loginTextColor,
                                                    checkColor: Colors.white,
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    dense: true,
                                                    value:
                                                        boolMaterialList[index],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        boolMaterialList[
                                                            index] = value!;
                                                        if (value == true) {
                                                          myMaterialList.add(
                                                              widget.materialList[
                                                                  index]);
                                                        } else {
                                                          myMaterialList.remove(
                                                              widget.materialList[
                                                                  index]);
                                                        }
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          widget.materialList.isNotEmpty
                              ? const Divider(
                                  thickness: 2,
                                  color: Colors.black12,
                                )
                              : const SizedBox(),
                          widget.shapeList.isNotEmpty
                              ? ExpansionTile(
                                  maintainState: true,
                                  collapsedIconColor: Colors.black,
                                  iconColor: Colors.black,
                                  tilePadding: EdgeInsets.all(0.sp),
                                  childrenPadding: EdgeInsets.all(0.sp),
                                  textColor: Colors.black,
                                  collapsedTextColor: Colors.black,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  expandedAlignment: Alignment.centerLeft,
                                  shape: Border.all(color: Colors.transparent),
                                  title: Text(
                                    "Shape",
                                    style: zzRegularBlackTextStyle13B,
                                  ),
                                  onExpansionChanged: ((newState) {
                                    setState(() {
                                      if (newState) {
                                        //myBrand = !myBrand;
                                      }

                                      // Get.to(()=>ExpansionPanelRadioSample());
                                      // Get.to(() => Steps());
                                    });
                                  }),
                                  children: <Widget>[
                                    SizedBox(
                                      width: Get.width,
                                      child: FutureBuilder(
                                        future: simulateSlowTransaction(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return Scrollbar(
                                              thickness: 3.sp,
                                              child: ListView.builder(
                                                itemCount:
                                                    widget.shapeList.length,
                                                addAutomaticKeepAlives: false,
                                                addRepaintBoundaries: false,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return CheckboxListTile(
                                                    title: Text(widget
                                                        .shapeList[index]),
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    activeColor: loginTextColor,
                                                    checkColor: Colors.white,
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    dense: true,
                                                    value: boolShapeList[index],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        boolShapeList[index] =
                                                            value!;
                                                        if (value == true) {
                                                          myShapeList.add(
                                                              widget.shapeList[
                                                                  index]);
                                                        } else {
                                                          myShapeList.remove(
                                                              widget.shapeList[
                                                                  index]);
                                                        }
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          widget.shapeList.isNotEmpty
                              ? const Divider(
                                  thickness: 2,
                                  color: Colors.black12,
                                )
                              : const SizedBox(),
                          widget.styleList.isNotEmpty
                              ? ExpansionTile(
                                  maintainState: true,
                                  collapsedIconColor: Colors.black,
                                  iconColor: Colors.black,
                                  tilePadding: EdgeInsets.all(0.sp),
                                  childrenPadding: EdgeInsets.all(0.sp),
                                  textColor: Colors.black,
                                  collapsedTextColor: Colors.black,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  expandedAlignment: Alignment.centerLeft,
                                  shape: Border.all(color: Colors.transparent),
                                  title: Text(
                                    "Style",
                                    style: zzRegularBlackTextStyle13B,
                                  ),
                                  onExpansionChanged: ((newState) {
                                    setState(() {});
                                  }),
                                  children: <Widget>[
                                    SizedBox(
                                      width: Get.width,
                                      child: FutureBuilder(
                                        future: simulateSlowTransaction(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return Scrollbar(
                                              thickness: 3.sp,
                                              child: ListView.builder(
                                                itemCount:
                                                    widget.styleList.length,
                                                addAutomaticKeepAlives: false,
                                                addRepaintBoundaries: false,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return CheckboxListTile(
                                                    title: Text(widget
                                                        .styleList[index]),
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    activeColor: loginTextColor,
                                                    checkColor: Colors.white,
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    dense: true,
                                                    value: boolStyleList[index],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        boolStyleList[index] =
                                                            value!;
                                                        if (value == true) {
                                                          myStyleList.add(
                                                              widget.styleList[
                                                                  index]);
                                                        } else {
                                                          myStyleList.remove(
                                                              widget.styleList[
                                                                  index]);
                                                        }
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          widget.styleList.isNotEmpty
                              ? const Divider(
                                  thickness: 2,
                                  color: Colors.black12,
                                )
                              : const SizedBox(),
                          widget.colorList.isNotEmpty
                              ? ExpansionTile(
                                  maintainState: true,
                                  collapsedIconColor: Colors.black,
                                  iconColor: Colors.black,
                                  tilePadding: EdgeInsets.all(0.sp),
                                  childrenPadding: EdgeInsets.all(0.sp),
                                  textColor: Colors.black,
                                  collapsedTextColor: Colors.black,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  expandedAlignment: Alignment.centerLeft,
                                  shape: Border.all(color: Colors.transparent),
                                  title: Text(
                                    "Color",
                                    style: zzRegularBlackTextStyle13B,
                                  ),
                                  onExpansionChanged: ((newState) {
                                    setState(() {});
                                  }),
                                  children: <Widget>[
                                    SizedBox(
                                      width: Get.width,
                                      child: FutureBuilder(
                                        future: simulateSlowTransaction(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return Scrollbar(
                                              thickness: 3.sp,
                                              child: ListView.builder(
                                                itemCount:
                                                    widget.colorList.length,
                                                physics:
                                                    NeverScrollableScrollPhysics(), // Disable inner scrolling

                                                addAutomaticKeepAlives: false,
                                                addRepaintBoundaries: false,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return CheckboxListTile(
                                                    title: Text(widget
                                                        .colorList[index]),
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    activeColor: loginTextColor,
                                                    checkColor: Colors.white,
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    dense: true,
                                                    value: boolColorList[index],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        boolColorList[index] =
                                                            value!;
                                                        if (value == true) {
                                                          myColorList.add(
                                                              widget.colorList[
                                                                  index]);
                                                        } else {
                                                          myColorList.remove(
                                                              widget.colorList[
                                                                  index]);
                                                        }
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          widget.colorList.isNotEmpty
                              ? const Divider(
                                  thickness: 2,
                                  color: Colors.black12,
                                )
                              : const SizedBox(),
                          widget.gender.isNotEmpty
                              ? ExpansionTile(
                                  maintainState: true,
                                  collapsedIconColor: Colors.black,
                                  iconColor: Colors.black,
                                  tilePadding: EdgeInsets.all(0.sp),
                                  childrenPadding: EdgeInsets.all(0.sp),
                                  textColor: Colors.black,
                                  collapsedTextColor: Colors.black,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  expandedAlignment: Alignment.centerLeft,
                                  shape: Border.all(color: Colors.transparent),
                                  title: Text(
                                    "Gender",
                                    style: zzRegularBlackTextStyle13B,
                                  ),
                                  onExpansionChanged: ((newState) {
                                    setState(() {});
                                  }),
                                  children: <Widget>[
                                    SizedBox(
                                      width: Get.width,
                                      child: FutureBuilder(
                                        future: simulateSlowTransaction(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return Scrollbar(
                                              thickness: 3.sp,
                                              child: ListView.builder(
                                                itemCount: widget.gender.length,
                                                addAutomaticKeepAlives: false,
                                                addRepaintBoundaries: false,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return CheckboxListTile(
                                                    title: Text(
                                                        widget.gender[index]),
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    activeColor: loginTextColor,
                                                    checkColor: Colors.white,
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    dense: true,
                                                    value:
                                                        boolGenderList[index],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        boolGenderList[index] =
                                                            value!;
                                                        if (value == true) {
                                                          myGenderList.add(
                                                              widget.gender[
                                                                  index]);
                                                        } else {
                                                          myGenderList.remove(
                                                              widget.gender[
                                                                  index]);
                                                        }
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          widget.gender.isNotEmpty
                              ? const Divider(
                                  thickness: 2,
                                  color: Colors.black12,
                                )
                              : const SizedBox(),
                          ExpansionTile(
                            maintainState: true,
                            collapsedIconColor: Colors.black,
                            iconColor: Colors.black,
                            tilePadding: EdgeInsets.all(0.sp),
                            childrenPadding: EdgeInsets.all(0.sp),
                            textColor: Colors.black,
                            collapsedTextColor: Colors.black,
                            controlAffinity: ListTileControlAffinity.trailing,
                            expandedAlignment: Alignment.centerLeft,
                            shape: Border.all(color: Colors.transparent),
                            title: Text(
                              "Availability",
                              style: zzRegularBlackTextStyle13B,
                            ),
                            onExpansionChanged: ((newState) {
                              setState(() {});
                            }),
                            children: <Widget>[
                              SizedBox(
                                width: Get.width,
                                child: FutureBuilder(
                                  future: simulateSlowTransaction(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Scrollbar(
                                        thickness: 3.sp,
                                        child: ListView.builder(
                                          itemCount: FilterModel
                                              .eyeAvailability.length,
                                          addAutomaticKeepAlives: false,
                                          addRepaintBoundaries: false,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CheckboxListTile(
                                              title: Text(FilterModel
                                                  .eyeAvailability[index]),
                                              contentPadding: EdgeInsets.zero,
                                              activeColor: loginTextColor,
                                              checkColor: Colors.white,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              dense: true,
                                              value: boolAvailList[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  boolAvailList[index] = value!;
                                                  if (value == true) {
                                                    myAvailList.add(FilterModel
                                                            .eyeAvailability[
                                                        index]);
                                                  } else {
                                                    myAvailList.remove(
                                                        FilterModel
                                                                .eyeAvailability[
                                                            index]);
                                                  }
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                            color: Colors.black12,
                          ),
                          ExpansionTile(
                            maintainState: true,
                            collapsedIconColor: Colors.black,
                            iconColor: Colors.black,
                            tilePadding: EdgeInsets.all(0.sp),
                            childrenPadding: EdgeInsets.all(0.sp),
                            textColor: Colors.black,
                            collapsedTextColor: Colors.black,
                            controlAffinity: ListTileControlAffinity.trailing,
                            expandedAlignment: Alignment.centerLeft,
                            shape: Border.all(color: Colors.transparent),
                            title: Text(
                              "Product Type",
                              style: zzRegularBlackTextStyle13B,
                            ),
                            onExpansionChanged: ((newState) {
                              setState(() {});
                            }),
                            children: <Widget>[
                              SizedBox(
                                width: Get.width,
                                child: FutureBuilder(
                                  future: simulateSlowTransaction(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Scrollbar(
                                        thickness: 3.sp,
                                        child: ListView.builder(
                                          itemCount:
                                              widget.productTypeList.length,
                                          addAutomaticKeepAlives: false,
                                          addRepaintBoundaries: false,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CheckboxListTile(
                                              title: Text(widget
                                                  .productTypeList[index]),
                                              contentPadding: EdgeInsets.zero,
                                              activeColor: loginTextColor,
                                              checkColor: Colors.white,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              dense: true,
                                              value: boolProductTypeList[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  boolProductTypeList[index] =
                                                      value!;
                                                  if (value == true) {
                                                    myProductTypeList.add(
                                                        widget.productTypeList[
                                                            index]);
                                                  } else {
                                                    myProductTypeList.remove(
                                                        widget.productTypeList[
                                                            index]);
                                                  }
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                            color: Colors.black12,
                          ),
                          ExpansionTile(
                            maintainState: true,
                            collapsedIconColor: black,
                            iconColor: black,
                            tilePadding: EdgeInsets.zero,
                            childrenPadding: EdgeInsets.zero,
                            textColor: black,
                            collapsedTextColor: black,
                            controlAffinity: ListTileControlAffinity.trailing,
                            expandedAlignment: Alignment.centerLeft,
                            shape: Border.all(color: Colors.transparent),
                            title: Text(
                              "Price",
                              style: zzRegularBlackTextStyle13B,
                            ),
                            onExpansionChanged: ((newState) {
                              setState(() {
                                if (newState) {
                                  myPrice = !myPrice;
                                }
                              });
                            }),
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.6,
                                              height: 50,
                                              child: TextField(
                                                  controller:
                                                      startPriceController,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  maxLength: 6,
                                                  decoration: const InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color: Colors.black),
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              5, 2, 5, 2),
                                                      counterText: '',
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          loginTextColor)),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          loginTextColor))),
                                                  onChanged: (value) {
                                                    updateTextField(value);
                                                  }),
                                            ),
                                            const SizedBox(width: 20),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.6,
                                              height: 50,
                                              child: TextField(
                                                  controller:
                                                      endPriceController,
                                                  keyboardType: TextInputType
                                                      .number,
                                                  maxLength: 6,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .black),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(5,
                                                                      2, 5, 2),
                                                          counterText: '',
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    loginTextColor),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              loginTextColor))),
                                                  onChanged: (value) {
                                                    if (value.isNotEmpty) {
                                                      double parsedValue =
                                                          double.tryParse(
                                                                  value) ??
                                                              0.0;
                                                      double maxAllowedValue =
                                                          double.tryParse(widget
                                                                      .endPrice ??
                                                                  '') ??
                                                              0.0;

                                                      if (parsedValue >
                                                          maxAllowedValue) {
                                                        endPriceController
                                                            .clear();
                                                      } else {
                                                        updateTextField2(value);
                                                      }
                                                    }
                                                  }),
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RangeSlider(
                                          min: 0,
                                          max: double.parse(widget.endPrice!),
                                          values:
                                              RangeValues(startValue, endValue),
                                          onChanged: (value) {
                                            setState(() {
                                              startValue = value.start;
                                              endValue = value.end;
                                              startPrice = value.start.toInt();
                                              endPrice = value.end.toInt();

                                              updateSlider(startValue);
                                              updateSlider2(endValue);
                                              startPriceController.text = value
                                                  .start
                                                  .toInt()
                                                  .toString();

                                              endPriceController.text =
                                                  value.end.toInt().toString();
                                            });
                                          }),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 44,
                      width: 120,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              myBrandList = [];
                              myMaterialList = [];
                              myShapeList = [];
                              myStyleList = [];
                              myColorList = [];
                              myGenderList = [];
                              myAvailList = [];
                              myProductTypeList = [];

                              startPriceController.text = '0';
                              endPriceController.text = widget.endPrice!;

                              boolBrandList = [];
                              boolMaterialList = [];
                              boolShapeList = [];
                              boolStyleList = [];
                              boolColorList = [];
                              boolGenderList = [];
                              boolAvailList = [];
                              boolProductTypeList = [];
                              boolBrandList = List.generate(
                                  widget.brandList.length, (index) => false);
                              boolMaterialList = List.generate(
                                  widget.materialList.length, (index) => false);
                              boolShapeList = List.generate(
                                  widget.shapeList.length, (index) => false);
                              boolStyleList = List.generate(
                                  widget.styleList.length, (index) => false);
                              boolColorList = List.generate(
                                  widget.colorList.length, (index) => false);

                              boolGenderList = List.generate(
                                  widget.gender.length, (index) => false);
                              boolAvailList = List.generate(
                                  FilterModel.eyeAvailability.length,
                                  (index) => false);
                              boolProductTypeList = List.generate(
                                  widget.productTypeList.length,
                                  (index) => false);
                              showSuccessSnackBar(
                                  context, 'Reset successfully...!');
                              //productFilter(context);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: loginTextColor,
                                width: 1,
                              ),
                              backgroundColor: Colors.white),
                          child: Text(
                            "Reset all",
                            style: GoogleFonts.lato(color: loginTextColor),
                          )),
                    ),
                    SizedBox(
                      width: 200,
                      height: 44,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              print(endPriceController.text);
                              if (endPriceController.text != '') {
                                int start =
                                    int.parse(startPriceController.text);
                                if (startPriceController.text != '') {
                                  start = int.parse(startPriceController.text);
                                } else {
                                  start = 0;
                                }
                                int end = int.parse(endPriceController.text);
                                if (start > end) {
                                  showErrorSnackBar(context,
                                      'end price should be greater than start price');
                                } else {
                                  if (widget.navigationTrailRequset == true) {
                                    Get.off(() => TrialRequestProductList(
                                        widget.myCollectionId,
                                        fromFilter: "F",
                                        aBrandList: myBrandList,
                                        aMaterialList: myMaterialList,
                                        aShapeList: myShapeList,
                                        aStyleList: myStyleList,
                                        aColorList: myColorList,
                                        aGenderList: myGenderList,
                                        aAvailabilityList: myAvailList,
                                        aProductTypeList: myProductTypeList,
                                        aStartPrice:
                                            startPriceController.text.isEmpty
                                                ? 0
                                                : int.parse(
                                                    startPriceController.text),
                                        aEndPrice:
                                            int.parse(endPriceController.text),
                                        aBoolBrandList: boolBrandList,
                                        aBoolMaterialList: boolMaterialList,
                                        aBoolShapeList: boolShapeList,
                                        aBoolStyleList: boolStyleList,
                                        aBoolColorList: boolColorList,
                                        aBoolGenderList: boolGenderList,
                                        aBoolAvailabilityList: boolAvailList,
                                        aBoolTypeList: boolProductTypeList));
                                  } else {
                                    Get.off(() => ViewProductListScreen(
                                          widget.myCollectionId,
                                          fromWhere: 6,
                                          fromFilter: "F",
                                          toCart: '',
                                          filterTitle:
                                              myProductTypeList.toString(),
                                          aBrandList: myBrandList,
                                          aMaterialList: myMaterialList,
                                          aShapeList: myShapeList,
                                          aStyleList: myStyleList,
                                          aColorList: myColorList,
                                          aGenderList: myGenderList,
                                          aAvailabilityList: myAvailList,
                                          aProductTypeList: myProductTypeList,
                                          aStartPrice: startPriceController
                                                  .text.isEmpty
                                              ? 0
                                              : int.parse(
                                                  startPriceController.text),
                                          aEndPrice: int.parse(
                                              endPriceController.text),
                                          aBoolBrandList: boolBrandList,
                                          aBoolMaterialList: boolMaterialList,
                                          aBoolShapeList: boolShapeList,
                                          aBoolStyleList: boolStyleList,
                                          aBoolColorList: boolColorList,
                                          aBoolGenderList: boolGenderList,
                                          aBoolAvailabilityList: boolAvailList,
                                          aBoolTypeList: boolProductTypeList,
                                        ));
                                  }
                                }
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: loginTextColor),
                          child: Text(
                            "Apply Filter",
                            style: zzBoldWhiteTextStyle14,
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ));
  }
}
