import 'package:reative_01/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/base/base_controller.dart';

class ForgotPasswordController extends BaseController {
  final accountController = TextEditingController();
  final otpController = TextEditingController();

  final RxInt currentStep = 0.obs; // 0: Enter account number, 1: Enter OTP

  @override
  void onClose() {
    accountController.dispose();
    otpController.dispose();
    super.onClose();
  }

  Future<void> submitAccountNumber() async {
    final account = accountController.text.trim();
    if (account.isEmpty) {
      Get.snackbar(
        LocaleKeys.commonError.tr,
        LocaleKeys.loginPleaseEnterAccountOrPhone.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (!RegExp(r'^[0-9]{9,11}$').hasMatch(account)) {
      Get.snackbar(
        LocaleKeys.commonError.tr,
        LocaleKeys.loginInvalidAccountOrPhone.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    setViewState(ViewState.loading);
    try {
      // Simulate API request to send OTP
      await Future.delayed(const Duration(milliseconds: 1500));
      currentStep.value = 1; // Transition to Step 2
      setViewState(ViewState.success);
      Get.snackbar(
        LocaleKeys.commonSuccess.tr,
        '${LocaleKeys.loginOtpSentToAccount.tr}$account',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.teal.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      setViewState(ViewState.error);
      Get.snackbar(
        LocaleKeys.commonError.tr,
        '${LocaleKeys.loginSystemErrorSendingOtp.tr}$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      setViewState(ViewState.idle);
    }
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      Get.snackbar(
        LocaleKeys.commonError.tr,
        LocaleKeys.loginPleaseEnterOtp.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (otp.length != 6) {
      Get.snackbar(
        LocaleKeys.commonError.tr,
        LocaleKeys.loginOtpMustBe6Digits.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    setViewState(ViewState.loading);
    try {
      // Simulate API request to verify OTP
      await Future.delayed(const Duration(milliseconds: 1500));
      setViewState(ViewState.success);
      Get.back(); // Close Dialog
      Get.snackbar(
        LocaleKeys.commonSuccess.tr,
        LocaleKeys.loginOtpVerifiedNewPasswordSent.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.teal.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      setViewState(ViewState.error);
      Get.snackbar(
        LocaleKeys.commonError.tr,
        '${LocaleKeys.loginInvalidOrExpiredOtp.tr}$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      setViewState(ViewState.idle);
    }
  }
}

