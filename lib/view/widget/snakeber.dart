


import 'package:flutter/material.dart';
import 'package:get/get.dart';

view_status_succesful({String? title, String? subtitle}) {
  Get.snackbar(title!, subtitle!,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color.fromARGB(255, 103, 230, 135),
      borderRadius: 12,
      margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
      colorText: Colors.white);
}

view_status_errors({String? title, String? subtitle}) {
  Get.snackbar(title!, subtitle!,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 230, 103, 94),
      borderRadius: 12,
      margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
      colorText: Colors.white);
}
