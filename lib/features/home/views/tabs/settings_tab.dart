import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reative_01/generated/locales.g.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../../core/localization/localization_service.dart';
import '../../../../flavor_config.dart';
import '../../controllers/home_controller.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final colorScheme = Theme.of(context).colorScheme;
    final config = FlavorConfig.instance;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Card
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: config.primaryColor.withOpacity(0.2),
                    child: Icon(
                      Icons.person_rounded,
                      size: 32,
                      color: config.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              controller.userName.value,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        const SizedBox(height: 2),
                        Text(
                          'user.demo@reative.com',
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Preferences (Theme & Language)
          Text(
            LocaleKeys.homePreferences.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Obx(() {
                  final themeService = Get.find<ThemeService>();
                  return SwitchListTile(
                    title: Text(LocaleKeys.homeDarkMode.tr),
                    secondary: Icon(themeService.isDarkMode.value ? Icons.dark_mode : Icons.light_mode),
                    value: themeService.isDarkMode.value,
                    onChanged: (value) => themeService.switchTheme(),
                  );
                }),
                const Divider(height: 1),
                Obx(() {
                  final locService = Get.find<LocalizationService>();
                  final isEnglish = locService.currentLanguageCode.value == 'en';
                  return SwitchListTile(
                    title: Text(LocaleKeys.homeEnglishLanguage.tr),
                    secondary: const Icon(Icons.language),
                    value: isEnglish,
                    onChanged: (value) => locService.toggleLanguage(),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Configuration Information
          Text(
            LocaleKeys.homeAppConfig.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.palette),
                  title: Text(LocaleKeys.homePrimaryColor.tr),
                  trailing: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: config.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.api),
                  title: const Text('API Endpoint'),
                  subtitle: Text(config.apiBaseUrl),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.layers),
                  title: const Text('Flavor'),
                  subtitle: Text(config.flavor.name.toUpperCase()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Logout Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: controller.logout,
              icon: const Icon(Icons.logout),
              label: Text(
                LocaleKeys.homeLogout.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
