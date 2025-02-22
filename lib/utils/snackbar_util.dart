import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_icons.dart';

class SnackbarUtil {
  static void showSuccess(String message, {String title = "Success"}) {
    _showSnackbar(title, message, AppColors.blue, AppIcons.circle);
  }

  static void showError(String message, {String title = "Error"}) {
    _showSnackbar(title, message, AppColors.red, AppIcons.error);
  }

  static void showWarning(String message, {String title = "Warning"}) {
    _showSnackbar(title, message, AppColors.orange, Icons.warning);
  }

  static void _showSnackbar(
      String title, String message, Color color, IconData icon) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color.withOpacity(0.9),
      colorText: AppColors.white,
      icon: Icon(icon, color: AppColors.white),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
