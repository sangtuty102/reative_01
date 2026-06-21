import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flavor_config.dart';
import 'routes/app_pages.dart';
import 'core/services/auth_service.dart';
import 'core/theme/theme_service.dart';
import 'core/theme/app_theme.dart';
import 'generated/locales.g.dart';
import 'core/localization/localization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fallback initialization if run directly via main.dart
  FlavorConfig.initialize(
    flavor: Flavor.dev,
    apiBaseUrl: 'https://api-dev.reative.com',
    appTitle: 'Reative Dev (Fallback)',
    primaryColor: Colors.teal,
  );

  await mainCommon();
}

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs);

  await Get.putAsync<ThemeService>(() => ThemeService(prefs).init());
  await Get.putAsync<LocalizationService>(() => LocalizationService(prefs).init());
  await Get.putAsync<AuthService>(() => AuthService().init());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = FlavorConfig.instance;
    final themeService = Get.find<ThemeService>();
    final localizationService = Get.find<LocalizationService>();

    return GetMaterialApp(
      title: config.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeService.themeMode,
      translations: AppTranslations(),
      locale: localizationService.currentLocale,
      fallbackLocale: LocalizationService.fallbackLocale,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
