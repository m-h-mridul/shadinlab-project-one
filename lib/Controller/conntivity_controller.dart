import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';

class ConntedtivityController extends GetxController {
  static ConntedtivityController to = Get.find();
  RxInt connectionStatus = 0.obs;
  RxBool runingstate = false.obs;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult? result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (error) {
      print(error);
    }
    return _updateConnectionStatus(result!);
  }

  _updateConnectionStatus(ConnectivityResult? result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        if (runingstate.value) {
          Get.snackbar('Wi-Fi', 'You are connected!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              borderRadius: 12,
              margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
              colorText: Colors.white);
        }

        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        if (runingstate.value) {
          Get.snackbar('Mobile', 'You are connected!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              borderRadius: 12,
              margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
              colorText: Colors.white);
        }
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 4;
        if (runingstate.value) {
          Get.snackbar('Connection Error!', 'Please try again later!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              borderRadius: 12,
              margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
              colorText: Colors.white);
        }
        break;
      default:
        if (runingstate.value) {
          Get.snackbar('Connection Error!', 'Please try again later!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              borderRadius: 12,
              margin: EdgeInsets.only(bottom: 20, left: 12, right: 12),
              colorText: Colors.white);
        }
        break;
    }
    print('Connectivitu cheak end');
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription!.cancel();
  }
}
