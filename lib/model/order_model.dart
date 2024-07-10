import 'package:infinite/utils/global.dart';

class OrderModel {
  int? id;
  String? currency;
  String? currentSubTotalPrice;
  String? currentTotalDiscounts;
  String? currentTotalPrice;
  String? currentTotalTax;
  String? financialStatus;
  String? orderName;
  String? processedAt;
  String? processedMethod;
  String? totalLineItemPrice;
  String? updatedAt;
  List<LineItemModel>? lineItemList;

  OrderModel({
    this.id,
    this.currency,
    this.currentSubTotalPrice,
    this.currentTotalDiscounts,
    this.currentTotalPrice,
    this.currentTotalTax,
    this.financialStatus,
    this.orderName,
    this.processedAt,
    this.processedMethod,
    this.totalLineItemPrice,
    this.updatedAt,
    this.lineItemList,
  });

  double getTotalAmount() {
    double totalAmount = 0.0;
    if (lineItemList != null) {
      for (var lineItem in lineItemList!) {
        if (lineItem.price != null) {
          totalAmount += double.parse(lineItem.price!);
        }
      }
    }
    return totalAmount;
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    int aId = json['id'] ?? 0;
    String aCurrency = json['currency'] ?? '';
    String aCurrentSubTotalPrice = json['current_subtotal_price'] ?? '';
    String aCurrentTotalDiscounts = json['current_subtotal_price'] ?? '';
    String aCurrentTotalPrice = json['current_total_price'] ?? '';
    String aCurrentTotalTax = json['current_total_tax'] ?? '';
    String aFinancialStatus = json['financial_status'] ?? '';
    String aOrderName = json['name'] ?? '';
    String aProcessedAt = json['processed_at'].toString().isEmpty
        ? ''
        : myDefaultTimeFormatForOrderTwo
            .format(myDefaultTimeFormatForOrder
                .parse(json['processed_at'].toString()))
            .toString();
    String aProcessedMethod = json['processing_method'] ?? '';
    String aTotalLineItemPrice = json['total_line_items_price'] ?? '';
    String aUpdatedAt = json['updated_at'] ?? '';

    var itemList = json['line_items'] as List;
    List<LineItemModel> aLineItemList = [];
    if (itemList.isNotEmpty || itemList != null) {
      aLineItemList =
          itemList.map((json) => LineItemModel.fromJson(json)).toList();
    } else {
      aLineItemList = [];
    }

    return OrderModel(
        id: aId,
        currency: aCurrency,
        currentSubTotalPrice: aCurrentSubTotalPrice,
        currentTotalDiscounts: aCurrentTotalDiscounts,
        currentTotalPrice: aCurrentTotalPrice,
        currentTotalTax: aCurrentTotalTax,
        financialStatus: aFinancialStatus,
        orderName: aOrderName,
        processedAt: aProcessedAt,
        processedMethod: aProcessedMethod,
        totalLineItemPrice: aTotalLineItemPrice,
        updatedAt: aUpdatedAt,
        lineItemList: aLineItemList);
  }
}

class LineItemModel {
  int? id;
  String? adminGraphqlApiId;
  int? fulfillableQuantity;
  String? fulfillmentService;
  String? fulfillmentStatus;
  bool? giftCard;
  int? grams;
  String? name;
  OriginLocation? originLocation;
  String? price;
  PriceSet? priceSet;
  bool? productExists;
  int? productId;
  int? quantity;
  bool? requiresShipping;
  String? sku;
  bool? taxable;
  String? title;
  String? totalDiscount;
  PriceSet? totalDiscountSet;
  int? variantId;
  String? variantInventoryManagement;
  String? variantTitle;
  String? vendor;
  String? imageUrl;
  String? productType;
  String? productName;
  List<Properties>? properties;

  LineItemModel(
      {this.id,
      this.adminGraphqlApiId,
      this.fulfillableQuantity,
      this.fulfillmentService,
      this.fulfillmentStatus,
      this.giftCard,
      this.grams,
      this.name,
      this.originLocation,
      this.price,
      this.priceSet,
      this.productExists,
      this.productId,
      this.properties,
      this.quantity,
      this.requiresShipping,
      this.sku,
      this.taxable,
      this.title,
      this.totalDiscount,
      this.totalDiscountSet,
      this.variantId,
      this.variantInventoryManagement,
      this.variantTitle,
      this.vendor,
      this.imageUrl,
      this.productType});

  LineItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminGraphqlApiId = json['admin_graphql_api_id'] ?? '';
    fulfillableQuantity = json['fulfillable_quantity'] ?? 0;
    fulfillmentService = json['fulfillment_service'] ?? '';
    fulfillmentStatus = json['fulfillment_status'] ?? 'Unfulfilled';
    giftCard = json['gift_card'] ?? false;
    grams = json['grams'] ?? 0;
    name = json['name'] ?? '';
    originLocation = json['origin_location'] != null
        ? OriginLocation.fromJson(json['origin_location'])
        : null;
    price = json['price'] ?? '';
    priceSet =
        json['price_set'] != null ? PriceSet.fromJson(json['price_set']) : null;
    productExists = json['product_exists'] ?? false;
    productId = json['product_id'] ?? 0;
    print('havish');
    print(productId);
   
    quantity = json['quantity'] ?? 0;
    requiresShipping = json['requires_shipping'] ?? false;
    sku = json['sku'] ?? '';
    taxable = json['taxable'] ?? false;
    title = json['title'] ?? '';
    totalDiscount = json['total_discount'] ?? '';
    totalDiscountSet = json['total_discount_set'] != null
        ? PriceSet.fromJson(json['total_discount_set'])
        : null;
    variantId = json['variant_id'] ?? 0;
    variantInventoryManagement = json['variant_inventory_management'] ?? '';
    variantTitle = json['variant_title'] ?? '';
    vendor = json['vendor'] ?? '';

    if (json['properties'] != null) {
      properties = List<Properties>.from(
          json['properties'].map((x) => Properties.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    data['fulfillable_quantity'] = fulfillableQuantity;
    data['fulfillment_service'] = fulfillmentService;
    data['fulfillment_status'] = fulfillmentStatus;
    data['gift_card'] = giftCard;
    data['grams'] = grams;
    data['name'] = name;
    if (originLocation != null) {
      data['origin_location'] = originLocation!.toJson();
    }
    data['price'] = price;
    if (priceSet != null) {
      data['price_set'] = priceSet!.toJson();
    }
    data['product_exists'] = productExists;
    data['product_id'] = productId;
   
    data['quantity'] = quantity;
    data['requires_shipping'] = requiresShipping;
    data['sku'] = sku;
    data['taxable'] = taxable;
    data['title'] = title;
    data['total_discount'] = totalDiscount;
    if (totalDiscountSet != null) {
      data['total_discount_set'] = totalDiscountSet!.toJson();
    }
    data['variant_id'] = variantId;
    data['variant_inventory_management'] = variantInventoryManagement;
    data['variant_title'] = variantTitle;
    data['vendor'] = vendor;
    if (properties != null) {
      data['properties'] =
          properties!.map((property) => property.toJson()).toList();
    }

    return data;
  }
}

class Properties {
  String? name;
  String? value;

  Properties({this.name, this.value});

  Properties.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class OriginLocation {
  int? id;
  String? countryCode;
  String? provinceCode;
  String? name;
  String? address1;
  String? address2;
  String? city;
  String? zip;

  OriginLocation(
      {this.id,
      this.countryCode,
      this.provinceCode,
      this.name,
      this.address1,
      this.address2,
      this.city,
      this.zip});

  OriginLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCode = json['country_code'] ?? '';
    provinceCode = json['province_code'] ?? '';
    name = json['name'] ?? '';
    address1 = json['address1'] ?? '';
    address2 = json['address2'] ?? '';
    city = json['city'] ?? '';
    zip = json['zip'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_code'] = countryCode;
    data['province_code'] = provinceCode;
    data['name'] = name;
    data['address1'] = address1;
    data['address2'] = address2;
    data['city'] = city;
    data['zip'] = zip;
    return data;
  }
}

class PriceSet {
  ShopMoney? shopMoney;
  ShopMoney? presentmentMoney;

  PriceSet({this.shopMoney, this.presentmentMoney});

  PriceSet.fromJson(Map<String, dynamic> json) {
    shopMoney = json['shop_money'] != null
        ? ShopMoney.fromJson(json['shop_money'])
        : null;
    presentmentMoney = json['presentment_money'] != null
        ? ShopMoney.fromJson(json['presentment_money'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shopMoney != null) {
      data['shop_money'] = shopMoney!.toJson();
    }
    if (presentmentMoney != null) {
      data['presentment_money'] = presentmentMoney!.toJson();
    }
    return data;
  }
}

class ShopMoney {
  String? amount;
  String? currencyCode;

  ShopMoney({this.amount, this.currencyCode});

  ShopMoney.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] ?? '';
    currencyCode = json['currency_code'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['currency_code'] = currencyCode;
    return data;
  }
}


