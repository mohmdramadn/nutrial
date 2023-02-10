import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/colors.dart';

class MessageService {
  void showSuccessSnackBar(String? title, String? message) {
    Get.snackbar(
      title ?? '',
      message ?? '',
      instantInit: true,
      backgroundColor: AppColors.floatingButton,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 4),
      messageText: Text(
        message ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, color: AppColors.primaryColor),
      ),
    );
  }

  void showErrorSnackBar(String? title, String? message) {
    Get.snackbar(title ?? '', message ?? '',
        instantInit: true,
        backgroundColor: AppColors.errorColor,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 4),
        messageText: Text(
          message ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ));
  }
}
