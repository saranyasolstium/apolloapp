import 'package:flutter/material.dart';

class ProductModel {
  int? id;
  String? title;
  String? productType;
  String? handle;
  String? templateSuffix;
  String? publishedScope;
  List<Map<String, dynamic>>? variantsList;
  List<Map<String, dynamic>>? optionsList;
  List<Map<String, dynamic>>? imagesList;
  Map<String, dynamic>? image;
  String? createdAt;
  List<Map<String, dynamic>> variantColorList = [];
  String? bodyHtml;
  String? tags;
  double price;
  Color wishlistIconColor;
  bool available; // Add available property

  ProductModel({
    this.id,
    this.title,
    this.productType,
    this.handle,
    this.templateSuffix,
    this.publishedScope,
    this.variantsList,
    this.optionsList,
    this.imagesList,
    this.image,
    this.createdAt,
    required this.variantColorList,
    this.bodyHtml,
    this.tags,
    required this.price,
    this.available = false, // Initialize available to false by default
  }) : wishlistIconColor = Colors.black;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    int aId = json['id'] ?? 0;
    String aTitle = json['title'] ?? '';
    String bodyHtml = json['body_html'] ?? '';
    String aCreatedAt = json['created_at'] ?? '';
    String aProductType = json['product_type'] ?? '';
    String aHandle = json['handle'] ?? '';
    String aTemplateSuffix = json['template_suffix'] ?? '';
    String aPublishedScope = json['published_scope'] ?? '';

    List<Map<String, dynamic>> variantsList = [];
    var aVariantsData = json['variants'] as List;
    for (var variant in aVariantsData) {
      variantsList.add(variant);
    }

    List<Map<String, dynamic>> optionsList = [];
    List<Map<String, dynamic>> variantColorList = [];
    var aOptionsData = json['options'] as List;
    for (var option in aOptionsData) {
      optionsList.add(option);
      String aName = option['name'] ?? '';
      if (aName.toLowerCase() == "color") {
        var aColorData = option['values'] as List;
        for (int a = 0; a < aColorData.length; a++) {
          var map = <String, dynamic>{};
          map['color'] = aColorData[a];
          map['index'] = a == 0 ? 0 : -1;
          map['product_id'] = aId;
          variantColorList.add(map);
        }
      }
    }
    if (variantColorList.isEmpty) {
      var map = <String, dynamic>{};
      map['color'] = "Default Title";
      map['index'] = 0;
      map['product_id'] = aId;
      variantColorList.add(map);
    }

    List<Map<String, dynamic>> imagesList = [];
    var aImagesData = json['images'] as List;
    for (var image in aImagesData) {
      imagesList.add(image);
    }

    Map<String, dynamic> image = json['image'] ?? <String, dynamic>{};
    String aTags = json['tags'] ?? '';
    print(json['variants'][0]['price']);
    double price = json['variants'][0]['price'] != null
        ? double.parse(json['variants'][0]['price'].toString())
        : 0.0;
    print(price);
    bool available = false;
    var aVariants = json['variants'] as List;
    for (var variant in aVariants) {
      int inventoryQuantity = variant['inventory_quantity'] ?? 0;

      if (inventoryQuantity > 0) {
        available = true;

        break;
      }
          print(available);

    }
    return ProductModel(
      id: aId,
      title: aTitle,
      productType: aProductType,
      handle: aHandle,
      templateSuffix: aTemplateSuffix,
      publishedScope: aPublishedScope,
      variantsList: variantsList,
      optionsList: optionsList,
      imagesList: imagesList,
      image: image,
      createdAt: aCreatedAt,
      variantColorList: variantColorList,
      bodyHtml: bodyHtml,
      tags: aTags,
      price: price,
      available: available,
    );
  }
}
