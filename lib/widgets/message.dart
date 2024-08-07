import 'package:flutter/material.dart';
import 'package:get/get.dart';

void message(error, message) {
    Get.snackbar(error, message,
        snackPosition: SnackPosition.TOP,
        borderColor: error == "Error" ? Colors.red : Colors.green,
        backgroundColor: Colors.white,
        borderRadius: 20,
        borderWidth: 3,
        duration: const Duration(seconds: 2));
  }