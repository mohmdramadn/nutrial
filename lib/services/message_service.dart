import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.only(top: 10.sp,bottom: 10.sp),
        titleText: const Text('',style: TextStyle(fontSize: 0)),
        backgroundColor: AppColors.errorColor,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 4),
        messageText: Text(
          message ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ));
  }

  Future<dynamic>? showDecisionAlertDialog<T>({
    String? title,
    required String message,
    required String confirm,
    required String cancel,
    required Function() onConfirm,
    required Function() onCancel,
  }) {
    return showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.backgroundColor,
            title: Text(title ?? ""),
            content: Text(message,style: const TextStyle(color: Colors.white)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                onPressed: onCancel,
                child: Text(
                  cancel,
                  style: const TextStyle(color: AppColors.primaryColor),
                ),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                onPressed: onConfirm,
                child: Text(
                  confirm,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
