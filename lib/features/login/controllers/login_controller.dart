import 'package:reative_01/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/base/base_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import 'forgot_password_controller.dart';
import '../views/forgot_password_dialog.dart';

class LoginController extends BaseController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  
  final RxBool isPasswordVisible = false.obs;
  final RxString appVersion = '...'.obs;

  @override
  void onInit() {
    super.onInit();
    loadAppVersion();
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = 'v${packageInfo.version}+${packageInfo.buildNumber}';
    } catch (e) {
      appVersion.value = 'v1.0.0';
    }
  }

  Future<void> login() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text;

    // Validation
    if (phone.isEmpty) {
      Get.snackbar(
        LocaleKeys.commonError.tr,
        LocaleKeys.loginPleaseEnterPhone.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (!RegExp(r'^[0-9]{9,11}$').hasMatch(phone)) {
      Get.snackbar(
        LocaleKeys.commonError.tr,
        LocaleKeys.loginInvalidPhone.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (password.isEmpty) {
      Get.snackbar(
        LocaleKeys.commonError.tr,
        LocaleKeys.loginPleaseEnterPassword.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        LocaleKeys.commonError.tr,
        LocaleKeys.loginPasswordTooShort.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Attempt login
    setViewState(ViewState.loading);

    try {
      // Simulate API response delay
      await Future.delayed(const Duration(milliseconds: 1500));
      
      await Get.find<AuthService>().saveLoginSession(phone);
      setViewState(ViewState.success);
      Get.offAllNamed(Routes.home, arguments: phone);
    } catch (e) {
      setViewState(ViewState.error);
      Get.snackbar(
        LocaleKeys.commonError.tr,
        '${LocaleKeys.loginLoginFailed.tr}$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      setViewState(ViewState.idle);
    }
  }

  void forgotPassword() {
    Get.dialog(
      GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) => const ForgotPasswordDialog(),
      ),
      barrierDismissible: false,
    );
  }
}

