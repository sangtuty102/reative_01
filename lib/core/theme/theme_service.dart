import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dịch vụ quản lý Theme (Sáng/Tối)
class ThemeService extends GetxService {
  final SharedPreferences _prefs;
  static const String _themeKey = 'isDarkMode';

  ThemeService(this._prefs);

  /// Trạng thái theme hiện tại (Reactive)
  late final RxBool isDarkMode;

  /// Khởi tạo service, nạp trạng thái theme từ SharedPreferences
  Future<ThemeService> init() async {
    isDarkMode = (_prefs.getBool(_themeKey) ?? false).obs;
    return this;
  }

  /// Lấy ThemeMode hiện tại để cấu hình cho GetMaterialApp
  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  /// Chuyển đổi giữa chế độ Sáng và Tối
  void switchTheme() {
    isDarkMode.value = !isDarkMode.value;
    _prefs.setBool(_themeKey, isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
