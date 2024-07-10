import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite/model/product_model.dart';
import 'package:infinite/services/network/dio_exception.dart';

import '../../model/address_model.dart';
import '../../model/order_model.dart';
import 'endpoints.dart';

class DioClient {
  static late Dio dio;
  static late Dio dioFormData;
  String myUrl;
  Map<String, dynamic>? myMap;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: EndPoints.baseUrl,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: 'application/json; charset=UTF-8',
          },
          responseType: ResponseType.json),
    )..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));

    dioFormData = Dio(
      BaseOptions(
          baseUrl: EndPoints.baseUrl,
          headers: {
            HttpHeaders.contentTypeHeader: "multipart/form-data",
            HttpHeaders.acceptHeader: 'application/json; charset=UTF-8',
          },
          responseType: ResponseType.json),
    )..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
  }

  DioClient({required this.myUrl, this.myMap});

  // POST WITH TOKEN
  Future<Response> post() async {
    try {
      final Response response = await dio.post(myUrl,
          data: myMap,
          options: Options(headers: {
            "X-Shopify-Access-Token": EndPoints.accessToken,
          }));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      } else {
        final Response response = e.response!;
        return response;
      }
    }
  }

  Future<Response> post2() async {
    try {
      final Response response = await dio.post(myUrl,
          data: myMap,
          options: Options(headers: {
            "Token": EndPoints.aToken,
          }));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      } else {
        final Response response = e.response!;
        return response;
      }
    }
  }

  Future<Response> loginPost() async {
    try {
      final Response response = await dio.post(myUrl,
          data: myMap,
          options: Options(headers: {
            "X-Shopify-Storefront-Access-Token": EndPoints.aLoginToken,
          }));
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      } else {
        final Response response = e.response!;
        return response;
      }
    }
  }

  Future<Response> doctorPost() async {
    try {
      final Response response = await dio.post(myUrl,
          data: myMap,
          options: Options(headers: {
            "Token": "Apollo12345",
          }));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      } else {
        final Response response = e.response!;
        return response;
      }
    }
  }

  // PUT WITH TOKEN
  Future<Response> update() async {
    try {
      final Response response = await dio.put(myUrl,
          data: myMap,
          options: Options(headers: {
            "X-Shopify-Access-Token": EndPoints.accessToken,
          }));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      } else {
        final Response response = e.response!;
        return response;
      }
    }
  }

  // POST WITH TOKEN FORM DATA
  static Future<Response> postFormData(String url, FormData data) async {
    try {
      final Response response = await dioFormData.post(url,
          data: data,
          options: Options(headers: {
            "accept": "*/*",
            "X-Shopify-Access-Token": EndPoints.accessToken,
          }));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      } else if (e.response?.statusCode == 442) {
        final Response response = e.response!;
        return response;
      }
      final Response response = e.response!;
      return response;
    }
  }

  // POST FOR RAZOR PAYMENT
  Future<Response> postForPayment() async {
    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('${EndPoints.myRazorpayKey}:${EndPoints.myRazorpaySecret}'))}';
      final Response response = await dio.post(myUrl,
          data: myMap,
          options: Options(headers: {
            "Authorization": basicAuth,
          }));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      } else {
        final Response response = e.response!;
        return response;
      }
    }
  }

  // GET FOR RAZOR PAYMENT
  Future<Response> getForPayment() async {
    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('${EndPoints.myRazorpayKey}:${EndPoints.myRazorpaySecret}'))}';
      final Response response = await dio.get(myUrl,
          options: Options(headers: {
            "Authorization": basicAuth,
          }));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      } else {
        final Response response = e.response!;
        return response;
      }
    }
  }

  // POST
  Future<Response> postWithoutToken() async {
    try {
      final Response response = await dio.post(
        myUrl,
        data: myMap,
      );
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 422) {
          final Response response = e.response!;
          return response;
        } else if (e.response?.statusCode == 403) {
          final Response response = e.response!;
          return response;
        } else if (e.response?.statusCode == 404) {
          final Response response = e.response!;
          return response;
        } else {
          final Response response = e.response!;
          return response;
        }
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint('SHOW POST RESPONSE DATA ERROR STATUS: $errorMessage');
      throw errorMessage;
    }
  }

  // GET WITH TOKEN
  Future<Response> getDetails() async {
    try {
      final Response response = await dio.get(myUrl,
          options: Options(headers: {
            "X-Shopify-Access-Token": EndPoints.accessToken,
          }));
      print(myUrl);
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      } else {
        final Response response = e.response!;
        return response;
      }
    }
  }

  // DOWNLOAD A FILE FROM URL
  static Future<Response> downloadFileFromCloud(
      String fileUrl, File file) async {
    try {
      final Response response = await dio.download(fileUrl, file.path,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          debugPrint(
              'SHOW SAMPLE DOCUMENT DOWNLOAD: ${"${(received / total * 100).toStringAsFixed(0)}%"}');
        }
      },
          deleteOnError: true,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  // DELETE
  Future<Response> deleteDetails() async {
    try {
      final Response response = await dio.delete(myUrl,
          options: Options(headers: {
            "X-Shopify-Access-Token": EndPoints.accessToken,
          }));

      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      debugPrint('SHOW DIO CLIENT RESPONSE DELETE ERROR: $errorMessage');
      final Response response = e.response!;
      return response;
    }
  }

  // GET PRODUCT LIST
  Future<List<ProductModel>> getProductList() async {
    List<ProductModel> list = [];
    try {
      print('Havish');
      print(myUrl);
      final Response response = await dio.get(myUrl,
          options: Options(headers: {
            "X-Shopify-Access-Token": EndPoints.accessToken,
          }));
      var data = response.data['products'] as List;
      list = data.map((json) => ProductModel.fromJson(json)).toList();
      return list;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        return list = [];
      } else if (e.response?.statusCode == 500) {
        return list = [];
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<AddressModel>> getAddressList() async {
    List<AddressModel> list = [];
    try {
      final Response response = await dio.get(myUrl,
          options: Options(headers: {
            "X-Shopify-Access-Token": EndPoints.accessToken,
          }));
      var data = response.data['addresses'] as List;
      list = data.map((json) => AddressModel.fromJson(json)).toList();

      return list;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        return list = [];
      } else if (e.response?.statusCode == 500) {
        return list = [];
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response> getFilterDetail() async {
    try {
      final Response response = await dio.get(myUrl,
          options: Options(headers: {
            "Token": EndPoints.aToken,
          }));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        final Response response = e.response!;
        return response;
      } else {
        final Response response = e.response!;
        return response;
      }
    }
  }

  Future<List<OrderModel>> getOrderList() async {
    List<OrderModel> list = [];
    try {
      final Response response = await dio.get(myUrl,
          options: Options(headers: {
            "X-Shopify-Access-Token": EndPoints.accessToken,
          }));
      print(response.data);
      var data = response.data['orders'] as List;
      list = data.map((json) => OrderModel.fromJson(json)).toList();

      return list;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        return list = [];
      } else if (e.response?.statusCode == 500) {
        return list = [];
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  // checking if user exist or not
  static Future<bool> userExist() async {
    return (await EndPoints.firestore
            .collection('users')
            .doc(EndPoints.user.uid)
            .get())
        .exists;
  }

  // for creating a new user
  // static Future<void> createUser() async {
  //   // final time = DateTime.now().millisecondsSinceEpoch.toString();
  //   // final chatuser = ChatUser(
  //   //     name: EndPoints.user.displayName.toString(),
  //   //     about: "Hey I am using We Chat",
  //   //     image: EndPoints.user.photoURL.toString(),
  //   //     create: time,
  //   //     id: EndPoints.user.uid,
  //   //     lastActive: time,
  //   //     email: EndPoints.user.email.toString(),
  //   //     pushToken: '',
  //   //     isOnline: false);
  //   return await EndPoints.firestore
  //       .collection('users')
  //       .doc(EndPoints.user.uid)
  //       .set(chatuser.toJson());
  // }
}
