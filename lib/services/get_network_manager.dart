
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite/res/styles.dart';
import 'package:infinite/res/texts.dart';

class GetXNetworkManager extends GetxController {
  static GetXNetworkManager to = Get.find();
  int connectionType = 0;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectionType() async {
    dynamic connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on Exception catch (e) {
      debugPrint('$e');
    }
    return _updateState(connectivityResult);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1;
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
        update();
        break;
      case ConnectivityResult.none:
        connectionType = 0;
        showSnackBar();
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }

  void showSnackBar(){
    Get.snackbar(noInternet, checkYourConnection,
        duration: const Duration(days: 7),
        margin: const EdgeInsets.all(10.0),
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        mainButton:
        TextButton(onPressed:() {
         // if(connectionType != 0) {
            Get.back();
            update();
         // }

        }, child: Text(dismiss,style: zzRegularGreenTextStyle14,)));
  }
}