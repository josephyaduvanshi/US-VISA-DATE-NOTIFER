import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class ShowSnackBar {
  static snackError(BuildContext context, String title, String sub) async {
    Get.snackbar(title, sub,
        shouldIconPulse: true,
        icon: const Icon(
          IconlyBold.shieldFail,
          color: Colors.red,
        ),
        duration: const Duration(seconds: 3),
        overlayColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.red,
        forwardAnimationCurve: Curves.elasticInOut,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING);
  }

  static snackSuccess(BuildContext context, String title, String sub) async {
    Get.snackbar(title, sub,
        shouldIconPulse: true,
        icon: const Icon(
          IconlyBold.shieldDone,
          color: Colors.blue,
        ),
        duration: const Duration(seconds: 3),
        overlayColor: Colors.green,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        colorText: Colors.blue,
        forwardAnimationCurve: Curves.elasticInOut,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING);
  }
}
