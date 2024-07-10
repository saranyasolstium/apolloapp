import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:infinite/model/filter_model.dart';
import 'package:infinite/model/product_model.dart';
import 'package:infinite/res/colors.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/services/network/dio_client.dart';
import 'package:infinite/services/network/endpoints.dart';
import 'package:infinite/services/remote_service.dart';
import 'package:infinite/view/home/ear_detail_screen.dart';
import 'package:infinite/view/home/home_screen.dart';
import 'package:infinite/view/home/oral_care/oralcare_detail.dart';
import 'package:infinite/view/home/skin_care/skincare_detail.dart';
import 'package:infinite/view/home/sleep_care/sleep_details.dart';
import 'package:infinite/view/products/product_filter.dart';
import 'package:infinite/view/products/search_product_screen.dart';
import 'package:infinite/utils/global.dart';
import 'package:infinite/widgets/cart_icon.dart';
import 'package:sizer/sizer.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

import '../../widgets/navigation_widget.dart';
import '../home/eye_detail_screen.dart';

class ViewProductListScreen extends StatefulWidget {
  final int? myCollectionId;
  final int? fromWhere;
  final String? toCart;
  final int? myTab;
  final String? fromWhere2;
  final String? fromFilter;
  final String? filterTitle;
  final List<String>? aBrandList;
  final List<String>? aMaterialList;
  final List<String>? aShapeList;
  final List<String>? aStyleList;
  final List<String>? aColorList;
  final List<String>? aGenderList;
  final List<String>? aAvailabilityList;
  final List<String>? aProductTypeList;
  final int? aStartPrice;
  final int? aEndPrice;
  final List<bool>? aBoolBrandList;
  final List<bool>? aBoolMaterialList;
  final List<bool>? aBoolShapeList;
  final List<bool>? aBoolStyleList;
  final List<bool>? aBoolColorList;
  final List<bool>? aBoolGenderList;
  final List<bool>? aBoolAvailabilityList;
  final List<bool>? aBoolTypeList;
  final String? handle;

// final List<bool>? aBoolPriceList;

  const ViewProductListScreen(this.myCollectionId,
      {this.fromWhere,
      this.toCart,
      this.myTab,
      this.fromWhere2,
      this.fromFilter,
      this.filterTitle,
      this.aBrandList,
      this.aMaterialList,
      this.aShapeList,
      this.aStyleList,
      this.aColorList,
      this.aGenderList,
      this.aAvailabilityList,
      this.aProductTypeList,
      this.aStartPrice,
      this.aEndPrice,
      this.aBoolBrandList,
      this.aBoolMaterialList,
      this.aBoolShapeList,
      this.aBoolStyleList,
      this.aBoolColorList,
      this.aBoolGenderList,
      this.aBoolAvailabilityList,
      this.aBoolTypeList,
      this.handle,
      Key? key})
      : super(key: key);

  @override
  State<ViewProductListScreen> createState() => _ViewProductListScreenState();
}

class _ViewProductListScreenState extends State<ViewProductListScreen> {
  late List<ProductModel> myProductList;
  List<ProductModel> myInStockList = [];
  List<ProductModel> myOutStockList = [];
  List<ProductModel> highestPriceList = [];
  List<ProductModel> list = [];
  bool hasNextPage = true;
  int page = 10;

  final ScrollController _controller = ScrollController();
  int pageItemCount = 10;
  int count = 0;
  int myCartCount = 0;
  int myBookCount = 0;
  int myFrameCount = 0;
  int myAddOnCount = 0;
  Timer? timer;
  String sort = '';
  String RadioValue = "ALL";
  int k = 0;
  String isColor = '';
  int? lastEndPrice;
  List<int> wishlist = [];
  List<String> productIds = [];
  int? customerId;
  String sortAll = "";
  List<ProductModel> filteredProductList = [];

  @override
  void initState() {
    //applyCartCount();
    super.initState();
    customerId = sharedPreferences!.getInt("id");

    widget.aAvailabilityList != ['I', 'ER'];

    loading = true;
    myProductList = [];
    _controller.addListener(_scrollListener);

    //NEWLY COMMENTED
    loading = true;
    // getStockList();
    getProductListCount();

    if (widget.fromFilter == 'F') {
      fetchProductFilter();
    } else {
      //_fetchProductsByCollectionId();
      getProductList();
    }
    if (widget.myTab == null) {
      widget.myTab == 1;
    }
    debugPrint('SHOW THE TAB SELECTION::::${widget.myTab}');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _scrollListener() {
    if (!hasNextPage) return;
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      pageItemCount += 10;

      if (widget.fromFilter != 'F') {
        if (RadioValue == "HIGH") {
          getPriceProductList(true);
        } else if (RadioValue == "LOW") {
          getPriceProductList(false);
        } else if (RadioValue == "NEW") {
          getNewArrivalsList();
        } else if (RadioValue == "BEST") {
          getNewArrivalsList();
        } else if (RadioValue == "MOST") {
          getNewArrivalsList();
        } else {
          getProductList();
        }
      } else if (widget.fromFilter == 'F') {
        // print("ssssssssssssssa");
        // print(sortAll);
        // if (sortAll == "ALL") {
        //   getProductList();
        // }
      }
    }
  }

  String? nextPageCursor;

  void getPriceProductList(bool reverse) async {
    try {
      setState(() {
        loading = true;
      });

      final HttpLink httpLink = HttpLink(
        'https://apollohospitals.myshopify.com/api/2024-04/graphql.json',
        defaultHeaders: {
          'X-Shopify-Storefront-Access-Token':
              'e44583241c0b66f362b767ec913c07e9',
        },
      );

      final GraphQLClient client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );

      QueryResult result = await client.query(
        QueryOptions(
          document: gql('''
        query Price(\$collectionId: ID!, \$reverse: Boolean, \$first: Int, \$after: String) {
          node(id: \$collectionId) {
            ... on Collection {
              id
              handle
              products(first: \$first, sortKey: PRICE, reverse: \$reverse, after: \$after) {
                pageInfo {
                  hasNextPage
                  endCursor
                }
                edges {
                  node {
                    id
                    handle
                  }
                }
              }
            }
          }
        }
      '''),
          variables: {
            'collectionId': 'gid://shopify/Collection/${widget.myCollectionId}',
            'reverse': reverse,
            'first': 50,
            'after': nextPageCursor,
          },
        ),
      );

      // Handle GraphQL exceptions
      if (result.hasException) {
        print('GraphQL Error: ${result.exception.toString()}');
        setState(() {
          loading = false; // Set loading to false after handling the exception
        });
        return;
      }

      // Handle empty products
      List<dynamic>? products = result.data?['node']['products']['edges'];
      if (products == null || products.isEmpty) {
        print('No products found.');
        setState(() {
          loading = false; // Set loading to false when no products are found
        });
        return;
      }

      // Extract product IDs
      List<String> newProductIds = products.map<String>((product) {
        String productId = product['node']['id'].split('/').last;
        return productId;
      }).toList();

      // Print or use the product IDs
      print('Product IDs: $newProductIds');

      // Update pagination variables
      nextPageCursor =
          result.data?['node']['products']['pageInfo']['endCursor'];
      hasNextPage = result.data?['node']['products']['pageInfo']['hasNextPage'];

      productIds.addAll(newProductIds);

      getDetails(newProductIds);

      setState(() {
        loading = true;
      });
    } catch (e) {
      print('Error fetching product list: $e');
      setState(() {
        loading = true;
      });
    }
  }

  void getNewArrivalsList() async {
    try {
      setState(() {
        loading = true;
      });

      final HttpLink httpLink = HttpLink(
        'https://apollohospitals.myshopify.com/api/2024-04/graphql.json',
        defaultHeaders: {
          'X-Shopify-Storefront-Access-Token':
              'e44583241c0b66f362b767ec913c07e9',
        },
      );

      final GraphQLClient client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );

      QueryResult result = await client.query(
        QueryOptions(
          document: gql('''
          query NewArrivals(\$collectionId: ID!, \$first: Int, \$after: String) {
            collection(id: \$collectionId) {
              id
              handle
              products(first: \$first, sortKey: RELEVANCE, after: \$after) {
                pageInfo {
                  hasNextPage
                  endCursor
                }
                edges {
                  node {
                    id
                    handle
                    createdAt
                  }
                }
              }
            }
          }
        '''),
          variables: {
            'collectionId': 'gid://shopify/Collection/${widget.myCollectionId}',
            'first': 50,
            'after': nextPageCursor,
          },
        ),
      );

      if (result.hasException) {
        print('GraphQL Error: ${result.exception.toString()}');
        return;
      }
      print(result.data);
      List<dynamic>? products = result.data?['collection']['products']['edges'];
      if (products == null || products.isEmpty) {
        print('No products found.');
        return;
      }

      List<String> newProductIds = products.map<String>((product) {
        String productId = product['node']['id'].split('/').last;
        return productId;
      }).toList();

      nextPageCursor =
          result.data?['collection']['products']['pageInfo']['endCursor'];
      hasNextPage =
          result.data?['collection']['products']['pageInfo']['hasNextPage'];

      productIds.addAll(newProductIds);

      getDetails(newProductIds);
    } catch (e) {
      print('Error fetching product list: $e');
    }
  }

  Future<void> fetchProductFilter() async {
    productIds = [];
    try {
      var response = await RemoteServices().productFilter(
          collectionId: widget.myCollectionId!,
          brand: widget.aBrandList!,
          material: widget.aMaterialList!,
          shape: widget.aShapeList!,
          minPrice: widget.aStartPrice!,
          maxPrice: widget.aEndPrice!,
          style: widget.aStyleList!,
          color: widget.aColorList!,
          gender: widget.aGenderList!,
          productType: widget.aProductTypeList!,
          availability: widget.aAvailabilityList!);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['data'] != null) {
          for (var productId in jsonData['data']) {
            productIds.add(productId);
          }
        }
        // if (widget.aBrandList!.isNotEmpty ||
        //     widget.aMaterialList!.isNotEmpty ||
        //     widget.aShapeList!.isNotEmpty) {
        //       productIds.clear();
        //   for (var metafield in jsonData['metafields']) {
        //     productIds.add(metafield['product_id']);

        //   }
        //         print("Saranya: ${productIds.length}");

        // }

        print('Product IDs: $productIds');
        print(productIds.length);
        setState(() {
          count = productIds.length;
        });
        if (productIds.length != 0) {
          getDetails1(productIds);
        } else {
          setState(() {
            myProductList = [];
            loading = false;
          });
        }
      } else {
        print('Failed to fetch reviews: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  int limit = 50;
  int offset = 0;

  void _updateFilteredList() {
    filteredProductList = myProductList.where((product) {
      var available = false;
      if (product.variantsList != null && product.variantsList!.isNotEmpty) {
        for (var variant in product.variantsList!) {
          int inventoryQuantity = variant['inventory_quantity'] ?? 0;
          if (inventoryQuantity > 0) {
            available = true;
            break;
          }
        }
      }
      return (available && widget.aAvailabilityList!.contains("InStock")) ||
          (!available && widget.aAvailabilityList!.contains("Out of Stock"));
    }).toList();
  }

  void getDetails1(List<String> productIds) async {
    try {
      setState(() {
        loading = true;
      });

      List<ProductModel> allProducts = [];
      while (offset < productIds.length) {
        int currentPageIdsLength = offset + limit < productIds.length
            ? limit
            : productIds.length - offset;
        List<String> currentBatch =
            productIds.sublist(offset, offset + currentPageIdsLength);
        String baseUrl =
            'https://apollohospitals.myshopify.com/admin/api/2024-04/products.json';
        String idsQueryParam = currentBatch.join(',');
        String url = '$baseUrl?ids=$idsQueryParam';
        print(url);

        final response = await DioClient(myUrl: url).getProductList();
        allProducts.addAll(response);
        offset += limit;

        if (response.isNotEmpty) {
          setState(() {
            for (ProductModel model in response) {
              myProductList.add(model);
              for (var values in model.variantColorList) {
                isColor = values['color'];
              }
              if (model.variantsList != null &&
                  model.variantsList!.isNotEmpty) {
                var variant = model.variantsList![0];
                var inventoryQuantity = variant['inventory_quantity'];
              }
            }
            loading=true;
            // if (widget.fromFilter == "F") {
            //   if (widget.aAvailabilityList!.isNotEmpty) {
            //    // _updateFilteredList();
            //   }
            //   setState(() {
            //     count = myProductList.length;
            //   });
            // }
          });
        }
      }

      setState(() {
        myProductList = allProducts;
        // Rest of your logic for sorting and filtering
        loading = false;
        setState(() {
          count=myProductList.length;
        });
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        loading = false;
      });
    }
  }

  void getDetails(List<String> productIds) async {
    try {
      setState(() {
        loading = true;
      });

      String baseUrl =
          'https://apollohospitals.myshopify.com/admin/api/2024-04/products.json';
      String idsQueryParam = productIds.join(',');
      String url = '$baseUrl?ids=$idsQueryParam';
      print(url);

      // Fetch product list
      final response = await DioClient(myUrl: url).getProductList();

      if (response.isNotEmpty) {
        setState(() {
          for (ProductModel model in response) {
            myProductList.add(model);
            for (var values in model.variantColorList) {
              isColor = values['color'];
            }
            if (model.variantsList != null && model.variantsList!.isNotEmpty) {
              var variant = model.variantsList![0];
              var inventoryQuantity = variant['inventory_quantity'];
            }
          }
          if (RadioValue == "LOW") {
            myProductList.sort((a, b) {
              double f = double.parse(a.variantsList![0]['price']);
              double s = double.parse(b.variantsList![0]['price']);
              return f.compareTo(s);
            });
          } else if (RadioValue == "HIGH") {
            myProductList.sort((a, b) {
              double f = double.parse(a.variantsList![0]['price']);
              double s = double.parse(b.variantsList![0]['price']);
              return s.compareTo(f);
            });
          }

          //  else if (widget.fromFilter == "F") {
          //   if (widget.aAvailabilityList!.isNotEmpty) {
          //     myProductList = myProductList.where((product) {
          //       var inventoryQuantity = getProductInventoryQuantity(product);
          //       return inventoryQuantity > 0
          //           ? widget.aAvailabilityList!.contains("InStock")
          //           : widget.aAvailabilityList!.contains("Out of Stock");
          //     }).toList();
          //   }
          //   setState(() {
          //     count = myProductList.length;
          //   });
          // }
        });
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        loading = false;
      });
    }
  }

  int getProductInventoryQuantity(ProductModel product) {
    if (product.variantsList != null && product.variantsList!.isNotEmpty) {
      var variant = product.variantsList![
          0]; // Assuming the first variant contains inventory information
      var inventoryQuantity = variant['inventory_quantity'];
      if (inventoryQuantity != null) {
        return inventoryQuantity as int;
      }
    }
    return 0;
  }

  // GET PRODUCT LIST
  void getProductList() {
    try {
      String aUrl =
          "${EndPoints.allProductsList}?limit=$pageItemCount&collection_id=${widget.myCollectionId}&status=active";
      DioClient(myUrl: aUrl).getProductList().then((value) {
        if (mounted) {
          setState(() {
            if (value.isNotEmpty) {
              myProductList = [];
              for (ProductModel model in value) {
                myProductList.add(model);
                for (var values in model.variantColorList) {
                  isColor = values['color'];
                }
              }

              fetchProductWishlist();
            } else {
              hasNextPage = false;
              myProductList = [];
            }
            loading = false;
          });
        }
      });
      //}
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<void> fetchProductWishlist() async {
    try {
      var response = await RemoteServices()
          .fetchAvgRating(widget.myCollectionId, customerId);
      print(response.body);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        // Extract wishlist
        if (jsonData.containsKey('wishlist')) {
          var wishlist = jsonData['wishlist'] as List<dynamic>;
          List<String> wishlistProductIds =
              wishlist.map((item) => item['product_id'].toString()).toList();
          myProductList.forEach((product) {
            setState(() {
              if (wishlistProductIds.contains(product.id.toString())) {
                product.wishlistIconColor = Colors.red;
                print('${product.id} is in wishlist!');
              } else {
                product.wishlistIconColor = Colors.black;

                print('${product.id} is not in wishlist.');
              }
            });
          });
        } else {
          // wishlistStatus = 0;
          // _iconColor = Colors.black;
        }

        // Extract review_count
        // setState(() {
        //   reviewCount = jsonData['review_count'];
        // });
      } else {
        print('Failed to fetch reviews: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  // void getStockList() {
  //   try {
  //     String aUrl =
  //         "${EndPoints.allProductsList}?collection_id=${widget.myCollectionId}";
  //     print(aUrl);
  //     DioClient(myUrl: aUrl).getProductList().then((value) {
  //       if (mounted) {
  //         setState(() {
  //           if (value.isNotEmpty) {
  //             myInStockList = [];
  //             myOutStockList = [];
  //             for (ProductModel model in value) {
  //               // myProductList.add(model);
  //               for (var variants in model.variantsList!) {
  //                 if (model.variantsList![0]['inventory_quantity'] == 0) {
  //                   myOutStockList.add(model);
  //                 } else {
  //                   myInStockList.add(model);
  //                 }
  //               }
  //             }
  //             loading = false;
  //           }
  //         });
  //       }
  //     });
  //   } catch (e) {
  //     debugPrint("$e");
  //   }
  // }

  void getProductListCount() {
    try {
      String aUrl = "";
      if (widget.myCollectionId == 0) {
        aUrl = EndPoints.productsListCount;
      } else {
        aUrl =
            "${EndPoints.productsListCount}?collection_id=${widget.myCollectionId}&status=active";
      }
      DioClient(myUrl: aUrl).getDetails().then((value) {
        if (mounted) {
          setState(() {
            if (value.statusCode == 200) {
              count = value.data['count'];
            }
          });
        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    try {
      final response = await RemoteServices().updateWishlist(
        customerId: customerId!,
        productId: productId,
      );

      if (response.statusCode == 200) {
        showSuccessSnackBar(context, "Wishlist Removed Successfully");
      } else {
        showErrorSnackBar(context, "Failed to remove wishlist!");
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  Future<void> addToWishlist(int productId) async {
    try {
      final response = await RemoteServices().createWishlist(
        customerId: customerId!,
        productId: productId,
      );

      if (response.statusCode == 200) {
        showSuccessSnackBar(context, "Wishlist Added Successfully");
      } else {
        showErrorSnackBar(context, "Failed to add wishlist!");
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  int calculateDiscountPercentage(
      String? actualPriceStr, String? comparePriceStr,
      {int decimalPlaces = 2}) {
    final actualPrice = double.parse(actualPriceStr ?? '0');
    final comparePrice = double.parse(comparePriceStr ?? '0');

    final discountAmount = actualPrice - comparePrice;

    final discountPercentage = (discountAmount / actualPrice) * 100;

    final roundedDiscountPercentage =
        double.parse(discountPercentage.toStringAsFixed(decimalPlaces));

    if (roundedDiscountPercentage - roundedDiscountPercentage.floorToDouble() >=
        0.6) {
      return roundedDiscountPercentage.ceil().toInt();
    } else {
      return roundedDiscountPercentage.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (widget.myTab == 1) {
          setState(() {
            Get.back();
          });
        } else {
          setState(() {
            Get.to(() => HomeScreen(index: 1));
          });
        }
        return Future.value(false);
      },
      child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              endDrawer: const NavigationWidget(),
              appBar: AppBar(
                backgroundColor: loginTextColor,
                leading: IconButton(
                  onPressed: () {
                    if (widget.fromWhere == 6) {
                      debugPrint("called 6");
                      setState(() {
                        Get.to(() => HomeScreen(index: 1));
                      });
                    } else if (widget.myTab == 1) {
                      debugPrint("called 1");
                      setState(() {
                        Get.to(() => HomeScreen(index: 1));
                      });
                    } else {
                      debugPrint("called ");
                      setState(() {
                        Get.to(() => HomeScreen(index: 1));
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios_sharp),
                ),
                actions: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        makeCallOrSendMessage(
                            "call", myDefaultLandLineNumber, "");
                      });
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        Get.to(() => SearchProductScreen(
                              collectionId: widget.myCollectionId!,
                            ));
                      });
                    },
                    child: SvgPicture.asset(
                      "assets/svg/search.svg",
                      color: white,
                      height: 20.0,
                      width: 20.0,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  SizedBox(width: 6.0.w),
                  CartIcon(
                    productId: widget.myCollectionId,
                    type: "product",
                  ),

                  SizedBox(width: 6.0.w),
                  Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          Scaffold.of(context).openEndDrawer();
                        });
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
                  //IconButton
                ], //
              ),
              body: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Visibility(
                        visible: loading == false,
                        child: Padding(
                          padding: EdgeInsets.only(left: 2.5.w),
                          child: Text(
                              "Showing out ${myProductList.length} of $count products",
                              style: zzBoldBlackTextStyle13),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(child: buildPostsView()),
                  Visibility(
                    visible: true,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                          color: loginBlue),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 10.0, bottom: 10.0),
                      //color: lightBlue,
                      width: 100.w,
                      height: 8.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (() {
                              sortByWidget();
                            }),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.asset(
                                  "assets/images/updown_arrow.png",
                                  width: 20.0,
                                  height: 20.0,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Sort By", style: fontMethod(context)),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const VerticalDivider(
                            color: white,
                            thickness: 1,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              String aProductType =
                                  myProductList[0].productType!;
                              print(aProductType);
                              if (aProductType == "Frame") {
                                if (widget.myCollectionId == 411228373236) {
                                  Get.off(() => ProductFilter(
                                        myCollectionId: widget.myCollectionId,
                                        brandList: FilterModel.sunBrand,
                                        materialList: FilterModel.sunMaterial,
                                        productTypeList: FilterModel.eyeProduct,
                                        shapeList: FilterModel.sunShape,
                                        styleList: FilterModel.sunStyle,
                                        colorList: FilterModel.sunColor,
                                        gender: FilterModel.eyeGender,
                                        endPrice: "16090",
                                        navigationTrailRequset: false,
                                      ));
                                } else {
                                  Get.off(() => ProductFilter(
                                        myCollectionId: widget.myCollectionId,
                                        brandList: FilterModel.eyeBrand,
                                        materialList: FilterModel.eyeMaterial,
                                        productTypeList: FilterModel.eyeProduct,
                                        shapeList: FilterModel.eyeShape,
                                        styleList: FilterModel.eyeStyle,
                                        colorList: FilterModel.eyeColor,
                                        gender: FilterModel.eyeGender,
                                        endPrice: "789900",
                                        navigationTrailRequset: false,
                                      ));
                                }
                              } else if (aProductType == "Audiology") {
                                Get.off(() => ProductFilter(
                                      myCollectionId: widget.myCollectionId,
                                      brandList: FilterModel.earBrand,
                                      materialList: [],
                                      productTypeList: FilterModel.earProduct,
                                      shapeList: [],
                                      styleList: [],
                                      colorList: [],
                                      gender: [],
                                      endPrice: "18490",
                                      navigationTrailRequset: false,
                                    ));
                              } else if (aProductType == "Oral Care") {
                                Get.off(() => ProductFilter(
                                      myCollectionId: widget.myCollectionId,
                                      brandList: FilterModel.oralBrand,
                                      materialList: [],
                                      productTypeList: FilterModel.oralProduct,
                                      shapeList: [],
                                      styleList: [],
                                      colorList: [],
                                      gender: [],
                                      endPrice: "3999",
                                      navigationTrailRequset: false,
                                    ));
                              } else if (aProductType == "Skin Care" ||
                                  aProductType == "Laser Hair Reduction" ||
                                  aProductType == "Hydra Facial" ||
                                  aProductType == "RF Skin Rejuvenation" ||
                                  aProductType == "Face Care") {
                                Get.to(() => ProductFilter(
                                      myCollectionId: widget.myCollectionId,
                                      brandList: FilterModel.skinBrand,
                                      materialList: [],
                                      productTypeList: FilterModel.skinProduct,
                                      shapeList: [],
                                      styleList: [],
                                      colorList: [],
                                      gender: [],
                                      endPrice: "499",
                                      navigationTrailRequset: false,
                                    ));
                              } else {
                                Get.to(() => ProductFilter(
                                      myCollectionId: widget.myCollectionId,
                                      brandList: [],
                                      materialList: [],
                                      productTypeList: FilterModel.sleepProduct,
                                      shapeList: [],
                                      styleList: [],
                                      colorList: [],
                                      gender: [],
                                      endPrice: "152000",
                                      navigationTrailRequset: false,
                                    ));
                              }
                            },
                            child: Row(children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Image.asset(
                                "assets/images/filter.png",
                                width: 20.0,
                                height: 20.0,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("Filter", style: fontMethod(context)),
                              const SizedBox(
                                width: 20,
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }

  Future<Future<ProductModel>> refresh(bool reload) async {
    Completer<ProductModel> completer = Completer<ProductModel>();
    Timer(const Duration(seconds: 1), () {
      if (completer != null) {
        completer.complete();
      }
    });
    return completer.future;
  }

  Widget buildPostsView() {
    if (myProductList.isEmpty) {
      if (loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Center(child: Image.asset("assets/images/no_records_found.png"));
      }
    } else {
      return RefreshIndicator(
          // key: refreshIndicatorKey,
          onRefresh: () async => setState(() async => await refresh(true)),
          color: loginTextColor,
          strokeWidth: 3,
          edgeOffset: 10.0,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          child: GridView.builder(
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 0.0,
                //childAspectRatio: isColor.isNotEmpty ? 2/3.5 : 2/3,
                childAspectRatio: 2.2 / 3.6,
              ),
              controller: _controller,
              itemCount: myProductList.length,
              itemBuilder: (BuildContext context, int index) {
                var model = myProductList[index];
                String aImage =
                    model.image!.isNotEmpty ? model.image!['src'] : "";
                return InkWell(
                  onTap: () {
                    setState(() {
                      String aProductType = model.productType!;
                      if (aProductType == "Audiology") {
                        Get.to(() => EarDetailScreen(id: model.id));
                      } else if (aProductType == "Frame") {
                        Get.to(() => EyeDetailsScreen(
                              id: model.id!,
                              toCart: widget.toCart,
                              productHandle: "",
                            ));
                      } else if (aProductType == "Oral Care") {
                        Get.to(() => OralDetailScreen(id: model.id!));
                      } else if (aProductType == "Skin Care" ||
                          aProductType == "Laser Hair Reduction" ||
                          aProductType == "Hydra Facial" ||
                          aProductType == "RF Skin Rejuvenation") {
                        Get.to(() => SkinDetailScreen(id: model.id!));
                      } else {
                        print(aProductType);
                        Get.to(() => SleepDetailScreen(id: model.id!));
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Visibility(
                              visible: !model.available,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  color: Colors.black,
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(' Sold Out ',
                                      textAlign: TextAlign.center,
                                      style: zzBoldBlueDarkTextStyle10A1),
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (model.wishlistIconColor == Colors.red) {
                                    model.wishlistIconColor = Colors.black;
                                    removeFromWishlist(model.id!);
                                  } else {
                                    model.wishlistIconColor = Colors.red;
                                    addToWishlist(model.id!);
                                  }
                                });
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: model.wishlistIconColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: aImage,
                            height: 120.0,
                            width: 120.0,
                            fit: BoxFit.contain,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress)),
                            errorWidget: (context, url, error) => Center(
                                child: Image.asset(
                              "assets/images/no_image.gif",
                              height: 350,
                            )),
                          ),
                        ),
                        // Container(
                        //   width: 28.0.w,
                        //   height: 4.0.h,
                        //   padding: const EdgeInsets.all(2.0),
                        //   margin: const EdgeInsets.only(left: 12.0),
                        //   decoration: BoxDecoration(
                        //     color: loginBlue,
                        //     borderRadius: BorderRadius.circular(20.0),
                        //   ),
                        //   child: IntrinsicHeight(
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         SizedBox(
                        //           width: 2.0.w,
                        //         ),
                        //         const Icon(
                        //           Icons.star,
                        //           color: ratingColor,
                        //           size: 15,
                        //         ),
                        //         SizedBox(
                        //           width: 1.0.w,
                        //         ),
                        //         Text(
                        //           "4.5",
                        //           // style: zzBoldBlackTextStyle11,
                        //           style: fontMethod(context),
                        //         ),
                        //         SizedBox(
                        //           width: 1.0.w,
                        //         ),
                        //         const VerticalDivider(
                        //           color: white,
                        //           thickness: 1,
                        //         ),
                        //         SizedBox(
                        //           width: 1.0.w,
                        //         ),
                        //         Text(
                        //           "12",
                        //           //style: zzRegularBlackTextStyle10,
                        //           style: fontMethod(context),
                        //         ),
                        //         SizedBox(
                        //           width: 1.5.w,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 1.0.h,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "${model.title}",
                            style: fontMethod(context),
                            overflow: TextOverflow.ellipsis,
                            // softWrap:false,
                            maxLines: 3,
                          ),
                        ),

                        model.productType == "Laser Hair Reduction" ||
                                model.productType == "Hydra Facial" ||
                                model.productType == "RF Skin Rejuvenation"
                            ? Container(
                                color: Colors.red,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Sale ${calculateDiscountPercentage(model.variantsList![0]['compare_at_price'].toString(), model.variantsList![0]['price'].toString())}%",
                                  textAlign: TextAlign.center,
                                  style: zzBoldBlueDarkTextStyle10A1,
                                ),
                              )
                            : const SizedBox(),
                        model.productType == "Nasal"
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    model.variantsList![0]['title'] == 'Rent'
                                        ? Text(
                                            "Rent: ₹${model.variantsList![0]['price']}/M",
                                            style: fontMethod(context),
                                          )
                                        : Text(
                                            "₹${model.variantsList![0]['price']}",
                                            style: fontMethod(context),
                                          ),
                                    if (model.variantsList!.length > 1)
                                      const SizedBox(width: 10),
                                    if (model.variantsList!.any((variant) =>
                                        variant['title'] == 'Sale'))
                                      Text(
                                        "Sale: ₹${model.variantsList!.firstWhere((variant) => variant['title'] == 'Sale')['price']}",
                                        style: fontMethod(context),
                                      ),
                                  ],
                                ))
                            : Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "₹${model.variantsList![0]['price']}",
                                      //  style: zzRegularBlackTextStyle10,
                                      style: fontMethod(context),
                                    ),
                                    SizedBox(
                                      width: 1.0.w,
                                    ),
                                    Visibility(
                                      visible: model.variantsList![0]
                                                  ['compare_at_price']
                                              .toString() !=
                                          "null",
                                      child: Text(
                                        '₹${model.variantsList![0]['compare_at_price']}',
                                        // style: zzRegularBlackTextStyle10_,
                                        style: fontMethod2(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                      ],
                    ),
                  ),
                );
              }));
    }
  }

  void getSortList() {
    setState(() {
      // myProductList = [];
      sortAll = "";
      nextPageCursor = null;

      if (RadioValue == 'HIGH') {
        if (widget.fromFilter == "F") {
          myProductList.sort((a, b) {
            double f = double.parse(a.variantsList![0]['price']);
            double s = double.parse(b.variantsList![0]['price']);
            return s.compareTo(f);
          });
        } else {
          pageItemCount = 0;
          myProductList = [];
          getPriceProductList(true);
        }
      } else if (RadioValue == 'LOW') {
        if (widget.fromFilter == "F") {
          myProductList.sort((a, b) {
            double f = double.parse(a.variantsList![0]['price']);
            double s = double.parse(b.variantsList![0]['price']);
            return f.compareTo(s);
          });
        } else {
          pageItemCount = 0;
          myProductList = [];
          getPriceProductList(false);
        }
      } else if (RadioValue == 'MOST') {
        if (widget.fromFilter == "F") {
          myProductList.sort((a, b) {
            DateTime f = DateTime.tryParse(a.createdAt ?? '') ?? DateTime.now();
            DateTime s = DateTime.tryParse(b.createdAt ?? '') ?? DateTime.now();
            return s.compareTo(f);
          });
        } else {
          pageItemCount = 0;
          myProductList = [];
          getNewArrivalsList();
        }
      } else if (RadioValue == 'BEST') {
        if (widget.fromFilter == "F") {
          myProductList.sort((a, b) {
            DateTime f = DateTime.tryParse(a.createdAt ?? '') ?? DateTime.now();
            DateTime s = DateTime.tryParse(b.createdAt ?? '') ?? DateTime.now();
            return s.compareTo(f);
          });
        } else {
          pageItemCount = 0;
          myProductList = [];
          getNewArrivalsList();
        }
      } else if (RadioValue == 'NEW') {
        if (widget.fromFilter == "F") {
          myProductList.sort((a, b) {
            DateTime f = DateTime.tryParse(a.createdAt ?? '') ?? DateTime.now();
            DateTime s = DateTime.tryParse(b.createdAt ?? '') ?? DateTime.now();
            return s.compareTo(f);
          });
        } else {
          pageItemCount = 0;
          myProductList = [];
          getNewArrivalsList();
        }
      } else if (RadioValue == 'ALL') {
        // pageItemCount = 10;
        getProductList();
        getProductListCount();
        sortAll = "ALL";
      }
    });
  }

  Future sortByWidget() {
    return showDialog(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                backgroundColor: loginBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.all(14),
                actionsPadding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                actions: <Widget>[
                  Container(
                    // margin: EdgeInsets.all(20),
                    width: 100.0.w,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Sort by'),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.of(context).pop();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SvgPicture.asset(
                                  "assets/svg/close_circle_white.svg",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('All'),
                            Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                  value: "ALL",
                                  groupValue: RadioValue,
                                  hoverColor: loginTextColor,
                                  //focusColor: loginTextColor,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => loginTextColor),
                                  onChanged: (value) {
                                    setState(() {
                                      RadioValue = value.toString();
                                    });
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Bestseller'),
                            Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                  value: "BEST",
                                  groupValue: RadioValue,
                                  hoverColor: loginTextColor,
                                  //focusColor: loginTextColor,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => loginTextColor),
                                  onChanged: (value) {
                                    setState(() {
                                      RadioValue = value.toString();
                                    });
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('New arrival'),
                            Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                  value: "NEW",
                                  groupValue: RadioValue,
                                  hoverColor: loginTextColor,
                                  //focusColor: loginTextColor,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => loginTextColor),
                                  onChanged: (value) {
                                    setState(() {
                                      RadioValue = value.toString();
                                    });
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Most viewed'),
                            Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                  value: "MOST",
                                  groupValue: RadioValue,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => loginTextColor),
                                  activeColor: loginTextColor,
                                  onChanged: (value) {
                                    setState(() {
                                      RadioValue = value.toString();
                                    });
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Price - Low to High'),
                            Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                  value: "LOW",
                                  groupValue: RadioValue,
                                  hoverColor: loginTextColor,
                                  //focusColor: loginTextColor,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => loginTextColor),
                                  onChanged: (value) {
                                    setState(() {
                                      RadioValue = value.toString();
                                    });
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Price - High to Low'),
                            Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                  value: "HIGH",
                                  groupValue: RadioValue,
                                  hoverColor: loginTextColor,
                                  //focusColor: loginTextColor,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => loginTextColor),
                                  onChanged: (value) {
                                    setState(() {
                                      RadioValue = value.toString();
                                    });
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () {
                              if (list.isEmpty) {
                                getSortList();
                              } else {
                                // getSearchSortList();
                              }
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: loginTextColor),
                            child: const Text(
                              'Apply',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        });
  }
}
