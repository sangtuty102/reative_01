import 'package:reative_01/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the dynamically injected ForgotPasswordController
    final controller = Get.find<ForgotPasswordController>();

    return Obx(() => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            controller.currentStep.value == 0
                ? LocaleKeys.loginRecoverPassword.tr
                : LocaleKeys.loginVerifyOtp.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.currentStep.value == 0) ...[
                  Text(
                    LocaleKeys.loginEnterAccountOrPhonePrompt.tr,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: controller.accountController,
                    labelText: LocaleKeys.loginAccountOrPhone.tr,
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                ] else ...[
                  Text(
                    LocaleKeys.loginEnterOtpPrompt.tr,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: controller.otpController,
                    labelText: LocaleKeys.loginOtpCode.tr,
                    prefixIcon: Icons.security,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: controller.isLoading ? null : () => Get.back(),
              child: Text(LocaleKeys.commonCancel.tr),
            ),
            CustomButton(
              width: 100,
              height: 40,
              loading: controller.isLoading,
              onPressed: () {
                if (controller.currentStep.value == 0) {
                  controller.submitAccountNumber();
                } else {
                  controller.verifyOtp();
                }
              },
              text: controller.currentStep.value == 0 ? LocaleKeys.commonContinue.tr : LocaleKeys.commonVerify.tr,
            ),
          ],
        ));
  }
}

