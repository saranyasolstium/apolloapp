import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infinite/model/review_model.dart';

class RemoteServices {
  static var client = http.Client();
  static String url = 'https://eaglecrm.solstium.net/api/';

//add review
  Future<http.Response> addReview({
    required int customerId,
    required int productId,
    required String email,
    required String name,
    required String rating,
    required String review,
  }) async {
    final Map<String, String> headers = {
      'Token': 'Apollo12345',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "customer_id": customerId,
      "product_id": productId,
      "email": email,
      "name": name,
      "rating": rating,
      "review": review,
    };

    final response = await http.post(
      Uri.parse('${url}createReview'),
      headers: headers,
      body: json.encode(body),
    );

    print(response.body);

    return response;
  }

  Future<List<Review>> fetchReview(int? productId) async {
    final Map<String, String> headers = {
      'Token': 'Apollo12345',
      'Content-Type': 'application/json',
    };

    print('${url}fetchReviews?product_id=$productId');
    final response = await http.get(
      Uri.parse('${url}fetchReviews?product_id=$productId'),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data'];
      final List<Review> reviews =
          data.map((item) => Review.fromJson(item)).toList();
      return reviews;
    } else {
      throw Exception('Failed to load review');
    }
  }

  Future<http.Response> createWishlist({
    required int customerId,
    required int productId,
  }) async {
    final Map<String, String> headers = {
      'Token': 'Apollo12345',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "customer_id": customerId,
      "product_id": productId,
    };
    print(body);

    final response = await http.post(
      Uri.parse('${url}createWishlist'),
      headers: headers,
      body: json.encode(body),
    );

    print(response.body);

    return response;
  }

  Future<http.Response> updateWishlist({
    required int customerId,
    required int productId,
  }) async {
    final Map<String, String> headers = {
      'Token': 'Apollo12345',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "customer_id": customerId,
      "product_id": productId,
    };
    print(body);

    final response = await http.post(
      Uri.parse('${url}updateWishlist'),
      headers: headers,
      body: json.encode(body),
    );

    print(response.body);

    return response;
  }

  Future<List<String>> fetchWishlists(int? customerId) async {
    final Map<String, String> headers = {
      'Token': 'Apollo12345',
      'Content-Type': 'application/json',
    };

    print('${url}fetchWishlists?customer_id=$customerId');
    final response = await http.get(
      Uri.parse('${url}fetchWishlists?customer_id=$customerId'),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data'];

      // Extracting product IDs
      final List<String> productIds =
          data.map((item) => item['product_id'].toString()).toList();

      return productIds;
    } else {
      throw Exception('Failed to load review');
    }
  }

  Future<http.Response> fetchProductAvgRating(int? productId) async {
    final Map<String, String> headers = {
      'Token': 'Apollo12345',
      'Content-Type': 'application/json',
    };

    print('${url}fetchProductAvgRating?product_id=$productId');

    final response = await http.get(
      Uri.parse('${url}fetchProductAvgRating?product_id=$productId'),
      headers: headers,
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load review');
    }
  }

  Future<http.Response> fetchAvgRating(
      int? collectionId, int? customerId) async {
    final Map<String, String> headers = {
      'Token': 'Apollo12345',
      'Content-Type': 'application/json',
    };

    print(
        '${url}fetchAvgRating?collection_id=$collectionId&customer_id=$customerId');

    final response = await http.get(
      Uri.parse(
          '${url}fetchAvgRating?collection_id=$collectionId&customer_id=$customerId'),
      headers: headers,
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load review');
    }
  }

  Future<http.Response> productFilter(
      {required int collectionId,
      required int minPrice,
      required int maxPrice,
      required List<String> brand,
      required List<String> material,
      required List<String> shape,
      required List<String> style,
      required List<String> color,
      required List<String> gender,
      required List<String> productType,
      required List<String> availability}) async {
    final Map<String, String> headers = {
      'Token': 'Apollo12345',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "collection_id": collectionId.toString(),
      "min_price": minPrice.toString(),
      "max_price": maxPrice.toString(),
      "sort_order": "ASC",
      "brand": jsonEncode(brand),
      "material": jsonEncode(material),
      "shape": jsonEncode(shape),
      "style": jsonEncode(style),
      "color": jsonEncode(color),
      "gender": jsonEncode(gender),
      "product_type": jsonEncode(productType),
      "inventory_quantity":jsonEncode(availability),
    };

    print('Request Body: $requestBody');

    final response = await http.post(
      Uri.parse('${url}Productfilter'),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    print('saranya987: ${response.body}');

    return response;
  }
}
