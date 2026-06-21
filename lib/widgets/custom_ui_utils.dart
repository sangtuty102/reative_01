import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../flavor_config.dart';

class CustomUiUtils {
  /// Displays a customized modern Snackbar
  static void showSnackbar({
    required String message,
    String title = 'Thông báo',
    bool isError = false,
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    final config = FlavorConfig.instance;
    final backgroundColor = isError
        ? Colors.red.withOpacity(0.85)
        : config.primaryColor.withOpacity(0.85);

    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        )
      ],
    );
  }

  /// Displays a customized modern Confirmation Dialog
  static void showConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
  }) {
    final config = FlavorConfig.instance;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              if (onCancel != null) onCancel();
            },
            child: Text(cancelText),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: config.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: Text(confirmText),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
