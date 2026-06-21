import 'package:reative_01/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/base/base_view.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../flavor_config.dart';
import '../../../core/theme/theme_service.dart';
import '../../../core/localization/localization_service.dart';
import '../controllers/login_controller.dart';

class LoginView extends BaseView<LoginController> {
  const LoginView({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final locService = Get.find<LocalizationService>();

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Obx(() => TextButton(
              onPressed: locService.toggleLanguage,
              child: Text(
                locService.currentLanguageCode.value.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            )),
        Obx(() => IconButton(
              icon: Icon(
                themeService.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: theme.colorScheme.primary,
              ),
              onPressed: themeService.switchTheme,
            )),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    final config = FlavorConfig.instance;
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    // Logo / Title area
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: config.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_outline_rounded,
                            size: 64,
                            color: config.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          LocaleKeys.loginLogin.tr,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          LocaleKeys.loginLoginSubtitle.tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(flex: 2),
                    // Login Card Form
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            // Phone Number Field
                            CustomTextField(
                              controller: controller.phoneController,
                              labelText: LocaleKeys.loginPhoneNumber.tr,
                              prefixIcon: Icons.phone,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 16),
                            // Password Field
                            CustomTextField(
                              controller: controller.passwordController,
                              labelText: LocaleKeys.loginPassword.tr,
                              prefixIcon: Icons.lock,
                              isPassword: true,
                            ),
                            const SizedBox(height: 8),
                            // Forgot Password Link
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: controller.forgotPassword,
                                child: Text(
                                  LocaleKeys.loginForgotPassword.tr,
                                  style: TextStyle(
                                    color: config.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Submit Button
                            CustomButton(
                              onPressed: controller.login,
                              text: LocaleKeys.loginLogin.tr,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(flex: 4),
                    // Bottom aligned App version
                    Obx(() => Text(
                          '${LocaleKeys.homeCurrentVersion.tr}${controller.appVersion.value}',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

